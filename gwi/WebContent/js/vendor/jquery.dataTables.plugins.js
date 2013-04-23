ko.bindingHandlers.dataTable = {
    'init': function(element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {

        if ($.data(element, isInitialisedKey) === true) return;

        var binding = ko.utils.unwrapObservable(valueAccessor());
        var isInitialisedKey = "ko.bindingHandlers.dataTable.isInitialised";
        var options = {};

        // ** Initialise the DataTables options object with the data-bind settings **
        // Clone the options object found in the data bindings.  This object will form the base for the DataTable initialisation object.
        if (binding.options) options = $.extend(options, binding.options);

        // Define the tables columns.
        if (binding.columns && binding.columns.length) {
            options.aoColumns = [];
            ko.utils.arrayForEach(binding.columns, function(col) {
                options.aoColumns.push({
                    mDataProp: col
                });

            })
        }

        // Define column data attributes
        if (binding.columns && binding.columns.length) {
            options.aoColumns = [];
            ko.utils.arrayForEach(binding.columns, function(col) {

                options.aoColumns.push({
                    mDataProp: col.name
                });

                theIndex = binding.columns.indexOf(col);

                if (col.dataSort) {
                    options.aoColumns[theIndex].iDataSort = col.dataSort;
                }

                if (col.sortType) {
                    options.aoColumns[theIndex].sType = col.sortType;
                }

                if (col.sortable == false) {
                    options.aoColumns[theIndex].bSortable = col.sortable;
                }

                if (col.visible == false) {
                    options.aoColumns[theIndex].bVisible = col.visible;
                }

            })
        }

        if (binding.sortingFixed && binding.sortingFixed.length) {
            options.aaSortingFixed = [];
            ko.utils.arrayForEach(binding.sortingFixed, function(item) {
                options.aaSortingFixed.push([item.column, item.direction]);

            })
        }

        if (binding.initialSortColumn) {
            options.aaSortingFixed = [[binding.initialSortColumn, 'asc']];
        }

        if (binding.autoWidth) {
            options.bAutoWidth = binding.autoWidth;
        } else {
            options.bAutoWidth = false;
        }

        if (binding.sDom) {
            options.sDom = binding.sDom;
        }

        if (binding.iDisplayLength) {
            options.iDisplayLength = binding.iDisplayLength;
        }

        if (binding.sPaginationType) {
            options.sPaginationType = binding.sPaginationType;
        }

        if (binding.bPaginate) {
            options.bPaginate = binding.bPaginate;
        }

        // Register the row template to be used with the DataTable.
        if (binding.rowTemplate && binding.rowTemplate != '') {
            options.fnRowCallback = function(row, data, displayIndex, displayIndexFull) {
                // Render the row template for this row.
                // BUGFIX N Beemster
                // als dit gebruikt wordt, is de context niet beschikbaar in de binding van de template
                //ko.renderTemplate(binding.rowTemplate, data, null, row, "replaceChildren");
                return row;
            }

            // zo werkt het wel!
            options.fnCreatedRow = function(nRow, aData, iDataIndex) {
                var destRow = $(nRow);
                destRow.empty();
                var dataSource = ko.utils.unwrapObservable(binding.dataSource);
                var observableForThisRow = dataSource[iDataIndex];
                var localContext = new ko.bindingContext(observableForThisRow, bindingContext);
                ko.renderTemplate(binding.rowTemplate, localContext, null, nRow, "replaceChildren");
            }

        }



        // Set the data source of the DataTable.
        if (binding.dataSource) {
            var dataSource = ko.utils.unwrapObservable(binding.dataSource);

            if (dataSource instanceof Array) {
                // Set the initial datasource of the table.
                options.aaData = ko.utils.unwrapObservable(binding.dataSource);

                // If the data source is a knockout observable array...
                if (ko.isObservable(binding.dataSource)) {
                    // Subscribe to the dataSource observable.  This callback will fire whenever items are added to 
                    // and removed from the data source.
                    binding.dataSource.subscribe(function(newItems) {
                        // ** Redraw table **
                        var dataTable = $(element).dataTable();
                        // Get a list of rows in the DataTable.
                        var tableNodes = dataTable.fnGetNodes();

                        // If the table contains rows...
                        if (tableNodes.length) {
                            // Unregister each of the table rows from knockout.
                            ko.utils.arrayForEach(tableNodes, function(node) {
                                ko.cleanNode(node);
                            });
                            // Clear the datatable of rows.
                            dataTable.fnClearTable();
                        }

                        // Unwrap the items in the data source if required.
                        var unwrappedItems = [];
                        ko.utils.arrayForEach(newItems, function(item) {

                            unwrappedItems.push(ko.utils.unwrapObservable(item));
                        });

                        // Add the new data back into the data table.
                        dataTable.fnAddData(unwrappedItems);
                    });
                }

            }
            // If the dataSource was not a function that retrieves data, or a javascript object array containing data.
            else {
            	console.log(dataSource);
                throw 'The dataSource defined must a javascript object array';
            }
        }

        // If no fnRowCallback has been registered in the DataTable's options, then register the default fnRowCallback.
        // This default fnRowCallback function is called for every row in the data source.  The intention of this callback
        // is to build a table row that is bound it's associated record in the data source via knockout js.
        if (!options.fnRowCallback) {
            options.fnRowCallback = function(row, srcData, displayIndex, displayIndexFull) {
                var columns = this.fnSettings().aoColumns

                // Empty the row that has been build by the DataTable of any child elements.
                var destRow = $(row);
                destRow.empty();

                // For each column in the data table...
                ko.utils.arrayForEach(columns, function(column) {

                    var columnName = column.mDataProp;

                    var newCell = $("<td></td>");

                    // bind the cell to the observable in the current data row.
                    var accesor = eval("srcData['" + columnName.replace(".", "']['") + "']");

                    destRow.append(newCell);
                    if (columnName == 'action') {
                        ko.applyBindingsToNode(newCell[0], {
                            html: accesor
                        }, srcData);
                    } else {
                        ko.applyBindingsToNode(newCell[0], {
                            text: accesor
                        }, srcData);
                    }
                });

                return destRow[0];
            }
        }

        // If no fnDrawCallback has been registered in the DataTable's options, then register the default here. 
        // This default callback is called every time the table is drawn (for example, when the pagination is clicked). 
        if (!options.fnDrawCallback) {
            options.fnDrawCallback = function() {
                // There are some assumptions here that need to be better abstracted
                $(binding.expandIcon).click(function() {
                    var theRow = $(this).parent().parent()[0]; //defined by the relationship between the clickable expand icon and the row. assumes that the icon (the trigger) is in a td which is in a tr. 
                    rowContent = $(theRow).find(".hiddenRow").html();

                    tableId = local[binding.gridId];

                    if (tableId.fnIsOpen(theRow)) {
                        $(this).removeClass('icon-contract ' + binding.expandIcon);
                        $(this).addClass('icon-expand ' + binding.expandIcon);
                        tableId.fnClose(theRow);
                    } else {
                        $(this).removeClass('icon-expand ' + binding.expandIcon);
                        $(this).addClass('icon-contract ' + binding.expandIcon);
                        tableId.fnOpen(theRow, rowContent, 'info_row');
                    }
                });

                if (binding.tooltip) {
                    if (binding.tooltip[0]) {
                        // bootstrap tooltip definition
                        $("[rel=" + binding.tooltip[1] + "]").tooltip({
                            placement: 'top',
                            trigger: 'hover',
                            animation: true,
                            delay: {
                                show: 1000,
                                hide: 10
                            }
                        });
                    }
                }
            }
        }

        binding.gridId = $(element).dataTable(options);

        $.data(element, isInitialisedKey, true);

        // Tell knockout that the control rendered by this binding is capable of managing the binding of it's descendent elements.
        // This is crutial, otherwise knockout will attempt to rebind elements that have been printed by the row template.
        return {
            controlsDescendantBindings: true
        };

    },

    convertDataCriteria: function(srcOptions) {
        var getColIndex = function(name) {
            var matches = name.match("\\d+");

            if (matches && matches.length) return matches[0];

            return null;
        }

        var destOptions = {
            Columns: []
        };

        // Figure out how many columns in in the data table.
        for (var i = 0; i < srcOptions.length; i++) {
            if (srcOptions[i].name == "iColumns") {
                for (var j = 0; j < srcOptions[i].value; j++)
                destOptions.Columns.push(new Object());
                break;
            }
        }

        ko.utils.arrayForEach(srcOptions, function(item) {
            var colIndex = getColIndex(item.name);

            if (item.name == "iDisplayStart") destOptions.RecordsToSkip = item.value;
            else if (item.name == "iDisplayLength") destOptions.RecordsToTake = item.value;
            else if (item.name == "sSearch") destOptions.GlobalSearchText = item.value;
            else if (cog.string.startsWith(item.name, "bSearchable_")) destOptions.Columns[colIndex].IsSearchable = item.value;
            else if (cog.string.startsWith(item.name, "sSearch_")) destOptions.Columns[colIndex].SearchText = item.value;
            else if (cog.string.startsWith(item.name, "mDataProp_")) destOptions.Columns[colIndex].ColumnName = item.value;
            else if (cog.string.startsWith(item.name, "iSortCol_")) {
                destOptions.Columns[item.value].IsSorted = true;
                destOptions.Columns[item.value].SortOrder = colIndex;

                var sortOrder = ko.utils.arrayFilter(srcOptions, function(item) {
                    return item.name == "sSortDir_" + colIndex;
                });

                if (sortOrder.length && sortOrder[0].value == "desc") destOptions.Columns[item.value].SortDirection = "Descending";
                else destOptions.Columns[item.value].SortDirection = "Ascending";
            }
        });

        return destOptions;
    }
};


$.fn.dataTableExt.oApi.fnStandingRedraw = function(oSettings) {
    if (oSettings.oFeatures.bServerSide === false) {
        var before = oSettings._iDisplayStart;

        oSettings.oApi._fnReDraw(oSettings);

        // iDisplayStart has been reset to zero - so lets change it back
        oSettings._iDisplayStart = before;
        oSettings.oApi._fnCalculateEnd(oSettings);
    }

    // draw the 'current' page
    oSettings.oApi._fnDraw(oSettings);
};


/* Default class modification */
$.extend($.fn.dataTableExt.oStdClasses, {
    "sSortAsc": "header headerSortDown",
    "sSortDesc": "header headerSortUp",
    "sSortable": "header",
    "sWrapper": "dataTables_wrapper form-inline"
});

/* API method to get paging information */
$.fn.dataTableExt.oApi.fnPagingInfo = function(oSettings) {
    return {
        "iStart": oSettings._iDisplayStart,
        "iEnd": oSettings.fnDisplayEnd(),
        "iLength": oSettings._iDisplayLength,
        "iTotal": oSettings.fnRecordsTotal(),
        "iFilteredTotal": oSettings.fnRecordsDisplay(),
        "iPage": Math.ceil(oSettings._iDisplayStart / oSettings._iDisplayLength),
        "iTotalPages": Math.ceil(oSettings.fnRecordsDisplay() / oSettings._iDisplayLength)
    };
}

/* Bootstrap style pagination control */
$.extend($.fn.dataTableExt.oPagination, {
    "bootstrap": {
        "fnInit": function(oSettings, nPaging, fnDraw) {
            var oLang = oSettings.oLanguage.oPaginate;
            var fnClickHandler = function(e) {
                e.preventDefault();
                if (oSettings.oApi._fnPageChange(oSettings, e.data.action)) {
                    fnDraw(oSettings);
                }
            };

            $(nPaging).addClass('pagination').append('<ul>' + '<li class="prev disabled"><a href="#">&larr; ' + oLang.sPrevious + '</a></li>' + '<li class="next disabled"><a href="#">' + oLang.sNext + ' &rarr; </a></li>' + '</ul>');
            var els = $('a', nPaging);
            $(els[0]).bind('click.DT', {
                action: "previous"
            }, fnClickHandler);
            $(els[1]).bind('click.DT', {
                action: "next"
            }, fnClickHandler);
        },

        "fnUpdate": function(oSettings, fnDraw) {

            var before = oSettings._iDisplayStart;

            var iListLength = 5;
            var oPaging = oSettings.oInstance.fnPagingInfo();
            var an = oSettings.aanFeatures.p;
            var i, j, sClass, iStart, iEnd, iHalf = Math.floor(iListLength / 2);

            if (oPaging.iTotalPages < iListLength) {
                iStart = 1;
                iEnd = oPaging.iTotalPages;
            }
            else if (oPaging.iPage <= iHalf) {
                iStart = 1;
                iEnd = iListLength;
            } else if (oPaging.iPage >= (oPaging.iTotalPages - iHalf)) {
                iStart = oPaging.iTotalPages - iListLength + 1;
                iEnd = oPaging.iTotalPages;
            } else {
                iStart = oPaging.iPage - iHalf + 1;
                iEnd = iStart + iListLength - 1;
            }

            for (i = 0, iLen = an.length; i < iLen; i++) {
                // Remove the middle elements
                $('li:gt(0)', an[i]).filter(':not(:last)').remove();

                // Add the new list items and their event handlers
                for (j = iStart; j <= iEnd; j++) {
                    sClass = (j == oPaging.iPage + 1) ? 'class="active"' : '';
                    $('<li ' + sClass + '><a href="#">' + j + '</a></li>').insertBefore($('li:last', an[i])[0]).bind('click', function(e) {
                        e.preventDefault();
                        oSettings._iDisplayStart = (parseInt($('a', this).text(), 10) - 1) * oPaging.iLength;
                        fnDraw(oSettings);
                    });
                }

                // Add / remove disabled classes from the static elements
                if (oPaging.iPage === 0) {
                    $('li:first', an[i]).addClass('disabled');
                } else {
                    $('li:first', an[i]).removeClass('disabled');
                }

                if (oPaging.iPage === oPaging.iTotalPages - 1 || oPaging.iTotalPages === 0) {
                    $('li:last', an[i]).addClass('disabled');
                } else {
                    $('li:last', an[i]).removeClass('disabled');
                }
            }
        }
    }
});


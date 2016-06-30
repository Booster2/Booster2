#!/bin/bash

echo "Packing SDF for Stratego-$1"

pack-sdf -i syntax/Stratego-$1.sdf -o lib/Stratego-$1.def -Idef lib/StrategoMix.def --Include src-gen/syntax

echo "Creating parse table"

sdf2table -t -i lib/Stratego-$1.def -m Stratego-$1 -o lib/Stratego-$1.tbl

echo "Finished"

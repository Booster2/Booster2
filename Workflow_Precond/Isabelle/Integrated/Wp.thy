theory Wp
imports Formulas
begin

locale wp_calc =
  fixes wp:: "'a \<times> 'f form \<Rightarrow> 'f form"
    and det:: "'a \<Rightarrow> bool"

  assumes wp_cong: "f ||\<longrightarrow>|| f' \<Longrightarrow> wp(a,f) ||\<longrightarrow>|| wp(a,f')"
      and wp_F_imp_F: "wp(a, F) ||\<longrightarrow>|| F"
      and wp_conj1: "wp (a,x) |\<and>| wp (a,y) ||\<longrightarrow>|| wp (a,x |\<and>| y)"
      and wp_disj2: "det a \<Longrightarrow> wp (a,x |\<or>| y)  ||\<longrightarrow>|| wp(a,x) |\<or>| wp(a,y)"

begin

lemma wp_false: "wp(a, F) ||=|| F"
  apply(subst m_equiv_m_imp, rule conjI)
  apply(rule wp_F_imp_F)
  apply(simp add: m_imp_def)
done

lemma wp_conj2: "wp (a,x |\<and>| y) ||\<longrightarrow>|| wp (a ,x) |\<and>| wp (a,y)"
  apply(clarsimp simp add: m_imp_def , rule conjI)
  apply(insert wp_cong[of "x |\<and>| y" x a])[1]
  apply(clarsimp simp add: m_imp_def)
  apply(insert wp_cong[of "x |\<and>| y" y a])[1]
  apply(clarsimp simp add: m_imp_def)
done

lemma wp_disj1: "(wp(a,x) |\<or>| wp(a,y)) ||\<longrightarrow>|| wp (a,x |\<or>| y)"
  apply(auto simp add: m_imp_def)
  apply(insert wp_cong[of x "x |\<or>| y" a])[1]
  apply(clarsimp simp add: m_imp_def)
  apply(insert wp_cong[of y "x |\<or>| y" a])[1]
  apply(clarsimp simp add: m_imp_def)
done
  

lemma wp_conj: "wp (a,x |\<and>| y) ||=|| wp (a ,x) |\<and>| wp (a,y)"
  apply(subst m_equiv_m_imp, rule conjI)
  apply(rule wp_conj2)
  apply(rule wp_conj1)
done

lemma wp_disj: "det a \<Longrightarrow> (wp (a,x |\<or>| y)) ||=|| (wp(a,x) |\<or>| wp(a,y))"
  apply(subst m_equiv_m_imp , rule conjI)
  apply(rule wp_disj2, assumption)
  apply(rule wp_disj1)
done
  

lemma wp_cong_equiv: "f ||=|| f' \<Longrightarrow> wp(a,f) ||=|| wp(a,f')"
  apply(insert wp_cong[of f f' a])
  apply(insert wp_cong[of f' f a])
  by(auto simp add: m_imp_def m_equiv_def)

lemma ev_wp_disj[simp]: "det a \<Longrightarrow> f_eval v (wp (a, x |\<or>| y)) = (f_eval v (wp(a,x)) \<or> f_eval v (wp (a,y)))"
  by(insert wp_disj [of a x y], simp add: m_equiv_def)
  
lemma ev_wp_conj[simp]: "f_eval v (wp (a, x |\<and>| y)) = (f_eval v (wp(a,x)) \<and> f_eval v (wp (a,y)))"
  by(insert wp_conj [of a x y] , simp add: m_equiv_def) 

lemma ev_wp_imp[simp]: "det a \<Longrightarrow> f_eval v (wp (a, x |\<longrightarrow>| y)) = (f_eval v (wp (a, |\<not>| x)) \<or> f_eval v (wp (a, y)))"
  by(simp add: f_imp_def)

lemma ev_wp_disj2[simp]: "\<lbrakk> det a ; det b \<rbrakk> \<Longrightarrow> f_eval v (wp (a,wp(b, x |\<or>| y))) = (f_eval v (wp (a , wp(b,x) |\<or>| wp(b,y))))"
  by(insert wp_cong_equiv[of "wp(b, x |\<or>| y)" "wp(b,x) |\<or>| wp(b,y)" a], simp add: m_equiv_def)
  
lemma ev_wp_conj2[simp]: "f_eval v (wp (a,wp(b, x |\<and>| y))) = (f_eval v (wp (a , wp(b,x) |\<and>| wp(b,y))))"
  by(insert wp_cong_equiv[of "wp(b, x |\<and>| y)" "wp(b,x) |\<and>| wp(b,y)" a] , simp add: m_equiv_def)

lemma ev_wp_imp2[simp]: "\<lbrakk> det a ; det b \<rbrakk> \<Longrightarrow> f_eval v (wp (a, wp(b,x |\<longrightarrow>| y))) = f_eval v (wp(a, (wp (b, |\<not>| x)) |\<or>| (wp (b, y))))"
  by(insert wp_cong_equiv[of "wp(b, x |\<longrightarrow>| y)" "(wp (b, |\<not>| x)) |\<or>| (wp (b, y))" a], simp add: m_equiv_def)


lemma wp_inconst: "wp (a,g) |\<and>| wp(a,|\<not>| g) ||=|| F"
  apply(rule m_equiv_trans)
  apply(subst m_equiv_sym)
  apply(rule wp_conj)
  apply(rule m_equiv_trans)
  apply(rule wp_cong_equiv[of _ F])
  apply(simp add: m_equiv_def)
  apply(rule wp_false)
done

lemma f_eval_wp_inconst: "\<lbrakk> f_eval v (wp (a,g)) ; f_eval v (wp(a,|\<not>| g)) \<rbrakk> \<Longrightarrow> False"
  apply(insert wp_inconst)
  apply(auto simp add: m_equiv_def)
done

lemma f_eval_wp_false[simp]: "f_eval v (wp (a1, F)) = False"
  by(insert wp_false, simp add: m_equiv_def )

lemma wp_m_imp_T: "wp(a,f) ||\<longrightarrow>|| wp(a,T)"
  apply(insert wp_cong_equiv [of f "f |\<and>| T" a])
  apply(drule meta_mp)
  apply(simp add: m_equiv_def)
  apply(auto simp add: m_equiv_def m_imp_def)
done

lemma f_eval_wp_imp_T: "f_eval v (wp (a,f)) \<Longrightarrow> f_eval v (wp (a,T))"
  by(insert wp_m_imp_T, simp add: m_imp_def)

lemma wp_wp_m_imp_T: "wp (a, wp (b, f)) ||\<longrightarrow>||  wp (a, wp (b,T))"
  apply(rule wp_cong)
  apply(rule wp_m_imp_T)
done

lemma f_eval_wp_wp_imp_fx: "f_eval v (wp (a, wp (b, f))) \<Longrightarrow> f_eval v (wp (a, wp (b, f |\<or>| x)))"
  apply(insert wp_cong[of "wp (b, f)" "wp (b, f |\<or>| x)" a])
  apply(drule meta_mp)
  apply(insert wp_cong[of "f" "f |\<or>| x" b])
  apply(drule meta_mp)
  apply(clarsimp simp add: m_imp_def)
  apply(simp)
  apply(clarsimp simp add: m_imp_def)
done

lemma f_eval_wp_wp_imp_T: "f_eval v (wp (a, wp (b, f))) \<Longrightarrow> f_eval v (wp (a, wp (b, T)))"
  by(insert wp_wp_m_imp_T, clarsimp simp add: m_imp_def)

lemma f_eval_wp_cong: "\<lbrakk> f_eval v (wp(a,f)) ; f ||\<longrightarrow>|| f'  \<rbrakk> \<Longrightarrow> f_eval v (wp(a,f'))"
  by(insert wp_cong[of f f' a] , clarsimp simp add: m_imp_def)

lemma f_eval_wp_disj1: "f_eval v (wp (a, A))
           \<Longrightarrow> f_eval v (wp (a, A |\<or>| B))"
  apply(drule_tac f'="A |\<or>| B" in f_eval_wp_cong)
  apply(auto simp add: m_imp_def)
done

lemma f_eval_wp_disj2: "f_eval v (wp (a, B))
           \<Longrightarrow> f_eval v (wp (a, A |\<or>| B))"
  apply(drule_tac f'="A |\<or>| B" in f_eval_wp_cong)
  apply(auto simp add: m_imp_def)
done

lemma f_eval_wp_case: "\<lbrakk> f_eval v (wp(a,f)) \<rbrakk> \<Longrightarrow> f_eval v (wp(a,g |\<or>| |\<not>| g))"
  apply(rule f_eval_wp_cong , simp)
  apply(simp add: m_imp_def)
done

lemma f_eval_wp_case2: "\<exists> f. f_eval v (wp (a, f)) 
               \<Longrightarrow> f_eval v (wp(a, g |\<or>| |\<not>| g))"
  apply(clarsimp)
  apply(drule_tac g=g in f_eval_wp_case, simp)
done


lemma f_eval_wp_m_imp_mp: "\<lbrakk> f_eval v (wp (a, g1)) ; g1 ||\<longrightarrow>|| g2 \<rbrakk> \<Longrightarrow> f_eval v (wp (a, g2))"
  by(drule wp_cong[of _ _ a] , clarsimp simp add: m_imp_def)

lemma f_eval_wp_disjoint: "\<lbrakk> f_eval v (wp (a, h1)) ; f_eval v (wp (a, h2)) ; h1 ||\<longrightarrow>|| |\<not>| h2 \<rbrakk> \<Longrightarrow> False"
  apply(frule f_eval_wp_m_imp_mp , simp)
  apply(insert wp_inconst[of a h2])
  apply(clarsimp simp add: m_equiv_def)
done

end

end
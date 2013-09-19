theory IndepActions_Connection
imports IndepActions_DisjointGuards 
        IndepActions_NondisjointGuards

begin

lemma "g1 |\<and>| g2 ||=|| F \<Longrightarrow>

           (g1 |\<longrightarrow>| A1)
       |\<and>| (g2 |\<longrightarrow>| A2)
       |\<and>| (g1 |\<or>| g2)    

       ||=||

           g1 |\<and>| A1 
       |\<or>| g2 |\<and>| A2"
by(auto simp add: m_equiv_def)

lemma "g2 ||=|| F \<Longrightarrow>

           (g1 |\<longrightarrow>| A1)
       |\<and>| (g2 |\<longrightarrow>| A2)
       |\<and>| (g1 |\<or>| g2)    

       ||=||

           g1 |\<and>| A1"
by(auto simp add: m_equiv_def)

lemma "g1 ||=|| F \<Longrightarrow>

           (g1 |\<longrightarrow>| A1)
       |\<and>| (g2 |\<longrightarrow>| A2)
       |\<and>| (g1 |\<or>| g2)    

       ||=||

           g2 |\<and>| A2"
by(auto simp add: m_equiv_def)


lemma "g1 |\<and>| g2 ||=|| F \<Longrightarrow>
           (g1 |\<longrightarrow>| A1)
       |\<and>| (g2 |\<longrightarrow>| A2)

       ||=||
 
        g1 |\<and>| A1 
    |\<or>| g2 |\<and>| A2
    |\<or>| |\<not>| g1 |\<and>| |\<not>| g2"
by(auto simp add: m_equiv_def)

context wp_calc
begin

fun prio3:: "('f form \<times> 'a) \<Rightarrow> ('f form \<times> 'a) \<Rightarrow> bool"
where
   "prio3 (g,a) (h,b) = (( (\<forall> I.    wp(a,wp(b,I)) ||\<longrightarrow>||  wp(b,wp(a,I)) )) \<and>
                                    wp(a, h) ||\<longrightarrow>|| h \<and>
                                    wp(a, |\<not>| h) ||\<longrightarrow>|| |\<not>| h \<and>
                                    g ||\<longrightarrow>|| wp(b, g) \<and>             (* the last two clauses *) 
                                    |\<not>| g ||\<longrightarrow>|| wp(b, |\<not>| g) )"    (* are too strong *)

lemma "\<lbrakk> prio3 (g1,a1) (h1,b1) ; prio3 (g1,a1) (h2,b2) ; prio3 (g2,a2) (h1,b1) ; prio3 (g2,a2) (h2,b2) \<rbrakk> 
       \<Longrightarrow> prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2))"
  by(clarsimp simp add: prio2.simps m_imp_def)  



fun prio4:: "('f form \<times> 'a) \<Rightarrow> ('f form \<times> 'a) \<Rightarrow> bool"
where
   "prio4 (g,a) (h,b) = ((\<forall> I. wp(a,wp(b,I)) ||\<longrightarrow>||  wp(b,wp(a,I)) ) \<and>
                         wp(a, h) ||\<longrightarrow>|| h \<and>
                         wp(a, |\<not>| h) ||\<longrightarrow>|| |\<not>| h \<and>
                         g |\<and>| wp(b,T) ||\<longrightarrow>|| wp(b, g) \<and>
                         |\<not>| g |\<and>| wp(b,T) ||\<longrightarrow>|| wp(b, |\<not>| g))"

declare prio4.simps[simp del]

lemma h1: "f_eval v (wp (a, wp (b, I))) \<Longrightarrow> prio4 (g,a) (h,b) \<Longrightarrow> f_eval v (wp(b,T))"
  apply(clarsimp simp add: prio4.simps m_imp_def)
  apply(rule f_eval_wp_imp_T , auto)
done

lemma "\<lbrakk> prio4 (g1,a1) (h1,b1) ; prio4 (g1,a1) (h2,b2) ; prio4 (g2,a2) (h1,b1) ; prio4 (g2,a2) (h2,b2) \<rbrakk> 
       \<Longrightarrow> prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2))"
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(rule conjI , clarsimp , frule h1 , simp , clarsimp simp add: prio4.simps m_imp_def)+
  apply(clarsimp , frule h1 , simp , clarsimp simp add: prio4.simps m_imp_def)
done

lemma "\<lbrakk> prio3 (g,a) (h,b) \<rbrakk> 
       \<Longrightarrow> prio4 (g,a) (h,b)"
  by(clarsimp simp add: prio4.simps m_imp_def)




lemma det_prio2_prio: "\<lbrakk> det a1 ; det a2 ; 
                         prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2)) \<rbrakk> 
                      \<Longrightarrow> prio (g1,a1) (h1,b1) \<and> prio (g1,a1) (h2,b2) \<and>
                          prio (g2,a2) (h1,b1) \<and> prio (g2,a2) (h2,b2)"
  apply(simp)

  apply(rule conjI , clarsimp)
  apply(clarsimp simp add: m_imp_def)
  apply(frule_tac g="h2" in f_eval_wp_case)
  apply(case_tac "f_eval v g2")
  apply(clarsimp)
  apply(erule disjE)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp)
  apply(erule disjE)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)

  apply(rule conjI , clarsimp)
  apply(clarsimp simp add: m_imp_def)
  apply(frule_tac g="h1" in f_eval_wp_case)
  apply(case_tac "f_eval v g2")
  apply(clarsimp)
  apply(erule disjE)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp)
  apply(erule disjE)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)

  apply(rule conjI , clarsimp)
  apply(clarsimp simp add: m_imp_def)
  apply(frule_tac g="h2" in f_eval_wp_case)
  apply(case_tac "f_eval v g1")
  apply(clarsimp)
  apply(erule disjE)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp)
  apply(erule disjE)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)

  apply(clarsimp)
  apply(clarsimp simp add: m_imp_def)
  apply(frule_tac g="h1" in f_eval_wp_case)
  apply(case_tac "f_eval v g1")
  apply(clarsimp)
  apply(erule disjE)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp)
  apply(erule disjE)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)
done

lemma disjoint_prio2_prio: "\<lbrakk> h1 |\<and>| h2 ||=|| F \<rbrakk> \<Longrightarrow> 
                             prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2)) 
                            \<Longrightarrow> prio (g1,a1) (h1,b1) \<and> prio (g1,a1) (h2,b2) \<and>
                                prio (g2,a2) (h1,b1) \<and> prio (g2,a2) (h2,b2)"
  apply(simp)

  apply(rule conjI , clarsimp)
  apply(clarsimp simp add: m_imp_def)
  apply(insert wp_cong[of h1 "h1 |\<and>| |\<not>| h2" a1])[1]
  apply(drule meta_mp)
  apply(clarsimp simp add: m_imp_def)
  apply(case_tac "f_eval v g2")
  apply(clarsimp simp add: m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)

  apply(rule conjI , clarsimp)
  apply(clarsimp simp add: m_imp_def)
  apply(insert wp_cong[of h2 "|\<not>| h1 |\<and>| h2" a1])[1]
  apply(drule meta_mp)
  apply(clarsimp simp add: m_imp_def)
  apply(case_tac "f_eval v g2")
  apply(clarsimp simp add: m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)

  apply(rule conjI , clarsimp)
  apply(clarsimp simp add: m_imp_def)
  apply(insert wp_cong[of h1 "h1 |\<and>| |\<not>| h2" a2])[1]
  apply(drule meta_mp)
  apply(clarsimp simp add: m_imp_def)
  apply(case_tac "f_eval v g1")
  apply(clarsimp simp add: m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)

  apply(clarsimp simp add: m_imp_def)
  apply(insert wp_cong[of h2 "|\<not>| h1 |\<and>| h2" a2])[1]
  apply(drule meta_mp)
  apply(clarsimp simp add: m_imp_def)
  apply(case_tac "f_eval v g1")
  apply(clarsimp simp add: m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)
  apply(clarsimp simp add: prio2.simps m_imp_def)
done

lemma disjoint_prio_prio2: "\<lbrakk> g1 |\<and>| g2 ||=|| F ; h1 |\<and>| h2 ||=|| F \<rbrakk> \<Longrightarrow>
                             prio (g1,a1) (h1,b1) \<and> prio (g1,a1) (h2,b2) \<and>
                             prio (g2,a2) (h1,b1) \<and> prio (g2,a2) (h2,b2) 
                             \<Longrightarrow>
                             prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2))"
  apply(clarsimp simp add: prio2.simps)
  
  apply(rule conjI)
  apply(subst m_imp_def)
  apply(subst (asm) m_imp_def) back back back back
  apply(clarsimp)
  apply(erule_tac x="I" in allE)
  apply(erule_tac x="v" in allE)
  apply(clarsimp)
  apply(drule_tac a=b1 in f_eval_wp_m_imp_mp) apply(simp)
  apply(drule_tac g=h1 in f_eval_m_imp_mp) apply(simp)
  apply(simp)

  apply(rule conjI)
  apply(subst m_imp_def)
  apply(subst (asm) m_imp_def) back back back back back
  apply(clarsimp)
  apply(erule_tac x="I" in allE) back
  apply(erule_tac x="v" in allE)
  apply(clarsimp)
  apply(drule_tac a=b2 in f_eval_wp_m_imp_mp) apply(simp)
  apply(drule_tac g=h2 in f_eval_m_imp_mp) apply(simp)
  apply(simp)

  apply(rule conjI)
  apply(subst m_imp_def)
  apply(clarsimp)
  apply(drule_tac f_eval_wp_disjoint[of _ _ h1 h2])
  apply(simp) apply(simp) apply(simp)

  apply(rule conjI)
  apply(subst m_imp_def)
  apply(clarsimp)
  apply(drule_tac f_eval_wp_disjoint[of _ _ h1 h2])
  apply(simp) apply(simp) apply(simp)

  apply(rule conjI)
  apply(subst m_imp_def)
  apply(subst (asm) m_imp_def) back back back back back back
  apply(clarsimp)
  apply(erule_tac x="I" in allE) back back
  apply(erule_tac x="v" in allE)
  apply(clarsimp)
  apply(drule_tac a=b1 in f_eval_wp_m_imp_mp) apply(simp)
  apply(drule_tac g=h1 in f_eval_m_imp_mp) apply(simp)
  apply(simp) 

  apply(rule conjI)
  apply(subst m_imp_def)
  apply(subst (asm) m_imp_def) back back back back back back back
  apply(clarsimp)
  apply(erule_tac x="I" in allE) back back back
  apply(erule_tac x="v" in allE)
  apply(clarsimp)
  apply(drule_tac a=b2 in f_eval_wp_m_imp_mp) apply(simp)
  apply(drule_tac g=h2 in f_eval_m_imp_mp) apply(simp)
  apply(simp) 

  apply(rule conjI)
  apply(subst m_imp_def)
  apply(clarsimp)
  apply(drule_tac f_eval_wp_disjoint[of _ _ h1 h2])
  apply(simp) apply(simp) apply(simp)

  apply(rule conjI)
  apply(subst m_imp_def)
  apply(clarsimp)
  apply(drule_tac f_eval_wp_disjoint[of _ _ h1 h2])
  apply(simp) apply(simp) apply(simp)

  apply(subst m_imp_def)+
  apply(subst (asm) m_imp_def)
  apply(auto)
done

lemma "prio2 ((g1,a1),(F,a2)) ((h1,b1),(F,b2)) 
       \<longleftrightarrow> prio (g1,a1) (h1,b1)"
  apply(rule iffI)
  apply(insert disjoint_prio2_prio[of h1 F g1 a1 F a2 b1 b2])[1]
  apply(clarsimp simp add: m_equiv_def)

  apply(rule disjoint_prio_prio2)
  apply(simp add: m_equiv_def)
  apply(simp add: m_equiv_def)
  apply(subst prio_F_g)
  apply(subst prio_g_F)+
  apply(simp)
done

end

end
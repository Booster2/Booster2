theory IndepActions_NondisjointGuards
imports Wp
begin

lemma foregoing_consideration: "x \<and> \<not> y \<and> A \<or>
                                \<not> x \<and> y \<and> B \<or>
                               x \<and> y \<and> A \<and> B
                              \<longleftrightarrow>
                              (x \<longrightarrow> A) \<and> (y \<longrightarrow> B) \<and> (x \<or> y)"
  by(metis)

context wp_calc
begin

fun prio2:: "('f form \<times> 'a) \<times> ('f form \<times> 'a) \<Rightarrow> ('f form \<times> 'a) \<times> ('f form \<times>'a) \<Rightarrow> bool"
where
   "prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2)) = 
                 (\<forall> I.           g1 |\<and>| |\<not>| g2 |\<and>| wp(a1,h1 |\<and>| |\<not>| h2 |\<and>| wp(b1,I)) 
                         ||\<longrightarrow>|| h1 |\<and>| |\<not>| h2 |\<and>| wp(b1,g1 |\<and>| |\<not>| g2 |\<and>| wp(a1,I)) 
                           \<and>
                                 g1 |\<and>| |\<not>| g2 |\<and>| wp(a1,|\<not>| h1 |\<and>| h2 |\<and>| wp(b2,I)) 
                         ||\<longrightarrow>|| |\<not>| h1 |\<and>| h2 |\<and>| wp(b2,g1 |\<and>| |\<not>| g2 |\<and>| wp(a1,I))
                           \<and>
                                 g1 |\<and>| |\<not>| g2 |\<and>| wp(a1, h1 |\<and>| h2 |\<and>| wp(b1,I)) 
                         ||\<longrightarrow>|| h1 |\<and>| h2 |\<and>| wp(b1,g1 |\<and>| |\<not>| g2 |\<and>| wp(a1,I))
                           \<and>
                                 g1 |\<and>| |\<not>| g2 |\<and>| wp(a1, h1 |\<and>| h2 |\<and>| wp(b2,I)) 
                         ||\<longrightarrow>|| h1 |\<and>| h2 |\<and>| wp(b2,g1 |\<and>| |\<not>| g2 |\<and>| wp(a1,I))

                           \<and>
                           
                                 |\<not>| g1 |\<and>| g2 |\<and>| wp(a2,h1 |\<and>| |\<not>| h2 |\<and>| wp(b1,I)) 
                         ||\<longrightarrow>|| h1 |\<and>| |\<not>| h2 |\<and>| wp(b1,|\<not>| g1 |\<and>| g2 |\<and>| wp(a2,I)) 
                           \<and>
                                 |\<not>| g1 |\<and>| g2 |\<and>| wp(a2,|\<not>| h1 |\<and>| h2 |\<and>| wp(b2,I)) 
                         ||\<longrightarrow>|| |\<not>| h1 |\<and>| h2 |\<and>| wp(b2,|\<not>| g1 |\<and>| g2 |\<and>| wp(a2,I))
                           \<and>
                                 |\<not>| g1 |\<and>| g2 |\<and>| wp(a2, h1 |\<and>| h2 |\<and>| wp(b1,I)) 
                         ||\<longrightarrow>|| h1 |\<and>| h2 |\<and>| wp(b1, |\<not>| g1 |\<and>| g2 |\<and>| wp(a2,I))
                           \<and>
                                 |\<not>| g1 |\<and>| g2 |\<and>| wp(a2, h1 |\<and>| h2 |\<and>| wp(b2,I)) 
                         ||\<longrightarrow>|| h1 |\<and>| h2 |\<and>| wp(b2, |\<not>| g1 |\<and>| g2 |\<and>| wp(a2,I))

                           \<and>
                                 g1 |\<and>| g2 |\<and>| wp(a1,h1 |\<and>| |\<not>| h2 |\<and>| wp(b1,I)) 
                         ||\<longrightarrow>|| h1 |\<and>| |\<not>| h2 |\<and>| wp(b1,g1 |\<and>| g2 |\<and>| wp(a1,I)) 
                           \<and>
                                 g1 |\<and>| g2 |\<and>| wp(a1,|\<not>| h1 |\<and>| h2 |\<and>| wp(b2,I)) 
                         ||\<longrightarrow>|| |\<not>| h1 |\<and>| h2 |\<and>| wp(b2,g1 |\<and>| g2 |\<and>| wp(a1,I))
                           \<and>
                                 g1 |\<and>| g2 |\<and>| wp(a1, h1 |\<and>| h2 |\<and>| wp(b1,I)) 
                         ||\<longrightarrow>|| h1 |\<and>| h2 |\<and>| wp(b1,g1 |\<and>| g2 |\<and>| wp(a1,I))
                           \<and>
                                 g1 |\<and>| g2 |\<and>| wp(a1, h1 |\<and>| h2 |\<and>| wp(b2,I)) 
                         ||\<longrightarrow>|| h1 |\<and>| h2 |\<and>| wp(b2,g1 |\<and>| g2 |\<and>| wp(a1,I))

                          \<and>
                                 g1 |\<and>| g2 |\<and>| wp(a2,h1 |\<and>| |\<not>| h2 |\<and>| wp(b1,I)) 
                         ||\<longrightarrow>|| h1 |\<and>| |\<not>| h2 |\<and>| wp(b1,g1 |\<and>| g2 |\<and>| wp(a2,I)) 
                           \<and>
                                 g1 |\<and>| g2 |\<and>| wp(a2,|\<not>| h1 |\<and>| h2 |\<and>| wp(b2,I)) 
                         ||\<longrightarrow>|| |\<not>| h1 |\<and>| h2 |\<and>| wp(b2,g1 |\<and>| g2 |\<and>| wp(a2,I))
                           \<and>
                                 g1 |\<and>| g2 |\<and>| wp(a2, h1 |\<and>| h2 |\<and>| wp(b1,I)) 
                         ||\<longrightarrow>|| h1 |\<and>| h2 |\<and>| wp(b1,g1 |\<and>| g2 |\<and>| wp(a2,I))
                           \<and>
                                 g1 |\<and>| g2 |\<and>| wp(a2, h1 |\<and>| h2 |\<and>| wp(b2,I)) 
                         ||\<longrightarrow>|| h1 |\<and>| h2 |\<and>| wp(b2,g1 |\<and>| g2 |\<and>| wp(a2,I))
)"


declare prio2.simps[simp del]

lemma prio_g1g2_nh1h2_a2: "\<lbrakk> prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2)) ;
                            f_eval v g1 ; f_eval v g2; 
                            f_eval v (wp (a2, |\<not>| h1)) ;
                            f_eval v (wp (a2, h2)) ;
                            f_eval v (wp (a2, wp (b2, X))) \<rbrakk>
                           \<Longrightarrow> f_eval v ( |\<not>| h1 |\<and>| h2 |\<and>| wp(b2, g1 |\<and>| g2 |\<and>| wp(a2,X)))"
by(clarsimp simp add: prio2.simps m_imp_def)

lemma prio_g1g2_h1nh2_a2: "\<lbrakk> prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2)) ;
                            f_eval v g1 ; f_eval v g2; 
                            f_eval v (wp (a2, h1)) ;
                            f_eval v (wp (a2, |\<not>| h2)) ;
                            f_eval v (wp (a2, wp (b1, X))) \<rbrakk>
                           \<Longrightarrow> f_eval v (h1 |\<and>| |\<not>| h2 |\<and>| wp(b1, g1 |\<and>| g2 |\<and>| wp(a2,X)))"
by(clarsimp simp add: prio2.simps m_imp_def)

lemma prio_g1g2_h1h2_a2: "\<lbrakk> prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2)) ;
                            f_eval v g1 ; f_eval v g2; 
                            f_eval v (wp (a2, h1)) ;
                            f_eval v (wp (a2, h2)) ;
                            f_eval v (wp (a2, wp (b1, X))) \<rbrakk>
                           \<Longrightarrow> f_eval v ( h1 |\<and>| h2 |\<and>| wp(b1, g1 |\<and>| g2 |\<and>| wp(a2,X)))"
by(clarsimp simp add: prio2.simps m_imp_def)

lemma "prio2 ((g1,a1),(g1,a1)) ((g1,a1),(g1,a1))"
  apply(auto simp add: prio2.simps m_imp_def)
  apply(insert wp_inconst)
  apply(clarsimp simp add: m_equiv_def)+
done

lemma "prio2 ((g,a),(F,b)) ((g,a),(F,c))"
  apply(auto simp add: prio2.simps)
  apply(clarsimp simp add: m_imp_def)
  apply(clarsimp simp add: m_imp_def)
    apply(insert wp_false, simp add: m_equiv_def)
  apply(clarsimp simp add: m_imp_def m_equiv_def)+ 
done

lemma "prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2))
       \<Longrightarrow> prio2 ((g1,a1),(g2,a2)) ((h2,b2),(h1,b1))"
by(auto simp add: prio2.simps m_imp_def)

lemma "prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2))
       \<Longrightarrow> prio2 ((g2,a2),(g1,a1)) ((h1,b1),(h2,b2))"
by(auto simp add: prio2.simps m_imp_def)

lemma "prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2))
       \<Longrightarrow> prio2 ((g2,a2),(g1,a1)) ((h2,b2),(h1,b1))"
by(auto simp add: prio2.simps m_imp_def)

lemma "prio2 ((F,a1),(F,a2)) ((h1,b1),(h2,b2))"
  apply(clarsimp simp add: prio2.simps)
  apply(rule conjI, clarsimp simp add: m_imp_def)+
  apply(clarsimp simp add: m_imp_def)
done

lemma "prio2 ((g1,a1),(g2,a2)) ((F,b1),(F,b2))"
  apply(clarsimp simp add: prio2.simps)
  apply(rule conjI, clarsimp simp add: m_imp_def)+
  apply(clarsimp simp add: m_imp_def)
done


(* Simplification *)

lemma t1: "   (g1 |\<longrightarrow>| wp(a1,     (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf11MIDDLEWf21RIGHT))) 
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf11MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)
                                |\<and>| A1))

               |\<and>| 
               (g2 |\<longrightarrow>| wp(a2,     (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf12MIDDLEWf21RIGHT)))
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)
                                |\<and>| A2))
               |\<and>|
               (g1 |\<or>| g2)

            ||=||

               (g1 |\<longrightarrow>| wp(a1,     (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf11MIDDLEWf21RIGHT))) 
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf11MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)))

               |\<and>| 
               (g2 |\<longrightarrow>| wp(a2,     (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf12MIDDLEWf21RIGHT)))
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)))
               |\<and>|
               
               (g1 |\<longrightarrow>| wp(a1,A1))

               |\<and>|

               (g2 |\<longrightarrow>| wp(a2,A2))

               |\<and>|
               (g1 |\<or>| g2)"
  apply(rule m_equiv_trans)
  apply(rule f_and_cong)
  apply(rule f_imp_cong)
  apply(rule m_equiv_refl)
  apply(rule_tac y="wp (a1, ((h1 |\<longrightarrow>| wp (b1, pre LEFTWf11MIDDLEWf21RIGHT)) 
                        |\<and>| (h2 |\<longrightarrow>| wp (b2, pre LEFTWf11MIDDLEWf22RIGHT)) 
                        |\<and>| (h1 |\<or>| h2)) |\<and>| A1)" in m_equiv_trans)
  apply(simp add: m_equiv_def)
  apply(rule wp_conj)
  apply(rule f_and_cong)
  apply(rule f_imp_cong)
  apply(rule m_equiv_refl)
  apply(rule_tac y="wp (a2, ((h1 |\<longrightarrow>| wp (b1, pre LEFTWf12MIDDLEWf21RIGHT)) 
                        |\<and>| (h2 |\<longrightarrow>| wp (b2, pre LEFTWf12MIDDLEWf22RIGHT)) 
                        |\<and>| (h1 |\<or>| h2)) |\<and>| A2)" in m_equiv_trans)
  apply(simp add: m_equiv_def)
  apply(rule wp_conj)
  apply(rule m_equiv_refl)

  apply(rule m_equiv_trans)
  apply(rule f_and_cong)
  apply(rule f_imp_m_equiv_conj)
  apply(rule f_and_cong)
  apply(rule f_imp_m_equiv_conj)
  apply(rule m_equiv_refl)

  apply(subst m_equiv_m_imp)
  apply(rule conjI)
  apply(clarsimp simp add: m_imp_def)
  apply(clarsimp simp add: m_imp_def)
done

lemma t2: "\<lbrakk> det a1 ; det a2 ;
             prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2)) \<rbrakk> \<Longrightarrow>
              (g1 |\<longrightarrow>| wp(a1,     (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf11MIDDLEWf21RIGHT))) 
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf11MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)))

               |\<and>| 
               (g2 |\<longrightarrow>| wp(a2,     (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf12MIDDLEWf21RIGHT)))
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)))
               |\<and>|
               (g1 |\<or>| g2)

              ||\<longrightarrow>||

              (h1 |\<longrightarrow>| wp(b1,     (g1 |\<longrightarrow>| wp(a1, pre(LEFTWf11MIDDLEWf21RIGHT))) 
                              |\<and>| (g2 |\<longrightarrow>| wp(a2, pre(LEFTWf12MIDDLEWf21RIGHT)))
                              |\<and>| (g1 |\<or>| g2)))

               |\<and>| 
               (h2 |\<longrightarrow>| wp(b2,      (g1 |\<longrightarrow>|  wp(a1, pre(LEFTWf11MIDDLEWf22RIGHT)))
                                |\<and>| (g2 |\<longrightarrow>| wp(a2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                                |\<and>| (g1 |\<or>| g2)))
               |\<and>|
               (h1 |\<or>| h2)"
  apply(clarsimp simp add: m_imp_def f_imp_def)
  apply(insert f_eval_wp_inconst)

  apply(case_tac "f_eval v g1")
  apply(case_tac "f_eval v g2")

(* g1 g2 *)
  apply(clarsimp)
  apply(insert f_eval_wp_case2[of _ a1 h1])[1]
  apply(erule_tac x="v" in meta_allE) back
  apply(drule meta_mp) apply(blast)
  apply(insert f_eval_wp_case2[of _ a1 h2])[1]
  apply(erule_tac x="v" in meta_allE) back
  apply(drule meta_mp) apply(blast)
  apply(clarsimp)
  apply(erule disjE) back back back back back back
  apply(erule disjE) back back back back back back
  apply(clarsimp)
  (* a1_h1_h2*)
  apply(subgoal_tac "f_eval v (wp (a2, h1)) \<and> f_eval v (wp (a2, h2))")
  apply(clarsimp)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(clarsimp simp add: m_imp_def prio2.simps)
    (* proof of subgoal *)
    apply(erule disjE) back back back back
    apply(frule f_eval_wp_case[of _ a2 _ h2])
    apply(clarsimp)
    apply(erule disjE) back apply(blast)
    apply(frule prio_g1g2_h1nh2_a2)
    apply(assumption)+
    apply(clarsimp)
    apply(erule disjE) apply(blast)
    apply(erule disjE) apply(blast)
    apply(clarsimp simp add: m_imp_def prio2.simps)
    apply(frule f_eval_wp_case[of _ a2 _ h1])
    apply(clarsimp)
    apply(erule disjE) back back apply(blast)
    apply(frule prio_g1g2_nh1h2_a2)
    apply(assumption)+
    apply(clarsimp)
    apply(erule disjE) apply(blast)
    apply(erule disjE) apply(blast)
    apply(clarsimp simp add: m_imp_def prio2.simps)
  (* a1_h1_nh2*)
  apply(subgoal_tac "f_eval v (wp (a2, h1)) \<and> f_eval v (wp (a2, |\<not>| h2))")
  apply(clarsimp)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(clarsimp simp add: m_imp_def prio2.simps)
    (* proof of subgoal *)
    apply(erule disjE) back back back back back
    apply(frule f_eval_wp_case[of _ a2 _ h2])
    apply(clarsimp)
    apply(erule disjE) back apply(blast)
    apply(frule prio_g1g2_h1h2_a2)
    apply(assumption)+
    apply(erule disjE) apply(blast)
    apply(clarsimp simp add: m_imp_def prio2.simps)
    apply(frule f_eval_wp_case[of _ a2 _ h1])
    apply(clarsimp)
    apply(erule disjE) back back back
    apply(erule disjE) back apply(blast)
    apply(frule prio_g1g2_h1h2_a2)
    apply(assumption)+
    apply(clarsimp)
    apply(erule disjE) apply(blast)
    apply(clarsimp simp add: m_imp_def prio2.simps)
    apply(erule disjE) back back apply(blast)
    apply(frule prio_g1g2_nh1h2_a2)
    apply(assumption)+
    apply(clarsimp)
    apply(erule disjE) apply(blast)
    apply(clarsimp simp add: m_imp_def prio2.simps)
  (* a1_nh1_h2*)
  apply(erule disjE) back back back back back back
  apply(subgoal_tac "f_eval v (wp (a2, |\<not>| h1)) \<and> f_eval v (wp (a2, h2))")
  apply(clarsimp)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(clarsimp simp add: m_imp_def prio2.simps)
    (* proof of subgoal *)
    apply(clarsimp)
    apply(erule disjE) back apply(blast)
    apply(erule disjE) back back
    apply(frule f_eval_wp_case[of _ a2 _ h2])
    apply(clarsimp)
    apply(erule disjE) back back
    apply(erule disjE) apply(blast)
    apply(frule prio_g1g2_h1h2_a2)
    apply(assumption)+
    apply(erule disjE) apply(blast)
    apply(clarsimp simp add: m_imp_def prio2.simps)
    apply(erule disjE) apply(blast)
    apply(frule prio_g1g2_h1nh2_a2)
    apply(assumption)+
    apply(clarsimp simp add: m_imp_def prio2.simps)
    apply(frule f_eval_wp_case[of _ a2 _ h1])
    apply(clarsimp)
    apply(frule prio_g1g2_h1h2_a2)
    apply(assumption)+
    apply(clarsimp simp add: m_imp_def prio2.simps)
  (* a1_nh1_nh2*)
    apply(erule disjE) back back back apply(blast)
    apply(blast)

  (* g1 ng2 *)
  apply(clarsimp)
  apply(insert f_eval_wp_case2[of _ a1 h1])[1]
  apply(erule_tac x="v" in meta_allE) back
  apply(drule meta_mp) apply(blast)
  apply(insert f_eval_wp_case2[of _ a1 h2])[1]
  apply(erule_tac x="v" in meta_allE) back
  apply(drule meta_mp) apply(blast)
  apply(clarsimp)
  apply(erule disjE) back back back
  apply(erule disjE) back back back
  apply(clarsimp)
  (* a1_h1_h2*)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  (* a1_h1_nh2*)
  apply(erule disjE) apply(blast)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  (* a1_nh1_h2*)
  apply(clarsimp)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(clarsimp simp add: m_imp_def prio2.simps)

  (* ng1 g2 *)
  apply(clarsimp)
  apply(insert f_eval_wp_case2[of _ a2 h1])[1]
  apply(erule_tac x="v" in meta_allE) back
  apply(drule meta_mp) apply(blast)
  apply(insert f_eval_wp_case2[of _ a2 h2])[1]
  apply(erule_tac x="v" in meta_allE) back
  apply(drule meta_mp) apply(blast)
  apply(clarsimp)
  apply(erule disjE) back back back
  apply(erule disjE) back back back
  apply(clarsimp)
  (* a2_h1_h2*)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  (* a2_h1_nh2*)
  apply(erule disjE) apply(blast)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  (* a2_nh1_h2*)
  apply(clarsimp)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI, clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_disj1)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule conjI)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(rule f_eval_wp_disj2)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(clarsimp simp add: m_imp_def prio2.simps)
done


lemma t3: "\<lbrakk> det a1 ; det a2 ;
             prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2)) \<rbrakk> \<Longrightarrow>
              (g1 |\<longrightarrow>| wp(a1,     (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf11MIDDLEWf21RIGHT))) 
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf11MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)))

               |\<and>| 
               (g2 |\<longrightarrow>| wp(a2,     (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf12MIDDLEWf21RIGHT)))
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)))
               |\<and>|
               (g1 |\<or>| g2) 
               

             ||\<longrightarrow>||

              (h1 |\<longrightarrow>| wp(b1, T))
               |\<and>| 
              (h2 |\<longrightarrow>| wp(b2, T))
               |\<and>|
              (h1 |\<or>| h2)"
  apply(clarsimp simp add: m_imp_def f_imp_def)
  apply(insert f_eval_wp_inconst)

  apply(case_tac "f_eval v g1")
  apply(case_tac "f_eval v g2")

(* g1 g2 *)
  apply(clarsimp)
  apply(insert f_eval_wp_case2[of _ a1 h1])[1]
  apply(erule_tac x="v" in meta_allE) back
  apply(drule meta_mp) apply(blast)
  apply(insert f_eval_wp_case2[of _ a1 h2])[1]
  apply(erule_tac x="v" in meta_allE) back
  apply(drule meta_mp) apply(blast)
  apply(clarsimp)
  apply(erule disjE) back back back back back back
  apply(erule disjE) back back back back back back
  apply(clarsimp)
  (* a1_h1_h2*)
  apply(subgoal_tac "f_eval v (wp (a2, h1)) \<and> f_eval v (wp (a2, h2))")
  apply(clarsimp)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(subgoal_tac "f_eval v h1 \<and> f_eval v h2 \<and> f_eval v (wp(b1, g1 |\<and>| g2 |\<and>| wp(a1, pre LEFTWf11MIDDLEWf21RIGHT)))")
  apply(subgoal_tac "f_eval v h1 \<and> f_eval v h2 \<and> f_eval v (wp(b2, g1 |\<and>| g2 |\<and>| wp(a1, pre LEFTWf11MIDDLEWf22RIGHT)))")
  apply(clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_imp_T , simp)
  apply(rule f_eval_wp_imp_T , simp)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(clarsimp simp add: m_imp_def prio2.simps)
    (* proof of subgoal *)
    apply(erule disjE) back back back back
    apply(frule f_eval_wp_case[of _ a2 _ h2])
    apply(clarsimp)
    apply(erule disjE) back apply(blast)
    apply(frule prio_g1g2_h1nh2_a2)
    apply(assumption)+
    apply(clarsimp)
    apply(erule disjE) apply(blast)
    apply(erule disjE) apply(blast)
    apply(clarsimp simp add: m_imp_def prio2.simps)
    apply(frule f_eval_wp_case[of _ a2 _ h1])
    apply(clarsimp)
    apply(erule disjE) back back apply(blast)
    apply(frule prio_g1g2_nh1h2_a2)
    apply(assumption)+
    apply(clarsimp)
    apply(erule disjE) apply(blast)
    apply(erule disjE) apply(blast)
    apply(clarsimp simp add: m_imp_def prio2.simps)
  (* a1_h1_nh2*)
  apply(subgoal_tac "f_eval v (wp (a2, h1)) \<and> f_eval v (wp (a2, |\<not>| h2))")
  apply(clarsimp)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(subgoal_tac "f_eval v (h1 |\<and>| |\<not>| h2 |\<and>| wp (b1, g1 |\<and>| g2 |\<and>| wp (a1, pre LEFTWf11MIDDLEWf21RIGHT)))")
  apply(clarsimp)
  apply(rule f_eval_wp_imp_T , simp)
  apply(clarsimp simp add: m_imp_def prio2.simps)
    (* proof of subgoal *)
    apply(erule disjE) back back back back back
    apply(frule f_eval_wp_case[of _ a2 _ h2])
    apply(clarsimp)
    apply(erule disjE) back apply(blast)
    apply(frule prio_g1g2_h1h2_a2)
    apply(assumption)+
    apply(erule disjE) apply(blast)
    apply(clarsimp simp add: m_imp_def prio2.simps)
    apply(frule f_eval_wp_case[of _ a2 _ h1])
    apply(clarsimp)
    apply(erule disjE) back back back
    apply(erule disjE) back apply(blast)
    apply(frule prio_g1g2_h1h2_a2)
    apply(assumption)+
    apply(clarsimp)
    apply(erule disjE) apply(blast)
    apply(clarsimp simp add: m_imp_def prio2.simps)
    apply(erule disjE) back back apply(blast)
    apply(frule prio_g1g2_nh1h2_a2)
    apply(assumption)+
    apply(clarsimp)
    apply(erule disjE) apply(blast)
    apply(clarsimp simp add: m_imp_def prio2.simps)
  (* a1_nh1_h2*)
  apply(erule disjE) back back back back back back
  apply(subgoal_tac "f_eval v (wp (a2, |\<not>| h1)) \<and> f_eval v (wp (a2, h2))")
  apply(clarsimp)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(subgoal_tac "f_eval v ( |\<not>| h1 |\<and>| h2 |\<and>| wp (b2, g1 |\<and>| g2 |\<and>| wp (a1, pre LEFTWf11MIDDLEWf22RIGHT)))")
  apply(clarsimp)
  apply(rule f_eval_wp_imp_T , simp)
  apply(clarsimp simp add: m_imp_def prio2.simps)
    (* proof of subgoal *)
    apply(clarsimp)
    apply(erule disjE) back apply(blast)
    apply(erule disjE) back back
    apply(frule f_eval_wp_case[of _ a2 _ h2])
    apply(clarsimp)
    apply(erule disjE) back back
    apply(erule disjE) apply(blast)
    apply(frule prio_g1g2_h1h2_a2)
    apply(assumption)+
    apply(erule disjE) apply(blast)
    apply(clarsimp simp add: m_imp_def prio2.simps)
    apply(erule disjE) apply(blast)
    apply(frule prio_g1g2_h1nh2_a2)
    apply(assumption)+
    apply(clarsimp simp add: m_imp_def prio2.simps)
    apply(frule f_eval_wp_case[of _ a2 _ h1])
    apply(clarsimp)
    apply(frule prio_g1g2_h1h2_a2)
    apply(assumption)+
    apply(clarsimp simp add: m_imp_def prio2.simps)
  (* a1_nh1_nh2*)
    apply(erule disjE) back back back apply(blast)
    apply(blast)
(* g1 ng2 *)
  apply(clarsimp)
  apply(insert f_eval_wp_case2[of _ a1 h1])[1]
  apply(erule_tac x="v" in meta_allE) back
  apply(drule meta_mp) apply(blast)
  apply(insert f_eval_wp_case2[of _ a1 h2])[1]
  apply(erule_tac x="v" in meta_allE) back
  apply(drule meta_mp) apply(blast)
  apply(clarsimp)
  apply(erule disjE) back back back
  apply(erule disjE) back back back
  apply(clarsimp)
  (* a1_h1_h2*)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(subgoal_tac "f_eval v (h1 |\<and>| h2 |\<and>| wp (b1, g1 |\<and>| |\<not>| g2 |\<and>| wp (a1, pre LEFTWf11MIDDLEWf21RIGHT)))")
  apply(subgoal_tac "f_eval v (h1 |\<and>| h2 |\<and>| wp (b2, g1 |\<and>| |\<not>| g2 |\<and>| wp (a1, pre LEFTWf11MIDDLEWf22RIGHT)))")
  apply(clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_imp_T , simp)
  apply(rule f_eval_wp_imp_T , simp)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  (* a1_h1_nh2*)
  apply(erule disjE) apply(blast)
  apply(subgoal_tac "f_eval v (h1 |\<and>| |\<not>| h2 |\<and>| wp (b1, g1 |\<and>| |\<not>| g2 |\<and>| wp (a1, pre LEFTWf11MIDDLEWf21RIGHT)))")
  apply(clarsimp)
  apply(rule f_eval_wp_imp_T , simp)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  (* a1_nh1_h2*)
  apply(clarsimp)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(subgoal_tac "f_eval v ( |\<not>| h1 |\<and>| h2 |\<and>| wp (b2, g1 |\<and>| |\<not>| g2 |\<and>| wp (a1, pre LEFTWf11MIDDLEWf22RIGHT)))")
  apply(clarsimp)
  apply(rule f_eval_wp_imp_T , simp)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  (* ng1 g2 *)
  apply(clarsimp)
  apply(insert f_eval_wp_case2[of _ a2 h1])[1]
  apply(erule_tac x="v" in meta_allE) back
  apply(drule meta_mp) apply(blast)
  apply(insert f_eval_wp_case2[of _ a2 h2])[1]
  apply(erule_tac x="v" in meta_allE) back
  apply(drule meta_mp) apply(blast)
  apply(clarsimp)
  apply(erule disjE) back back back
  apply(erule disjE) back back back
  apply(clarsimp)
  (* a2_h1_h2*)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(subgoal_tac "f_eval v (h1 |\<and>| h2 |\<and>| wp (b1, |\<not>|g1 |\<and>| g2 |\<and>| wp (a2, pre LEFTWf12MIDDLEWf21RIGHT)))")
  apply(subgoal_tac "f_eval v (h1 |\<and>| h2 |\<and>| wp (b2, |\<not>|g1 |\<and>| g2 |\<and>| wp (a2, pre LEFTWf12MIDDLEWf22RIGHT)))")
  apply(clarsimp)
  apply(rule conjI)
  apply(rule f_eval_wp_imp_T , simp)
  apply(rule f_eval_wp_imp_T , simp)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  (* a1_h1_nh2*)
  apply(erule disjE) apply(blast)
  apply(subgoal_tac "f_eval v (h1 |\<and>| |\<not>| h2 |\<and>| wp (b1, |\<not>|g1 |\<and>| g2 |\<and>| wp (a2, pre LEFTWf12MIDDLEWf21RIGHT)))")
  apply(clarsimp)
  apply(rule f_eval_wp_imp_T , simp)
  apply(clarsimp simp add: m_imp_def prio2.simps)
  (* a1_nh1_h2*)
  apply(clarsimp)
  apply(erule disjE) apply(blast)
  apply(erule disjE) apply(blast)
  apply(subgoal_tac "f_eval v ( |\<not>| h1 |\<and>| h2 |\<and>| wp (b2, |\<not>|g1 |\<and>| g2 |\<and>| wp (a2, pre LEFTWf12MIDDLEWf22RIGHT)))")
  apply(clarsimp)
  apply(rule f_eval_wp_imp_T , simp)
  apply(clarsimp simp add: m_imp_def prio2.simps)
done

lemma simp1: "\<lbrakk> det a1 ; det a2 ;
                prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2)) \<rbrakk> \<Longrightarrow>
               (g1 |\<longrightarrow>| wp(a1,     (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf11MIDDLEWf21RIGHT))) 
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf11MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)
                                |\<and>| A1))

               |\<and>| 
               (g2 |\<longrightarrow>| wp(a2,     (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf12MIDDLEWf21RIGHT)))
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)
                                |\<and>| A2))
               |\<and>|
               (g1 |\<or>| g2) 
               

             |\<and>|

              (h1 |\<longrightarrow>| wp(b1,     (g1 |\<longrightarrow>| wp(a1, pre(LEFTWf11MIDDLEWf21RIGHT))) 
                              |\<and>| (g2 |\<longrightarrow>| wp(a2, pre(LEFTWf12MIDDLEWf21RIGHT)))
                              |\<and>| (g1 |\<or>| g2)
                              |\<and>| B1))

               |\<and>| 
               (h2 |\<longrightarrow>| wp(b2,      (g1 |\<longrightarrow>|  wp(a1, pre(LEFTWf11MIDDLEWf22RIGHT)))
                                |\<and>| (g2 |\<longrightarrow>| wp(a2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                                |\<and>| (g1 |\<or>| g2)
                                |\<and>| B2))
               |\<and>|
               (h1 |\<or>| h2) 
               
              ||=|| 

              (g1 |\<longrightarrow>| wp(a1,      (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf11MIDDLEWf21RIGHT))) 
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf11MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)
                                |\<and>| A1))

               |\<and>| 
               (g2 |\<longrightarrow>| wp(a2,     (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf12MIDDLEWf21RIGHT)))
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)
                                |\<and>| A2))
               |\<and>|
               (g1 |\<or>| g2) 
               
             |\<and>|

              (h1 |\<longrightarrow>| wp(b1, B1))
               |\<and>| 
              (h2 |\<longrightarrow>| wp(b2, B2)) 
              "
  apply(subst m_equiv_sym)
  apply(rule m_equiv_trans)
  apply(rule_tac y="((g1 |\<longrightarrow>| wp (a1, (h1 |\<longrightarrow>| wp (b1, pre LEFTWf11MIDDLEWf21RIGHT)) |\<and>| (h2 |\<longrightarrow>| wp (b2, pre LEFTWf11MIDDLEWf22RIGHT)) |\<and>| (h1 |\<or>| h2) |\<and>| A1)) |\<and>|
                    (g2 |\<longrightarrow>| wp (a2, (h1 |\<longrightarrow>| wp (b1, pre LEFTWf12MIDDLEWf21RIGHT)) |\<and>| (h2 |\<longrightarrow>| wp (b2, pre LEFTWf12MIDDLEWf22RIGHT)) |\<and>| (h1 |\<or>| h2) |\<and>| A2)) |\<and>|
                    (g1 |\<or>| g2)) |\<and>| ((h1 |\<longrightarrow>| wp (b1, B1)) |\<and>| (h2 |\<longrightarrow>| wp (b2, B2)))" in m_equiv_trans)
  apply(simp add: m_equiv_def)
  apply(rule f_and_cong)
  apply(rule t1)
  apply(rule m_equiv_refl)

  apply(rule m_equiv_trans)
  apply(rule m_imp_redund)
  apply(rule m_imp_and)
  apply(rule_tac y="((g1 |\<longrightarrow>| wp (a1, (h1 |\<longrightarrow>| wp (b1, pre LEFTWf11MIDDLEWf21RIGHT)) |\<and>| (h2 |\<longrightarrow>| wp (b2, pre LEFTWf11MIDDLEWf22RIGHT)) |\<and>| (h1 |\<or>| h2))) |\<and>|
                    (g2 |\<longrightarrow>| wp (a2, (h1 |\<longrightarrow>| wp (b1, pre LEFTWf12MIDDLEWf21RIGHT)) |\<and>| (h2 |\<longrightarrow>| wp (b2, pre LEFTWf12MIDDLEWf22RIGHT)) |\<and>| (h1 |\<or>| h2))) |\<and>|
                    (g1 |\<or>| g2)) |\<and>|
                    ((g1 |\<longrightarrow>| wp (a1, A1)) |\<and>| (g2 |\<longrightarrow>| wp (a2, A2)))" in m_imp_trans)
  apply(simp add: m_imp_def)
  apply(rule m_imp_and)
  apply(rule t2)
  apply(assumption+)
  apply(subst m_equiv_m_imp)
  apply(rule conjI)
  apply(simp add: m_imp_def)
  apply(simp add: m_imp_def)
done



lemma simp2: "\<lbrakk> det a1 ; det a2 ;
                prio2 ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2)) \<rbrakk> \<Longrightarrow>
               (g1 |\<longrightarrow>| wp(a1,     (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf11MIDDLEWf21RIGHT))) 
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf11MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)
                                |\<and>| A1))

               |\<and>| 
               (g2 |\<longrightarrow>| wp(a2,     (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf12MIDDLEWf21RIGHT)))
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)
                                |\<and>| A2))
               |\<and>|
               (g1 |\<or>| g2) 
               

             |\<and>|

              (h1 |\<longrightarrow>| wp(b1,     (g1 |\<longrightarrow>| wp(a1, pre(LEFTWf11MIDDLEWf21RIGHT))) 
                              |\<and>| (g2 |\<longrightarrow>| wp(a2, pre(LEFTWf12MIDDLEWf21RIGHT)))
                              |\<and>| (g1 |\<or>| g2)
                              |\<and>| T))

               |\<and>| 
               (h2 |\<longrightarrow>| wp(b2,      (g1 |\<longrightarrow>|  wp(a1, pre(LEFTWf11MIDDLEWf22RIGHT)))
                                |\<and>| (g2 |\<longrightarrow>| wp(a2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                                |\<and>| (g1 |\<or>| g2)
                                |\<and>| T))
               |\<and>|
               (h1 |\<or>| h2) 
               
              ||=|| 

              (g1 |\<longrightarrow>| wp(a1,      (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf11MIDDLEWf21RIGHT))) 
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf11MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)
                                |\<and>| A1))

               |\<and>| 
               (g2 |\<longrightarrow>| wp(a2,     (h1 |\<longrightarrow>| wp(b1, pre(LEFTWf12MIDDLEWf21RIGHT)))
                                |\<and>| (h2 |\<longrightarrow>| wp(b2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                                |\<and>| (h1 |\<or>| h2)
                                |\<and>| A2))
               |\<and>|
               (g1 |\<or>| g2)  
              "
  apply(subst m_equiv_sym)
  apply(rule m_equiv_trans)
  apply(rule t1)
  apply(rule m_equiv_trans)
  apply(rule m_imp_redund)
  apply(rule_tac y="((g1 |\<longrightarrow>| wp (a1, (h1 |\<longrightarrow>| wp (b1, pre LEFTWf11MIDDLEWf21RIGHT)) |\<and>| (h2 |\<longrightarrow>| wp (b2, pre LEFTWf11MIDDLEWf22RIGHT)) |\<and>| (h1 |\<or>| h2))) |\<and>|
                    (g2 |\<longrightarrow>| wp (a2, (h1 |\<longrightarrow>| wp (b1, pre LEFTWf12MIDDLEWf21RIGHT)) |\<and>| (h2 |\<longrightarrow>| wp (b2, pre LEFTWf12MIDDLEWf22RIGHT)) |\<and>| (h1 |\<or>| h2))) |\<and>|
                    (g1 |\<or>| g2)) |\<and>|
                    ((g1 |\<longrightarrow>| wp (a1, A1)) |\<and>| (g2 |\<longrightarrow>| wp (a2, A2)))" in m_imp_trans)
  apply(simp add: m_imp_def)
  apply(rule m_imp_and)
  apply(rule t2)
  apply(assumption+)

  apply(rule m_equiv_trans)
  apply(rule m_imp_redund)
  apply(rule m_imp_and)
  apply(rule_tac y="((g1 |\<longrightarrow>| wp (a1, (h1 |\<longrightarrow>| wp (b1, pre LEFTWf11MIDDLEWf21RIGHT)) |\<and>| (h2 |\<longrightarrow>| wp (b2, pre LEFTWf11MIDDLEWf22RIGHT)) |\<and>| (h1 |\<or>| h2))) |\<and>|
                    (g2 |\<longrightarrow>| wp (a2, (h1 |\<longrightarrow>| wp (b1, pre LEFTWf12MIDDLEWf21RIGHT)) |\<and>| (h2 |\<longrightarrow>| wp (b2, pre LEFTWf12MIDDLEWf22RIGHT)) |\<and>| (h1 |\<or>| h2))) |\<and>|
                    (g1 |\<or>| g2)) |\<and>|
                    ((g1 |\<longrightarrow>| wp (a1, A1)) |\<and>| (g2 |\<longrightarrow>| wp (a2, A2)))" in m_imp_trans)
  apply(simp add: m_imp_def)
  apply(rule m_imp_and)
  apply(rule t3)
  apply(assumption+)

  apply(subst m_equiv_m_imp)
  apply(rule conjI)
  apply(simp add: m_imp_def)
  apply(simp add: m_imp_def)
done

end

end

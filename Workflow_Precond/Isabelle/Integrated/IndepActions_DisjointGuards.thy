theory IndepActions_DisjointGuards
imports Wp
begin

context wp_calc
begin

fun prio:: "('f form \<times> 'a) \<Rightarrow> ('f form \<times> 'a) \<Rightarrow> bool"
where
   "prio (g,a) (h,b) = (\<forall> I.     g |\<and>| wp(a,h |\<and>| wp(b,I)) 
                         ||\<longrightarrow>|| h |\<and>| wp(b,g |\<and>| wp(a,I)) )"

lemma "prio (g,a) (g,a)"
  by(simp add: m_imp_def)

lemma prio_g_F: "prio (g,a) (F,b)"
  by(insert wp_false, simp add: m_equiv_def m_imp_def)

lemma prio_F_g: "prio (F,b) (g,a)"
  by(insert wp_false, simp add: m_equiv_def m_imp_def)





lemma simp1: "\<lbrakk> det a1 ; det a2 ;
                prio (g1,a1) (h1,b1) ; prio (g1,a1) (h2,b2) ; prio (g2,a2) (h1,b1) ; prio (g2,a2) (h2,b2) ;
                g1 |\<and>| g2 ||=|| F ; h1 |\<and>| h2 ||=|| F \<rbrakk> \<Longrightarrow>
               (g1 |\<and>| wp(a1,   (h1 |\<and>| wp(b1, pre(LEFTWf11MIDDLEWf21RIGHT)) 
                             |\<or>| h2 |\<and>| wp(b2, pre(LEFTWf11MIDDLEWf22RIGHT)))
                           |\<and>| A1 )

               |\<or>| 
               g2 |\<and>| wp(a2,    (h1 |\<and>| wp(b1, pre(LEFTWf12MIDDLEWf21RIGHT)) 
                             |\<or>| h2 |\<and>| wp(b2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                           |\<and>| A2))

             |\<and>|

              (h1 |\<and>| wp(b1,    (g1 |\<and>| wp(a1, pre(LEFTWf11MIDDLEWf21RIGHT)) 
                             |\<or>| g2 |\<and>| wp(a2, pre(LEFTWf12MIDDLEWf21RIGHT)))
                           |\<and>| B1 )

               |\<or>| 
               h2 |\<and>| wp(b2,    (g1 |\<and>| wp(a1, pre(LEFTWf11MIDDLEWf22RIGHT)) 
                             |\<or>| g2 |\<and>| wp(a2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                           |\<and>| B2)) 

              ||=|| 
              
               (g1 |\<and>| wp(a1,   (h1 |\<and>| wp(b1, pre(LEFTWf11MIDDLEWf21RIGHT)) 
                             |\<or>| h2 |\<and>| wp(b2, pre(LEFTWf11MIDDLEWf22RIGHT)))
                           |\<and>| A1 )

               |\<or>| 
               g2 |\<and>| wp(a2,    (h1 |\<and>| wp(b1, pre(LEFTWf12MIDDLEWf21RIGHT)) 
                             |\<or>| h2 |\<and>| wp(b2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                           |\<and>| A2))

             |\<and>|

              (h1 |\<and>| wp(b1, B1)

               |\<or>| 
               h2 |\<and>| wp(b2, B2))
              "
apply(simp add: m_equiv_def , clarsimp , rule iffI, clarsimp)

apply(erule disjE)+
apply(clarsimp)
apply(clarsimp)
apply(erule disjE)
apply(clarsimp)
apply(clarsimp)

apply(clarsimp simp add: m_imp_def) 
apply(erule disjE)+

apply(clarsimp)
apply(erule disjE)
apply(clarsimp)
apply(erule_tac x="pre LEFTWf11MIDDLEWf21RIGHT" in allE)
apply(erule_tac x="v" in allE) back back
apply(clarsimp)
apply(rule_tac f="g1 |\<and>| wp (a1, pre LEFTWf11MIDDLEWf21RIGHT)" in f_eval_wp_cong)
apply(simp)
apply(clarsimp simp add: m_imp_def)
apply(clarsimp)
apply(erule_tac x="pre LEFTWf11MIDDLEWf22RIGHT" in allE) back
apply(erule_tac x="v" in allE) back back
apply(clarsimp)

apply(clarsimp)
apply(erule disjE)
apply(clarsimp)
apply(clarsimp)
apply(erule_tac x="pre LEFTWf11MIDDLEWf22RIGHT" in allE) back
apply(erule_tac x="v" in allE) back back
apply(clarsimp)
apply(erule notE)
apply(rule_tac f="g1 |\<and>| wp (a1, pre LEFTWf11MIDDLEWf22RIGHT)" in f_eval_wp_cong)
apply(simp)
apply(clarsimp simp add: m_imp_def)

apply(clarsimp)
apply(erule disjE)+
apply(clarsimp)
apply(erule_tac x="pre LEFTWf12MIDDLEWf21RIGHT" in allE) back back
apply(erule_tac x="v" in allE) back back
apply(clarsimp)
apply(rule_tac f="g2 |\<and>| wp (a2, pre LEFTWf12MIDDLEWf21RIGHT)" in f_eval_wp_cong)
apply(simp)
apply(clarsimp simp add: m_imp_def)
apply(clarsimp)
apply(erule_tac x="pre LEFTWf12MIDDLEWf22RIGHT" in allE) back back back
apply(erule_tac x="v" in allE) back back
apply(clarsimp)

apply(clarsimp)
apply(erule disjE)
apply(clarsimp)
apply(clarsimp)
apply(erule_tac x="pre LEFTWf12MIDDLEWf22RIGHT" in allE) back back back
apply(erule_tac x="v" in allE) back back
apply(clarsimp)
apply(erule notE)
apply(rule_tac f="g2 |\<and>| wp (a2, pre LEFTWf12MIDDLEWf22RIGHT)" in f_eval_wp_cong)
apply(simp)
apply(clarsimp simp add: m_imp_def)
done
  
lemma simp2: "\<lbrakk> det a1 ; det a2 ; 
               prio (g1,a1) (h1,b1) ; prio (g1,a1) (h2,b2) ; prio (g2,a2) (h1,b1) ; prio (g2,a2) (h2,b2) ;
         g1 |\<and>| g2 ||=|| F ; h1 |\<and>| h2 ||=|| F ; 
         B1 ||=|| T ; B2 ||=|| T \<rbrakk> \<Longrightarrow>
              (g1 |\<and>| wp(a1,   (h1 |\<and>| wp(b1, pre(LEFTWf11MIDDLEWf21RIGHT)) 
                             |\<or>| h2 |\<and>| wp(b2, pre(LEFTWf11MIDDLEWf22RIGHT)))
                           |\<and>| A1 )

               |\<or>| 
               g2 |\<and>| wp(a2,    (h1 |\<and>| wp(b1, pre(LEFTWf12MIDDLEWf21RIGHT)) 
                             |\<or>| h2 |\<and>| wp(b2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                           |\<and>| A2))

             |\<and>|

              (h1 |\<and>| wp(b1, B1)

               |\<or>| 
               h2 |\<and>| wp(b2, B2))

           ||=|| 

               (g1 |\<and>| wp(a1,   (h1 |\<and>| wp(b1, pre(LEFTWf11MIDDLEWf21RIGHT)) 
                             |\<or>| h2 |\<and>| wp(b2, pre(LEFTWf11MIDDLEWf22RIGHT)))
                           |\<and>| A1 )

               |\<or>| 
               g2 |\<and>| wp(a2,    (h1 |\<and>| wp(b1, pre(LEFTWf12MIDDLEWf21RIGHT)) 
                             |\<or>| h2 |\<and>| wp(b2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                           |\<and>| A2))"
apply(simp add: m_equiv_def , clarsimp , rule iffI)
apply(clarsimp)

apply(erule disjE)
apply(clarsimp)
apply(erule disjE)
apply(clarsimp)
apply(erule_tac x="T" in allE)
apply(simp add: m_imp_def)
apply(erule_tac x="v" in allE) back back back back
apply(drule mp) back
apply(drule f_eval_wp_wp_imp_T)
apply(clarsimp)
apply(insert wp_cong_equiv[of "wp (b1, T)" "wp (b1, B1)" a1])[1]
apply(drule meta_mp)
apply(rule wp_cong_equiv , simp add: equiv_def)
apply(simp add: m_equiv_def)
apply(clarsimp)
apply(drule f_eval_wp_imp_T) back back back
apply(insert wp_cong_equiv[of "T" "B1" b1])[1]
apply(drule meta_mp)
apply(simp add: m_equiv_def)
apply(simp add: m_equiv_def)

apply(clarsimp)
apply(erule_tac x="T" in allE) back
apply(simp add: m_imp_def)
apply(erule_tac x="v" in allE) back back back back
apply(drule mp) back
apply(drule f_eval_wp_wp_imp_T)
apply(clarsimp)
apply(insert wp_cong_equiv[of "wp (b2, T)" "wp (b2, B2)" a1])[1]
apply(drule meta_mp)
apply(rule wp_cong_equiv , simp add: m_equiv_def)
apply(simp add: m_equiv_def)
apply(clarsimp)
apply(drule f_eval_wp_imp_T) back back back
apply(insert wp_cong_equiv[of "T" "B2" b2])[1]
apply(drule meta_mp)
apply(simp add: m_equiv_def)
apply(simp add: m_equiv_def)

apply(clarsimp)
apply(erule disjE)
apply(clarsimp)
apply(erule_tac x="T" in allE) back back
apply(simp add: m_imp_def)
apply(erule_tac x="v" in allE) back back back back
apply(drule mp) back
apply(drule f_eval_wp_wp_imp_T)
apply(clarsimp)
apply(insert wp_cong_equiv[of "wp (b1, T)" "wp (b1, B1)" a2])[1]
apply(drule meta_mp)
apply(rule wp_cong_equiv , simp add: m_equiv_def)
apply(simp add: m_equiv_def)
apply(clarsimp)
apply(drule f_eval_wp_imp_T) back back back
apply(insert wp_cong_equiv[of "T" "B1" b1])[1]
apply(drule meta_mp)
apply(simp add: m_equiv_def)
apply(simp add: m_equiv_def)

apply(clarsimp)
apply(erule_tac x="T" in allE) back back back
apply(simp add: m_imp_def)
apply(erule_tac x="v" in allE) back back back back
apply(drule mp) back
apply(drule f_eval_wp_wp_imp_T)
apply(clarsimp)
apply(insert wp_cong_equiv[of "wp (b2, T)" "wp (b2, B2)" a2])[1]
apply(drule meta_mp)
apply(rule wp_cong_equiv , simp add: m_equiv_def)
apply(simp add: m_equiv_def)
apply(clarsimp)
apply(drule f_eval_wp_imp_T) back back back
apply(insert wp_cong_equiv[of "T" "B2" b2])[1]
apply(drule meta_mp)
apply(simp add: m_equiv_def)
apply(simp add: m_equiv_def)
done


lemma simp_comb: "\<lbrakk> det a1; det a2;
                    prio (g1,a1) (h1,b1) ; prio (g1,a1) (h2,b2) ; prio (g2,a2) (h1,b1) ; prio (g2,a2) (h2,b2) ;
                    g1 |\<and>| g2 ||=|| F ; h1 |\<and>| h2 ||=|| F ;
                    B1 ||=|| T ; B2 ||=|| T \<rbrakk> \<Longrightarrow>
               (g1 |\<and>| wp(a1,   (h1 |\<and>| wp(b1, pre(LEFTWf11MIDDLEWf21RIGHT)) 
                             |\<or>| h2 |\<and>| wp(b2, pre(LEFTWf11MIDDLEWf22RIGHT)))
                           |\<and>| A1 )

               |\<or>| 
               g2 |\<and>| wp(a2,    (h1 |\<and>| wp(b1, pre(LEFTWf12MIDDLEWf21RIGHT)) 
                             |\<or>| h2 |\<and>| wp(b2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                           |\<and>| A2))

             |\<and>|

              (h1 |\<and>| wp(b1,    (g1 |\<and>| wp(a1, pre(LEFTWf11MIDDLEWf21RIGHT)) 
                             |\<or>| g2 |\<and>| wp(a2, pre(LEFTWf12MIDDLEWf21RIGHT)))
                           |\<and>| B1 )

               |\<or>| 
               h2 |\<and>| wp(b2,    (g1 |\<and>| wp(a1, pre(LEFTWf11MIDDLEWf22RIGHT)) 
                             |\<or>| g2 |\<and>| wp(a2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                           |\<and>| B2)) 

              ||=|| 
              
               (g1 |\<and>| wp(a1,   (h1 |\<and>| wp(b1, pre(LEFTWf11MIDDLEWf21RIGHT)) 
                             |\<or>| h2 |\<and>| wp(b2, pre(LEFTWf11MIDDLEWf22RIGHT)))
                           |\<and>| A1 )

               |\<or>| 
               g2 |\<and>| wp(a2,    (h1 |\<and>| wp(b1, pre(LEFTWf12MIDDLEWf21RIGHT)) 
                             |\<or>| h2 |\<and>| wp(b2, pre(LEFTWf12MIDDLEWf22RIGHT)))
                           |\<and>| A2))
              "
apply(rule m_equiv_trans)
apply(rule simp1 , assumption+)
apply(rule simp2 , assumption+)
done

end

end

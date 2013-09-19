theory Formulas
imports Main
begin

datatype 'f form = atom "'f" 
                 | not "'f form"            ("|\<not>| _" [66] 66)
                 | or "'f form" "'f form"   (infixr "|\<or>|" 64)

definition f_and :: "'f form \<Rightarrow> 'f form \<Rightarrow> 'f form" (infixr "|\<and>|" 65)
where
  "x |\<and>| y \<equiv>  |\<not>| ( |\<not>| x |\<or>| |\<not>| y)"

definition F:: "'f form"
where
  "F \<equiv> undefined |\<and>| |\<not>| undefined"

definition T:: "'f form"
where
  "T \<equiv> undefined |\<or>| |\<not>| undefined"

definition f_imp:: "'f form \<Rightarrow> 'f form \<Rightarrow> 'f form"  (infixr "|\<longrightarrow>|" 62)
where
  "x |\<longrightarrow>| y \<equiv> |\<not>| x |\<or>| y" 


fun f_eval:: "('f \<Rightarrow> bool) \<Rightarrow> 'f form \<Rightarrow> bool"
where
  "f_eval v (atom f) = v f"
| "f_eval v ( |\<not>| x) = ( \<not> (f_eval v x) )" 
| "f_eval v (x |\<or>| y) = ((f_eval v x) \<or> (f_eval v y))"

lemma [simp]: "f_eval v (x |\<and>| y) = ((f_eval v x) \<and> (f_eval v y))"
  by(simp add: f_and_def)
lemma [simp]: "f_eval v T = True"
  by(simp add: T_def)
lemma [simp]: "f_eval v F = False"
  by(simp add: F_def)
lemma [simp]: "f_eval v (x |\<longrightarrow>| y) = (f_eval v x \<longrightarrow> f_eval v y)"
  by(simp add: f_imp_def)


definition m_imp:: "'f form \<Rightarrow> 'f form \<Rightarrow> bool" (infixr "||\<longrightarrow>||" 61)
where
  "f1 ||\<longrightarrow>|| f2 \<equiv> \<forall> v. f_eval v f1 \<longrightarrow> f_eval v f2"

definition m_equiv :: "'f form \<Rightarrow> 'f form \<Rightarrow> bool" (infix "||=||" 60)
where
  "f1 ||=|| f2 \<equiv> (\<forall> v. f_eval v f1 = f_eval v f2)" 

lemma m_equiv_m_imp: "(f1 ||=|| f2) = (f1  ||\<longrightarrow>|| f2 \<and> f2 ||\<longrightarrow>|| f1)"
  by(auto simp add: m_equiv_def m_imp_def)

lemma m_equiv_refl: "x ||=|| x"
  by(simp add: m_equiv_def)

lemma m_equiv_trans[trans]: "x ||=|| y \<Longrightarrow> y ||=|| z \<Longrightarrow> x ||=|| z"
  by(simp add: m_equiv_def)

lemma m_equiv_sym: "(x ||=|| y) = (y ||=|| x)"
  by(auto simp add: m_equiv_def)

lemma f_and_assoc: "x |\<and>| y |\<and>| z ||=|| (x |\<and>| y) |\<and>| z"
  by(simp add: m_equiv_def)

lemma f_and_idemp: "x |\<and>| x ||=|| x"
  by(simp add: m_equiv_def)




lemma f_and_cong: "\<lbrakk> f1 ||=|| f1' ; f2 ||=|| f2' \<rbrakk> \<Longrightarrow> f1 |\<and>| f2 ||=|| f1' |\<and>| f2'"
  by(simp add: m_equiv_def)

lemma f_or_cong: "\<lbrakk> f1 ||=|| f1' ; f2 ||=|| f2' \<rbrakk> \<Longrightarrow> f1 |\<or>| f2 ||=|| f1' |\<or>| f2'"
  by(simp add: m_equiv_def)

lemma f_imp_cong: "\<lbrakk> f1 ||=|| f1' ; f2 ||=|| f2' \<rbrakk> \<Longrightarrow> (f1 |\<longrightarrow>| f2) ||=|| (f1' |\<longrightarrow>| f2')"
  by(simp add: m_equiv_def)

lemma m_imp_cong: "\<lbrakk> f1 ||=|| f1' ; f2 ||=|| f2' \<rbrakk> \<Longrightarrow> f1 ||\<longrightarrow>|| f2 \<Longrightarrow> f1' ||\<longrightarrow>|| f2'"
  by(simp add: m_equiv_def m_imp_def)




lemma m_imp_redund: "f ||\<longrightarrow>|| f' \<Longrightarrow> f ||=|| f |\<and>| f'"
  by(auto simp add: m_equiv_def m_imp_def)

lemma m_imp_and: "f ||\<longrightarrow>|| f' \<Longrightarrow> f |\<and>| f'' ||\<longrightarrow>|| f'"
  by(simp add: m_imp_def)

lemma m_imp_trans: "\<lbrakk> x ||\<longrightarrow>|| y ; y ||\<longrightarrow>|| z \<rbrakk> \<Longrightarrow> x ||\<longrightarrow>|| z"
  by(simp add: m_imp_def)

lemma f_imp_m_equiv_conj: "(g |\<longrightarrow>| A |\<and>| B) ||=|| (g |\<longrightarrow>| A) |\<and>| (g |\<longrightarrow>| B)"
  by(auto simp add: m_equiv_def)

lemma m_imp_imp_conj: "\<lbrakk> A ||\<longrightarrow>|| B ; A ||\<longrightarrow>|| C \<rbrakk> \<Longrightarrow> A ||\<longrightarrow>|| B |\<and>| C"
  by(simp add: m_imp_def)

lemma [simp]: "g1 |\<and>| g2 ||=|| F
              \<longleftrightarrow> g1 ||\<longrightarrow>|| |\<not>| g2 \<and> g2 ||\<longrightarrow>|| |\<not>| g1"
  by(auto simp add: m_equiv_def m_imp_def)

lemma f_eval_m_imp_mp: "\<lbrakk> f_eval v g ; g ||\<longrightarrow>|| g2 \<rbrakk> \<Longrightarrow> f_eval v g2"
  by(clarsimp simp add: m_imp_def)

end
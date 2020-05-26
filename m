Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465031AFE24
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 22:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDSUgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 16:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgDSUgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 16:36:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FB9C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 13:36:16 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQGfi-0007LO-Cs; Sun, 19 Apr 2020 22:36:10 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 5C7C0FFBA2;
        Sun, 19 Apr 2020 22:36:09 +0200 (CEST)
Message-Id: <20200419203336.319268126@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 19 Apr 2020 22:31:44 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [patch 07/15] x86/tlb: Move __flush_tlb_one_user() out of line
References: <20200419203137.214111265@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_tlbstate is exported because various TLB related functions need access
to it, but cpu_tlbstate is sensitive information which should only be
accessed by well contained kernel functions and not be directly exposed to
modules.

The various TLB flush functions need access to cpu_tlbstate. As third step
move _flush_tlb_one_user() out of line and hide the native function. The
latter can be static when CONFIG_PARAVIRT is disabled.

Consolidate the name space while at it and remove the pointless extra
wrapper in the paravirt code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h |    1 
 arch/x86/include/asm/tlbflush.h |   53 +--------------------------------------
 arch/x86/kernel/paravirt.c      |    5 ---
 arch/x86/mm/tlb.c               |   54 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 56 deletions(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -49,6 +49,7 @@ static inline void slow_down_io(void)
 
 void native_flush_tlb_local(void);
 void native_flush_tlb_global(void);
+void native_flush_tlb_one_user(unsigned long addr);
 
 static inline void __flush_tlb_local(void)
 {
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -142,11 +142,10 @@ static inline unsigned long build_cr3_no
 
 void flush_tlb_local(void);
 void flush_tlb_global(void);
+void flush_tlb_one_user(unsigned long addr);
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
-#else
-#define __flush_tlb_one_user(addr)	__native_flush_tlb_one_user(addr)
 #endif
 
 struct tlb_context {
@@ -346,54 +345,6 @@ static inline void cr4_set_bits_and_upda
 extern void initialize_tlbstate_and_flush(void);
 
 /*
- * Given an ASID, flush the corresponding user ASID.  We can delay this
- * until the next time we switch to it.
- *
- * See SWITCH_TO_USER_CR3.
- */
-static inline void invalidate_user_asid(u16 asid)
-{
-	/* There is no user ASID if address space separation is off */
-	if (!IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION))
-		return;
-
-	/*
-	 * We only have a single ASID if PCID is off and the CR3
-	 * write will have flushed it.
-	 */
-	if (!cpu_feature_enabled(X86_FEATURE_PCID))
-		return;
-
-	if (!static_cpu_has(X86_FEATURE_PTI))
-		return;
-
-	__set_bit(kern_pcid(asid),
-		  (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_flush_mask));
-}
-
-/*
- * flush one page in the user mapping
- */
-static inline void __native_flush_tlb_one_user(unsigned long addr)
-{
-	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-
-	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
-
-	if (!static_cpu_has(X86_FEATURE_PTI))
-		return;
-
-	/*
-	 * Some platforms #GP if we call invpcid(type=1/2) before CR4.PCIDE=1.
-	 * Just use invalidate_user_asid() in case we are called early.
-	 */
-	if (!this_cpu_has(X86_FEATURE_INVPCID_SINGLE))
-		invalidate_user_asid(loaded_mm_asid);
-	else
-		invpcid_flush_one(user_pcid(loaded_mm_asid), addr);
-}
-
-/*
  * flush everything
  */
 static inline void __flush_tlb_all(void)
@@ -432,7 +383,7 @@ static inline void __flush_tlb_one_kerne
 	 * kernel address space and for its usermode counterpart, but it does
 	 * not flush it for other address spaces.
 	 */
-	__flush_tlb_one_user(addr);
+	flush_tlb_one_user(addr);
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -160,11 +160,6 @@ unsigned paravirt_patch_insns(void *insn
 	return insn_len;
 }
 
-static void native_flush_tlb_one_user(unsigned long addr)
-{
-	__native_flush_tlb_one_user(addr);
-}
-
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -24,6 +24,7 @@
 # define STATIC_NOPV			static
 # define __flush_tlb_local		native_flush_tlb_local
 # define __flush_tlb_global		native_flush_tlb_global
+# define __flush_tlb_one_user(addr)	native_flush_tlb_one_user(addr)
 #endif
 
 /*
@@ -118,6 +119,32 @@ static void choose_new_asid(struct mm_st
 	*need_flush = true;
 }
 
+/*
+ * Given an ASID, flush the corresponding user ASID.  We can delay this
+ * until the next time we switch to it.
+ *
+ * See SWITCH_TO_USER_CR3.
+ */
+static inline void invalidate_user_asid(u16 asid)
+{
+	/* There is no user ASID if address space separation is off */
+	if (!IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION))
+		return;
+
+	/*
+	 * We only have a single ASID if PCID is off and the CR3
+	 * write will have flushed it.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_PCID))
+		return;
+
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	__set_bit(kern_pcid(asid),
+		  (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_flush_mask));
+}
+
 static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, bool need_flush)
 {
 	unsigned long new_mm_cr3;
@@ -892,6 +919,33 @@ unsigned long __get_current_cr3_fast(voi
 EXPORT_SYMBOL_GPL(__get_current_cr3_fast);
 
 /*
+ * Flush one page in the user mapping
+ */
+STATIC_NOPV void native_flush_tlb_one_user(unsigned long addr)
+{
+	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+
+	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
+
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	/*
+	 * Some platforms #GP if we call invpcid(type=1/2) before CR4.PCIDE=1.
+	 * Just use invalidate_user_asid() in case we are called early.
+	 */
+	if (!this_cpu_has(X86_FEATURE_INVPCID_SINGLE))
+		invalidate_user_asid(loaded_mm_asid);
+	else
+		invpcid_flush_one(user_pcid(loaded_mm_asid), addr);
+}
+
+void flush_tlb_one_user(unsigned long addr)
+{
+	__flush_tlb_one_user(addr);
+}
+
+/*
  * Flush everything
  */
 STATIC_NOPV void native_flush_tlb_global(void)


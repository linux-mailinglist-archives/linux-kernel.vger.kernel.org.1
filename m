Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B8A1B22B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 11:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgDUJ10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 05:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728632AbgDUJ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:27:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47024C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:27:21 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQpBO-00086I-9N; Tue, 21 Apr 2020 11:27:10 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 671341002EE;
        Tue, 21 Apr 2020 11:27:09 +0200 (CEST)
Message-Id: <20200421092600.328438734@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 21 Apr 2020 11:20:43 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [patch V2 16/16] x86/tlb: Restrict access to tlbstate
References: <20200421092027.591582014@linutronix.de>
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

Hide tlbstate, flush_tlb_info and related helpers when tlbflush.h is
included from a module. Modules have absolutely no business with these
internals.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/tlbflush.h |   96 ++++++++++++++++++++--------------------
 arch/x86/mm/init.c              |    1 
 2 files changed, 49 insertions(+), 48 deletions(-)

--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -13,19 +13,46 @@
 #include <asm/pti.h>
 #include <asm/processor-flags.h>
 
-struct flush_tlb_info;
-
 void __flush_tlb_all(void);
-void flush_tlb_local(void);
-void flush_tlb_one_user(unsigned long addr);
-void flush_tlb_one_kernel(unsigned long addr);
-void flush_tlb_others(const struct cpumask *cpumask,
-		      const struct flush_tlb_info *info);
 
-#ifdef CONFIG_PARAVIRT
-#include <asm/paravirt.h>
-#endif
+#define TLB_FLUSH_ALL	-1UL
+
+void cr4_update_irqsoff(unsigned long set, unsigned long clear);
+unsigned long cr4_read_shadow(void);
+
+/* Set in this cpu's CR4. */
+static inline void cr4_set_bits_irqsoff(unsigned long mask)
+{
+	cr4_update_irqsoff(mask, 0);
+}
 
+/* Clear in this cpu's CR4. */
+static inline void cr4_clear_bits_irqsoff(unsigned long mask)
+{
+	cr4_update_irqsoff(0, mask);
+}
+
+/* Set in this cpu's CR4. */
+static inline void cr4_set_bits(unsigned long mask)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cr4_set_bits_irqsoff(mask);
+	local_irq_restore(flags);
+}
+
+/* Clear in this cpu's CR4. */
+static inline void cr4_clear_bits(unsigned long mask)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cr4_clear_bits_irqsoff(mask);
+	local_irq_restore(flags);
+}
+
+#ifndef MODULE
 /*
  * 6 because 6 should be plenty and struct tlb_state will fit in two cache
  * lines.
@@ -129,54 +156,17 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct tl
 bool nmi_uaccess_okay(void);
 #define nmi_uaccess_okay nmi_uaccess_okay
 
-void cr4_update_irqsoff(unsigned long set, unsigned long clear);
-unsigned long cr4_read_shadow(void);
-
 /* Initialize cr4 shadow for this CPU. */
 static inline void cr4_init_shadow(void)
 {
 	this_cpu_write(cpu_tlbstate.cr4, __read_cr4());
 }
 
-/* Set in this cpu's CR4. */
-static inline void cr4_set_bits_irqsoff(unsigned long mask)
-{
-	cr4_update_irqsoff(mask, 0);
-}
-
-/* Clear in this cpu's CR4. */
-static inline void cr4_clear_bits_irqsoff(unsigned long mask)
-{
-	cr4_update_irqsoff(0, mask);
-}
-
-/* Set in this cpu's CR4. */
-static inline void cr4_set_bits(unsigned long mask)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	cr4_set_bits_irqsoff(mask);
-	local_irq_restore(flags);
-}
-
-/* Clear in this cpu's CR4. */
-static inline void cr4_clear_bits(unsigned long mask)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	cr4_clear_bits_irqsoff(mask);
-	local_irq_restore(flags);
-}
-
 extern unsigned long mmu_cr4_features;
 extern u32 *trampoline_cr4_features;
 
 extern void initialize_tlbstate_and_flush(void);
 
-#define TLB_FLUSH_ALL	-1UL
-
 /*
  * TLB flushing:
  *
@@ -215,6 +205,16 @@ struct flush_tlb_info {
 	bool			freed_tables;
 };
 
+void flush_tlb_local(void);
+void flush_tlb_one_user(unsigned long addr);
+void flush_tlb_one_kernel(unsigned long addr);
+void flush_tlb_others(const struct cpumask *cpumask,
+		      const struct flush_tlb_info *info);
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#endif
+
 #define flush_tlb_mm(mm)						\
 		flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true)
 
@@ -255,4 +255,6 @@ static inline void arch_tlbbatch_add_mm(
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
+#endif /* !MODULE */
+
 #endif /* _ASM_X86_TLBFLUSH_H */
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -970,7 +970,6 @@ void __init zone_sizes_init(void)
 	.next_asid = 1,
 	.cr4 = ~0UL,	/* fail hard if we screw up cr4 shadow initialization */
 };
-EXPORT_PER_CPU_SYMBOL(cpu_tlbstate);
 
 void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache)
 {


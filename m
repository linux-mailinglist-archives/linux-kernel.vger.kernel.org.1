Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3271AFE2E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 22:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgDSUgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 16:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSUgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 16:36:11 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7360C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 13:36:11 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQGfc-0007Ip-4B; Sun, 19 Apr 2020 22:36:04 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 37825FFBA2;
        Sun, 19 Apr 2020 22:36:03 +0200 (CEST)
Message-Id: <20200419203335.856333226@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 19 Apr 2020 22:31:39 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [patch 02/15] x86/cpu: Uninline CR4 accessors
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

The various CR4 accessors require cpu_tlbstate as the CR4 shadow cache is
located there.

In preparation of unexporting cpu_tlbstate create a builtin function for
manipulating CR4 and rework the various helpers to use it.

Export native_write_cr4() only when CONFIG_LKTDM=m.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/tlbflush.h |   36 +++++-------------------------------
 arch/x86/kernel/cpu/common.c    |   25 ++++++++++++++++++++++++-
 arch/x86/kernel/process.c       |   11 +++++++++++
 3 files changed, 40 insertions(+), 32 deletions(-)

--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -276,37 +276,25 @@ static inline bool nmi_uaccess_okay(void
 
 #define nmi_uaccess_okay nmi_uaccess_okay
 
+void cr4_update_irqsoff(unsigned long set, unsigned long clear);
+unsigned long cr4_read_shadow(void);
+
 /* Initialize cr4 shadow for this CPU. */
 static inline void cr4_init_shadow(void)
 {
 	this_cpu_write(cpu_tlbstate.cr4, __read_cr4());
 }
 
-static inline void __cr4_set(unsigned long cr4)
-{
-	lockdep_assert_irqs_disabled();
-	this_cpu_write(cpu_tlbstate.cr4, cr4);
-	__write_cr4(cr4);
-}
-
 /* Set in this cpu's CR4. */
 static inline void cr4_set_bits_irqsoff(unsigned long mask)
 {
-	unsigned long cr4;
-
-	cr4 = this_cpu_read(cpu_tlbstate.cr4);
-	if ((cr4 | mask) != cr4)
-		__cr4_set(cr4 | mask);
+	cr4_update_irqsoff(mask, 0);
 }
 
 /* Clear in this cpu's CR4. */
 static inline void cr4_clear_bits_irqsoff(unsigned long mask)
 {
-	unsigned long cr4;
-
-	cr4 = this_cpu_read(cpu_tlbstate.cr4);
-	if ((cr4 & ~mask) != cr4)
-		__cr4_set(cr4 & ~mask);
+	cr4_update_irqsoff(0, mask);
 }
 
 /* Set in this cpu's CR4. */
@@ -329,20 +317,6 @@ static inline void cr4_clear_bits(unsign
 	local_irq_restore(flags);
 }
 
-static inline void cr4_toggle_bits_irqsoff(unsigned long mask)
-{
-	unsigned long cr4;
-
-	cr4 = this_cpu_read(cpu_tlbstate.cr4);
-	__cr4_set(cr4 ^ mask);
-}
-
-/* Read the CR4 shadow. */
-static inline unsigned long cr4_read_shadow(void)
-{
-	return this_cpu_read(cpu_tlbstate.cr4);
-}
-
 /*
  * Mark all other ASIDs as invalid, preserves the current.
  */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -387,7 +387,30 @@ void native_write_cr4(unsigned long val)
 			  bits_missing);
 	}
 }
-EXPORT_SYMBOL(native_write_cr4);
+#if IS_MODULE(CONFIG_LKDTM)
+EXPORT_SYMBOL_GPL(native_write_cr4);
+#endif
+
+void cr4_update_irqsoff(unsigned long set, unsigned long clear)
+{
+	unsigned long newval, cr4 = this_cpu_read(cpu_tlbstate.cr4);
+
+	lockdep_assert_irqs_disabled();
+
+	newval = (cr4 & ~clear) | set;
+	if (newval != cr4) {
+		this_cpu_write(cpu_tlbstate.cr4, newval);
+		__write_cr4(newval);
+	}
+}
+EXPORT_SYMBOL(cr4_update_irqsoff);
+
+/* Read the CR4 shadow. */
+unsigned long cr4_read_shadow(void)
+{
+	return this_cpu_read(cpu_tlbstate.cr4);
+}
+EXPORT_SYMBOL_GPL(cr4_read_shadow);
 
 void cr4_init(void)
 {
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -612,6 +612,17 @@ void speculation_ctrl_update_current(voi
 	preempt_enable();
 }
 
+static inline void cr4_toggle_bits_irqsoff(unsigned long mask)
+{
+	unsigned long newval, cr4 = this_cpu_read(cpu_tlbstate.cr4);
+
+	newval = cr4 ^ mask;
+	if (newval != cr4) {
+		this_cpu_write(cpu_tlbstate.cr4, newval);
+		__write_cr4(newval);
+	}
+}
+
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 {
 	unsigned long tifp, tifn;


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691DC1C586F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgEEOOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729630AbgEEOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC01C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:40 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyL1-00011q-GB; Tue, 05 May 2020 16:14:23 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id C5A48FFC8D;
        Tue,  5 May 2020 16:14:22 +0200 (CEST)
Message-Id: <20200505134340.902709267@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:41:20 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 2 08/18] lib/smp_processor_id: Move it into noinstr section
References: <20200505134112.272268764@linutronix.de>
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

That code is already not traceable. Move it into the noinstr section so the
objtool section validation does not trigger.

Annotate the warning code as "safe". While it might be not under all
circumstances, getting the information out is important enough.

Should this ever trigger from the sensitive code which is shielded against
instrumentation, e.g. low level entry, then the printk is the least of the
worries.

Addresses the objtool warnings:
 vmlinux.o: warning: objtool: context_tracking_recursion_enter()+0x7: call to __this_cpu_preempt_check() leaves .noinstr.text section
 vmlinux.o: warning: objtool: __context_tracking_exit()+0x17: call to __this_cpu_preempt_check() leaves .noinstr.text section
 vmlinux.o: warning: objtool: __context_tracking_enter()+0x2a: call to __this_cpu_preempt_check() leaves .noinstr.text section

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/smp_processor_id.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -8,7 +8,7 @@
 #include <linux/kprobes.h>
 #include <linux/sched.h>
 
-notrace static nokprobe_inline
+noinstr static
 unsigned int check_preemption_disabled(const char *what1, const char *what2)
 {
 	int this_cpu = raw_smp_processor_id();
@@ -37,6 +37,7 @@ unsigned int check_preemption_disabled(c
 	 */
 	preempt_disable_notrace();
 
+	instr_begin();
 	if (!printk_ratelimit())
 		goto out_enable;
 
@@ -45,6 +46,7 @@ unsigned int check_preemption_disabled(c
 
 	printk("caller is %pS\n", __builtin_return_address(0));
 	dump_stack();
+	instr_end();
 
 out_enable:
 	preempt_enable_no_resched_notrace();
@@ -52,16 +54,14 @@ unsigned int check_preemption_disabled(c
 	return this_cpu;
 }
 
-notrace unsigned int debug_smp_processor_id(void)
+noinstr unsigned int debug_smp_processor_id(void)
 {
 	return check_preemption_disabled("smp_processor_id", "");
 }
 EXPORT_SYMBOL(debug_smp_processor_id);
-NOKPROBE_SYMBOL(debug_smp_processor_id);
 
-notrace void __this_cpu_preempt_check(const char *op)
+noinstr void __this_cpu_preempt_check(const char *op)
 {
 	check_preemption_disabled("__this_cpu_", op);
 }
 EXPORT_SYMBOL(__this_cpu_preempt_check);
-NOKPROBE_SYMBOL(__this_cpu_preempt_check);


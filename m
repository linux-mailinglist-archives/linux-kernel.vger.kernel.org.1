Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7066329A81F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895836AbgJ0Joc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:44:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38470 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895821AbgJ0Job (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=XdIEkBr7sDLhWAZDeKeH5tPyKdV7Qd0PyKAPdl+F/ws=; b=vz+ye3AB3ljYu7T2htIgHyltRP
        JSuhty7SBzj8kWU/udRTfSJZFWpCzJebklLyHxzgrtPA0OU8E+iCEemJI2Xd5CJrKNVbS5B6jcZtK
        b5sdcfmCjupVoiU5KsyPu72xArCsG4YaOXfgIS7nVkaovm+1FS7nq8oWHzvdyCwOSqoFA+B4ruxks
        8B0Bdk9G0GacdjWwVDJNBMeMFEbnfgdy8NoaBoeRN+RtGF9wQ364jnbk0mPvKdJ8Sguxtadi+G5ry
        sxeIhCqpQ3ehob4MO1Z5Cfy2FCtrWZMQe3U3yRT+TBcECHQxXnLJY8QrX+ZxRxZQ+xG+Xogke0oS7
        2IFA/7wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXLWF-0005AL-Mp; Tue, 27 Oct 2020 09:43:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46DB630411F;
        Tue, 27 Oct 2020 10:43:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 307B82B7AC14F; Tue, 27 Oct 2020 10:43:53 +0100 (CET)
Message-ID: <20201027093608.096535386@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Oct 2020 10:15:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@kernel.org, me@kylehuey.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, rocallahan@gmail.com,
        alexandre.chartre@oracle.com, paulmck@kernel.org,
        frederic@kernel.org, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, mhiramat@kernel.org,
        pmladek@suse.com, joel@joelfernandes.org, rostedt@goodmis.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, brgerst@gmail.com,
        jpoimboe@redhat.com, daniel.thompson@linaro.org,
        julliard@winehq.org, pgofman@codeweavers.com, peterz@infradead.org
Subject: [PATCH 3/3] x86/debug: Fix PTRACE_{BLOCK,SINGLE}STEP vs ptrace_get_debugreg(6)
References: <20201027091504.712183781@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to
thread.virtual_dr6") changed the semantics of the variable from random
collection of bits, to exactly only those bits that ptrace() needs.

Unfortunately we lost DR_STEP for PTRACE_{BLOCK,SINGLE}STEP.

Fixes: d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to thread.virtual_dr6")
Reported-by: Kyle Huey <me@kylehuey.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/ptrace.h |    2 ++
 arch/x86/kernel/step.c        |    9 +++++++++
 arch/x86/kernel/traps.c       |    2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -355,6 +355,8 @@ static inline unsigned long regs_get_ker
 #define arch_has_block_step()	(boot_cpu_data.x86 >= 6)
 #endif
 
+extern unsigned long user_dr_step(unsigned long dr6);
+
 #define ARCH_HAS_USER_SINGLE_STEP_REPORT
 
 struct user_desc;
--- a/arch/x86/kernel/step.c
+++ b/arch/x86/kernel/step.c
@@ -235,3 +235,12 @@ void user_disable_single_step(struct tas
 	if (test_and_clear_tsk_thread_flag(child, TIF_FORCED_TF))
 		task_pt_regs(child)->flags &= ~X86_EFLAGS_TF;
 }
+
+unsigned long user_dr_step(unsigned long dr6)
+{
+	if (test_thread_flag(TIF_BLOCKSTEP) ||
+	    test_thread_flag(TIF_SINGLESTEP))
+		return dr6 & DR_STEP;
+
+	return 0;
+}
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -940,7 +940,7 @@ static __always_inline void exc_debug_us
 	 * Clear the virtual DR6 value, ptrace() routines will set bits here
 	 * for things it wants signals for.
 	 */
-	current->thread.virtual_dr6 = 0;
+	current->thread.virtual_dr6 = user_dr_step(dr6);
 
 	/*
 	 * The SDM says "The processor clears the BTF flag when it



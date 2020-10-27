Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0319D29A81E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895815AbgJ0Jo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:44:26 -0400
Received: from casper.infradead.org ([90.155.50.34]:35902 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895785AbgJ0JoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Ss7wia/EeBYDnnMFGNRfAfqn7SaLY/dgJUG86p4bYow=; b=Pt2wTXYdCym5Jkmf3PSrVYYC6q
        PsBVCsAuKlyMI2QHEd0RUWlO0DxtHh2+uDEi3+/mCG0VcdITvwEj4XFEtRft3OzACpYZnXhJnYU+e
        vKY67QcyaLOHcmR4fONhs6FU8N7PVCdatNrCUY6XUp3jEnXhn2+AbgGASzIELqKUUq8MzpvmDBsfN
        P1jR+tzPG1HG20Z2Fv00Y3p7MqXKFJ15NjCIwTGX7DURUeX26hJyyuzavpLcS09PS0hfOaodTH0g/
        NyFD/aXfXhvWXTJsfws3S4oxkeHQIMJnoXerfO1LT0nYAT9uwlwGo3VHNMkAnLA8b4ABJUbd/7Ast
        IlDQdTgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXLWE-0006hw-IL; Tue, 27 Oct 2020 09:43:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46009300455;
        Tue, 27 Oct 2020 10:43:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2B4102B6C3D53; Tue, 27 Oct 2020 10:43:53 +0100 (CET)
Message-ID: <20201027093607.956147736@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Oct 2020 10:15:05 +0100
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
Subject: [PATCH 1/3] x86/debug: Fix BTF handling
References: <20201027091504.712183781@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDM states that #DB clears DEBUGCTLMSR_BTF, this means that when
we set that bit for userspace (TIF_BLOCKSTEP) and get a kernel #DB
first, we'll loose the BTF bit meant for userspace execution.

Have the kernel #DB handler restore the BTF bit when it was requested
for userspace.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -799,13 +799,6 @@ static __always_inline unsigned long deb
 	 */
 	current->thread.virtual_dr6 = 0;
 
-	/*
-	 * The SDM says "The processor clears the BTF flag when it
-	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
-	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
-	 */
-	clear_thread_flag(TIF_BLOCKSTEP);
-
 	return dr6;
 }
 
@@ -873,6 +866,20 @@ static __always_inline void exc_debug_ke
 	 */
 	WARN_ON_ONCE(user_mode(regs));
 
+	if (test_thread_flag(TIF_BLOCKSTEP)) {
+		/*
+		 * The SDM says "The processor clears the BTF flag when it
+		 * generates a debug exception." but PTRACE_BLOCKSTEP requested
+		 * it for userspace, but we just took a kernel #DB, so re-set
+		 * BTF.
+		 */
+		unsigned long debugctl;
+
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+		debugctl |= DEBUGCTLMSR_BTF;
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+	}
+
 	/*
 	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
 	 * watchpoint at the same time then that will still be handled.
@@ -936,6 +943,13 @@ static __always_inline void exc_debug_us
 	instrumentation_begin();
 
 	/*
+	 * The SDM says "The processor clears the BTF flag when it
+	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
+	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
+	 */
+	clear_thread_flag(TIF_BLOCKSTEP);
+
+	/*
 	 * If dr6 has no reason to give us about the origin of this trap,
 	 * then it's very likely the result of an icebp/int01 trap.
 	 * User wants a sigtrap for that.



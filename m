Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5C529C786
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1796449AbgJ0SeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:34:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39750 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1795953AbgJ0SeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kqdYjxc2O9b1X8EV8bVinkOpeHRHYJ1esUJTZZpw2xk=; b=KY7G0Euwn6mG5aWvpMvGuLpnBa
        a3gSjDRKmxO6rw/2sBOn0MkjnAbr8V+p0m/yGotfvzVR2U8gUCFwnsfttVo4s6duOD75sqcyHW6K6
        KIjhvB9kHlnMHbcvmnsM9JUHVEaI2+/WLunU/SUGXfLlIM5SHFiPthi8UmAN2qbQ1V73fmlysMsP0
        5Z+WGwIJeocb+0r7Z6owkio5T6RLYJNC0JMLSGl9KsWBcPWu9fLtD5m2JeiySvu82xgHH2wKdF4DY
        j+iD54vHfHm7eZI5E+hUJEOmfeqYE/rmekDvsTyRMQKSBpGMeMKnNocA1TOXBlmu2SePP1WtYqJ0l
        ju6tB1HA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXTmn-00031p-7F; Tue, 27 Oct 2020 18:33:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB0B9307AAA;
        Tue, 27 Oct 2020 19:33:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7AF92D196570; Tue, 27 Oct 2020 19:33:30 +0100 (CET)
Date:   Tue, 27 Oct 2020 19:33:30 +0100
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
        julliard@winehq.org, pgofman@codeweavers.com
Subject: [PATCH v2 3/3] Fix DR_STEP vs ptrace_get_debugreg(6)
Message-ID: <20201027183330.GM2628@hirez.programming.kicks-ass.net>
References: <20201027091504.712183781@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027091504.712183781@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Commit d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to
thread.virtual_dr6") changed the semantics of the variable from random
collection of bits, to exactly only those bits that ptrace() needs.

Unfortunately we lost DR_STEP for PTRACE_{BLOCK,SINGLE}STEP.

Furthermore, it turns out that userspace expects DR_STEP to be
unconditionally available, even for manual TF usage outside of
PTRACE_{BLOCK,SINGLE}_STEP.

Fixes: d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to thread.virtual_dr6")
Reported-by: Kyle Huey <me@kylehuey.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
v2: uncondtionally provide DR_STEP, at the very least WINE relies on this

 arch/x86/kernel/traps.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -937,10 +937,13 @@ static __always_inline void exc_debug_us
 	instrumentation_begin();
 
 	/*
-	 * Clear the virtual DR6 value, ptrace() routines will set bits here
-	 * for things it wants signals for.
+	 * Start the virtual/ptrace DR6 value with just the DR_STEP mask
+	 * of the real DR6. ptrace_triggered() will set the DR_TRAPn bits.
+	 *
+	 * Userspace expects DR_STEP to be visible in ptrace_get_debugreg(6)
+	 * even if it is not the result of PTRACE_SINGLESTEP.
 	 */
-	current->thread.virtual_dr6 = 0;
+	current->thread.virtual_dr6 = (dr6 & DR_STEP);
 
 	/*
 	 * The SDM says "The processor clears the BTF flag when it

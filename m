Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B5A2BA994
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgKTLua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgKTLu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:50:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D574C061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 03:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RhndaecUjQL70Aq1jqBoMpeXuVqONfb2qRNUEdHoCpQ=; b=AEocwjmO9uJtnNcjYJJpUpcLr9
        NY9vP3rz9Q7PUa68znr0btj3sHeCh3XCjDqJQjOqPMpa2Eq+JJtYi3+FfPe7Z/87aER+pQanrKZbn
        4n6MLYv85ZW0cB1s4wcyTShENWcN+QSmgJGrsdnfio92dHxX1W4b8w6TmDOIgeOT2MqJ+b7Jhe9yF
        LVeo4CYumXZ08uX3bx88HaXBjXA+i49ezq3f8smaV4va07Rh3mi8DHXnHh0CAaS56D22vEPDfY2Si
        r5Cd3hSxfQE+ns/xWCD0LsBy0LIUjxZEuF3oiA2x6LNiiKLN4QogzS0YU5mIMmxzRJuTtrjKi2nKi
        FTbKVRqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg4vl-0003x9-Uv; Fri, 20 Nov 2020 11:50:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0AE29305C16;
        Fri, 20 Nov 2020 12:50:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E92302B06A144; Fri, 20 Nov 2020 12:50:19 +0100 (CET)
Message-ID: <20201120114925.652731270@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Nov 2020 12:41:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     rafael@kernel.org, viresh.kumar@linaro.org, mingo@kernel.org
Cc:     x86@kernel.org, mark.rutland@arm.com, will@kernel.org,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: [PATCH 2/2] intel_idle: Fix intel_idle() vs tracing
References: <20201120114145.197714127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuidle->enter() callbacks should not call into tracing because RCU
has already been disabled. Instead of doing the broadcast thing
itself, simply advertise to the cpuidle core that those states stop
the timer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/idle/intel_idle.c |   37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -126,26 +126,9 @@ static __cpuidle int intel_idle(struct c
 	struct cpuidle_state *state = &drv->states[index];
 	unsigned long eax = flg2MWAIT(state->flags);
 	unsigned long ecx = 1; /* break on interrupt flag */
-	bool tick;
-
-	if (!static_cpu_has(X86_FEATURE_ARAT)) {
-		/*
-		 * Switch over to one-shot tick broadcast if the target C-state
-		 * is deeper than C1.
-		 */
-		if ((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK) {
-			tick = true;
-			tick_broadcast_enter();
-		} else {
-			tick = false;
-		}
-	}
 
 	mwait_idle_with_hints(eax, ecx);
 
-	if (!static_cpu_has(X86_FEATURE_ARAT) && tick)
-		tick_broadcast_exit();
-
 	return index;
 }
 
@@ -1460,6 +1443,23 @@ static bool __init intel_idle_verify_cst
 	return true;
 }
 
+static bool __init intel_idle_state_needs_timer_stop(struct cpuidle_state *state)
+{
+	unsigned long eax = flg2MWAIT(state->flags);
+
+	if (boot_cpu_has(X86_FEATURE_ARAT))
+		return false;
+
+	/*
+	 * Switch over to one-shot tick broadcast if the target C-state
+	 * is deeper than C1.
+	 */
+	if ((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK)
+		return true;
+
+	return false;
+}
+
 static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 {
 	int cstate;
@@ -1507,6 +1507,9 @@ static void __init intel_idle_init_cstat
 		     !(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_ALWAYS_ENABLE)))
 			drv->states[drv->state_count].flags |= CPUIDLE_FLAG_OFF;
 
+		if (intel_idle_state_needs_timer_stop(&drv->states[drv->state_count]))
+			drv->states[drv->state_count].flags |= CPUIDLE_FLAG_TIMER_STOP;
+
 		drv->state_count++;
 	}
 



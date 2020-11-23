Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1652C0DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbgKWOfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731659AbgKWOfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:35:18 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF51FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JFfSpaqviRXMwocNwPI/bu7hyPZymrOYOob1Afcmx/U=; b=NzO4WjWCaDe2zsvLXIKRN7sAMM
        hERH+w7z0KCYeVzziESKFLHsiCeENJZEXnQwC6XiinZzXF1S2CONxpfpPeO8TGg1VvuD6C6rohlhx
        vs7Ay0H6xtNxsR9T6vyPSpcRlhTiOfwuBCgZfrtzrVaUd9vX8QiEo+o1SNl2Ya/mLlW0fpL5IzLb0
        jfdhNnDMhvOnCGtBFA7pGg0uqTPum98/SGMWIo1D/5AiF7OppKINxvn6JKu//uHVdTa7DSk0q7UQ0
        AGX1Y2IgrBUTNLMOTJUNUGXtcycEuWkBu6mZhsMLIb7ko4+T2NPtsuIKO1tdcr5803m8vE/+gKhAj
        JmhZjjvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khCvw-0008Qw-8W; Mon, 23 Nov 2020 14:35:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD260306E56;
        Mon, 23 Nov 2020 15:35:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7C30202A3CEC; Mon, 23 Nov 2020 15:35:10 +0100 (CET)
Date:   Mon, 23 Nov 2020 15:35:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, svens@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] intel_idle: Fix intel_idle() vs tracing
Message-ID: <20201123143510.GR3021@hirez.programming.kicks-ass.net>
References: <20201120114145.197714127@infradead.org>
 <20201120114925.652731270@infradead.org>
 <CAJZ5v0hhSO36-m-otWp0vqWNNZFiDWPX-xxK-ninRr2d==QOWA@mail.gmail.com>
 <20201123134618.GL3021@hirez.programming.kicks-ass.net>
 <CAJZ5v0invgyZ50AHZmbOBYkgvM2uAqqE+t_mvD=ZCxac_gAtUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0invgyZ50AHZmbOBYkgvM2uAqqE+t_mvD=ZCxac_gAtUQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 02:54:47PM +0100, Rafael J. Wysocki wrote:

> intel_idle_init_cstates_acpi() needs to be updated too as it doesn't
> pick up the flags automatically.

Ooh, it has two different state init routines :-/, sorry I missed that.
See below.

> It looks like CPUIDLE_FLAG_RCU_IDLE needs to be copied too.

I might need more clue again; processor_idle() needs this because it
calls into ACPI (acpi_idle_enter_bm()) for that BM crud. I didn't find
anything like that here.


---
Subject: intel_idle: Fix intel_idle() vs tracing
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Nov 20 11:28:35 CET 2020

cpuidle->enter() callbacks should not call into tracing because RCU
has already been disabled. Instead of doing the broadcast thing
itself, simply advertise to the cpuidle core that those states stop
the timer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/idle/intel_idle.c |   40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

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
 
@@ -1227,6 +1210,23 @@ static bool __init intel_idle_acpi_cst_e
 	return false;
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
 static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 {
 	int cstate, limit = min_t(int, CPUIDLE_STATE_MAX, acpi_state_table.count);
@@ -1269,6 +1269,9 @@ static void __init intel_idle_init_cstat
 		if (disabled_states_mask & BIT(cstate))
 			state->flags |= CPUIDLE_FLAG_OFF;
 
+		if (intel_idle_state_needs_timer_stop(state))
+			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+
 		state->enter = intel_idle;
 		state->enter_s2idle = intel_idle_s2idle;
 	}
@@ -1507,6 +1510,9 @@ static void __init intel_idle_init_cstat
 		     !(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_ALWAYS_ENABLE)))
 			drv->states[drv->state_count].flags |= CPUIDLE_FLAG_OFF;
 
+		if (intel_idle_state_needs_timer_stop(&drv->states[drv->state_count]))
+			drv->states[drv->state_count].flags |= CPUIDLE_FLAG_TIMER_STOP;
+
 		drv->state_count++;
 	}
 

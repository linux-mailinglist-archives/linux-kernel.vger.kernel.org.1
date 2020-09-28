Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D43127AE84
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 15:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgI1NAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 09:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgI1NAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 09:00:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134B8C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=WiurnCcHfhcaqE4SKB4xvzlGUq8igqVJxtqs9UacGwM=; b=io9TxdZftAgyQVbFKc+eX7yw3g
        YnmvYm6/9cVoePZNjRulruhmXHa9BZ0ZM9XLBjd5PRMJCdDpbbVUYTL4HEnD02XymPoI74W1lGHRt
        xsvP9J52Ku0rqQgGf0gIvJXUJWWYMV9hIuUgvb/ZpaJPdlGS1UYJhSENRIPzZZEafYpkFaepj01g4
        AkhfXgy6IWthYsq5m+lCPcoPQLhyjzFm4lJPKb6xy6UcVtMstRXGVlNOC82KdjuuTbVFYXid4Utms
        Om6HMYKxgpO9OlHtdAPeZDFZa0mHjGpFihYVcbSkP4aN1f0gAPjp6uNQS5yei1y/S46xdQOuOGwIy
        MnveUm2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMskp-0001U6-5j; Mon, 28 Sep 2020 12:59:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1FD12300DB4;
        Mon, 28 Sep 2020 14:59:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5E422006F633; Mon, 28 Sep 2020 14:59:38 +0200 (CEST)
Date:   Mon, 28 Sep 2020 14:59:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "elver@google.com" <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>, ulf.hansson@linaro.org
Subject: Re: cpudile warning on mx6q sabresd caused by eb1f00237aca
 ("lockdep,trace: Expose tracepoints")
Message-ID: <20200928125938.GG2628@hirez.programming.kicks-ass.net>
References: <AM6PR04MB4966B1FD8333443A1EAEDE2980350@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR04MB4966B1FD8333443A1EAEDE2980350@AM6PR04MB4966.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 12:26:58PM +0000, Aisheng Dong wrote:
> Hi Peter,
> 
> We met a cpudile warning on mx6q sabresd board since v5.9-rc3 and also exist in latest linux-next (next-20200925).
> After some bisection, I found it’s caused by below patch.
> Any suggestions about this issue?

The word is 'exposed', not 'caused', these are pre-existing bugs.

> [    6.870684] [<c0db7690>] (_raw_spin_lock) from [<c011f6a4>] (imx6q_enter_wait+0x18/0x9c)
> [    6.878846] [<c011f6a4>] (imx6q_enter_wait) from [<c09abfb0>] (cpuidle_enter_state+0x168/0x5e4)

I'm not really familiar with all the oddities of ARM cpuidle, but one
possible way is similar to this commit.

commit 1fecfdbb7acc6624655450a609221c89b5197a06
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue Sep 15 12:32:01 2020 +0200

    ACPI: processor: Take over RCU-idle for C3-BM idle
    
    The C3 BusMaster idle code takes lock in a number of places, some deep
    inside the ACPI code. Instead of wrapping it all in RCU_NONIDLE, have
    the driver take over RCU-idle duty and avoid flipping RCU state back
    and forth a lot.
    
    ( by marking 'C3 && bm_check' as RCU_IDLE, we _must_ call enter_bm() for
      that combination, otherwise we'll loose RCU-idle, this requires
      shuffling some code around )
    
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Tested-by: Borislav Petkov <bp@suse.de>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 9ec504067f98..7ecb90e90afd 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -558,22 +558,43 @@ static DEFINE_RAW_SPINLOCK(c3_lock);
 
 /**
  * acpi_idle_enter_bm - enters C3 with proper BM handling
+ * @drv: cpuidle driver
  * @pr: Target processor
  * @cx: Target state context
+ * @index: index of target state
  */
-static void acpi_idle_enter_bm(struct acpi_processor *pr,
-			       struct acpi_processor_cx *cx)
+static int acpi_idle_enter_bm(struct cpuidle_driver *drv,
+			       struct acpi_processor *pr,
+			       struct acpi_processor_cx *cx,
+			       int index)
 {
+	static struct acpi_processor_cx safe_cx = {
+		.entry_method = ACPI_CSTATE_HALT,
+	};
+
 	/*
 	 * disable bus master
 	 * bm_check implies we need ARB_DIS
 	 * bm_control implies whether we can do ARB_DIS
 	 *
-	 * That leaves a case where bm_check is set and bm_control is
-	 * not set. In that case we cannot do much, we enter C3
-	 * without doing anything.
+	 * That leaves a case where bm_check is set and bm_control is not set.
+	 * In that case we cannot do much, we enter C3 without doing anything.
 	 */
-	if (pr->flags.bm_control) {
+	bool dis_bm = pr->flags.bm_control;
+
+	/* If we can skip BM, demote to a safe state. */
+	if (!cx->bm_sts_skip && acpi_idle_bm_check()) {
+		dis_bm = false;
+		index = drv->safe_state_index;
+		if (index >= 0) {
+			cx = this_cpu_read(acpi_cstate[index]);
+		} else {
+			cx = &safe_cx;
+			index = -EBUSY;
+		}
+	}
+
+	if (dis_bm) {
 		raw_spin_lock(&c3_lock);
 		c3_cpu_count++;
 		/* Disable bus master arbitration when all CPUs are in C3 */
@@ -582,15 +603,21 @@ static void acpi_idle_enter_bm(struct acpi_processor *pr,
 		raw_spin_unlock(&c3_lock);
 	}
 
+	rcu_idle_enter();
+
 	acpi_idle_do_entry(cx);
 
+	rcu_idle_exit();
+
 	/* Re-enable bus master arbitration */
-	if (pr->flags.bm_control) {
+	if (dis_bm) {
 		raw_spin_lock(&c3_lock);
 		acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE, 0);
 		c3_cpu_count--;
 		raw_spin_unlock(&c3_lock);
 	}
+
+	return index;
 }
 
 static int acpi_idle_enter(struct cpuidle_device *dev,
@@ -604,20 +631,13 @@ static int acpi_idle_enter(struct cpuidle_device *dev,
 		return -EINVAL;
 
 	if (cx->type != ACPI_STATE_C1) {
+		if (cx->type == ACPI_STATE_C3 && pr->flags.bm_check)
+			return acpi_idle_enter_bm(drv, pr, cx, index);
+
+		/* C2 to C1 demotion. */
 		if (acpi_idle_fallback_to_c1(pr) && num_online_cpus() > 1) {
 			index = ACPI_IDLE_STATE_START;
 			cx = per_cpu(acpi_cstate[index], dev->cpu);
-		} else if (cx->type == ACPI_STATE_C3 && pr->flags.bm_check) {
-			if (cx->bm_sts_skip || !acpi_idle_bm_check()) {
-				acpi_idle_enter_bm(pr, cx);
-				return index;
-			} else if (drv->safe_state_index >= 0) {
-				index = drv->safe_state_index;
-				cx = per_cpu(acpi_cstate[index], dev->cpu);
-			} else {
-				acpi_safe_halt();
-				return -EBUSY;
-			}
 		}
 	}
 
@@ -641,7 +661,13 @@ static int acpi_idle_enter_s2idle(struct cpuidle_device *dev,
 			return 0;
 
 		if (pr->flags.bm_check) {
-			acpi_idle_enter_bm(pr, cx);
+			u8 bm_sts_skip = cx->bm_sts_skip;
+
+			/* Don't check BM_STS, do an unconditional ARB_DIS for S2IDLE */
+			cx->bm_sts_skip = 1;
+			acpi_idle_enter_bm(drv, pr, cx, index);
+			cx->bm_sts_skip = bm_sts_skip;
+
 			return 0;
 		} else {
 			ACPI_FLUSH_CPU_CACHE();
@@ -674,8 +700,11 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 		if (lapic_timer_needs_broadcast(pr, cx))
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 
-		if (cx->type == ACPI_STATE_C3)
+		if (cx->type == ACPI_STATE_C3) {
 			state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
+			if (pr->flags.bm_check)
+				state->flags |= CPUIDLE_FLAG_RCU_IDLE;
+		}
 
 		count++;
 		if (count == CPUIDLE_STATE_MAX)

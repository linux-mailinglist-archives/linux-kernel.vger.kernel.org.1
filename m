Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1E82F40B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436812AbhAMAnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 19:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392221AbhAMAKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 19:10:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68AEA23120;
        Wed, 13 Jan 2021 00:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610496593;
        bh=17kSMe10Y9bH+urli4hihz1yUqtO6un/+neV6IM2xLM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ccS8oBhcXBCu7tqX0yowCoPCkJZjwDbNK3JzGTKjQm3K+TQ4wP92TXS/Y4eYIVa9u
         qgSqfoL5cZCdTQEoSQvv7e5HdVN3TikM1pYMQdH6NAj+aiuT3/sS/ohcgtuzjeD0JQ
         1vJ9gQ5BHoNaETBYvJXEgEsMoPCegDdhCJ6QwexnAuyjx91vzdTMzqQDi1+BRIWJ2a
         LGV4fgG+9O4MNiBAOn4fJvaQwrzDKcgrcTgvOrwt8c2B36CVM1+JZ3Yn09iguknJzA
         OqCfKVAAb/222MDXyevmSzoXNFyix50Gz9S35ypEQa82gslaqwQQxMOSLzoI9uKmT/
         clrO5KkSGFhrQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3790D3522AC3; Tue, 12 Jan 2021 16:09:53 -0800 (PST)
Date:   Tue, 12 Jan 2021 16:09:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: Re: [PATCH 0/2] irq: detect slow IRQ handlers
Message-ID: <20210113000953.GN2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210112135950.30607-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112135950.30607-1-mark.rutland@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 01:59:48PM +0000, Mark Rutland wrote:
> Hi,
> 
> While fuzzing arm64 with Syzkaller (under QEMU+KVM) over a number of releases,
> I've occasionally seen some ridiculously long stalls (20+ seconds), where it
> appears that a CPU is stuck in a hard IRQ context. As this gets detected after
> the CPU returns to the interrupted context, it's difficult to identify where
> exactly the stall is coming from.
> 
> These patches are intended to help tracking this down, with a WARN() if an IRQ
> handler takes longer than a given timout (1 second by default), logging the
> specific IRQ and handler function. While it's possible to achieve similar with
> tracing, it's harder to integrate that into an automated fuzzing setup.
> 
> I've been running this for a short while, and haven't yet seen any of the
> stalls with this applied, but I've tested with smaller timeout periods in the 1
> millisecond range by overloading the host, so I'm confident that the check
> works.
> 
> Thanks,
> Mark.

Nice!

Acked-by: Paul E. McKenney <paulmck@kernel.org>

I added the patch below to add a three-second delay to the scheduling
clock interrupt handler.  This executed, but did not cause your warning
to be emitted, probably because rcutorture runs under qemu/KVM.  So no
Tested-by, not yet, anyway.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e04e336..dac8c7a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2606,6 +2606,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
  */
 void rcu_sched_clock_irq(int user)
 {
+	static atomic_t invctr;
+
 	trace_rcu_utilization(TPS("Start scheduler-tick"));
 	lockdep_assert_irqs_disabled();
 	raw_cpu_inc(rcu_data.ticks_this_gp);
@@ -2623,6 +2625,14 @@ void rcu_sched_clock_irq(int user)
 		invoke_rcu_core();
 	lockdep_assert_irqs_disabled();
 
+	if (atomic_inc_return(&invctr) % 0x3ffff == 0) {
+		int i;
+
+		pr_alert("%s: 3-second delay.\n", __func__);
+		for (i = 0; i < 3000; i++)
+			udelay(1000);
+	}
+
 	trace_rcu_utilization(TPS("End scheduler-tick"));
 }
 

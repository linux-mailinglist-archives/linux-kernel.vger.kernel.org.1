Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17902D9D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502135AbgLNRIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502103AbgLNRIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:08:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D78C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xwRP1HYoq3KaWNU4ESSEQPQzxrz2ErrEqWsxTITkomc=; b=VU2U5QRCN9tQi82zr79uZQRJ+/
        B+wtleVz3qwHVygFL6QLl36SGhrSWtSa6IRNOlv+VutFVZ0EPNvJQqoeM9iuenGuIGZXZvZqTO6q2
        pchU0mRVNDfpKxKy2a4/8ICCA23XuGXXdqpFoiMh+zG5XwRVJAqE/ael5lNe6dRnd3CZuvZPftpYJ
        RNb6vMmojz3uq2aVX/R4Ggq4dpQ6NML0bZat7Y5O2pM496W+wG9/LECbp4RzdSYH9UihUuVcy5SFF
        qvbMf7eUxy2CoIIACshTvMs8CPPhBU8TSgkLsNLA3abY6AqjApsgmT2duq4tsnzU5SbPN6dLYKqyz
        Cj0vKmaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1korJT-0002Qq-86; Mon, 14 Dec 2020 17:07:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96DB03010CF;
        Mon, 14 Dec 2020 18:07:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 658DD21F9FEF9; Mon, 14 Dec 2020 18:07:04 +0100 (CET)
Message-ID: <20201214170017.877557652@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 14 Dec 2020 17:48:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mgorman@techsingularity.net, vincent.guittot@linaro.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        aubrey.li@linux.intel.com, mingo@redhat.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, benbjiang@gmail.com
Subject: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost accounting
References: <20201214164822.402812729@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We compute the average cost of the total scan, but then use it as a
per-cpu scan cost when computing the scan proportion. Fix this by
properly computing a per-cpu scan cost.

This also fixes a bug where we would terminate early (!--nr, case) and
not account that cost at all.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6144,10 +6144,10 @@ static inline int select_idle_smt(struct
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	int cpu, loops = 1, nr = INT_MAX;
+	int this = smp_processor_id();
 	struct sched_domain *this_sd;
 	u64 time;
-	int this = smp_processor_id();
-	int cpu, nr = INT_MAX;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6175,14 +6175,19 @@ static int select_idle_cpu(struct task_s
 	}
 
 	for_each_cpu_wrap(cpu, cpus, target) {
-		if (!--nr)
-			return -1;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			break;
+
+		if (loops >= nr) {
+			cpu = -1;
+			break;
+		}
+		loops++;
 	}
 
 	if (sched_feat(SIS_PROP)) {
 		time = cpu_clock(this) - time;
+		time = div_u64(time, loops);
 		update_avg(&this_sd->avg_scan_cost, time);
 	}
 



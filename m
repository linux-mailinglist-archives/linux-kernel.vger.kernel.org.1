Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09F12D9D54
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502150AbgLNRIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502110AbgLNRIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:08:25 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8121DC0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=X1+UsqPh/WT98ToaIREDxkZJ0WZmsWBw/I/Q+ZnWpYo=; b=oSwfytvKpgR5FO3HgR7rR5KDnD
        lB1YBL5t5BXbZiEbH1SYYjMhH7ufsbG8VVanR81q0vR+2nYTQyxdwuCQzorjHVJQ6ZXAzoteMEOz9
        YhoRYu0hzC9V4BJK/ZgyQEGeIxNReoqPNNe6i1AnLatBvRejydh0hkVCahE2B9PXI9eadr48X9jt4
        WustKPb+AyN4vRYXSMwUAb6GArXy/H8zxIYcgpgH2sog+JS23xJm3DxX10iIABw1GSsluRyUaH/T5
        VBaV4xajjwZn7lvMv/O8tBzAV1AvBPs0RHNNab1mBD/bmeDb0KeuZhBdqUsHh29Ph9WxhfaIJ7wkY
        rr12zGvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1korJT-0002Qo-6t; Mon, 14 Dec 2020 17:07:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97E273059C6;
        Mon, 14 Dec 2020 18:07:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 67DA42364D0D2; Mon, 14 Dec 2020 18:07:04 +0100 (CET)
Message-ID: <20201214170017.938791025@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 14 Dec 2020 17:48:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mgorman@techsingularity.net, vincent.guittot@linaro.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        aubrey.li@linux.intel.com, mingo@redhat.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, benbjiang@gmail.com
Subject: [RFC][PATCH 2/5] sched/fair: Make select_idle_cpu() proportional to cores
References: <20201214164822.402812729@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calculating how many (logical) CPUs to scan, compute how
many cores to scan.

This changes behaviour for anything !SMT2.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   19 ++++++++++++++-----
 kernel/sched/fair.c |   12 ++++++++++--
 2 files changed, 24 insertions(+), 7 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7454,11 +7454,20 @@ int sched_cpu_activate(unsigned int cpu)
 	balance_push_set(cpu, false);
 
 #ifdef CONFIG_SCHED_SMT
-	/*
-	 * When going up, increment the number of cores with SMT present.
-	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
-		static_branch_inc_cpuslocked(&sched_smt_present);
+	do {
+		int weight = cpumask_weight(cpu_smt_mask(cpu));
+		extern int sched_smt_weight;
+
+		if (weight > sched_smt_weight)
+			sched_smt_weight = weight;
+
+		/*
+		 * When going up, increment the number of cores with SMT present.
+		 */
+		if (weight == 2)
+			static_branch_inc_cpuslocked(&sched_smt_present);
+
+	} while (0);
 #endif
 	set_cpu_active(cpu, true);
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6010,6 +6010,8 @@ static inline int find_idlest_cpu(struct
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
 
+int sched_smt_weight = 1;
+
 static inline void set_idle_cores(int cpu, int val)
 {
 	struct sched_domain_shared *sds;
@@ -6124,6 +6126,8 @@ static int select_idle_smt(struct task_s
 
 #else /* CONFIG_SCHED_SMT */
 
+#define sched_smt_weight	1
+
 static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
@@ -6136,6 +6140,8 @@ static inline int select_idle_smt(struct
 
 #endif /* CONFIG_SCHED_SMT */
 
+#define sis_min_cores		2
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
@@ -6166,10 +6172,12 @@ static int select_idle_cpu(struct task_s
 		avg_cost = this_sd->avg_scan_cost + 1;
 
 		span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
+		if (span_avg > sis_min_cores * avg_cost)
 			nr = div_u64(span_avg, avg_cost);
 		else
-			nr = 4;
+			nr = sis_min_cores;
+
+		nr *= sched_smt_weight;
 
 		time = cpu_clock(this);
 	}



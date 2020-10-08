Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BBF2877F7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbgJHPs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgJHPsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:48:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9713C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 08:48:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a200so4311525pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7AcqdAL0fc9jjb1a0cxcXs0Q+R/4HuaHIdYuFzA25ZQ=;
        b=bqKw33WQTOPuTTfWhGEgZVxzSRhuTxH2c9Xx5KSy+lG9IUSoqK2DjMZ0sKVMoRf/PE
         evXFG1ti5xjNKgs8ghuaUSjxd7fEuuDY8ehmf5TBFJvcoZS/MEbWsdqWK/OTkMBt6idZ
         IBGmi+vh/bWR34/rlRRcTcZhiJZ2SNzzzHEOoECRQA2ptwpn3jm3uQhcq75i6r44/9Tw
         hTlDbL3SfU1o1Qc15s+a8FTmQGdBm2botlkdLmkqPOAB1bO4MClGNhLrJmpLL9JM0HMQ
         iY5yRK8wnsPg/RDnhJRyPUoQ5Ad20FmJeyM6XTn+KZWNVMIe1X3ZVWBsU7alhgxGHkJx
         OZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7AcqdAL0fc9jjb1a0cxcXs0Q+R/4HuaHIdYuFzA25ZQ=;
        b=hWRhFfpZ1SqfbZO942uWNCCGoWjvTJ8MWBRd9Pe9AmXiNjQOUyaX15GIxUw9rVUcaW
         8T2dBZu+xb8SV/a325GJyF/+qQVGVKTMZ0UBjg3CdJKWlSkytyHt10kKGc/VrLXg4B+g
         MjJb7IMmK/jQI12+rWFkARbEmnwrZ2KBz2Ga74FYyMuGUIZrHup5jnzAA+acrtyphLVa
         K5DV70v2/XuKQuDMTfGxIGXEO/qGgvSFeeSuvSNuLM93gLqTSO6o1AGNq/GFAGDRAKJ4
         MF89zsPQjwYZSP+d3QJwwy1qamDPSf8SxLMhv7iYdxjzHkhXmOsCw/fG1ZDS0cW0tsKC
         TMKQ==
X-Gm-Message-State: AOAM532IqE0f6RsiZvoBii9y5Bvz7FWwjfV5vOjOuM7O5y2yHafqxctk
        0I9dbmBKe5SHWk7X2LOX3ihGP+q3NQg=
X-Google-Smtp-Source: ABdhPJzHrRNbc9wBHty7lNmW9ENJjktSzy3ed2Xai3slPSkNUB8BZ2cwkCucUilzlF8fnqf6Q17eDw==
X-Received: by 2002:a17:90a:3fcd:: with SMTP id u13mr6530272pjm.85.1602172131831;
        Thu, 08 Oct 2020 08:48:51 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id n125sm7632772pfn.185.2020.10.08.08.48.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Oct 2020 08:48:50 -0700 (PDT)
Date:   Thu, 8 Oct 2020 23:48:46 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, valentin.schneider@arm.com, raistlin@linux.it,
        iwtbavbm@gmail.com
Subject: [PATCH v6 1/2] sched/deadline: Optimize sched_dl_global_validate()
Message-ID: <78d21ee792cc48ff79e8cd62a5f26208463684d6.1602171061.git.iwtbavbm@gmail.com>
References: <cover.1602171061.git.iwtbavbm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1602171061.git.iwtbavbm@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under CONFIG_SMP, dl_bw is per root domain, but not per CPU.
When checking or updating dl_bw, currently iterating every CPU is
overdoing, just need iterate each root domain once.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
---
 kernel/sched/deadline.c | 39 ++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h    |  9 +++++++++
 kernel/sched/topology.c |  1 +
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c19c1883d695..365e5fec8c28 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -97,6 +97,17 @@ static inline unsigned long dl_bw_capacity(int i)
 		return __dl_bw_capacity(i);
 	}
 }
+
+static inline bool dl_bw_visited(int cpu, u64 gen)
+{
+	struct root_domain *rd = cpu_rq(cpu)->rd;
+
+	if (rd->visit_gen == gen)
+		return true;
+
+	rd->visit_gen = gen;
+	return false;
+}
 #else
 static inline struct dl_bw *dl_bw_of(int i)
 {
@@ -112,6 +123,11 @@ static inline unsigned long dl_bw_capacity(int i)
 {
 	return SCHED_CAPACITY_SCALE;
 }
+
+static inline bool dl_bw_visited(int cpu, u64 gen)
+{
+	return false;
+}
 #endif
 
 static inline
@@ -2514,11 +2530,15 @@ const struct sched_class dl_sched_class
 	.update_curr		= update_curr_dl,
 };
 
+/* Used for dl_bw check and update. */
+static u64 dl_generation;
+
 int sched_dl_global_validate(void)
 {
 	u64 runtime = global_rt_runtime();
 	u64 period = global_rt_period();
 	u64 new_bw = to_ratio(period, runtime);
+	u64 gen = ++dl_generation;
 	struct dl_bw *dl_b;
 	int cpu, ret = 0;
 	unsigned long flags;
@@ -2527,13 +2547,13 @@ int sched_dl_global_validate(void)
 	 * Here we want to check the bandwidth not being set to some
 	 * value smaller than the currently allocated bandwidth in
 	 * any of the root_domains.
-	 *
-	 * FIXME: Cycling on all the CPUs is overdoing, but simpler than
-	 * cycling on root_domains... Discussion on different/better
-	 * solutions is welcome!
 	 */
 	for_each_possible_cpu(cpu) {
 		rcu_read_lock_sched();
+
+		if (dl_bw_visited(cpu, gen))
+			goto next;
+
 		dl_b = dl_bw_of(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
@@ -2541,6 +2561,7 @@ int sched_dl_global_validate(void)
 			ret = -EBUSY;
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 
+next:
 		rcu_read_unlock_sched();
 
 		if (ret)
@@ -2566,6 +2587,7 @@ static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
 void sched_dl_do_global(void)
 {
 	u64 new_bw = -1;
+	u64 gen = ++dl_generation;
 	struct dl_bw *dl_b;
 	int cpu;
 	unsigned long flags;
@@ -2576,11 +2598,14 @@ void sched_dl_do_global(void)
 	if (global_rt_runtime() != RUNTIME_INF)
 		new_bw = to_ratio(global_rt_period(), global_rt_runtime());
 
-	/*
-	 * FIXME: As above...
-	 */
 	for_each_possible_cpu(cpu) {
 		rcu_read_lock_sched();
+
+		if (dl_bw_visited(cpu, gen)) {
+			rcu_read_unlock_sched();
+			continue;
+		}
+
 		dl_b = dl_bw_of(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..ce527b981e61 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -801,6 +801,15 @@ struct root_domain {
 	struct dl_bw		dl_bw;
 	struct cpudl		cpudl;
 
+	/*
+	 * Indicate whether a root_domain's dl_bw has been checked or
+	 * updated. It's monotonously increasing.
+	 *
+	 * Also, some corner cases, like 'wrap around' is dangerous, but given
+	 * that u64 is 'big enough'. So that shouldn't be a concern.
+	 */
+	u64 visit_gen;
+
 #ifdef HAVE_RT_PUSH_IPI
 	/*
 	 * For IPI pull requests, loop across the rto_mask.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index dd7770226086..90f3e5558fa2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -516,6 +516,7 @@ static int init_rootdomain(struct root_domain *rd)
 	init_irq_work(&rd->rto_push_work, rto_push_irq_work_func);
 #endif
 
+	rd->visit_gen = 0;
 	init_dl_bw(&rd->dl_bw);
 	if (cpudl_init(&rd->cpudl) != 0)
 		goto free_rto_mask;
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D332861E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgJGPMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbgJGPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:12:35 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A5CC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 08:12:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so1491736pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 08:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GTQvyHBhF8zqn+b9rAnfCcHoCUbmVlIZJLbxwOkf134=;
        b=h8CEv3AHR6czfLSrF5ULxZkdQqXdxwq58zLwc23PgHA3N+61pmipRXk7zEMAc6qFOT
         3P7JDYJ/GvGOOnhrZP9cBOcClbor8GBhXWKlE9qaLedPPVWoAk+6ALD7i47GV015f6Kq
         QFyQrAH6xD7vVt1Aw1LYifPYa6FoAABca+ewTpD3sg5JjVou54kWcfPvq482ZDXI0glS
         QqCHYtbXI4Q4lNusTo0dZUB36mZZbRzgwof2BEREZuHIaaNXYqoVhEH4VyLlEQD1AWD/
         35knETcIBb4wUvw9Mo4e5PuZuPGtWdtaXVuB8ceKbN0t4LxTPq0c7MZ3yfUxtF8lAhLT
         Qu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GTQvyHBhF8zqn+b9rAnfCcHoCUbmVlIZJLbxwOkf134=;
        b=CT7d1f6tIxIXY9cYnyZohb0Rgj9hh5GymyQAmo4nAY7WHJN9cnmA2t1og9JUBzKcGe
         gVXBvjCS5o5CpfQwWD5cHiYe1Qq4M4tEW58/ppcogjy+nhZnVK+aCC6trmQgQYfqNXUg
         1fP3z1lyVIoThpIZxBRHouubQ4eHJdEl1olDBqbCyXwyktpvua/8QNtlgB8dVkY/30AF
         eta/nywZKhv5MPY+S4arPFIc/iRwOftTGCRRaGZQ/pBZTT3GYQZZwK4PGID1QqDznevy
         Hul6J28YfrzF3rQqv0UPr4RTgki6d4PqF1PU0cbNueNkUmsKadrGZj6qeS3fwPo8nfAi
         xS0A==
X-Gm-Message-State: AOAM531TLvUVnJyC/Zg0Naxo68nxe8fd58vjWEVHK/GHarHg+ZZnXZvK
        MjbMg1Ti9t6y6TZZPKcvOS2RmDF6wvE=
X-Google-Smtp-Source: ABdhPJwt+RS0YOcxYSdVG1xuI5FbWL54Y1lwceDwiVv0b5S2l+Sopm21P5KYQP23jNa7sV/1Cd7ZTw==
X-Received: by 2002:a62:2581:0:b029:13f:ba38:b113 with SMTP id l123-20020a6225810000b029013fba38b113mr3280672pfl.15.1602083554259;
        Wed, 07 Oct 2020 08:12:34 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id t1sm3172850pja.9.2020.10.07.08.12.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Oct 2020 08:12:33 -0700 (PDT)
Date:   Wed, 7 Oct 2020 23:12:29 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, valentin.schneider@arm.com, raistlin@linux.it,
        iwtbavbm@gmail.com
Subject: [PATCH v5 1/2] sched/deadline: optimize sched_dl_global_validate()
Message-ID: <9ad8eff54a3dd6f7f0da50e827047e4d3c4bb00a.1601993091.git.iwtbavbm@gmail.com>
References: <cover.1601993091.git.iwtbavbm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1601993091.git.iwtbavbm@gmail.com>
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
 kernel/sched/deadline.c | 43 ++++++++++++++++++++++++++++++++---------
 kernel/sched/sched.h    |  7 +++++++
 kernel/sched/topology.c |  1 +
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c19c1883d695..5200e185923f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -97,6 +97,17 @@ static inline unsigned long dl_bw_capacity(int i)
 		return __dl_bw_capacity(i);
 	}
 }
+
+static inline bool dl_bw_visited(int cpu, u32 gen)
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
+static inline bool dl_bw_visited(int cpu, u32 gen)
+{
+	return false;
+}
 #endif
 
 static inline
@@ -2514,26 +2530,30 @@ const struct sched_class dl_sched_class
 	.update_curr		= update_curr_dl,
 };
 
+/* Used for dl_bw check and update. */
+static u32 dl_generation;
+
 int sched_dl_global_validate(void)
 {
 	u64 runtime = global_rt_runtime();
 	u64 period = global_rt_period();
 	u64 new_bw = to_ratio(period, runtime);
 	struct dl_bw *dl_b;
-	int cpu, ret = 0;
 	unsigned long flags;
+	int cpu, ret = 0;
+	u32 gen = ++dl_generation;
 
 	/*
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
@@ -2567,8 +2588,9 @@ void sched_dl_do_global(void)
 {
 	u64 new_bw = -1;
 	struct dl_bw *dl_b;
-	int cpu;
 	unsigned long flags;
+	int cpu;
+	u32 gen = ++dl_generation;
 
 	def_dl_bandwidth.dl_period = global_rt_period();
 	def_dl_bandwidth.dl_runtime = global_rt_runtime();
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
index 28709f6b0975..53477e8b26b0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -798,6 +798,13 @@ struct root_domain {
 	 */
 	cpumask_var_t		dlo_mask;
 	atomic_t		dlo_count;
+
+	/*
+	 * Indicate whether a root_domain's dl_bw has been checked or
+	 * updated. It's monotonously increasing, then wrap around.
+	 */
+	u32 visit_gen;
+
 	struct dl_bw		dl_bw;
 	struct cpudl		cpudl;
 
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


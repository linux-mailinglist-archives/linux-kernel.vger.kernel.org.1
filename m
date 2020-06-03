Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2F71ECAF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 10:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgFCIDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 04:03:45 -0400
Received: from foss.arm.com ([217.140.110.172]:58256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgFCID1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:03:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDE9B113E;
        Wed,  3 Jun 2020 01:03:26 -0700 (PDT)
Received: from macbook.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 80C8C3F52E;
        Wed,  3 Jun 2020 01:03:25 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] sched/fair: Remove unused 'sd' parameter from scale_rt_capacity()
Date:   Wed,  3 Jun 2020 10:03:04 +0200
Message-Id: <20200603080304.16548-5-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603080304.16548-1-dietmar.eggemann@arm.com>
References: <20200603080304.16548-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8ec59c0f5f49 ("sched/topology: Remove unused 'sd'
parameter from arch_scale_cpu_capacity()") it is no longer needed.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5c4a559d0dae..7158d4e3c855 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8039,7 +8039,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 	};
 }
 
-static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
+static unsigned long scale_rt_capacity(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long max = arch_scale_cpu_capacity(cpu);
@@ -8071,7 +8071,7 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
-	unsigned long capacity = scale_rt_capacity(sd, cpu);
+	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
 
 	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
-- 
2.17.1


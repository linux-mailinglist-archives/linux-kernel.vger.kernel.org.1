Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A8D276938
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgIXGs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:48:57 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:53312 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726119AbgIXGs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:48:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U9wa7Ds_1600930127;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U9wa7Ds_1600930127)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Sep 2020 14:48:53 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jiang Biao <benbjiang@tencent.com>
Cc:     Wetp Zhang <wetp.zy@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] sched/fair: Fix wrong cpu selecting from isolated domain
Date:   Thu, 24 Sep 2020 14:48:47 +0800
Message-Id: <1600930127-76857-1-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've met problems that occasionally tasks with full cpumask
(e.g. by putting it into a cpuset or setting to full affinity)
were migrated to our isolated cpus in production environment.

After some analysis, we found that it is due to the current
select_idle_smt() not considering the sched_domain mask.

Steps to reproduce on my 31-CPU hyperthreads machine:
1. with boot parameter: "isolcpus=domain,2-31"
   (thread lists: 0,16 and 1,17)
2. cgcreate -g cpu:test; cgexec -g cpu:test "test_threads"
3. some threads will be migrated to the isolated cpu16~17.

Fix it by checking the valid domain mask in select_idle_smt().

Fixes: 10e2f1acd010 ("sched/core: Rewrite and improve select_idle_siblings())
Reported-by: Wetp Zhang <wetp.zy@linux.alibaba.com>
Reviewed-by: Jiang Biao <benbjiang@tencent.com>
Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 kernel/sched/fair.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a05..fa942c4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6075,7 +6075,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 /*
  * Scan the local SMT mask for idle CPUs.
  */
-static int select_idle_smt(struct task_struct *p, int target)
+static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	int cpu;
 
@@ -6083,7 +6083,8 @@ static int select_idle_smt(struct task_struct *p, int target)
 		return -1;
 
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
+		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
 			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
@@ -6099,7 +6100,7 @@ static inline int select_idle_core(struct task_struct *p, struct sched_domain *s
 	return -1;
 }
 
-static inline int select_idle_smt(struct task_struct *p, int target)
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
 }
@@ -6274,7 +6275,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-	i = select_idle_smt(p, target);
+	i = select_idle_smt(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-- 
1.8.3.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE572CD284
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 10:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388612AbgLCJ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 04:26:49 -0500
Received: from smtp.h3c.com ([60.191.123.56]:56828 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387479AbgLCJ0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 04:26:49 -0500
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 0B3843Bn067998
        for <linux-kernel@vger.kernel.org>; Thu, 3 Dec 2020 16:04:03 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTP id 0B381uaN052213;
        Thu, 3 Dec 2020 16:01:56 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 3 Dec 2020 16:01:58 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] sched/rt: Print curr when RT throttling activated
Date:   Thu, 3 Dec 2020 15:51:29 +0800
Message-ID: <20201203075129.17902-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 0B381uaN052213
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may meet the issue, that one RT thread occupied the cpu by 950ms/1s,
The RT thread maybe is a business thread or other unknown thread.

Currently, it only outputs the print "sched: RT throttling activated"
when RT throttling happen. It is hard to know what is the RT thread,
For further analysis, we need add more prints.

This patch is to print current RT task when RT throttling activated,
It help us to know what is the RT thread in the first time.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 kernel/sched/rt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f215eea6a..8913f38cb 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -946,7 +946,7 @@ static inline int rt_se_prio(struct sched_rt_entity *rt_se)
 	return rt_task_of(rt_se)->prio;
 }
 
-static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
+static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq, struct task_struct *curr)
 {
 	u64 runtime = sched_rt_runtime(rt_rq);
 
@@ -970,7 +970,8 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 		 */
 		if (likely(rt_b->rt_runtime)) {
 			rt_rq->rt_throttled = 1;
-			printk_deferred_once("sched: RT throttling activated\n");
+			printk_deferred_once("sched: RT throttling activated (curr: pid %d, comm %s)\n",
+						curr->pid, curr->comm);
 		} else {
 			/*
 			 * In case we did anyway, make it go away,
@@ -1026,7 +1027,7 @@ static void update_curr_rt(struct rq *rq)
 		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
 			raw_spin_lock(&rt_rq->rt_runtime_lock);
 			rt_rq->rt_time += delta_exec;
-			if (sched_rt_runtime_exceeded(rt_rq))
+			if (sched_rt_runtime_exceeded(rt_rq, curr))
 				resched_curr(rq);
 			raw_spin_unlock(&rt_rq->rt_runtime_lock);
 		}
-- 
2.17.1


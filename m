Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43A2276612
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 03:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIXBy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 21:54:57 -0400
Received: from smtp.h3c.com ([60.191.123.56]:43077 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIXBy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 21:54:57 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 08O1svJc003306
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 09:54:57 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 24 Sep 2020 09:54:58 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] sched/fair: Remove the force parameter of update_tg_load_avg()
Date:   Thu, 24 Sep 2020 09:47:55 +0800
Message-ID: <20200924014755.36253-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 08O1svJc003306
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the file fair.c, sometims update_tg_load_avg(cfs_rq, 0) is used,
sometimes update_tg_load_avg(cfs_rq, false) is used.
update_tg_load_avg() has the parameter force, but in current code,
it never set 1 or true to it, so remove the force parameter.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 kernel/sched/fair.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a0536..7056fa97f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -831,7 +831,7 @@ void init_entity_runnable_average(struct sched_entity *se)
 void post_init_entity_util_avg(struct task_struct *p)
 {
 }
-static void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
+static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
 }
 #endif /* CONFIG_SMP */
@@ -3288,7 +3288,6 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 /**
  * update_tg_load_avg - update the tg's load avg
  * @cfs_rq: the cfs_rq whose avg changed
- * @force: update regardless of how small the difference
  *
  * This function 'ensures': tg->load_avg := \Sum tg->cfs_rq[]->avg.load.
  * However, because tg->load_avg is a global value there are performance
@@ -3300,7 +3299,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
  *
  * Updating tg's load_avg is necessary before update_cfs_share().
  */
-static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
+static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
 	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
 
@@ -3310,7 +3309,7 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
 	if (cfs_rq->tg == &root_task_group)
 		return;
 
-	if (force || abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
+	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
 		atomic_long_add(delta, &cfs_rq->tg->load_avg);
 		cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
 	}
@@ -3612,7 +3611,7 @@ static inline bool skip_blocked_update(struct sched_entity *se)
 
 #else /* CONFIG_FAIR_GROUP_SCHED */
 
-static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force) {}
+static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
 
 static inline int propagate_entity_load_avg(struct sched_entity *se)
 {
@@ -3800,13 +3799,13 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		 * IOW we're enqueueing a task on a new CPU.
 		 */
 		attach_entity_load_avg(cfs_rq, se);
-		update_tg_load_avg(cfs_rq, 0);
+		update_tg_load_avg(cfs_rq);
 
 	} else if (decayed) {
 		cfs_rq_util_change(cfs_rq, 0);
 
 		if (flags & UPDATE_TG)
-			update_tg_load_avg(cfs_rq, 0);
+			update_tg_load_avg(cfs_rq);
 	}
 }
 
@@ -7887,7 +7886,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 		struct sched_entity *se;
 
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
-			update_tg_load_avg(cfs_rq, 0);
+			update_tg_load_avg(cfs_rq);
 
 			if (cfs_rq == &rq->cfs)
 				decayed = true;
@@ -10786,7 +10785,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
 	/* Catch up with the cfs_rq and remove our load when we leave */
 	update_load_avg(cfs_rq, se, 0);
 	detach_entity_load_avg(cfs_rq, se);
-	update_tg_load_avg(cfs_rq, false);
+	update_tg_load_avg(cfs_rq);
 	propagate_entity_cfs_rq(se);
 }
 
@@ -10805,7 +10804,7 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
 	/* Synchronize entity with its cfs_rq */
 	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
 	attach_entity_load_avg(cfs_rq, se);
-	update_tg_load_avg(cfs_rq, false);
+	update_tg_load_avg(cfs_rq);
 	propagate_entity_cfs_rq(se);
 }
 
-- 
2.17.1


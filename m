Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6082758DE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgIWNgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:36:54 -0400
Received: from smtp.h3c.com ([60.191.123.56]:34822 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWNgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:36:54 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 08NDaZ4n036800
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 21:36:35 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 21:36:39 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] sched/fair: Use bool parameter for update_tg_load_avg()
Date:   Wed, 23 Sep 2020 21:29:35 +0800
Message-ID: <20200923132935.20778-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 08NDaZ4n036800
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the file fair.c, sometims update_tg_load_avg(cfs_rq, 0) is used,
sometimes update_tg_load_avg(cfs_rq, false) is used. So change it
to use bool parameter.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a0536..61dac1c58 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -831,7 +831,7 @@ void init_entity_runnable_average(struct sched_entity *se)
 void post_init_entity_util_avg(struct task_struct *p)
 {
 }
-static void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
+static void update_tg_load_avg(struct cfs_rq *cfs_rq, bool force)
 {
 }
 #endif /* CONFIG_SMP */
@@ -3300,7 +3300,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
  *
  * Updating tg's load_avg is necessary before update_cfs_share().
  */
-static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
+static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, bool force)
 {
 	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
 
@@ -3612,7 +3612,7 @@ static inline bool skip_blocked_update(struct sched_entity *se)
 
 #else /* CONFIG_FAIR_GROUP_SCHED */
 
-static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force) {}
+static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, bool force) {}
 
 static inline int propagate_entity_load_avg(struct sched_entity *se)
 {
@@ -3800,13 +3800,13 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		 * IOW we're enqueueing a task on a new CPU.
 		 */
 		attach_entity_load_avg(cfs_rq, se);
-		update_tg_load_avg(cfs_rq, 0);
+		update_tg_load_avg(cfs_rq, false);
 
 	} else if (decayed) {
 		cfs_rq_util_change(cfs_rq, 0);
 
 		if (flags & UPDATE_TG)
-			update_tg_load_avg(cfs_rq, 0);
+			update_tg_load_avg(cfs_rq, false);
 	}
 }
 
@@ -7887,7 +7887,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 		struct sched_entity *se;
 
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
-			update_tg_load_avg(cfs_rq, 0);
+			update_tg_load_avg(cfs_rq, false);
 
 			if (cfs_rq == &rq->cfs)
 				decayed = true;
-- 
2.17.1


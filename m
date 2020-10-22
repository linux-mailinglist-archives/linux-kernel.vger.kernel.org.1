Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76C92961C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368698AbgJVPlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:41:04 -0400
Received: from m12-12.163.com ([220.181.12.12]:57960 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895638AbgJVPlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=FPoCB
        9cCd894ZXCdpNcj1FG6JjnHljFZ2vYZHCNTRdU=; b=VIS5sr6NuYJXjEPtOQdD6
        POTmhrqOvJNcbRuGQyVxutSOsGWflligyvEVTZN1A9hRuB6WqOwTaBhoPuL1vxuW
        8R/A6kSupay+p6qEN/mtBxR51A81OM9jlV6HqGr/396dpRGHuq/sJ67qxM3jLWma
        6d8L8/9MsUxRdUunGf6zjw=
Received: from localhost (unknown [101.86.214.18])
        by smtp8 (Coremail) with SMTP id DMCowABHJuNNp5FfwPIBTA--.34385S2;
        Thu, 22 Oct 2020 23:37:49 +0800 (CST)
Date:   Thu, 22 Oct 2020 23:37:49 +0800
From:   Hui Su <sh_def@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/deadline: use rq_of_se intead of dl_rq_of_se and
 rq_of_dl_rq
Message-ID: <20201022153749.GA290282@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DMCowABHJuNNp5FfwPIBTA--.34385S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr1DGw13JFWUCFW7Ww4fAFb_yoW5Zw1DpF
        4UZ3W5Gr4jyry2g3yjya1kJrWak3s3t34DuF93G393KF1UJryrJF1ayryjvFy3JrW5C3W2
        yr4Yqrs3Ga9Yyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaHq7UUUUU=
X-Originating-IP: [101.86.214.18]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiMQ7FX1UMWEUJIAAAsI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get the rq from dl_se in the old way:
first use dl_rq_of_se() get dl_rq, then use rq_of_dl_rq() get rq,

dl_rq_of_se(): dl_se ==> p ==> rq ==> dl

rq_of_dl_rq():                        dl
				      ||
			       rq <==

rq_of_dl_rq(dl_rq_of_se()):
	       dl_se ==> p ==> rq ==> dl
	       			      ||
	      		       rq <==

it looks a little redundant.

So add rq_of_se(dl_se) to instead of rq_of_dl_rq(dl_rq_of_se(dl_se)).
rq_of_se():    dl_se ==> p ==> rq

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/deadline.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6d93f4518734..b242bbf61b21 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -30,10 +30,16 @@ static inline struct rq *rq_of_dl_rq(struct dl_rq *dl_rq)
 	return container_of(dl_rq, struct rq, dl);
 }
 
-static inline struct dl_rq *dl_rq_of_se(struct sched_dl_entity *dl_se)
+static inline struct rq *rq_of_se(struct sched_dl_entity *dl_se)
 {
 	struct task_struct *p = dl_task_of(dl_se);
-	struct rq *rq = task_rq(p);
+
+	return task_rq(p);
+}
+
+static inline struct dl_rq *dl_rq_of_se(struct sched_dl_entity *dl_se)
+{
+	struct rq *rq = rq_of_se(dl_se);
 
 	return &rq->dl;
 }
@@ -695,8 +701,8 @@ static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p, int flag
  */
 static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
 {
-	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq);
+	struct rq *rq = rq_of_se(dl_se);
+
 
 	WARN_ON(dl_se->dl_boosted);
 	WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
@@ -739,8 +745,7 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
 static void replenish_dl_entity(struct sched_dl_entity *dl_se,
 				struct sched_dl_entity *pi_se)
 {
-	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq);
+	struct rq *rq = rq_of_se(dl_se);
 
 	BUG_ON(pi_se->dl_runtime <= 0);
 
@@ -925,8 +930,7 @@ static inline bool dl_is_implicit(struct sched_dl_entity *dl_se)
 static void update_dl_entity(struct sched_dl_entity *dl_se,
 			     struct sched_dl_entity *pi_se)
 {
-	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq);
+	struct rq *rq = rq_of_se(dl_se);
 
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) ||
 	    dl_entity_overflow(dl_se, pi_se, rq_clock(rq))) {
@@ -1152,7 +1156,7 @@ void init_dl_task_timer(struct sched_dl_entity *dl_se)
 static inline void dl_check_constrained_dl(struct sched_dl_entity *dl_se)
 {
 	struct task_struct *p = dl_task_of(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq_of_se(dl_se));
+	struct rq *rq = rq_of_se(dl_se);
 
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) &&
 	    dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
@@ -1497,8 +1501,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
 	} else if (flags & ENQUEUE_REPLENISH) {
 		replenish_dl_entity(dl_se, pi_se);
 	} else if ((flags & ENQUEUE_RESTORE) &&
-		  dl_time_before(dl_se->deadline,
-				 rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))))) {
+		dl_time_before(dl_se->deadline, rq_clock(rq_of_se(dl_se)))) {
 		setup_new_dl_entity(dl_se);
 	}
 
-- 
2.25.1



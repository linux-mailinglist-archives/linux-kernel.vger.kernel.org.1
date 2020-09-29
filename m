Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1519727D43A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgI2RPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:15:23 -0400
Received: from m12-18.163.com ([220.181.12.18]:54565 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbgI2RPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:15:22 -0400
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 13:15:22 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=SxqWv
        YTG1HpnORyZKr+/WGY6AozVe6bDTYbmS07ilB8=; b=ooZDTCzWH0Sfj1WLHM2yo
        /RwRPUgB+MVj7tswi5sNwrPdT1/BrigKvl0Wm7526qKsWDHxbNk2umCcv1QhVcKC
        uLF4BjZM1e/QgMjCa6jDEk/XeTJAP3FqBQGsrRoTiWB5j5ijrZ6lvkpjl05ZLUe7
        nu1lVNDCcfAGkNtT2fA2n8=
Received: from localhost (unknown [101.228.30.83])
        by smtp14 (Coremail) with SMTP id EsCowAA3t7NIZ3NfsA1LQw--.63069S2;
        Wed, 30 Sep 2020 00:56:40 +0800 (CST)
Date:   Wed, 30 Sep 2020 00:56:40 +0800
From:   Hui Su <sh_def@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/rt.c remove unnecessary parameter in
 pick_next_rt_entity
Message-ID: <20200929165640.GA28986@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EsCowAA3t7NIZ3NfsA1LQw--.63069S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryDKF1kuw45Cw47Jr18Krg_yoW8XF13p3
        WDC34kZa15Ga1jgFWrAwsrurWfKrn8Jw4xWF1Dtw4FyF1YkrWFq3Wagr42vr1Y934UuFya
        yr4jqw43Ka18ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaNtcUUUUU=
X-Originating-IP: [101.228.30.83]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiMQiuX1UMVvtJOAAAsN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct rq is not necessary for pick_next_rt_entity(),
we can get next sched_rt_entity just from struct rt_rq.

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/rt.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f215eea6a966..113965e1952c 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1593,11 +1593,9 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	rt_queue_push_tasks(rq);
 }
 
-static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
-						   struct rt_rq *rt_rq)
+static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
 {
 	struct rt_prio_array *array = &rt_rq->active;
-	struct sched_rt_entity *next = NULL;
 	struct list_head *queue;
 	int idx;
 
@@ -1605,9 +1603,8 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
 	BUG_ON(idx >= MAX_RT_PRIO);
 
 	queue = array->queue + idx;
-	next = list_entry(queue->next, struct sched_rt_entity, run_list);
 
-	return next;
+	return list_entry(queue->next, struct sched_rt_entity, run_list);
 }
 
 static struct task_struct *_pick_next_task_rt(struct rq *rq)
@@ -1616,7 +1613,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 	struct rt_rq *rt_rq  = &rq->rt;
 
 	do {
-		rt_se = pick_next_rt_entity(rq, rt_rq);
+		rt_se = pick_next_rt_entity(rt_rq);
 		BUG_ON(!rt_se);
 		rt_rq = group_rt_rq(rt_se);
 	} while (rt_rq);
-- 
2.25.1



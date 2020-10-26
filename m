Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2686299436
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788344AbgJZRqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:46:40 -0400
Received: from m12-17.163.com ([220.181.12.17]:38333 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1788225AbgJZRol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=bg6cg
        GTHylj+dSW5jnq4jEDiqkbLRkRHYQNHQ7cE1GE=; b=C94dAdlkpyRNly15209ZS
        UaSxuiF9FWCdrfkBbUVGaCd0NqIImEKoqBXKx5uW2DJPMFZFLH79hqhtR1FoAxSf
        Q3gqh3W+iAR983w52H7PVOPWM5R2UHBUjV6BTaxYzuxdu4q7XyK0KnODuSSZ78xZ
        VXnQkXMnmaz6MCHAYScDVo=
Received: from localhost (unknown [101.86.209.121])
        by smtp13 (Coremail) with SMTP id EcCowAAHXhJgCpdfqHwQQA--.42293S2;
        Tue, 27 Oct 2020 01:41:52 +0800 (CST)
Date:   Tue, 27 Oct 2020 01:41:52 +0800
From:   Hui Su <sh_def@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/rt.c: use list_is_singular() instead of '->prev !=
 ->next'
Message-ID: <20201026174152.GA10163@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EcCowAAHXhJgCpdfqHwQQA--.42293S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw4rury7Gw1xury7AFykuFg_yoW8XF4DpF
        ZxZ3srAa1kJanFqa48ZF4v93W3uwnaq3yakFn2g3yrAF4rtrWrXrnxtF42gr4Utr929F1a
        yr4jgrZ3WF1kWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jV-eOUUUUU=
X-Originating-IP: [101.86.209.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiMQHJX1UMWIcI3gAAs2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the list_is_singular(&rt_se->run_list) api instead of
'rt_se->run_list.prev != rt_se->run_list.next'.
Fix a comment by the way, and make the comment more clearly.

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/rt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 49ec096a8aa1..1479d00656b4 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2381,7 +2381,7 @@ static inline void watchdog(struct rq *rq, struct task_struct *p) { }
  *
  * NOTE: This function can be called remotely by the tick offload that
  * goes along full dynticks. Therefore no local assumption can be made
- * and everything must be accessed through the @rq and @curr passed in
+ * and everything must be accessed through the @rq and @p passed in
  * parameters.
  */
 static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
@@ -2406,11 +2406,11 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 	p->rt.time_slice = sched_rr_timeslice;
 
 	/*
-	 * Requeue to the end of queue if we (and all of our ancestors) are not
-	 * the only element on the queue
+	 * Requeue to the end of rt_prio_array queue if we (and all of our
+	 * ancestors) are not the only element on the rt_prio_array queue.
 	 */
 	for_each_sched_rt_entity(rt_se) {
-		if (rt_se->run_list.prev != rt_se->run_list.next) {
+		if (!list_is_singular(&rt_se->run_list)) {
 			requeue_task_rt(rq, p, 0);
 			resched_curr(rq);
 			return;
-- 
2.25.1



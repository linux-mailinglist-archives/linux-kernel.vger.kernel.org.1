Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759512A0C93
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgJ3ReY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:34:24 -0400
Received: from m12-14.163.com ([220.181.12.14]:52117 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgJ3ReY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=aXz6P
        XMABCaK75Cp1e9lZub5YPOLySPyU3fHr8pFIik=; b=NHlZHF6ajC5ZsmfROH0tE
        tpHlFrqSuNp7VrHYz6dnphEEk6GELeAWT4NtWxdH9AcDubHyuVAOndTZigXAmR60
        WpF0+f+fzBuFvsgiZkU+iSOxWlrcIFoOfhMvPW/Q0vlkfT5g6am4Y8vcAw3e0dBO
        yw/O4zm5fB2hWTKraDBnS4=
Received: from localhost (unknown [101.86.209.82])
        by smtp10 (Coremail) with SMTP id DsCowADHDrMnTpxfuqgeTA--.6732S2;
        Sat, 31 Oct 2020 01:32:23 +0800 (CST)
Date:   Sat, 31 Oct 2020 01:32:23 +0800
From:   Hui Su <sh_def@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched: use task_current() instead of 'rq->curr == p'
Message-ID: <20201030173223.GA52339@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DsCowADHDrMnTpxfuqgeTA--.6732S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr1rZw4ktrWxury8JFW5ZFb_yoW5Xw45pa
        98W3yUJw4kGayjqr18ZFZ5Zr43G3s5X3sIgF1vy3ySyF4rK34Fq3WUtFWa9r1Yvr109r4a
        vr4qgrW7Kw18KF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jyT5LUUUUU=
X-Originating-IP: [101.86.209.82]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbitwfNX1aEGOuoxgAAst
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have supplied the macro: 'task_current()', and we should
all use task_current() instaed of 'rq->curr == p',
which is more readable.

No functional change.

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/deadline.c | 2 +-
 kernel/sched/debug.c    | 2 +-
 kernel/sched/fair.c     | 6 +++---
 kernel/sched/rt.c       | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f232305dcefe..3b335be97952 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2474,7 +2474,7 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 			    int oldprio)
 {
-	if (task_on_rq_queued(p) || rq->curr == p) {
+	if (task_on_rq_queued(p) || task_current(rq, p)) {
 #ifdef CONFIG_SMP
 		/*
 		 * This might be too much, but unfortunately
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0655524700d2..1ca554f10901 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -486,7 +486,7 @@ static char *task_group_path(struct task_group *tg)
 static void
 print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 {
-	if (rq->curr == p)
+	if (task_current(rq, p))
 		SEQ_printf(m, ">R");
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 290f9e38378c..c3e3ae76302e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5399,7 +5399,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 		s64 delta = slice - ran;
 
 		if (delta < 0) {
-			if (rq->curr == p)
+			if (task_current(rq, p))
 				resched_curr(rq);
 			return;
 		}
@@ -10740,7 +10740,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	 * our priority decreased, or if we are not currently running on
 	 * this runqueue and our priority is higher than the current's
 	 */
-	if (rq->curr == p) {
+	if (task_current(rq, p)) {
 		if (p->prio > oldprio)
 			resched_curr(rq);
 	} else
@@ -10873,7 +10873,7 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 		 * kick off the schedule if running, otherwise just see
 		 * if we can still preempt the current task.
 		 */
-		if (rq->curr == p)
+		if (task_current(rq, p))
 			resched_curr(rq);
 		else
 			check_preempt_curr(rq, p, 0);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 49ec096a8aa1..cd615aace14c 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2317,7 +2317,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 	if (!task_on_rq_queued(p))
 		return;
 
-	if (rq->curr == p) {
+	if (task_current(rq, p)) {
 #ifdef CONFIG_SMP
 		/*
 		 * If our priority decreases while running, we
-- 
2.29.0



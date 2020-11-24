Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F652C1C27
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 04:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgKXDlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 22:41:53 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:45526 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727822AbgKXDlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 22:41:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UGNJiAF_1606189309;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGNJiAF_1606189309)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Nov 2020 11:41:49 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: remove rq getting in schedule_tail
Date:   Tue, 24 Nov 2020 11:41:45 +0800
Message-Id: <1606189305-51222-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit dfa50b605c2a ("sched: Make finish_task_switch() return 'struct rq
*'") moved the 'rq' parameter into finish_task_switch, so we don't need
it now in schedule_tail.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org> 
Cc: Juri Lelli <juri.lelli@redhat.com> 
Cc: Vincent Guittot <vincent.guittot@linaro.org> 
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com> 
Cc: Steven Rostedt <rostedt@goodmis.org> 
Cc: Ben Segall <bsegall@google.com> 
Cc: Mel Gorman <mgorman@suse.de> 
Cc: Daniel Bristot de Oliveira <bristot@redhat.com> 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/sched/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 44d526b8d942..ab473fce092b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4239,7 +4239,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	__releases(rq->lock)
 {
-	struct rq *rq;
 
 	/*
 	 * New tasks start with FORK_PREEMPT_COUNT, see there and
@@ -4249,7 +4248,7 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 * and the preempt_enable() will end up enabling preemption.
 	 */
 
-	rq = finish_task_switch(prev);
+	finish_task_switch(prev);
 	preempt_enable();
 
 	if (current->set_child_tid)
-- 
2.29.GIT


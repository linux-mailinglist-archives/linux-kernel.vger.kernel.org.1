Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCEC2960F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900950AbgJVOfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:35:09 -0400
Received: from m12-17.163.com ([220.181.12.17]:34771 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900934AbgJVOfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=ISS4W
        INctybSKxM38J/oKDBjRKJgdilAobdsetlufZU=; b=d5tvVBCcldU/K4V42ZPaO
        M+aS6/TKzLeYZSPuV8D2b4qv5mVJ+Y3ksp8cQRvsqRhrz1QrHoTYAMbBTO6oksmW
        LlHioRJ1NEJ16dyrXM4KGUwiKA2adn7M4/QCAHXQ7OrpolRjPo0sgZlw7Uswye05
        yQMydYlOMr/nyllaaLoA4o=
Received: from localhost (unknown [101.86.214.18])
        by smtp13 (Coremail) with SMTP id EcCowACnVrPhl5FfOX+zPA--.25930S2;
        Thu, 22 Oct 2020 22:32:01 +0800 (CST)
Date:   Thu, 22 Oct 2020 22:32:00 +0800
From:   Hui Su <sh_def@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/deadline: remove the param struct rq in
 pick_next_dl_entity()
Message-ID: <20201022143200.GA237517@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EcCowACnVrPhl5FfOX+zPA--.25930S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWrJFyDJF43Jw15Cry7GFg_yoWkZrc_Aw
        10vwn8G340vr4rCr17Gw4xWF92q3yjq3WrAa1vg397ArWagrZIyr95CFnxXr97WFWxCF9r
        Grn5GF4vkrna9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn2Nt3UUUUU==
X-Originating-IP: [101.86.214.18]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiLgHFX1SIqjOPwAAAs-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we can get the next dl_entity just from struct dl_rq,
and do not need the param struct rq.
So remove it.
Like the change: https://lkml.org/lkml/2020/9/29/2030

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/deadline.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6d93f4518734..2736764c3cbc 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1837,8 +1837,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	deadline_queue_push_tasks(rq);
 }
 
-static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
-						   struct dl_rq *dl_rq)
+static struct sched_dl_entity *pick_next_dl_entity(struct dl_rq *dl_rq)
 {
 	struct rb_node *left = rb_first_cached(&dl_rq->root);
 
@@ -1857,7 +1856,7 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
 	if (!sched_dl_runnable(rq))
 		return NULL;
 
-	dl_se = pick_next_dl_entity(rq, dl_rq);
+	dl_se = pick_next_dl_entity(dl_rq);
 	BUG_ON(!dl_se);
 	p = dl_task_of(dl_se);
 	set_next_task_dl(rq, p, true);
-- 
2.25.1



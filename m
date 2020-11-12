Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FE42B0398
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgKLLMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgKLLMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:12:16 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BCAC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:12:15 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id y2so1784517wrl.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=q/nenNf4nIbtsKSlhvoAb4csMxuxA4idUEw49EasD7I=;
        b=MOCT1ILqBQEKTPHafpla72KMkNuvHCUIPpjXDvDOaJ0JmM7oeA94LDW9UIdVVhDLq1
         WVyCk+kV1lPw4xmSTyHuj3phmREgETzKpvSpjTgL/ttYSQVRHww43v1qtmK/g6kGLUYI
         s94zC3DVa6z7x+TGqqH67gXgyQHwa8HhOMmV+YlhQBpfyNSM6i2xAjk1ADh2ppyPWzJl
         ap4wcaFe+2l3X4Lb+ih9vKUQ2pehzm1l3Bo+5bJXQUySQ/eiwJlS5Iv3d0Hpuf1tEgqL
         Xm6ueBBzzzwq9OGU/pTCBowv2PqyofyFH4II9BtOMJG2GFm07p6rwBg6n3ufSEeeJ2u1
         K1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=q/nenNf4nIbtsKSlhvoAb4csMxuxA4idUEw49EasD7I=;
        b=O2/pojTPXGlFJXwk+Yky6oMxcN/avZPC5/HBHVwXAORGLxq02QjB1pvtwwFTzvQGAb
         lZejG+64TZg2FMvYoGcq8UpHdqjNq/mZ7LSx3zeFQOlGG8QLhDyJiqY7hgQ8lquulvGz
         Em7pb6L+4IeAgr12loGmWsvm3sbl+sIGiNThzDLJyT0wdElGfs/29SeEUbaoKfc5F3qn
         9HBwZx0oLFjhWSiTJf4RI/tzn73sM69rmsGGNY87vjRNpbjGJQ+tqo5G/ybFqPg1WOgG
         jPDSN9BErJIF45GehguhUFo1I1yzpMhNstlpikpq7GzYKsWCSpJi2BoPG0lYRQaC/n07
         3tSA==
X-Gm-Message-State: AOAM532jZricCx68S3IIXlMcPXiSulB/0EJ95451ZklbgdWticumrIX2
        a3FUUcznBvEfZJpvN5bfWjF8wBZQubIh
X-Google-Smtp-Source: ABdhPJzJTbhADq/z9W9E16eGuMJcl+eUA52BL16cczl3H4FscWPsiyBTZlg+fQfnMEtABV13kfmR32re6HX4
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:adf:a39e:: with SMTP id
 l30mr26164988wrb.195.1605179534546; Thu, 12 Nov 2020 03:12:14 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:12:01 +0000
Message-Id: <20201112111201.2081902-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] sched/fair: Fix overutilized update in enqueue_task_fair()
From:   Quentin Perret <qperret@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@qperret.net>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Cc:     kernel-team@android.com, Quentin Perret <qperret@google.com>,
        Rick Yiu <rickyiu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enqueue_task_fair() attempts to skip the overutilized update for new
tasks as their util_avg is not accurate yet. However, the flag we check
to do so is overwritten earlier on in the function, which makes the
condition pretty much a nop.

Fix this by saving the flag early on.

Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point
indicator")
Reported-by: Rick Yiu <rickyiu@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 290f9e38378c..f3ee60b92718 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5477,6 +5477,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
+	int task_new = !(flags & ENQUEUE_WAKEUP);
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -5549,7 +5550,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * into account, but that is not straightforward to implement,
 	 * and the following generally works well enough in practice.
 	 */
-	if (flags & ENQUEUE_WAKEUP)
+	if (!task_new)
 		update_overutilized_status(rq);
 
 enqueue_throttle:
-- 
2.29.2.222.g5d2a92d10f8-goog


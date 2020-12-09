Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102692D403F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgLIKpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbgLIKpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:45:08 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0824C061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 02:44:27 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id s2so711384plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 02:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Een9d7veFiTsOXmEKXm9zr8seLLZa1UZOWp04RSXu8E=;
        b=Y7RF0e7kCH5C1MTyPtcgosScjTKq1bzIKM0c7nwWsg8CkbGs3PMhomO9Yq//415SwX
         jhdm5jruxKvcUmO2UIaqgLtpHoh9IwawO0cfMZA9bIjFvPmbtc73dKlosHILHcr/Q1Sm
         MNzlwLlqiPfdC14FrAMgrH7UXcVOZ4wrM728huRaA5ALKj2lI6BQL1ZLN7O/WNGojnag
         JWpQyQlZi2Uz0JeI83CAyikazFE/N46+Q6MY3I5x0+9Udlx0hMhwDOpP0ld7phwqUB/5
         suSTlEOO1YQq8j7foGhBb4sIzkA8Uod+XMBRjHOfuOadl4K240bTt/PdK40eq2gdADXM
         FlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Een9d7veFiTsOXmEKXm9zr8seLLZa1UZOWp04RSXu8E=;
        b=hLQPik6zWWESGUQhwyzFkPVvEMZMS38kFs9b38zr1DQFgbTOebOJseyR/V5PBKLP/p
         I0W8/fRv4nG8vqBBSLfcMhHxs+RoLwyPFcSovtJWql5/18/wabE1/fO84i3tJ3KCkx9W
         9oCi/RITSyUmVVuSWI+sWregeyDVax7d7KR5Cm4jIwEpDvMIEt8qN2QlQnXZd8Pc1KQq
         DGl+gHKRKiIy9JO2RjgBGOwNMNBu8Lyxn+OKGZzckCkHy4VLNCWcDk2+CxzEfTngTRav
         jBexR2ZmugnzIZ74zuGUIrBDfa+nALUKkMCf/fcuK/0Sj/gKCvq8WvtPppy8RrBTEQjk
         MtEg==
X-Gm-Message-State: AOAM532ktKnWL8jFEM+2fqgo5ZpXAzGBYOT3relBllUtaxb5M08gb5+f
        eXCRDedt6uBSeQyrblBSQyflEkP5FUSdqlmM
X-Google-Smtp-Source: ABdhPJwjGP5GKbDfB3VJs+ilffjR4A7rqYEeSXBahZw8bCysea5xSnOhyXnLA3kbpmTlKXHZQzeobg==
X-Received: by 2002:a17:90a:b794:: with SMTP id m20mr1625412pjr.47.1607510667539;
        Wed, 09 Dec 2020 02:44:27 -0800 (PST)
Received: from bj10918pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y69sm2096554pfb.64.2020.12.09.02.44.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 02:44:26 -0800 (PST)
From:   Xuewen Yan <xuewen.yan94@gmail.com>
X-Google-Original-From: Xuewen Yan <xuewen.yan@unisoc.com>
To:     patrick.bellasi@arm.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Xuewen.Yan@unisoc.com, xuewyan@foxmail.com,
        Xuewen Yan <xuewen.yan@unisoc.com>
Subject: [PATCH] fair/util_est: Separate util_est_dequeue() for cfs_rq_util_change
Date:   Wed,  9 Dec 2020 18:44:16 +0800
Message-Id: <1607510656-22990-1-git-send-email-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when a task dequeued, it will update it's util, and cfs_rq_util_change
would check rq's util, if the cfs_rq->avg.util_est.enqueued is bigger
than  cfs_rq->avg.util_avg, but because the cfs_rq->avg.util_est.enqueued
didn't be decreased, this would cause bigger cfs_rq_util by mistake,
as a result, cfs_rq_util_change may change freq unreasonablely.

separate the util_est_dequeue() into util_est_dequeue() and
util_est_update(), and dequeue the _task_util_est(p) before update util.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae7ceba..20ecfd5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3946,11 +3946,9 @@ static inline bool within_margin(int value, int margin)
 }
 
 static void
-util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
+util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p)
 {
-	long last_ewma_diff;
 	struct util_est ue;
-	int cpu;
 
 	if (!sched_feat(UTIL_EST))
 		return;
@@ -3961,6 +3959,17 @@ static inline bool within_margin(int value, int margin)
 	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
 
 	trace_sched_util_est_cfs_tp(cfs_rq);
+}
+
+static void
+util_est_update(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
+{
+	long last_ewma_diff;
+	struct util_est ue;
+	int cpu;
+
+	if (!sched_feat(UTIL_EST))
+		return;
 
 	/*
 	 * Skip update of task's estimated utilization when the task has not
@@ -4085,7 +4094,10 @@ static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
 util_est_enqueue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
 
 static inline void
-util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p,
+util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
+
+static inline void
+util_est_update(struct cfs_rq *cfs_rq, struct task_struct *p,
 		 bool task_sleep) {}
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 
@@ -5589,6 +5601,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int idle_h_nr_running = task_has_idle_policy(p);
 	bool was_sched_idle = sched_idle_rq(rq);
 
+	util_est_dequeue(&rq->cfs, p);
+
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		dequeue_entity(cfs_rq, se, flags);
@@ -5639,7 +5653,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		rq->next_balance = jiffies;
 
 dequeue_throttle:
-	util_est_dequeue(&rq->cfs, p, task_sleep);
+	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
 
-- 
1.9.1


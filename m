Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1419E2B8A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 04:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgKSDxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 22:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKSDxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 22:53:20 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F549C0613D4;
        Wed, 18 Nov 2020 19:53:20 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id j14so4073700ots.1;
        Wed, 18 Nov 2020 19:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4zCaYDrZ0lEDm1VsenAXpHuvR5IQW8vAGkRFs6XZJ9E=;
        b=N9V3ZZ9tNCTmamz3qT4i9pd9Y/VpY7pMLvZmV9h2mw5dxpc252S40gVIs1S9CxqVGa
         UCROQo3KaB9QSNDLUedLHF/U2g7wu9cuwEN3NbZFlNWUdSEUPYdbrpRBOfK6F9coKni+
         G+kcYZwC0AdI0y3DcfASfr0YVbamlywv1sCCyAYeOE08ZQIbe2K9qYcZ7jJ/eUpUMFG4
         o0y1TgixX0hAy2lJp0XzvGkOPbG+JQQH04JVlhME9WsRHpWwhdJyDYfHYgw6xMml0GRu
         IDcFn9yQ9J/8vc1vZyq375JMQmyQzekcTQWhxs2RYIrh/RtvXTsIPQVFmKv9CTdj0r0Z
         d2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4zCaYDrZ0lEDm1VsenAXpHuvR5IQW8vAGkRFs6XZJ9E=;
        b=HdFAcofRTySQ+DRQt+SKW7z9OgdZST+e7Nmdt+iG+HF2L9Mmwu6glHsTiDwB1CGSTK
         IbhvdLdPXIi3evYvNiOGReJ2AedNA405DM9xKh7UWvkMDhTlObdJqOaxVsUoFiILA6Wa
         gQZG/TAvGtte3G8RDlhxqKYFUPl3C42vLCTg0i5m1243mFNctJeKQNG/BL6J1KY0IYDg
         1YfWp7REwVYFt1VYlbbAxi76kqeHepfdY/m7t7tGbs7McpfdtxXLdTbc0sXCb+0xrJ07
         1Y70LcgJuIFHFHp3D8JFlAfRz23tLD43PTAe1IJ+CpRuA2gBriPL2FqsT6BuEGpqAbcd
         MLgQ==
X-Gm-Message-State: AOAM5331BQSCYV3b/x3mwVEgUOJQAoJQNpdAhl/sDD5yuvrwHYqSb5Y0
        5a0bCgwJb6UH9YeS8r2ZlAo=
X-Google-Smtp-Source: ABdhPJxHJg1m8sWYPW99um0XrwXPcTtoRW+HHRFlLp2ToyISBIRIdApnjy+R6m5gg8/tq3F+VxAhww==
X-Received: by 2002:a9d:640e:: with SMTP id h14mr1353540otl.334.1605757999660;
        Wed, 18 Nov 2020 19:53:19 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id k20sm8320926ots.53.2020.11.18.19.53.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 19:53:19 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 3/4] sched: define update_stats_curr_start() as a common helper
Date:   Thu, 19 Nov 2020 11:52:29 +0800
Message-Id: <20201119035230.45330-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201119035230.45330-1-laoar.shao@gmail.com>
References: <20201119035230.45330-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_stats_curr_start() is used to update the exec_start when we are
starting a new run period, which is used by all sched class. So we'd
better define it as a common helper.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/fair.c  | 14 +-------------
 kernel/sched/rt.c    |  2 +-
 kernel/sched/sched.h | 12 ++++++++++++
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aba21191283d..b762cc3e165c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -914,18 +914,6 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	}
 }
 
-/*
- * We are picking a new current task - update its stats:
- */
-static inline void
-update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-	/*
-	 * We are starting a new run period:
-	 */
-	se->exec_start = rq_clock_task(rq_of(cfs_rq));
-}
-
 /**************************************************
  * Scheduling class queueing methods:
  */
@@ -4254,7 +4242,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
 
-	update_stats_curr_start(cfs_rq, se);
+	update_stats_curr_start(rq_of(cfs_rq), se);
 	cfs_rq->curr = se;
 
 	/*
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 49ec096a8aa1..b9ec886702a1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1574,7 +1574,7 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 
 static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
 {
-	p->se.exec_start = rq_clock_task(rq);
+	update_stats_curr_start(rq, &p->se);
 
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e29f2375c4f5..28986736ced9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2642,3 +2642,15 @@ static inline struct task_struct *task_of(struct sched_entity *se)
 	return container_of(se, struct task_struct, se);
 }
 
+/*
+ * We are picking a new current task - update its stats:
+ */
+static inline void
+update_stats_curr_start(struct rq *rq, struct sched_entity *se)
+{
+	/*
+	 * We are starting a new run period:
+	 */
+	se->exec_start = rq_clock_task(rq);
+}
+
-- 
2.18.4


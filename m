Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078042EBEBF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbhAFNfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbhAFNf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:35:29 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C77C06135B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 05:34:49 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id n26so5042493eju.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 05:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tX6FuZmplZyc/sbw7a4TMGB/WxQAzLMlIzYxRA8eKCo=;
        b=JsUL98prO9u7pFhNg8nQR/jF5K3C8OXj8JB+cj5LEG7omKiCqnJx1Fq47vrv1Sp1Jq
         x4z5rZ5AfCyEOmeQJph+t41ETqHxYO5ZQ7TU/A4oRCRYJm6XBNi3YXsjKfllb8tUtS3I
         Uzl4HfMU02sfrRZ5iaoPBdzS6hd280TZxO8bArtUjtspCmoiTiAwnTgOfBRFTq8jCQs/
         +naF+2a/SGnM00HaRHcPHDlnZNP3LENN8d+tiz5LmV9AaS8BcTZW5Ep3Yi8CTx/bbMr2
         m/ZIs3CusxsBHX4S5nM/FYWNVbuFOxYpjpwbHsSuv1dL6IvMeFEsRR5s6nEQKSaFhCHW
         Lj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tX6FuZmplZyc/sbw7a4TMGB/WxQAzLMlIzYxRA8eKCo=;
        b=HMYLaviwe8ly70fKv0s7L78nOK3I9kgYMaNkgcyV9FfknbpqVmc/exS6nKl2VUYRd6
         dtHrkTRnTI/el4ajnCqWMMSORQ8Pz7aKnBIar2drqMp0Y+8cXunM1/xCMFr4J/d5SeMO
         xV1EEwY+0mWHv86vHQjwT4tVcTjIfcWGo5z/JxJcpDbCoMTo0WJcZ/pUjCARwhFFY5/W
         MZfGfj2ouV/Q64H2p5bO/ve1Ol4leIKE1yiJtxT4/3W0rXRb+NmgtJaKDuvOHUBv/e8Z
         p4MD/Ywm+URobIdT5Oip2zkq9i/cdkDag1xIZfpuubnzk8vCP8c5Isd9XMmwwwc2ubQc
         QtIg==
X-Gm-Message-State: AOAM530Oba1fDMjQdThCMHUtUMpeSgXlAjyKSYecjrNmj7kOb4ZicBu9
        gNF6IQfwklGdd6IDquEZAssBBA==
X-Google-Smtp-Source: ABdhPJwTq81ZHZ7u5eUWSY/ch6LJOvWgN2RoyVAOQi7yaPGFwre9SnRUh6bIVRuEC7j3fI/OAXiW4w==
X-Received: by 2002:a17:906:adce:: with SMTP id lb14mr2880049ejb.502.1609940087941;
        Wed, 06 Jan 2021 05:34:47 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:b599:da0e:e83d:2b44])
        by smtp.gmail.com with ESMTPSA id u24sm1264081eje.71.2021.01.06.05.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:34:46 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/3] sched/fair: reduce cases for active balance
Date:   Wed,  6 Jan 2021 14:34:19 +0100
Message-Id: <20210106133419.2971-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210106133419.2971-1-vincent.guittot@linaro.org>
References: <20210106133419.2971-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Active balance is triggered for a number of voluntary case like misfit or
pinned tasks cases but also after that a number of load balance failed to
migrate a task. Remove the active load balance case for overloaded group
as an overloaded state means that there is at least one waiting tasks. The
threshold on the upper limit of the task's load will decrease with the
number of failed LB until the task has migrated.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 69a455113b10..ee87fd6f7359 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9499,13 +9499,30 @@ asym_active_balance(struct lb_env *env)
 }
 
 static inline bool
-voluntary_active_balance(struct lb_env *env)
+imbalanced_active_balance(struct lb_env *env)
+{
+	struct sched_domain *sd = env->sd;
+
+	/* The imbalanced case includes the case of pinned tasks preventing a fair
+	 * distribution of the load on the system but also the even distribution of the
+	 * threads on a system with spare capacity
+	 */
+	if ((env->migration_type == migrate_task) &&
+		(sd->nr_balance_failed > sd->cache_nice_tries+2))
+		return 1;
+
+	return 0;
+}
+
+static int need_active_balance(struct lb_env *env)
 {
 	struct sched_domain *sd = env->sd;
 
 	if (asym_active_balance(env))
 		return 1;
 
+	if (imbalanced_active_balance(env))
+		return 1;
 	/*
 	 * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
 	 * It's worth migrating the task if the src_cpu's capacity is reduced
@@ -9525,16 +9542,6 @@ voluntary_active_balance(struct lb_env *env)
 	return 0;
 }
 
-static int need_active_balance(struct lb_env *env)
-{
-	struct sched_domain *sd = env->sd;
-
-	if (voluntary_active_balance(env))
-		return 1;
-
-	return unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2);
-}
-
 static int active_load_balance_cpu_stop(void *data);
 
 static int should_we_balance(struct lb_env *env)
@@ -9785,21 +9792,13 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			/* We've kicked active balancing, force task migration. */
 			sd->nr_balance_failed = sd->cache_nice_tries+1;
 		}
-	} else
+	} else {
 		sd->nr_balance_failed = 0;
+	}
 
-	if (likely(!active_balance) || voluntary_active_balance(&env)) {
+	if (likely(!active_balance) || need_active_balance(&env)) {
 		/* We were unbalanced, so reset the balancing interval */
 		sd->balance_interval = sd->min_interval;
-	} else {
-		/*
-		 * If we've begun active balancing, start to back off. This
-		 * case may not be covered by the all_pinned logic if there
-		 * is only 1 task on the busy runqueue (because we don't call
-		 * detach_tasks).
-		 */
-		if (sd->balance_interval < sd->max_interval)
-			sd->balance_interval *= 2;
 	}
 
 	goto out;
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F39C2ECDED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbhAGKeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbhAGKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:34:25 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29331C0612F8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:33:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 91so5114116wrj.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3yJrCZHt3G7YVDh20BCiLWsyZdxeGghFUC/3zVX3EPw=;
        b=qJTbmnDixZ1wps+tzJwKiBVaQXP0/0ou76RygQVI2Uqt/ekDD6h9RI25PLjxXA0J3P
         /G8+jneeuMKRHl6BPv1aXIDgx5CJcVGG8gAJF9bO0rdNn+wsIeIf63hM+aLzAcOJr5+P
         egbqhMPwAtlgwqntPrIAcLqcw+xFlVyOSFO/0cEDzCoXCxlkoVYjO/y3V1IznXE2lINz
         UIbleNFKoYqRiS1G12reHAPrGA86L4TC8q5izIr8c2106tjGUcIYpF/JnOk3/JjREYM3
         lAQCpAf7hOKHnYlv23f99UIUAZ2WS3v3oPKhBFijK3eXiwQhkZT7iHizLo89ZGaGvsz+
         OkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3yJrCZHt3G7YVDh20BCiLWsyZdxeGghFUC/3zVX3EPw=;
        b=K5RDfT6L42SR2mQWZp+Y9QwhLGTB1CcYxzdihmOTwj7MMIims6Jn2sWomdN3/8OibH
         2XYzW3rKSRFMvSIPVNIgu3XGR0lFx0TWOA5CSqZ1ziD0mM4HD465LJnxk8kBNG3naBeR
         9oFlmH23J6qnm4wkzAjLoK6ZJIesMtAcKHwZTYJt5JqgJb6O5P4SgyLbGIOX2Bf+FFlR
         In0UNfJilcF0hya+jpCg8UIzZrT+GSEuLLNV53nypT9nQOez9mWKz97FRPF9Quv74fld
         tkYSYCCbFMuUSIWqZk/qM7fpwjg70W0q3EzR6lKIWqwcJh+9lULURQmBPvkU686S2Rls
         Gj2A==
X-Gm-Message-State: AOAM533eAXxJHXrzekKS2ek/PwOtZtEyC06gwbFFRPzcuD422cZG0Umd
        ag9HRxIVfabCqmkfceEKiNzqJA==
X-Google-Smtp-Source: ABdhPJwg9KiOnJzK36mdVV4ka9AW1508Rnge76FUU0ijASfKSYxUQMYWmLKE6KGKpXTFWCdxlv76Dg==
X-Received: by 2002:adf:b78d:: with SMTP id s13mr8404957wre.344.1610015613886;
        Thu, 07 Jan 2021 02:33:33 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d7b:24c9:55f9:4b75])
        by smtp.gmail.com with ESMTPSA id i9sm7734120wrs.70.2021.01.07.02.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:33:33 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/3 v2] sched/fair: reduce cases for active balance
Date:   Thu,  7 Jan 2021 11:33:25 +0100
Message-Id: <20210107103325.30851-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210107103325.30851-1-vincent.guittot@linaro.org>
References: <20210107103325.30851-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Active balance is triggered for a number of voluntary cases like misfit
or pinned tasks cases but also after that a number of load balance
attempts failed to migrate a task. There is no need to use active load
balance when the group is overloaded because an overloaded state means
that there is at least one waiting task. Nevertheless, the waiting task
is not selected and detached until the threshold becomes higher than its
load. This threshold increases with the number of failed lb (see the
condition if ((load >> env->sd->nr_balance_failed) > env->imbalance) in
detach_tasks()) and the waiting task will end up to be selected after a
number of attempts.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a3515dea1afc..00ec5b901188 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9499,13 +9499,32 @@ asym_active_balance(struct lb_env *env)
 }
 
 static inline bool
-voluntary_active_balance(struct lb_env *env)
+imbalanced_active_balance(struct lb_env *env)
+{
+	struct sched_domain *sd = env->sd;
+
+	/*
+	 * The imbalanced case includes the case of pinned tasks preventing a fair
+	 * distribution of the load on the system but also the even distribution of the
+	 * threads on a system with spare capacity
+	 */
+	if ((env->migration_type == migrate_task) &&
+	    (sd->nr_balance_failed > sd->cache_nice_tries+2))
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
+
 	/*
 	 * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
 	 * It's worth migrating the task if the src_cpu's capacity is reduced
@@ -9525,16 +9544,6 @@ voluntary_active_balance(struct lb_env *env)
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
@@ -9787,21 +9796,13 @@ static int load_balance(int this_cpu, struct rq *this_rq,
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106D9271BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgIUHYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIUHYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:24:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3288C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:24:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so11571049wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wryN092ByTgXanHbvHgE8a/y9LUlYx+irX6Hiau1LbY=;
        b=w0/ZsBkDQCQIJqpWIb9FY3Eozec31whnTKHILvvBgvAtbGJyA1TCcbtt4fmvvFz2/x
         9UxnIZcBLd8rg0u+Jd1I0w/xQ3zU6HT5MKzlaIaPHDIan7gLgvvnkVfLt4Gy3egfkhND
         t4/XuC4M//7ysZZ+KUvsfu8qfW12x1I1NtaXwFa5tR4+PWuPif7jklxvmzYb/Z3G9GtD
         YfbhlS5rqZr6mHjir1XIgcyIZnpLV5wnuUStWMvMDxNDVD4tUMF8PS9qfDONfvkao86d
         I2xrbIbQwCtKlBg8A7sXXVquZEvp7irQ8+UcHPztSHNKsb2NfOJVCs6DA+KgBh7gW7c/
         R8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wryN092ByTgXanHbvHgE8a/y9LUlYx+irX6Hiau1LbY=;
        b=eU97pQv393PR1rUNa7BkmgE81FaB5LgrNfXj34LTlUyGVvd9bRR38P09AJ2IVNwunZ
         spZfErRYlGV3xlyCiiv5VH42obbCDJ6DP/rXZG66PqQrmSd9m047jmW5ta1uBL6baIRh
         Hkkz1Q3iRfRv8x5jYrMmJFBHYWmH9Hc7buBmHFBRW7hNQr2+txGReVx07QmaYY8bbdX1
         uv65KIjehVDloZ/Dhp31T40Xc0gZU+GDGKo3EiypKERrCIrKNdI99dVzl4eVw1F6ZBl2
         rU32Njh7ii2pLilxdwaakaQaloF3kZmLzf5UIfHm3+nfXdXOmxT1XzKmRzFl/fvD+R15
         6/kg==
X-Gm-Message-State: AOAM533qT67S5+HEOQehggo5DP2ro1CaK8tt5OVadl6qFXb3JB8BK3O7
        wiofx7QyMtttShrxi2j5iPeq9dCoS1YUKQ==
X-Google-Smtp-Source: ABdhPJwFx8bmgChc5zLJdgeh/0J4JvJquDE4eBgAT0dOj2GrbZA8EAV/4uvdsM05ErtoFLDpxWh18g==
X-Received: by 2002:adf:e84a:: with SMTP id d10mr54132780wrn.66.1600673071606;
        Mon, 21 Sep 2020 00:24:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:157d:a871:1ab2:f67c])
        by smtp.gmail.com with ESMTPSA id k6sm17888651wmi.1.2020.09.21.00.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 00:24:30 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, pauld@redhat.com, hdanton@sina.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/4 v2] sched/fair: relax constraint on task's load during load balance
Date:   Mon, 21 Sep 2020 09:24:21 +0200
Message-Id: <20200921072424.14813-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921072424.14813-1-vincent.guittot@linaro.org>
References: <20200921072424.14813-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some UCs like 9 always running tasks on 8 CPUs can't be balanced and the
load balancer currently migrates the waiting task between the CPUs in an
almost random manner. The success of a rq pulling a task depends of the
value of nr_balance_failed of its domains and its ability to be faster
than others to detach it. This behavior results in an unfair distribution
of the running time between tasks because some CPUs will run most of the
time, if not always, the same task whereas others will share their time
between several tasks.

Instead of using nr_balance_failed as a boolean to relax the condition
for detaching task, the LB will use nr_balanced_failed to relax the
threshold between the tasks'load and the imbalance. This mecanism
prevents the same rq or domain to always win the load balance fight.

Reviewed-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33699db27ed5..d8320dc9d014 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7674,8 +7674,8 @@ static int detach_tasks(struct lb_env *env)
 			 * scheduler fails to find a good waiting task to
 			 * migrate.
 			 */
-			if (load/2 > env->imbalance &&
-			    env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
+
+			if ((load >> env->sd->nr_balance_failed) > env->imbalance)
 				goto next;
 
 			env->imbalance -= load;
-- 
2.17.1


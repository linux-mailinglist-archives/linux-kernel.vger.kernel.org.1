Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B21B271BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgIUHaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgIUHaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:30:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCF4C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:30:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id b79so11427456wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zol9sTlVx1cMDB/LDeZ4rbD4ZJBOxDdQeq9S1TY4BIw=;
        b=U++wP5Oxs7iNDod/UNjDPpsRf3sa27XVybxZP7gmo23YnZ0tR0ukS2ZIaV9/dto8yM
         kFF0qM+yMePKBDHPUxVlSEfGyTjbEFbI5Qy0SbSWir0cuXlVx6Tn/Y5RUNwkijbH8H0n
         aU5+AGDMFjkMtM9xoNMzI1d7a6lTmqvGHyC9VV3R8Wrm//FGa/RmPEH/Ly7q0wL8rVJP
         oWahiJH7WaxWoI52O7zMUdftbXFUGQUCv1OZGJ5C2VOjxdcgh3QKm/j/aNXYNf2lfr5g
         iAZkRuqPq9WxpqWK8vBpCIy9M3rE/z5FJKGC5LFT7IfaKW5VyjuRdzxqIz/e+ijI6qv0
         Eheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zol9sTlVx1cMDB/LDeZ4rbD4ZJBOxDdQeq9S1TY4BIw=;
        b=hLRZbl6l1UtZMTJkeT5I6Hgz2ozFOeQeZ0r7BHV5o3tVEd5KYw1mFKEjrZFmsnX+WI
         bpB08TaZ4gMr09nBgLjYylGUtLWi7nNMmWeTTMvbyoqWCh7pJ2lFIElfNLtwJoV3cRMx
         wJ4jvCmXSssyPJTXWS37Ek1xYbq0cjL7C55B/JGfm/Zgq+6sfpH/iq70ib+tYOw+eCKU
         UUTtZomvmTP7ancz9wtJvANRCkZVZhf7KjW5vywqPUsOoYmUzIPI3LvBCJeT7LrAU/Ee
         2wJgbPVnqPRvRDZLtIOqcXyxjygb/NWLNRDiBkxoZi5+KrdCH6986xwPW8Hv+0I+Odpk
         lYpw==
X-Gm-Message-State: AOAM530dGfPh3HQHh6lfQqUOgHX5hrf+wAm60iI92ofuo1qjlwjesliw
        hxWVr16B5MbVw653SDwYr5VLkA==
X-Google-Smtp-Source: ABdhPJwsDVGeRVgYiTq4kLTn2/rl4PLGOF/6jtq7sewX6RpZ85MXigabqmHC0IE8UQSSz8b0yiU8oA==
X-Received: by 2002:a1c:7308:: with SMTP id d8mr28321173wmb.55.1600673403472;
        Mon, 21 Sep 2020 00:30:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:157d:a871:1ab2:f67c])
        by smtp.gmail.com with ESMTPSA id z14sm19102884wrh.14.2020.09.21.00.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 00:30:02 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/numa: use runnable_avg to classify node
Date:   Mon, 21 Sep 2020 09:29:59 +0200
Message-Id: <20200921072959.16317-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use runnable_avg to classify numa node state similarly to what is done for
normal load balancer. This helps to ensure that numa and normal balancers
use the same view of the state of the system.

- large arm64system: 2 nodes / 224 CPUs
hackbench -l (256000/#grp) -g #grp

grp    tip/sched/core         +patchset              improvement
1      14,008(+/- 4,99 %)     13,800(+/- 3.88 %)     1,48 %
4       4,340(+/- 5.35 %)      4.283(+/- 4.85 %)     1,33 %
16      3,357(+/- 0.55 %)      3.359(+/- 0.54 %)    -0,06 %
32      3,050(+/- 0.94 %)      3.039(+/- 1,06 %)     0,38 %
64      2.968(+/- 1,85 %)      3.006(+/- 2.92 %)    -1.27 %
128     3,290(+/-12.61 %)      3,108(+/- 5.97 %)     5.51 %
256     3.235(+/- 3.95 %)      3,188(+/- 2.83 %)     1.45 %

Reviewed-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
Changes for v2:
- added reviewed tag
- rebased on tip/sched/core

 kernel/sched/fair.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33699db27ed5..a15deb210a17 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1504,6 +1504,7 @@ enum numa_type {
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
 	unsigned long load;
+	unsigned long runnable;
 	unsigned long util;
 	/* Total compute capacity of CPUs on a node */
 	unsigned long compute_capacity;
@@ -1547,6 +1548,7 @@ struct task_numa_env {
 };
 
 static unsigned long cpu_load(struct rq *rq);
+static unsigned long cpu_runnable(struct rq *rq);
 static unsigned long cpu_util(int cpu);
 static inline long adjust_numa_imbalance(int imbalance, int src_nr_running);
 
@@ -1555,11 +1557,13 @@ numa_type numa_classify(unsigned int imbalance_pct,
 			 struct numa_stats *ns)
 {
 	if ((ns->nr_running > ns->weight) &&
-	    ((ns->compute_capacity * 100) < (ns->util * imbalance_pct)))
+	    (((ns->compute_capacity * 100) < (ns->util * imbalance_pct)) ||
+	     ((ns->compute_capacity * imbalance_pct) < (ns->runnable * 100))))
 		return node_overloaded;
 
 	if ((ns->nr_running < ns->weight) ||
-	    ((ns->compute_capacity * 100) > (ns->util * imbalance_pct)))
+	    (((ns->compute_capacity * 100) > (ns->util * imbalance_pct)) &&
+	     ((ns->compute_capacity * imbalance_pct) > (ns->runnable * 100))))
 		return node_has_spare;
 
 	return node_fully_busy;
@@ -1610,6 +1614,7 @@ static void update_numa_stats(struct task_numa_env *env,
 		struct rq *rq = cpu_rq(cpu);
 
 		ns->load += cpu_load(rq);
+		ns->runnable += cpu_runnable(rq);
 		ns->util += cpu_util(cpu);
 		ns->nr_running += rq->cfs.h_nr_running;
 		ns->compute_capacity += capacity_of(cpu);
-- 
2.17.1


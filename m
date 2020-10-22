Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC53D29603F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900361AbgJVNoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900354AbgJVNoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:44:20 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEB9C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:44:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l15so2319206wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XQ1mu2RlNVOop7P5rHLdFuIruym6wsPYv0wahLbOBrU=;
        b=oUQ2opuTaCF8uYjpmp0U8PO9QnhPdjbAIZKCq8oRNSrBFrvxTrpysrz4vENS94e1Xj
         O5+xpNnSeF0nwroEMh6ue5OTqW+a9iwEAekSY0r50KXvM7HOzOkjQblRzo3At6YTp/Vv
         TccjGKOXlGy8cttUtONHi9vuBugHjMCJRfcGT/x5AnDSs4io3jIE+M3cd4wYUyd3oTHe
         2Yxr56Tbi0vNbPTAWfgQDLPwSrE7pKYIIbAM7s4eqDgA5oNzJofstzaQAv+Eg2NCpcH3
         EdZ3zlP+WFJQgYNQE0JvJeMNFbgdZibtmV3T1G7t29FPrWmDf23MvYVckXW0hzESnIaO
         i8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XQ1mu2RlNVOop7P5rHLdFuIruym6wsPYv0wahLbOBrU=;
        b=eFyHvUxYx4Gd9dWM3nvga77AS+rWHpL6XpQFGE7EnGf+xhvmHsxnrc/ZNYXCSgdsy4
         KujxbWSqx47k6ccLEqff56PlcUoucW1y5eBUD8oj4SsQ2aKmrZc9YjOFFcM9TNrfvnge
         Ny4Xx159sEupZYz4Rr4yARV1rogxGImXu6NfAg80UOVJVGy+bEut+54K+VfszOgvTDBm
         EMZGPg4Lo0KsyrtGu4wsY01XEExpIzV8PXxc0EwW3TIv101kFEE5Mhjgb6IsHqg+wxfU
         uG8T8Kd70PQ/lfTiUKDwGAIf5t/H9JDjOlKqNYvZqAv9umCv/xPFUfAU2lLBKQFC6dc8
         DM+Q==
X-Gm-Message-State: AOAM531bgm0JoyZ+1i9V4n+OUyD8vNkYV8YFp4ZjHq5H15Rw1xdi/zJW
        aNvo58Eq0ZA3IOqlzS2v1XoEHg==
X-Google-Smtp-Source: ABdhPJxa/QpErGfyuX4WI8hqMVEuCH08OTF3UGvvmAKodQAjFrTkenc0+k+MxHXIUSAF53kBkajQKg==
X-Received: by 2002:a7b:c143:: with SMTP id z3mr2758427wmi.17.1603374257474;
        Thu, 22 Oct 2020 06:44:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:595f:4822:48a9:74dd])
        by smtp.gmail.com with ESMTPSA id c14sm3954924wrv.12.2020.10.22.06.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 06:44:16 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, morten.rasmussen@arm.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: prefer prev cpu in asymmetric wakeup path
Date:   Thu, 22 Oct 2020 15:43:54 +0200
Message-Id: <20201022134354.3485-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During fast wakeup path, scheduler always check whether local or prev cpus
are good candidates for the task before looking for other cpus in the
domain. With
  commit b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
the heterogenous system gains a dedicated path but doesn't try to keep
reusing prev cpu whenever possible. If the previous cpu is idle and belong to the
asymmetric domain, we should check it 1st before looking for another cpu
because it stays one of the best candidate and it stabilizes task placement
on the system.

This change aligns asymmetric path behavior with symmetric one and reduces
cases where the task migrates across all cpus of the sd_asym_cpucapacity
domains at wakeup.

This change does not impact normal EAS mode but only the overloaded case or
when EAS is not used.

On hikey960 with performance governor (EAS disable)

./perf bench sched pipe -T -l 150000
             mainline           w/ patch
# migrations   299811                  3
ops/sec        154535(+/-0.13%)   181754(+/- 0.29) +17%

Fixes: b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa4c6227cd6d..f39638fe6b94 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6170,7 +6170,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
  * maximize capacity.
  */
 static int
-select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
+select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int prev, int target)
 {
 	unsigned long best_cap = 0;
 	int cpu, best_cpu = -1;
@@ -6178,9 +6178,22 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 
 	sync_entity_load_avg(&p->se);
 
+	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
+	    task_fits_capacity(p, capacity_of(target)))
+		return target;
+
 	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
+	/*
+	 * If the previous CPU belongs to this asymmetric domain and is idle,
+	 * check it 1st as it's the best candidate.
+	 */
+	if (prev != target && cpumask_test_cpu(prev, cpus) &&
+	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
+	    task_fits_capacity(p, capacity_of(prev)))
+		return prev;
+
 	for_each_cpu_wrap(cpu, cpus, target) {
 		unsigned long cpu_cap = capacity_of(cpu);
 
@@ -6223,7 +6236,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		if (!sd)
 			goto symmetric;
 
-		i = select_idle_capacity(p, sd, target);
+		i = select_idle_capacity(p, sd, prev, target);
 		return ((unsigned)i < nr_cpumask_bits) ? i : target;
 	}
 
-- 
2.17.1


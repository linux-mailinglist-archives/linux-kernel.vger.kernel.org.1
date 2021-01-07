Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033B02ECDEC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbhAGKe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbhAGKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:34:25 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE54C0612F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:33:33 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q75so5096542wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kqk6okOP5ATsRY625kBf0QXlv2nTtYEZNLmNx0DMSDA=;
        b=h180i2Q4+8a2pdtgIDlYrN+vKl5GlGStnz/VLA0WZB12NFstt8XNB1Gkogqw1wHeGV
         abVAc0k71aj5wcOvPHVWBJidjnl/fHvLVwzo7LOyrdw8ihEFhIcHPQmuc8k66spUOM1x
         pblyIwfhJ14QQqHKXokwYaewFv8O8vztLla0zh2V5YYB6qYYu5eaGVCQ05MQn6N1NdPn
         t1JSPp+lK+fpzM+W8bTvaKCvpg05s5odJwi1/fa//wggdur7SKvh95e3YIsRR037L/X7
         3HvYEQLsNugrxmlskZVXO6j8vutwNnuMhh5XaB5wbp3Orb7ge4WVLwpgIdvRzyvi7VLD
         wLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kqk6okOP5ATsRY625kBf0QXlv2nTtYEZNLmNx0DMSDA=;
        b=qtvv9Iyy9tXFrhkk9upuO2u+eNl0RKnMZOCgiiOHfnhha1mDa/hGDuUlw5NVm7aC12
         J/cFRQiOlg8FQBIXfaRyaV5ezn7bwnV77ww5i0SjrU4gpT4uV7miOV1IWtQLPuVB0ebl
         HfybrDFWvZ3ruxR8zH1/VqzycTA5ieDd2qAAqPARtuKNt8LeODRDRJo1EBha6cxfKirM
         rkn6d5oBddLpiiqul743HnK6DkR9zOxxq08XGayIAQz26l8kos/tbVC6qyppMfHpOHBj
         yuPG1IEfnrfvIe/bTjiWE7f/6yd4ejSFth79sSuA7tvNikMKG0ozXA8rB92yvoRi8eBN
         wkEQ==
X-Gm-Message-State: AOAM532kYKnaDufXSnrgOgtE7vsNgMIToJABQSw0wEdyEl0/+6hsS8Ih
        vTewfbTDg+u9iXrvSq8H4oUqWg==
X-Google-Smtp-Source: ABdhPJzr5x19BGZE1sbnKkjLsWi9X6f9nCAyHQTzsZCKL9vzOWN9L55gEl00E9LkyiFLH6IT7DTUkA==
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr7428742wml.106.1610015612375;
        Thu, 07 Jan 2021 02:33:32 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d7b:24c9:55f9:4b75])
        by smtp.gmail.com with ESMTPSA id i9sm7734120wrs.70.2021.01.07.02.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:33:31 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/3 v2] sched/fair: don't set LBF_ALL_PINNED unnecessarily
Date:   Thu,  7 Jan 2021 11:33:24 +0100
Message-Id: <20210107103325.30851-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210107103325.30851-1-vincent.guittot@linaro.org>
References: <20210107103325.30851-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting LBF_ALL_PINNED during active load balance is only valid when there
is only 1 running task on the rq otherwise this ends up increasing the
balance interval whereas other tasks could migrate after the next interval
once they become cache-cold as an example.

LBF_ALL_PINNED flag is now always set it by default. It is then cleared
when we find one task that can be pulled when calling detach_tasks() or
during active migration.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5428b8723e61..a3515dea1afc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9626,6 +9626,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	env.src_rq = busiest;
 
 	ld_moved = 0;
+	/* Clear this flag as soon as we find a pullable task */
+	env.flags |= LBF_ALL_PINNED;
 	if (busiest->nr_running > 1) {
 		/*
 		 * Attempt to move tasks. If find_busiest_group has found
@@ -9633,7 +9635,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		 * still unbalanced. ld_moved simply stays zero, so it is
 		 * correctly treated as an imbalance.
 		 */
-		env.flags |= LBF_ALL_PINNED;
 		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
 
 more_balance:
@@ -9759,10 +9760,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
 				raw_spin_unlock_irqrestore(&busiest->lock,
 							    flags);
-				env.flags |= LBF_ALL_PINNED;
 				goto out_one_pinned;
 			}
 
+			/* Record that we found atleast one task that could run on this_cpu */
+			env.flags &= ~LBF_ALL_PINNED;
+
 			/*
 			 * ->active_balance synchronizes accesses to
 			 * ->active_balance_work.  Once set, it's cleared
-- 
2.17.1


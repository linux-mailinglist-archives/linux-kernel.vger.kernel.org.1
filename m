Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3051A766C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 10:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437043AbgDNIub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 04:50:31 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:51972 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729365AbgDNIua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:50:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TvW-l9J_1586854193;
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0TvW-l9J_1586854193)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Apr 2020 16:50:23 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/fair: Simplify the code of should_we_balance()
Date:   Tue, 14 Apr 2020 16:48:19 +0800
Message-Id: <d46a8fe94185c1a5bacde287e96e4a9b7a4b4716.1586852854.git.rocking@linux.alibaba.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <245c792f0e580b3ca342ad61257f4c066ee0f84f.1586594833.git.rocking@linux.alibaba.com>
References: <245c792f0e580b3ca342ad61257f4c066ee0f84f.1586594833.git.rocking@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only consider group_balance_cpu() after there is no idle
cpu. So, just do comparison before return at these two cases.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
---
 kernel/sched/fair.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b..c3f57f4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9409,7 +9409,7 @@ static int active_load_balance_cpu_stop(void *data);
 static int should_we_balance(struct lb_env *env)
 {
 	struct sched_group *sg = env->sd->groups;
-	int cpu, balance_cpu = -1;
+	int cpu;
 
 	/*
 	 * Ensure the balancing environment is consistent; can happen
@@ -9430,18 +9430,12 @@ static int should_we_balance(struct lb_env *env)
 		if (!idle_cpu(cpu))
 			continue;
 
-		balance_cpu = cpu;
-		break;
+		/* Are we the first idle CPU? */
+		return cpu == env->dst_cpu;
 	}
 
-	if (balance_cpu == -1)
-		balance_cpu = group_balance_cpu(sg);
-
-	/*
-	 * First idle CPU or the first CPU(busiest) in this sched group
-	 * is eligible for doing load balancing at this and above domains.
-	 */
-	return balance_cpu == env->dst_cpu;
+	/* Are we the first CPU in the balance mask of this group? */
+	return group_balance_cpu(sg) == env->dst_cpu;
 }
 
 /*
-- 
2.9.5


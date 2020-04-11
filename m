Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0B971A4F17
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 11:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDKJVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 05:21:07 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:35247 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgDKJVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 05:21:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TvC34s5_1586596838;
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0TvC34s5_1586596838)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Apr 2020 17:20:52 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, uri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Simplify the code of should_we_balance()
Date:   Sat, 11 Apr 2020 17:20:20 +0800
Message-Id: <245c792f0e580b3ca342ad61257f4c066ee0f84f.1586594833.git.rocking@linux.alibaba.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only consider group_balance_cpu() after there is no idle
cpu. So, just do comparison before return at these two cases.

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
---
 kernel/sched/fair.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1ea3ddd..81b2c647 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9413,7 +9413,7 @@ static int active_load_balance_cpu_stop(void *data);
 static int should_we_balance(struct lb_env *env)
 {
 	struct sched_group *sg = env->sd->groups;
-	int cpu, balance_cpu = -1;
+	int cpu;
 
 	/*
 	 * Ensure the balancing environment is consistent; can happen
@@ -9434,18 +9434,12 @@ static int should_we_balance(struct lb_env *env)
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
+	/* Are we the first balance CPU of this group? */
+	return group_balance_cpu(sg) == env->dst_cpu;
 }
 
 /*
-- 
2.9.5


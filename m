Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6411C2FD128
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbhATNKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:10:40 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:54766 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733307AbhATM2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:28:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UMLCqvO_1611145670;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UMLCqvO_1611145670)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Jan 2021 20:27:50 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     changhuaixin@linux.alibaba.com
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        pauld@redhead.com, peterz@infradead.org, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: [PATCH 3/4] sched/fair: Add cfs bandwidth burst statistics
Date:   Wed, 20 Jan 2021 20:27:14 +0800
Message-Id: <20210120122715.29493-4-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20210120122715.29493-1-changhuaixin@linux.alibaba.com>
References: <20201217074620.58338-1-changhuaixin@linux.alibaba.com>
 <20210120122715.29493-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce statistics exports for the burstable cfs bandwidth
controller.

The following exports are included:

current_bw: current runtime in global pool
nr_burst:   number of periods bandwidth burst occurs
burst_time: cumulative wall-time that any cpus has
	    used above quota in respective periods

Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
---
 kernel/sched/core.c  |  6 ++++++
 kernel/sched/fair.c  | 12 +++++++++++-
 kernel/sched/sched.h |  3 +++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fecf0f05ef0c..80ca763ca492 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7986,6 +7986,8 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 		cfs_b->runtime = min(max_cfs_runtime, cfs_b->runtime);
 	}
 
+	cfs_b->previous_runtime = cfs_b->runtime;
+
 	/* Restart the period timer (if active) to handle new period expiry: */
 	if (runtime_enabled)
 		start_cfs_bandwidth(cfs_b, 1);
@@ -8234,6 +8236,10 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 		seq_printf(sf, "wait_sum %llu\n", ws);
 	}
 
+	seq_printf(sf, "current_bw %llu\n", cfs_b->runtime);
+	seq_printf(sf, "nr_burst %d\n", cfs_b->nr_burst);
+	seq_printf(sf, "burst_time %llu\n", cfs_b->burst_time);
+
 	return 0;
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 38a726f77783..e431b2fff01d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4600,7 +4600,7 @@ static inline u64 sched_cfs_bandwidth_slice(void)
  */
 void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b, u64 overrun)
 {
-	u64 refill;
+	u64 refill, runtime;
 
 	if (cfs_b->quota != RUNTIME_INF) {
 
@@ -4609,10 +4609,20 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b, u64 overrun)
 			return;
 		}
 
+		if (cfs_b->previous_runtime > cfs_b->runtime) {
+			runtime = cfs_b->previous_runtime - cfs_b->runtime;
+			if (runtime > cfs_b->quota) {
+				cfs_b->burst_time += runtime - cfs_b->quota;
+				cfs_b->nr_burst++;
+			}
+		}
+
 		overrun = min(overrun, cfs_b->max_overrun);
 		refill = cfs_b->quota * overrun;
 		cfs_b->runtime += refill;
 		cfs_b->runtime = min(cfs_b->runtime, cfs_b->buffer);
+
+		cfs_b->previous_runtime = cfs_b->runtime;
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ff8b5382485d..4adb984e5197 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -367,6 +367,7 @@ struct cfs_bandwidth {
 	u64			burst;
 	u64			buffer;
 	u64			max_overrun;
+	u64			previous_runtime;
 	s64			hierarchical_quota;
 
 	u8			idle;
@@ -379,7 +380,9 @@ struct cfs_bandwidth {
 	/* Statistics: */
 	int			nr_periods;
 	int			nr_throttled;
+	int			nr_burst;
 	u64			throttled_time;
+	u64			burst_time;
 #endif
 };
 
-- 
2.14.4.44.g2045bb6


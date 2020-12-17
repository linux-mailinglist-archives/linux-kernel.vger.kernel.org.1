Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7182DCD0C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 08:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgLQHr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 02:47:26 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:44619 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726512AbgLQHrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 02:47:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UIu4fsO_1608191190;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UIu4fsO_1608191190)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Dec 2020 15:46:31 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     bsegall@google.com, changhuaixin@linux.alibaba.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com, mgorman@suse.de,
        mingo@redhat.com, pauld@redhead.com, peterz@infradead.org,
        pjt@google.com, rostedt@goodmis.org, vincent.guittot@linaro.org,
        khlebnikov@yandex-team.ru, xiyou.wangcong@gmail.com,
        shanpeic@linux.alibaba.com
Subject: [PATCH 3/4] sched/fair: Add cfs bandwidth burst statistics
Date:   Thu, 17 Dec 2020 15:46:19 +0800
Message-Id: <20201217074620.58338-4-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20201217074620.58338-1-changhuaixin@linux.alibaba.com>
References: <20201217074620.58338-1-changhuaixin@linux.alibaba.com>
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
index 71cced83df2f..d80a37819d7a 100644
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


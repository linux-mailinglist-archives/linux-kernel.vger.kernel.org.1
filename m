Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAF82CCFCB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgLCGsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:48:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8183 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgLCGsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:48:08 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CmmbQ5SkPz15Wsk;
        Thu,  3 Dec 2020 14:46:58 +0800 (CST)
Received: from [10.174.176.199] (10.174.176.199) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Dec 2020 14:47:15 +0800
Subject: [PATCH 2/2] sched: Split the function show_schedstat()
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <66f73a23-a273-7dff-4202-adc61c3152c8@huawei.com>
Message-ID: <a0245eb6-d7ff-cae5-3608-d46424fa437d@huawei.com>
Date:   Thu, 3 Dec 2020 14:47:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <66f73a23-a273-7dff-4202-adc61c3152c8@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.199]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The schedstat include runqueue-specific stats and domain-specific stats,
so split it into two functions, show_rqstat() and show_domainstat().

No functional changes.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 kernel/sched/stats.c | 101 +++++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 47 deletions(-)

diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index e99403df3f90..ef75e7d64d32 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -12,61 +12,68 @@
  */
 #define SCHEDSTAT_VERSION 15

-static int show_schedstat(struct seq_file *seq, void *v)
+static void show_domainstat(struct seq_file *seq, int cpu)
+{
+#ifdef CONFIG_SMP
+	struct sched_domain *sd;
+	int dcount = 0;
+
+	/* domain-specific stats */
+	rcu_read_lock();
+	for_each_domain(cpu, sd) {
+		enum cpu_idle_type itype;
+
+		seq_printf(seq, "domain%d %*pb", dcount++,
+			   cpumask_pr_args(sched_domain_span(sd)));
+		for (itype = CPU_IDLE; itype < CPU_MAX_IDLE_TYPES;
+				itype++) {
+			seq_printf(seq, " %u %u %u %u %u %u %u %u",
+			    sd->lb_count[itype],
+			    sd->lb_balanced[itype],
+			    sd->lb_failed[itype],
+			    sd->lb_imbalance[itype],
+			    sd->lb_gained[itype],
+			    sd->lb_hot_gained[itype],
+			    sd->lb_nobusyq[itype],
+			    sd->lb_nobusyg[itype]);
+		}
+		seq_printf(seq,
+			   " %u %u %u %u %u %u %u %u %u %u %u %u\n",
+		    sd->alb_count, sd->alb_failed, sd->alb_pushed,
+		    sd->sbe_count, sd->sbe_balanced, sd->sbe_pushed,
+		    sd->sbf_count, sd->sbf_balanced, sd->sbf_pushed,
+		    sd->ttwu_wake_remote, sd->ttwu_move_affine,
+		    sd->ttwu_move_balance);
+	}
+	rcu_read_unlock();
+#endif
+}
+
+static void show_rqstat(struct seq_file *seq, int cpu)
 {
-	int cpu;
+	struct rq *rq = cpu_rq(cpu);
+
+	/* runqueue-specific stats */
+	seq_printf(seq,
+	    "cpu%d %u 0 %u %u %u %u %llu %llu %lu\n",
+	    cpu, rq->yld_count,
+	    rq->sched_count, rq->sched_goidle,
+	    rq->ttwu_count, rq->ttwu_local,
+	    rq->rq_cpu_time,
+	    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
+}

+static int show_schedstat(struct seq_file *seq, void *v)
+{
 	if (v == (void *)1) {
 		seq_printf(seq, "version %d\n", SCHEDSTAT_VERSION);
 		seq_printf(seq, "timestamp %lu\n", jiffies);
 	} else {
-		struct rq *rq;
-#ifdef CONFIG_SMP
-		struct sched_domain *sd;
-		int dcount = 0;
-#endif
-		cpu = (unsigned long)(v - 2);
-		rq = cpu_rq(cpu);
+		int cpu = (unsigned long)(v - 2);

-		/* runqueue-specific stats */
-		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu\n",
-		    cpu, rq->yld_count,
-		    rq->sched_count, rq->sched_goidle,
-		    rq->ttwu_count, rq->ttwu_local,
-		    rq->rq_cpu_time,
-		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
+		show_rqstat(seq, cpu);
+		show_domainstat(seq, cpu);

-#ifdef CONFIG_SMP
-		/* domain-specific stats */
-		rcu_read_lock();
-		for_each_domain(cpu, sd) {
-			enum cpu_idle_type itype;
-
-			seq_printf(seq, "domain%d %*pb", dcount++,
-				   cpumask_pr_args(sched_domain_span(sd)));
-			for (itype = CPU_IDLE; itype < CPU_MAX_IDLE_TYPES;
-					itype++) {
-				seq_printf(seq, " %u %u %u %u %u %u %u %u",
-				    sd->lb_count[itype],
-				    sd->lb_balanced[itype],
-				    sd->lb_failed[itype],
-				    sd->lb_imbalance[itype],
-				    sd->lb_gained[itype],
-				    sd->lb_hot_gained[itype],
-				    sd->lb_nobusyq[itype],
-				    sd->lb_nobusyg[itype]);
-			}
-			seq_printf(seq,
-				   " %u %u %u %u %u %u %u %u %u %u %u %u\n",
-			    sd->alb_count, sd->alb_failed, sd->alb_pushed,
-			    sd->sbe_count, sd->sbe_balanced, sd->sbe_pushed,
-			    sd->sbf_count, sd->sbf_balanced, sd->sbf_pushed,
-			    sd->ttwu_wake_remote, sd->ttwu_move_affine,
-			    sd->ttwu_move_balance);
-		}
-		rcu_read_unlock();
-#endif
 	}
 	return 0;
 }
-- 
2.18.4

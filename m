Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58134294E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 16:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443318AbgJUOMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 10:12:46 -0400
Received: from m12-17.163.com ([220.181.12.17]:34961 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437025AbgJUOMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 10:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=f+r7C
        rHqXQYts/WEVUthduvz1shR4bw+QhzDPrcogVs=; b=FaW5LfXe7UIDyU020NbPj
        H+F9wV/0+dXxifRLck721KJn9OcxcbZP5EzrEBaSifJwwVoBSsABOdQ+PLhlGDjg
        cp9kTbCoH7nQ+kUgQh3DqmvGRcBPWolHt+AJa3MymJFVoRYJNmyxRAhYJhjEDjRF
        kBZAGWNrl+m8PXNSsf1XcU=
Received: from localhost (unknown [101.86.214.18])
        by smtp13 (Coremail) with SMTP id EcCowACXIxE3QZBf5E_YOw--.21188S2;
        Wed, 21 Oct 2020 22:09:59 +0800 (CST)
Date:   Wed, 21 Oct 2020 22:09:58 +0800
From:   Hui Su <sh_def@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched_debug: remove the param dl_rq in print_dl_rq()
Message-ID: <20201021140958.GA138139@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EcCowACXIxE3QZBf5E_YOw--.21188S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1rAw1xJw1fCryxWrW5Awb_yoW8Zw47pF
        nxZayUKayDAryUXa4xArWkurWa9wnrt34agFykZ3yftr1Fqw1rtrnxKr4aqF1Y9r9Ykanx
        ArnF9347K3WUWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jvnQUUUUUU=
X-Originating-IP: [101.86.214.18]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiIBfEX10TB3NavAAAsw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

different from rt_sched_class and fair_sched_class,
dl_sched_class have no sched group.

We can direct get dl_rq according to cpu, so remove the
param dl_rq in print_dl_rq().

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/deadline.c | 2 +-
 kernel/sched/debug.c    | 3 ++-
 kernel/sched/sched.h    | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6d93f4518734..dd9bf5684df9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2885,6 +2885,6 @@ bool dl_cpu_busy(unsigned int cpu)
 #ifdef CONFIG_SCHED_DEBUG
 void print_dl_stats(struct seq_file *m, int cpu)
 {
-	print_dl_rq(m, cpu, &cpu_rq(cpu)->dl);
+	print_dl_rq(m, cpu);
 }
 #endif /* CONFIG_SCHED_DEBUG */
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0655524700d2..2f0166828638 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -640,9 +640,10 @@ void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 #undef P
 }
 
-void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
+void print_dl_rq(struct seq_file *m, int cpu)
 {
 	struct dl_bw *dl_bw;
+	struct dl_rq *dl_rq =  &cpu_rq(cpu)->dl;
 
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "dl_rq[%d]:\n", cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..e01c3391e386 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2261,7 +2261,7 @@ extern void print_rt_stats(struct seq_file *m, int cpu);
 extern void print_dl_stats(struct seq_file *m, int cpu);
 extern void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq);
 extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
-extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
+extern void print_dl_rq(struct seq_file *m, int cpu);
 #ifdef CONFIG_NUMA_BALANCING
 extern void
 show_numa_stats(struct task_struct *p, struct seq_file *m);
-- 
2.25.1



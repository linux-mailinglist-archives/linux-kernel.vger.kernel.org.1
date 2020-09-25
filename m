Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F0E279299
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgIYUr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:47:57 -0400
Received: from m12-15.163.com ([220.181.12.15]:46950 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgIYUr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=7C13u
        zELQwJCWNghcDztIgm0xXNZKxFIF/KIo/ZOGYw=; b=hb5/7Rpt9eVU4obzjtM5E
        8Ep2oXZKE2aLxyYHHDp/z8l96hPBTmnw/LXMPnURzLdBBEUS9wmgvla2uNO1mkKU
        5c0K8re4/Pj9rd/ML4Un3nRfkspjU7bddCk9BHUmRePhOElex+cj8DPoO/UPxqno
        StKKdqyi9rv8pKXphI7pRs=
Received: from localhost (unknown [101.86.214.224])
        by smtp11 (Coremail) with SMTP id D8CowAA3CpSbQG5fGRM2Dw--.11100S2;
        Sat, 26 Sep 2020 03:10:20 +0800 (CST)
Date:   Sat, 26 Sep 2020 03:10:19 +0800
From:   Hui Su <sh_def@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched,fair: use list_for_each_entry() in print_cfs_stats()
Message-ID: <20200925191019.GA174025@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: D8CowAA3CpSbQG5fGRM2Dw--.11100S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF13XF4xtF4kGF15Xw45Awb_yoW8Aw4fpF
        98A3y7tr4vkw15u3WUCrZ5uFy5Xry5W3y2qayDtayvyw1DG3s0qrn7tw15ZFWYqrZ5C345
        Kr4DKryakr47ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcNVkUUUUU=
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiIByqX10TBgVk6AAAsI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro for_each_leaf_cfs_rq_safe() use list_for_each_entry_safe(),
which can against removal of list entry, but we only
print the cfs_rq data and won't remove the list entry in
print_cfs_stats().

Thus, add macro for_each_leaf_cfs_rq() based on
list_for_each_entry(), and use for_each_leaf_cfs_rq() in
print_cfs_stats().

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/fair.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a0536add..d40dfb4349b0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -391,11 +391,16 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
 }
 
-/* Iterate thr' all leaf cfs_rq's on a runqueue */
+/* Iterate thr' all leaf cfs_rq's on a runqueue safely */
 #define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			\
 	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
 				 leaf_cfs_rq_list)
 
+/* Iterate thr' all leaf cfs_rq's on a runqueue */
+#define for_each_leaf_cfs_rq(rq, cfs_rq)			\
+	list_for_each_entry(cfs_rq, &rq->leaf_cfs_rq_list,	\
+				 leaf_cfs_rq_list)
+
 /* Do the two (enqueued) entities belong to the same group ? */
 static inline struct cfs_rq *
 is_same_group(struct sched_entity *se, struct sched_entity *pse)
@@ -11185,10 +11190,10 @@ const struct sched_class fair_sched_class
 #ifdef CONFIG_SCHED_DEBUG
 void print_cfs_stats(struct seq_file *m, int cpu)
 {
-	struct cfs_rq *cfs_rq, *pos;
+	struct cfs_rq *cfs_rq;
 
 	rcu_read_lock();
-	for_each_leaf_cfs_rq_safe(cpu_rq(cpu), cfs_rq, pos)
+	for_each_leaf_cfs_rq(cpu_rq(cpu), cfs_rq)
 		print_cfs_rq(m, cpu, cfs_rq);
 	rcu_read_unlock();
 }
-- 
2.25.1



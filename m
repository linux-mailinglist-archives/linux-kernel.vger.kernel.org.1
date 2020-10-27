Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E113929BACD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1807545AbgJ0QLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:11:35 -0400
Received: from m12-11.163.com ([220.181.12.11]:37755 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1803440AbgJ0Pwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=YYpUG
        dUMMNE62WLI9s0VZ/tsFR2Kqi6GdpgbpCnW7qs=; b=eSndI+BDybmz8RRQYC3yi
        K20qlXNMNOKoAiTI/GL811AqKGIJLZku5u19h54zpNNNdcqi0lXNGhlJI4fnf4i/
        MxqWLDBpZWeXkSQxay6RPq6qTfiuBhSdr9WMvzDfQC5ByV5AKJG/uEw+3bqhj4fk
        RMd/korSzwj4xLRuFMUdV0=
Received: from localhost (unknown [101.86.209.121])
        by smtp7 (Coremail) with SMTP id C8CowADX1cb8QZhf0AiDFg--.18689S2;
        Tue, 27 Oct 2020 23:51:24 +0800 (CST)
Date:   Tue, 27 Oct 2020 23:51:24 +0800
From:   Hui Su <sh_def@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/group_sched: add task_group_is_root() api
Message-ID: <20201027155124.GA57486@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: C8CowADX1cb8QZhf0AiDFg--.18689S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr4rAFWrAFyftF4kZF4rGrg_yoWrAF18pa
        yDAayUJr4rJ3Wvgr97C3yv9ryrWwn3W39F9ryvyw4fJr4Igr1Fvr1qvr129F1YgFs0kF13
        tan0y3y2kw4UKF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5YFAUUUUU=
X-Originating-IP: [101.86.209.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbifxzKX1r6mVew1QAAs9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use task_group_is_root() instead of '!tg->se[0]'
and 'tg == &root_task_group' to judge whether a
task_group is root_task_group.

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/autogroup.c |  2 +-
 kernel/sched/core.c      | 11 ++++++++---
 kernel/sched/fair.c      |  4 ++--
 kernel/sched/rt.c        |  2 +-
 kernel/sched/sched.h     |  2 ++
 5 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 2067080bb235..2673ef7b50e2 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -106,7 +106,7 @@ static inline struct autogroup *autogroup_create(void)
 
 bool task_wants_autogroup(struct task_struct *p, struct task_group *tg)
 {
-	if (tg != &root_task_group)
+	if (!task_group_is_root(tg))
 		return false;
 	/*
 	 * If we race with autogroup_move_group() the caller can use the old
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7d5ab5..6002f9b67f07 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1075,7 +1075,7 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 	 */
 	if (task_group_is_autogroup(task_group(p)))
 		return uc_req;
-	if (task_group(p) == &root_task_group)
+	if (task_group_is_root(task_group(p)))
 		return uc_req;
 
 	uc_max = task_group(p)->uclamp[clamp_id];
@@ -7574,6 +7574,11 @@ void sched_move_task(struct task_struct *tsk)
 	task_rq_unlock(rq, tsk, &rf);
 }
 
+bool task_group_is_root(struct task_group *tg)
+{
+	return tg == &root_task_group;
+}
+
 static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
 {
 	return css ? container_of(css, struct task_group, css) : NULL;
@@ -7894,7 +7899,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 	int i, ret = 0, runtime_enabled, runtime_was_enabled;
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
 
-	if (tg == &root_task_group)
+	if (task_group_is_root(tg))
 		return -EINVAL;
 
 	/*
@@ -8138,7 +8143,7 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 	seq_printf(sf, "nr_throttled %d\n", cfs_b->nr_throttled);
 	seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
 
-	if (schedstat_enabled() && tg != &root_task_group) {
+	if (schedstat_enabled() && !task_group_is_root(tg)) {
 		u64 ws = 0;
 		int i;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 290f9e38378c..fa1a07d74e6a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3311,7 +3311,7 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 	/*
 	 * No need to update load_avg for root_task_group as it is not used.
 	 */
-	if (cfs_rq->tg == &root_task_group)
+	if (task_group_is_root(cfs_rq->tg))
 		return;
 
 	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
@@ -11095,7 +11095,7 @@ int sched_group_set_shares(struct task_group *tg, unsigned long shares)
 	/*
 	 * We can't change the weight of the root cgroup.
 	 */
-	if (!tg->se[0])
+	if (task_group_is_root(tg))
 		return -EINVAL;
 
 	shares = clamp(shares, scale_load(MIN_SHARES), scale_load(MAX_SHARES));
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 49ec096a8aa1..a7987564d5da 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2580,7 +2580,7 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 	 * Disallowing the root group RT runtime is BAD, it would disallow the
 	 * kernel creating (and or operating) RT threads.
 	 */
-	if (tg == &root_task_group && rt_runtime == 0)
+	if (task_group_is_root(tg) && rt_runtime == 0)
 		return -EINVAL;
 
 	/* No period doesn't make any sense. */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index df80bfcea92e..8758fbf0fa2a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -497,6 +497,8 @@ extern void sched_offline_group(struct task_group *tg);
 
 extern void sched_move_task(struct task_struct *tsk);
 
+extern bool task_group_is_root(struct task_group *tg);
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
 
-- 
2.25.1



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBBF3021F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 06:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbhAYFvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 00:51:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:2793 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbhAYFvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 00:51:15 -0500
IronPort-SDR: HgNllAWv0lbSEJI10BBKAZvdAYPaUVTh05Snb5LzzUZr2XOtvjIOZi12rgq0pT7tRz3Ri63iZK
 FxFTeDnj97qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="167345176"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="167345176"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 21:50:30 -0800
IronPort-SDR: xvyeKa7DaMVDTjMpB7vQODjQsSnxWgoUQZxy20pgrSf0b2M9rPu5HeUitxqoh+o4huN+MkG6W3
 FnbK70ruLk4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="573518261"
Received: from aubrey-ubuntu.sh.intel.com ([10.239.53.27])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jan 2021 21:50:26 -0800
From:   Aubrey Li <aubrey.li@intel.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com,
        mgorman@techsingularity.net, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [RFC PATCH v1] sched/fair: limit load balance redo times at the same sched_domain level
Date:   Mon, 25 Jan 2021 14:02:58 +0800
Message-Id: <1611554578-6464-1-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A long-tail load balance cost is observed on the newly idle path,
this is caused by a race window between the first nr_running check
of the busiest runqueue and its nr_running recheck in detach_tasks.

Before the busiest runqueue is locked, the tasks on the busiest
runqueue could be pulled by other CPUs and nr_running of the busiest
runqueu becomes 1, this causes detach_tasks breaks with LBF_ALL_PINNED
flag set, and triggers load_balance redo at the same sched_domain level.

In order to find the new busiest sched_group and CPU, load balance will
recompute and update the various load statistics, which eventually leads
to the long-tail load balance cost.

This patch introduces a variable(sched_nr_lb_redo) to limit load balance
redo times, combined with sysctl_sched_nr_migrate, the max load balance
cost is reduced from 100+ us to 70+ us, measured on a 4s x86 system with
192 logical CPUs.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 kernel/sched/fair.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae7ceba..b59f371 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7407,6 +7407,8 @@ struct lb_env {
 	unsigned int		loop;
 	unsigned int		loop_break;
 	unsigned int		loop_max;
+	unsigned int		redo_cnt;
+	unsigned int		redo_max;
 
 	enum fbq_type		fbq_type;
 	enum migration_type	migration_type;
@@ -9525,6 +9527,7 @@ static int should_we_balance(struct lb_env *env)
 	return group_balance_cpu(sg) == env->dst_cpu;
 }
 
+static const unsigned int sched_nr_lb_redo = 1;
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -9547,6 +9550,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		.dst_grpmask    = sched_group_span(sd->groups),
 		.idle		= idle,
 		.loop_break	= sched_nr_migrate_break,
+		.redo_max	= sched_nr_lb_redo,
 		.cpus		= cpus,
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
@@ -9682,7 +9686,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			 * destination group that is receiving any migrated
 			 * load.
 			 */
-			if (!cpumask_subset(cpus, env.dst_grpmask)) {
+			if (!cpumask_subset(cpus, env.dst_grpmask) &&
+					++env.redo_cnt < env.redo_max) {
 				env.loop = 0;
 				env.loop_break = sched_nr_migrate_break;
 				goto redo;
-- 
2.7.4


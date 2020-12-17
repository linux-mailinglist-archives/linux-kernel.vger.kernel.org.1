Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BE32DD177
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 13:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgLQMXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 07:23:50 -0500
Received: from foss.arm.com ([217.140.110.172]:33138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbgLQMXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 07:23:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B7A031B;
        Thu, 17 Dec 2020 04:23:01 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 24ABA3F66B;
        Thu, 17 Dec 2020 04:22:59 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com, kuo-lang.tseng@intel.com, shakeelb@google.com,
        mingo@redhat.com, babu.moger@amd.com, james.morse@arm.com,
        hpa@zytor.com, Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 4/3] x86/intel_rdt: Apply READ_ONCE/WRITE_ONCE to task_struct .rmid & .closid
Date:   Thu, 17 Dec 2020 12:19:31 +0000
Message-Id: <20201217121931.10734-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1607036601.git.reinette.chatre@intel.com>
References: <cover.1607036601.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A CPU's current task can have its {closid, rmid} fields read locally while
they are being concurrently written to from another CPU. This can happen
anytime __resctrl_sched_in() races with either __rdtgroup_move_task() or
rdt_move_group_tasks().

Prevent load / store tearing for those accesses by giving them the
READ_ONCE() / WRITE_ONCE() treatment.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/x86/include/asm/resctrl.h         | 11 +++++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 +++++-----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 07603064df8f..d60ed0668a59 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -56,19 +56,22 @@ static void __resctrl_sched_in(void)
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
 	u32 closid = state->default_closid;
 	u32 rmid = state->default_rmid;
+	u32 tmp;
 
 	/*
 	 * If this task has a closid/rmid assigned, use it.
 	 * Else use the closid/rmid assigned to this cpu.
 	 */
 	if (static_branch_likely(&rdt_alloc_enable_key)) {
-		if (current->closid)
-			closid = current->closid;
+		tmp = READ_ONCE(current->closid);
+		if (tmp)
+			closid = tmp;
 	}
 
 	if (static_branch_likely(&rdt_mon_enable_key)) {
-		if (current->rmid)
-			rmid = current->rmid;
+		tmp = READ_ONCE(current->rmid);
+		if (tmp)
+			rmid = tmp;
 	}
 
 	if (closid != state->cur_closid || rmid != state->cur_rmid) {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 523660a68d9a..791a7064edea 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -601,11 +601,11 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	 */
 
 	if (rdtgrp->type == RDTCTRL_GROUP) {
-		tsk->closid = rdtgrp->closid;
-		tsk->rmid = rdtgrp->mon.rmid;
+		WRITE_ONCE(tsk->closid, rdtgrp->closid);
+		WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
 	} else if (rdtgrp->type == RDTMON_GROUP) {
 		if (rdtgrp->mon.parent->closid == tsk->closid) {
-			tsk->rmid = rdtgrp->mon.rmid;
+			WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
 		} else {
 			rdt_last_cmd_puts("Can't move task to different control group\n");
 			return -EINVAL;
@@ -2345,8 +2345,8 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 	for_each_process_thread(p, t) {
 		if (!from || is_closid_match(t, from) ||
 		    is_rmid_match(t, from)) {
-			t->closid = to->closid;
-			t->rmid = to->mon.rmid;
+			WRITE_ONCE(t->closid, to->closid);
+			WRITE_ONCE(t->rmid, to->mon.rmid);
 
 			/* If the task is on a CPU, set the CPU in the mask. */
 			set_task_cpumask(t, mask);
-- 
2.27.0


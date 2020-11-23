Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488ED2BFE28
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 03:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgKWCY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 21:24:59 -0500
Received: from foss.arm.com ([217.140.110.172]:51754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgKWCY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 21:24:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDFD9113E;
        Sun, 22 Nov 2020 18:24:58 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A8A33F70D;
        Sun, 22 Nov 2020 18:24:57 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     James Morse <James.Morse@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 3/3] x86/intel_rdt: Apply READ_ONCE/WRITE_ONCE to task_struct .rmid & .closid
Date:   Mon, 23 Nov 2020 02:24:33 +0000
Message-Id: <20201123022433.17905-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201123022433.17905-1-valentin.schneider@arm.com>
References: <20201123022433.17905-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A CPU's current task can have its {closid, rmid} fields read locally while
they are being concurrently written to from another CPU. This can happen
anytime __resctrl_sched_in() races with e.g. a __rdtgroup_move_task() call
on a different CPU targeting the first CPU's current task.

Prevent load / store tearing for those accesses by giving them the
READ_ONCE() / WRITE_ONCE() treatment.

Reviewed-by: James Morse <James.Morse@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/x86/include/asm/resctrl.h         | 11 +++++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 24 +++++++++++++-----------
 2 files changed, 20 insertions(+), 15 deletions(-)

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
index f62d81104fd0..135a51529f70 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -529,8 +529,8 @@ static void move_myself(struct callback_head *head)
 	 */
 	if (atomic_dec_and_test(&rdtgrp->waitcount) &&
 	    (rdtgrp->flags & RDT_DELETED)) {
-		current->closid = 0;
-		current->rmid = 0;
+		WRITE_ONCE(current->closid, 0);
+		WRITE_ONCE(current->rmid, 0);
 		kfree(rdtgrp);
 	}
 
@@ -565,8 +565,8 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	 * their parent CTRL group.
 	 */
 	if (rdtgrp->type == RDTCTRL_GROUP)
-		tsk->closid = rdtgrp->closid;
-	tsk->rmid = rdtgrp->mon.rmid;
+		WRITE_ONCE(tsk->closid, rdtgrp->closid);
+	WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
 
 	/*
 	 * Take a refcount, so rdtgrp cannot be freed before the
@@ -598,13 +598,15 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
 {
 	return (rdt_alloc_capable &&
-	       (r->type == RDTCTRL_GROUP) && (t->closid == r->closid));
+		(r->type == RDTCTRL_GROUP) &&
+		(READ_ONCE(t->closid) == r->closid));
 }
 
 static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
 {
 	return (rdt_mon_capable &&
-	       (r->type == RDTMON_GROUP) && (t->rmid == r->mon.rmid));
+		(r->type == RDTMON_GROUP) &&
+		(READ_ONCE(t->rmid) == r->mon.rmid));
 }
 
 /**
@@ -680,7 +682,7 @@ static int rdtgroup_move_task(pid_t pid, struct rdtgroup *rdtgrp,
 		goto out;
 
 	if (rdtgrp->type == RDTMON_GROUP &&
-	    rdtgrp->mon.parent->closid != tsk->closid) {
+	    rdtgrp->mon.parent->closid != READ_ONCE(tsk->closid)) {
 		rdt_last_cmd_puts("Can't move task to different control group\n");
 		ret = -EINVAL;
 		goto out;
@@ -810,7 +812,7 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
 		    rdtg->mode != RDT_MODE_EXCLUSIVE)
 			continue;
 
-		if (rdtg->closid != tsk->closid)
+		if (rdtg->closid != READ_ONCE(tsk->closid))
 			continue;
 
 		seq_printf(s, "res:%s%s\n", (rdtg == &rdtgroup_default) ? "/" : "",
@@ -818,7 +820,7 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
 		seq_puts(s, "mon:");
 		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
 				    mon.crdtgrp_list) {
-			if (tsk->rmid != crg->mon.rmid)
+			if (READ_ONCE(tsk->rmid) != crg->mon.rmid)
 				continue;
 			seq_printf(s, "%s", crg->kn->name);
 			break;
@@ -2336,8 +2338,8 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 	for_each_process_thread(p, t) {
 		if (!from || is_closid_match(t, from) ||
 		    is_rmid_match(t, from)) {
-			t->closid = to->closid;
-			t->rmid = to->mon.rmid;
+			WRITE_ONCE(t->closid, to->closid);
+			WRITE_ONCE(t->rmid, to->mon.rmid);
 
 #ifdef CONFIG_SMP
 			/*
-- 
2.27.0


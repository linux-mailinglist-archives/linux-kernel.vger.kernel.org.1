Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09992BFE27
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 03:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgKWCY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 21:24:58 -0500
Received: from foss.arm.com ([217.140.110.172]:51736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgKWCY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 21:24:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43FD9106F;
        Sun, 22 Nov 2020 18:24:57 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E99AA3F70D;
        Sun, 22 Nov 2020 18:24:55 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     James Morse <James.Morse@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 2/3] x86/intel_rdt: Plug task_work vs task_struct {rmid,closid} update race
Date:   Mon, 23 Nov 2020 02:24:32 +0000
Message-Id: <20201123022433.17905-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201123022433.17905-1-valentin.schneider@arm.com>
References: <20201123022433.17905-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon moving a task to a new control / monitor group, said task's
{closid, rmid} fields are updated *after* triggering the move_myself()
task_work callback. If the triggering thread gets preempted, or if the
targeted task was already on its way to return to userspace, then
move_myself() might be executed before the relevant task's {closid, rmid}
fields have been updated.

Update the task_struct's {closid, rmid} tuple *before* invoking
task_work_add(). Highlight the required ordering with a pair of comments.

Fixes: e02737d5b826 ("x86/intel_rdt: Add tasks files")
Reviewed-by: James Morse <James.Morse@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 34 ++++++++++++++++----------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b6b5b95df833..f62d81104fd0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -524,6 +524,8 @@ static void move_myself(struct callback_head *head)
 	 * If resource group was deleted before this task work callback
 	 * was invoked, then assign the task to root group and free the
 	 * resource group.
+	 *
+	 * See pairing atomic_inc() in __rdtgroup_move_task()
 	 */
 	if (atomic_dec_and_test(&rdtgrp->waitcount) &&
 	    (rdtgrp->flags & RDT_DELETED)) {
@@ -553,14 +555,32 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	callback = kzalloc(sizeof(*callback), GFP_KERNEL);
 	if (!callback)
 		return -ENOMEM;
-	callback->work.func = move_myself;
+
+	init_task_work(&callback->work, move_myself);
 	callback->rdtgrp = rdtgrp;
 
+	/*
+	 * For ctrl_mon groups move both closid and rmid.
+	 * For monitor groups, can move the tasks only from
+	 * their parent CTRL group.
+	 */
+	if (rdtgrp->type == RDTCTRL_GROUP)
+		tsk->closid = rdtgrp->closid;
+	tsk->rmid = rdtgrp->mon.rmid;
+
 	/*
 	 * Take a refcount, so rdtgrp cannot be freed before the
 	 * callback has been invoked.
+	 *
+	 * Also ensures above {closid, rmid} writes are observed by
+	 * move_myself(), as it can run immediately after task_work_add().
+	 * Otherwise old values may be loaded, and the move will only actually
+	 * happen at the next context switch.
+	 *
+	 * Pairs with atomic_dec() in move_myself().
 	 */
 	atomic_inc(&rdtgrp->waitcount);
+
 	ret = task_work_add(tsk, &callback->work, TWA_RESUME);
 	if (ret) {
 		/*
@@ -571,18 +591,6 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 		atomic_dec(&rdtgrp->waitcount);
 		kfree(callback);
 		rdt_last_cmd_puts("Task exited\n");
-	} else {
-		/*
-		 * For ctrl_mon groups move both closid and rmid.
-		 * For monitor groups, can move the tasks only from
-		 * their parent CTRL group.
-		 */
-		if (rdtgrp->type == RDTCTRL_GROUP) {
-			tsk->closid = rdtgrp->closid;
-			tsk->rmid = rdtgrp->mon.rmid;
-		} else if (rdtgrp->type == RDTMON_GROUP) {
-			tsk->rmid = rdtgrp->mon.rmid;
-		}
 	}
 	return ret;
 }
-- 
2.27.0


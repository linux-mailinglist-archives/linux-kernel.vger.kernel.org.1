Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629442DDB83
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 23:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgLQWcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 17:32:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:41195 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732093AbgLQWci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 17:32:38 -0500
IronPort-SDR: 8zMSzPp/zNQrnfzFU3nvBZAhIOeb/Ilj4AeXFYfn1y+LK1lzH/2u1LgHtW4A02TK0h4gvTiLBb
 HTYPtYynjY5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="154567848"
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="154567848"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 14:31:43 -0800
IronPort-SDR: V+bt6X4JGWOuRyhkI25MFTX4y+NdpKXpbg2T9yyl/o7yUvxPEShenYR4k/vmfDxV0/NbCPA8MQ
 dwPKRfL9Y1oA==
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="387836645"
Received: from rchatre-mobl1.jf.intel.com ([10.54.70.7])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 14:31:42 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, shakeelb@google.com,
        valentin.schneider@arm.com, mingo@redhat.com, babu.moger@amd.com,
        james.morse@arm.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 4/4] x86/resctrl: Apply READ_ONCE/WRITE_ONCE to task_struct .rmid & .closid
Date:   Thu, 17 Dec 2020 14:31:21 -0800
Message-Id: <9921fda88ad81afb9885b517fbe864a2bc7c35a9.1608243147.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608243147.git.reinette.chatre@intel.com>
References: <cover.1608243147.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

A CPU's current task can have its {closid, rmid} fields read locally while
they are being concurrently written to from another CPU. This can happen
anytime __resctrl_sched_in() races with either __rdtgroup_move_task() or
rdt_move_group_tasks().

Prevent load / store tearing for those accesses by giving them the
READ_ONCE() / WRITE_ONCE() treatment.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
V1->V2:
* Subject line prefix x86/intel_rdt -> x86/resctrl. (Reinette)

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
index 9bd36210d220..5aeb4fb91228 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -569,11 +569,11 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
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
@@ -2316,8 +2316,8 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 	for_each_process_thread(p, t) {
 		if (!from || is_closid_match(t, from) ||
 		    is_rmid_match(t, from)) {
-			t->closid = to->closid;
-			t->rmid = to->mon.rmid;
+			WRITE_ONCE(t->closid, to->closid);
+			WRITE_ONCE(t->rmid, to->mon.rmid);
 
 			/*
 			 * If the task is on a CPU, set the CPU in the mask.
-- 
2.26.2


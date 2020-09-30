Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC6027F5F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbgI3X00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:26:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:25939 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732252AbgI3X0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:26:21 -0400
IronPort-SDR: KN2yUR3cGCLOfeUJFNtlC+IzpZ8VXtojJDU8AcA6K/F7L62uPBc0QkzOeWbTul61eNlXSpXmMq
 LEtY6d2ai5Vw==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="159975256"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="159975256"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:26:19 -0700
IronPort-SDR: 1TDlzbbIHwUWFLpurDP4XqtwPZsSHn3UjIW/xcpe9yPyPl1zKPlZiApKbEW7U/WvwxutBQOqZA
 W0YkuVlH21lw==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="457857984"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:26:19 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] x86/mce: Recover from poison found while copying from user space
Date:   Wed, 30 Sep 2020 16:26:10 -0700
Message-Id: <20200930232611.15355-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200930232611.15355-1-tony.luck@intel.com>
References: <20200921113144.GD5901@zn.tnic>
 <20200930232611.15355-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youquan Song <youquan.song@intel.com>

Existing kernel code can only recover from a machine check on code that
is tagged in the exception table with a fault handling recovery path.

Two new fields in the task structure to pass information from machine
check handler to the "task_work" that is queued to run before the task
returns to user mode:

+ mce_vaddr: will be initialized to the user virtual address of the fault
  in the case where the fault occurred in the kernel copying data from
  a user address.  This is so that kill_me_maybe() can provide that
  information to the user SIGBUS handler.

+ mce_kflags: copy of the struct mce.kflags needed by kill_me_maybe()
  to determine if mce_vaddr is applicable to this error.

Add code to recover from a machine check while copying data from user
space to the kernel. Action for this case is the same as if the user
touched the poison directly; unmap the page and send a SIGBUS to the task.

Refactor the recovery code path to share common code between the "fault
in user mode" case and the "fault while copying from user" case.

New code paths will be activated by the next patch which sets
MCE_IN_KERNEL_COPYIN.

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 33 +++++++++++++++++++++------------
 include/linux/sched.h          |  2 ++
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a2bb4d4df8b7..9713825e6745 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1386,15 +1386,10 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	if ((m.cs & 3) == 3) {
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
-
-		current->mce_addr = m.addr;
-		current->mce_ripv = !!(m.mcgstatus & MCG_STATUS_RIPV);
-		current->mce_whole_page = whole_page(&m);
-		current->mce_kill_me.func = kill_me_maybe;
-		if (kill_it)
-			current->mce_kill_me.func = kill_me_now;
-		task_work_add(current, &current->mce_kill_me, true);
 	} else {
+		/* (m.kflags MCE_IN_KERNEL_RECOV must have been set to get here */
+		BUG_ON(!(m.kflags & MCE_IN_KERNEL_RECOV));
+
 		/*
 		 * Handle an MCE which has happened in kernel space but from
 		 * which the kernel can recover: ex_has_fault_handler() has
@@ -1404,11 +1399,25 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 * corresponding exception handler which would do that is the
 		 * proper one.
 		 */
-		if (m.kflags & MCE_IN_KERNEL_RECOV) {
-			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
-				mce_panic("Failed kernel mode recovery", &m, msg);
-		}
+		if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
+			mce_panic("Failed kernel mode recovery", &m, msg);
+
+		/*
+		 * If this wasn't a copy from user, then recovery is complete.
+		 */
+		if (!(m.kflags & MCE_IN_KERNEL_COPYIN))
+			goto out;
 	}
+
+	current->mce_addr = m.addr;
+	current->mce_kflags = m.kflags;
+	current->mce_ripv = !!(m.mcgstatus & MCG_STATUS_RIPV);
+	current->mce_whole_page = whole_page(&m);
+	current->mce_kill_me.func = kill_me_maybe;
+	if (kill_it)
+		current->mce_kill_me.func = kill_me_now;
+	task_work_add(current, &current->mce_kill_me, true);
+
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 93ecd930efd3..2cbba3e2b150 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1308,6 +1308,8 @@ struct task_struct {
 #endif
 
 #ifdef CONFIG_X86_MCE
+	void __user			*mce_vaddr;
+	__u64				mce_kflags;
 	u64				mce_addr;
 	__u64				mce_ripv : 1,
 					mce_whole_page : 1,
-- 
2.21.1


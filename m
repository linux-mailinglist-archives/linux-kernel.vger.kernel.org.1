Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133142853A3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgJFVJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:09:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:44603 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbgJFVJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:09:19 -0400
IronPort-SDR: n/3tjKO48euh3DFj3Ud65kNnd1apn2ftKVHolk6O3WcvtdzqbGbfZyuytuYbCKMgxMmRuz0/gn
 mkKhwvgXodRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="161302110"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="161302110"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 14:09:19 -0700
IronPort-SDR: BCHtQym/6C62d0OCIBjOrffAsbQ2t6syJMdZIn/uhys/52Nz/LE3OhyP5MSerGUN9O5VFKLKYf
 iOMiYPLLDCWQ==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="527590603"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 14:09:19 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] x86/mce: Recover from poison found while copying from user space
Date:   Tue,  6 Oct 2020 14:09:09 -0700
Message-Id: <20201006210910.21062-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20201006210910.21062-1-tony.luck@intel.com>
References: <20201005163130.GD21151@zn.tnic>
 <20201006210910.21062-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Use a new helper function to share common code between the "fault
in user mode" case and the "fault while copying from user" case.

New code paths will be activated by the next patch which sets
MCE_IN_KERNEL_COPYIN.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 27 ++++++++++++++++++++-------
 include/linux/sched.h          |  2 ++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2d6caf09e8e6..5c423c4bab68 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1260,6 +1260,21 @@ static void kill_me_maybe(struct callback_head *cb)
 	kill_me_now(cb);
 }
 
+static void queue_task_work(struct mce *m, int kill_it)
+{
+	current->mce_addr = m->addr;
+	current->mce_kflags = m->kflags;
+	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
+	current->mce_whole_page = whole_page(m);
+
+	if (kill_it)
+		current->mce_kill_me.func = kill_me_now;
+	else
+		current->mce_kill_me.func = kill_me_maybe;
+
+	task_work_add(current, &current->mce_kill_me, true);
+}
+
 /*
  * The actual machine check handler. This only handles real
  * exceptions when something got corrupted coming in through int 18.
@@ -1401,13 +1416,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		current->mce_addr = m.addr;
-		current->mce_ripv = !!(m.mcgstatus & MCG_STATUS_RIPV);
-		current->mce_whole_page = whole_page(&m);
-		current->mce_kill_me.func = kill_me_maybe;
-		if (kill_it)
-			current->mce_kill_me.func = kill_me_now;
-		task_work_add(current, &current->mce_kill_me, true);
+		queue_task_work(&m, kill_it);
+
 	} else {
 		/*
 		 * Handle an MCE which has happened in kernel space but from
@@ -1422,6 +1432,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
 				mce_panic("Failed kernel mode recovery", &m, msg);
 		}
+
+		if (m.kflags & MCE_IN_KERNEL_COPYIN)
+			queue_task_work(&m, kill_it);
 	}
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
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


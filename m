Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90209283C91
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgJEQcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgJEQcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:32:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14F3C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 09:32:52 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07d500f39533324043f5fb.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d500:f395:3332:4043:f5fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B3E61EC02FC;
        Mon,  5 Oct 2020 18:32:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601915571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LmvgqjN0s+h3zzXOSz5zG1O3zeN0eG4M6XfomH2onLA=;
        b=gj5miPhfJ+UyPAF9a1T5stmR57ct141rlf5gEgvPBwh65OCJ3K8ha81bsjZf+iON6/EdKc
        hVzYi4HdVCaNtnbTZC8DZ7EyztSPd1KGVMQVOTdYCAlYo7SbSZz57/yvu8MzAf3gCng+hp
        LIQ4yThmsIskDJtZWfSbcg2HjwqaiQk=
Date:   Mon, 5 Oct 2020 18:32:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] x86/mce: Recover from poison found while copying
 from user space
Message-ID: <20201005163247.GE21151@zn.tnic>
References: <20200921113144.GD5901@zn.tnic>
 <20200930232611.15355-1-tony.luck@intel.com>
 <20200930232611.15355-7-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930232611.15355-7-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 04:26:10PM -0700, Tony Luck wrote:
> From: Youquan Song <youquan.song@intel.com>
> 
> Existing kernel code can only recover from a machine check on code that
> is tagged in the exception table with a fault handling recovery path.
> 
> Two new fields in the task structure to pass information from machine
> check handler to the "task_work" that is queued to run before the task
> returns to user mode:
> 
> + mce_vaddr: will be initialized to the user virtual address of the fault
>   in the case where the fault occurred in the kernel copying data from
>   a user address.  This is so that kill_me_maybe() can provide that
>   information to the user SIGBUS handler.
> 
> + mce_kflags: copy of the struct mce.kflags needed by kill_me_maybe()
>   to determine if mce_vaddr is applicable to this error.
> 
> Add code to recover from a machine check while copying data from user
> space to the kernel. Action for this case is the same as if the user
> touched the poison directly; unmap the page and send a SIGBUS to the task.
> 
> Refactor the recovery code path to share common code between the "fault
> in user mode" case and the "fault while copying from user" case.
> 
> New code paths will be activated by the next patch which sets
> MCE_IN_KERNEL_COPYIN.
> 
> Signed-off-by: Youquan Song <youquan.song@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 33 +++++++++++++++++++++------------
>  include/linux/sched.h          |  2 ++
>  2 files changed, 23 insertions(+), 12 deletions(-)

Isn't that just simpler?

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4d2cf08820af..dc6c83aa2ec1 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1261,6 +1261,21 @@ static void kill_me_maybe(struct callback_head *cb)
 	kill_me_now(cb);
 }
 
+static inline void queue_task_work(struct mce *m, int kill_it)
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
@@ -1402,13 +1417,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
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
@@ -1423,6 +1433,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
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
index e7f65573dde3..d383cf09e78f 100644
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
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

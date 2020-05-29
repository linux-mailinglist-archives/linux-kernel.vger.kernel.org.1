Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810CC1E7843
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgE2I1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 04:27:03 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:49662 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbgE2I1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:27:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Tzy5mx3_1590740787;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tzy5mx3_1590740787)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 May 2020 16:26:27 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH V2 2/4] x86/entry: directly switch to kernel stack when .Lerror_bad_iret
Date:   Fri, 29 May 2020 08:26:15 +0000
Message-Id: <20200529082618.1697-3-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200529082618.1697-1-laijs@linux.alibaba.com>
References: <87mu5roov6.fsf@nanos.tec.linutronix.de>
 <20200529082618.1697-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly copy pt_regs to kernel stack when .Lerror_bad_iret.
Directly switch to kernel stack when .Lerror_bad_iret.

We can see that entry_64.S do the following things back to back
when .Lerror_bad_iret:
  call fixup_bad_iret(), switch to sp0 stack with pt_regs copied
  call sync_regs(), switch to kernel stack with pt_regs copied

So we can do the all things together in fixup_bad_iret().

After this patch, fixup_bad_iret() is restored to the behavior before
7f2590a110b8("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 13 ++-----------
 arch/x86/kernel/traps.c   |  9 ++++-----
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b524ff3499d0..6f8963072ed0 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -915,16 +915,6 @@ SYM_CODE_START_LOCAL(error_entry)
 	ENCODE_FRAME_POINTER 8
 	ret
 
-.Lerror_entry_from_usermode_after_swapgs:
-	/* Put us onto the real thread stack. */
-	popq	%r12				/* save return addr in %12 */
-	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
-	call	sync_regs
-	movq	%rax, %rsp			/* switch stack */
-	ENCODE_FRAME_POINTER
-	pushq	%r12
-	ret
-
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
 .Lerror_entry_done:
@@ -978,7 +968,8 @@ SYM_CODE_START_LOCAL(error_entry)
 	mov	%rsp, %rdi
 	call	fixup_bad_iret
 	mov	%rax, %rsp
-	jmp	.Lerror_entry_from_usermode_after_swapgs
+	ENCODE_FRAME_POINTER 8
+	ret
 SYM_CODE_END(error_entry)
 
 SYM_CODE_START_LOCAL(error_return)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 50fb9cd5be97..053a15717bfd 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -669,13 +669,12 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 	/*
 	 * This is called from entry_64.S early in handling a fault
 	 * caused by a bad iret to user mode.  To handle the fault
-	 * correctly, we want to move our stack frame to where it would
-	 * be had we entered directly on the entry stack (rather than
-	 * just below the IRET frame) and we want to pretend that the
-	 * exception came from the IRET target.
+	 * correctly, we want to move our stack frame to kernel stack
+	 * (rather than just below the IRET frame) and we want to
+	 * pretend that the exception came from the IRET target.
 	 */
 	struct bad_iret_stack tmp, *new_stack =
-		(struct bad_iret_stack *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
+		(struct bad_iret_stack *)__this_cpu_read(cpu_current_top_of_stack) - 1;
 
 	/* Copy the IRET target to the temporary storage. */
 	memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
-- 
2.20.1


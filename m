Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397322EF7C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbhAHSzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:55:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbhAHSzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:55:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7ED5D23A81;
        Fri,  8 Jan 2021 18:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610132108;
        bh=N9EmXGrgmYlUphwBezd2dWcyGDB4qIvxjfleKtsSxOA=;
        h=From:To:Cc:Subject:Date:From;
        b=RvetMlQlpoTK18Fx/HC7kBIkYjxFXSXyVnOGUTHpiiHgA2fImH9os/+ZrTZaG70bb
         poXYctrgdZTeIqy/xHPZlWlD0fb3IA3IfWprH0sU5pHq3C81cCaghsRKGMtFHufPW/
         N9UYEmxFD7Wch7dInqBGVOCN3Xs+oK/HnrwRmKT2wI1Y3cu6Z3cLKN2AFrXSEddhCJ
         hGP4QH6DHUba/lk2FGTligk2bg+cU3uidowkBXflazNpfc57OJwnx4+9VJUtRtlvjE
         8DKeUZjkHqRMi/8mVkCO+EqDS7drpr3FjLWzpAXxqwwIlky+Dwcffduk1xgPNmud6u
         FyxjHnYCNcAKw==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Yu Zhao <yuzhao@google.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH] x86/vm86/32: Remove VM86_SCREEN_BITMAP support
Date:   Fri,  8 Jan 2021 10:55:05 -0800
Message-Id: <3d34069ab2d249d866ea1d18a47e4170dbfb5982.1610132102.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation was rather buggy.  It unconditionally marked PTEs
read-only, even for VM_SHARED mappings.  I'm not sure whether this is
actually a problem, but it certainly seems unwise.  More importantly, it
released the mmap lock before flushing the TLB, which could allow a racing
CoW operation to falsely believe that the underlying memory was not
writable.

I can't find any users at all of this mechanism, so just remove it.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Linux-MM <linux-mm@kvack.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: x86@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/uapi/asm/vm86.h |  2 +-
 arch/x86/kernel/vm86_32.c        | 55 ++++++--------------------------
 2 files changed, 10 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/uapi/asm/vm86.h b/arch/x86/include/uapi/asm/vm86.h
index d2ee4e307ef8..50004fb4590d 100644
--- a/arch/x86/include/uapi/asm/vm86.h
+++ b/arch/x86/include/uapi/asm/vm86.h
@@ -106,7 +106,7 @@ struct vm86_struct {
 /*
  * flags masks
  */
-#define VM86_SCREEN_BITMAP	0x0001
+#define VM86_SCREEN_BITMAP	0x0001        /* no longer supported */
 
 struct vm86plus_info_struct {
 	unsigned long force_return_for_pic:1;
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 764573de3996..28b9e8d511e1 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -160,49 +160,6 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	do_exit(SIGSEGV);
 }
 
-static void mark_screen_rdonly(struct mm_struct *mm)
-{
-	struct vm_area_struct *vma;
-	spinlock_t *ptl;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	int i;
-
-	mmap_write_lock(mm);
-	pgd = pgd_offset(mm, 0xA0000);
-	if (pgd_none_or_clear_bad(pgd))
-		goto out;
-	p4d = p4d_offset(pgd, 0xA0000);
-	if (p4d_none_or_clear_bad(p4d))
-		goto out;
-	pud = pud_offset(p4d, 0xA0000);
-	if (pud_none_or_clear_bad(pud))
-		goto out;
-	pmd = pmd_offset(pud, 0xA0000);
-
-	if (pmd_trans_huge(*pmd)) {
-		vma = find_vma(mm, 0xA0000);
-		split_huge_pmd(vma, pmd, 0xA0000);
-	}
-	if (pmd_none_or_clear_bad(pmd))
-		goto out;
-	pte = pte_offset_map_lock(mm, pmd, 0xA0000, &ptl);
-	for (i = 0; i < 32; i++) {
-		if (pte_present(*pte))
-			set_pte(pte, pte_wrprotect(*pte));
-		pte++;
-	}
-	pte_unmap_unlock(pte, ptl);
-out:
-	mmap_write_unlock(mm);
-	flush_tlb_mm_range(mm, 0xA0000, 0xA0000 + 32*PAGE_SIZE, PAGE_SHIFT, false);
-}
-
-
-
 static int do_vm86_irq_handling(int subfunction, int irqnumber);
 static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus);
 
@@ -282,6 +239,15 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 			offsetof(struct vm86_struct, int_revectored)))
 		return -EFAULT;
 
+
+	/* VM86_SCREEN_BITMAP had numerous bugs and appears to have no users. */
+	if (v.flags & VM86_SCREEN_BITMAP) {
+		char comm[TASK_COMM_LEN];
+
+		pr_info_once("vm86: '%s' uses VM86_SCREEN_BITMAP, which is no longer supported\n", get_task_comm(comm, current);
+		return -EINVAL;
+	}
+
 	memset(&vm86regs, 0, sizeof(vm86regs));
 
 	vm86regs.pt.bx = v.regs.ebx;
@@ -370,9 +336,6 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 	update_task_stack(tsk);
 	preempt_enable();
 
-	if (vm86->flags & VM86_SCREEN_BITMAP)
-		mark_screen_rdonly(tsk->mm);
-
 	memcpy((struct kernel_vm86_regs *)regs, &vm86regs, sizeof(vm86regs));
 	return regs->ax;
 }
-- 
2.29.2


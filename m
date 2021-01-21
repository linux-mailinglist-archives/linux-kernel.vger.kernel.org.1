Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66382FE45C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbhAUHtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:49:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbhAUG6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:58:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 855F2239D0;
        Thu, 21 Jan 2021 06:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212226;
        bh=3a0+38bVBsY4UUlD4uVWLcOY3iDUrDoW4dg7mxqoMJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVOczs/KE7e3K/7fhlR5G7AnH0FfUmLoSHDQ1A4V0G0vPUnheZ6D59m6R8fp6WTMX
         aox0Dpjl6todCMOSQmIKDJ8WaxEnIHIOBSJpucrr8WHLAuohERhZZgnc6Dy+oErst7
         3F2y0aXVWLxtjKvm96XTFDk7ZPos4EpmoNgBTK+TCnpjR57FtTcKzeDrfA6naENPmX
         6HVLBAcr67JsCSSP+m/NcitOg7+/uiVzx8wMNInuVE7NVMkiWUwU9W5TFJO64S0M0q
         3ZbeXpHeTTmAqeqxZFQ3WUEHrQabxcVbP0oqj6DqWlDBIoD2X8fNFf+7cvBDQP1t2c
         G0IwxnE21lMKw==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 14/29] csky: Fixup FAULT_FLAG_XXX param for handle_mm_fault
Date:   Thu, 21 Jan 2021 14:53:34 +0800
Message-Id: <20210121065349.3188251-14-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The past code only passes the FAULT_FLAG_WRITE into
handle_mm_fault and missing USER & DEFAULT & RETRY.

The patch references to arch/riscv/mm/fault.c, but there is no
FAULT_FLAG_INSTRUCTION in csky hw.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/mm/fault.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index e888acf1c403..cecca6729b04 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -80,6 +80,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	struct vm_area_struct *vma = NULL;
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 	int si_code;
 	int fault;
 	unsigned long address = read_mmu_entryhi() & PAGE_MASK;
@@ -150,6 +151,13 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	if (in_atomic() || !mm)
 		goto bad_area_nosemaphore;
 
+	if (user_mode(regs))
+		flags |= FAULT_FLAG_USER;
+
+	if (is_write(regs))
+		flags |= FAULT_FLAG_WRITE;
+
+retry:
 	mmap_read_lock(mm);
 	vma = find_vma(mm, address);
 	if (!vma)
@@ -180,8 +188,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, is_write(regs) ? FAULT_FLAG_WRITE : 0,
-				regs);
+	fault = handle_mm_fault(vma, address, flags, regs);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
@@ -191,6 +198,18 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 			goto bad_area;
 		BUG();
 	}
+
+	if (unlikely((fault & VM_FAULT_RETRY) && (flags & FAULT_FLAG_ALLOW_RETRY))) {
+		flags |= FAULT_FLAG_TRIED;
+
+		/*
+		 * No need to mmap_read_unlock(mm) as we would
+		 * have already released it in __lock_page_or_retry
+		 * in mm/filemap.c.
+		 */
+		goto retry;
+	}
+
 	mmap_read_unlock(mm);
 	return;
 
-- 
2.17.1


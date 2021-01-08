Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6572EF658
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbhAHRQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:16:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbhAHRQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:16:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BECD23A1E;
        Fri,  8 Jan 2021 17:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610126134;
        bh=RQ63edxxspf278oJN0oZGKPL8Fi8yL2rV5xz0JAIPv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1piDlIhX/f7OnjtPcJpJ4+WxCxxcyvn0iiTbR9lDZR6q0nMVPBTV7cjgwoxLQnoc
         cdEY2UWOe4xwjG2xKf562FaMUxxnniFbfGEoRUV7fj+ciTIkUy+NTU9wNfWINk9l1m
         5uacUKtKOVQYgNHM/eo1DLLGT+P4cBjqznWyUaC5KQOsb7ndljYvtZXOrG/9OScwKp
         N7hBFkDQtiBjvBvud+jy4oLAVqdsFwY0F2GVjIHppJQWXsh6GdT/WZLqLBYgV0W3no
         xa3W9mCmCkkvvVQQDjViPOqb1mqSrQjdOCraxW+dBg1W4Di062CDKANGBOhcCStZqU
         tWOPBXbg9zTqQ==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>, kernel-team@android.com
Subject: [PATCH v2 2/3] mm: Allow architectures to request 'old' entries when prefaulting
Date:   Fri,  8 Jan 2021 17:15:16 +0000
Message-Id: <20210108171517.5290-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210108171517.5290-1-will@kernel.org>
References: <20210108171517.5290-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5c0a85fad949 ("mm: make faultaround produce old ptes") changed
the "faultaround" behaviour to initialise prefaulted PTEs as 'old',
since this avoids vmscan wrongly assuming that they are hot, despite
having never been explicitly accessed by userspace. The change has been
shown to benefit numerous arm64 micro-architectures (with hardware
access flag) running Android, where both application launch latency and
direct reclaim time are significantly reduced.

Unfortunately, commit 315d09bf30c2 ("Revert "mm: make faultaround produce
old ptes"") reverted the change to it being identified as the cause of a
~6% regression in unixbench on x86. Experiments on a variety of recent
arm64 micro-architectures indicate that unixbench is not affected by
the original commit, yielding a 0-1% performance improvement.

Since one size does not fit all for the initial state of prefaulted PTEs,
introduce arch_wants_old_prefaulted_pte(), which allows an architecture
to opt-in to 'old' prefaulted PTEs at runtime based on whatever criteria
it may have.

Cc: Jan Kara <jack@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Vinayak Menon <vinmenon@codeaurora.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/mm.h |  5 ++++-
 mm/filemap.c       | 12 ++++++++----
 mm/memory.c        | 20 +++++++++++++++++++-
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 801dd99f733c..873e410d6238 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -434,6 +434,7 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ * @FAULT_FLAG_PREFAULT: Fault was a prefault.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -464,6 +465,7 @@ extern pgprot_t protection_map[16];
 #define FAULT_FLAG_REMOTE			0x80
 #define FAULT_FLAG_INSTRUCTION  		0x100
 #define FAULT_FLAG_INTERRUPTIBLE		0x200
+#define FAULT_FLAG_PREFAULT			0x400
 
 /*
  * The default fault flags that should be used by most of the
@@ -501,7 +503,8 @@ static inline bool fault_flag_allow_retry_first(unsigned int flags)
 	{ FAULT_FLAG_USER,		"USER" }, \
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
 	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
-	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
+	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
+	{ FAULT_FLAG_PREFAULT,		"PREFAULT" }
 
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
diff --git a/mm/filemap.c b/mm/filemap.c
index c1f2dc89b8a7..0fb9d1714797 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3051,14 +3051,18 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		if (!pte_none(*vmf->pte))
 			goto unlock;
 
+		/* We're about to handle the fault */
+		if (vmf->address == address) {
+			vmf->flags &= ~FAULT_FLAG_PREFAULT;
+			ret = VM_FAULT_NOPAGE;
+		} else {
+			vmf->flags |= FAULT_FLAG_PREFAULT;
+		}
+
 		do_set_pte(vmf, page);
 		/* no need to invalidate: a not-present page won't be cached */
 		update_mmu_cache(vma, vmf->address, vmf->pte);
 		unlock_page(head);
-
-		/* The fault is handled */
-		if (vmf->address == address)
-			ret = VM_FAULT_NOPAGE;
 		continue;
 unlock:
 		unlock_page(head);
diff --git a/mm/memory.c b/mm/memory.c
index 3e2fc2950ad7..f0e7c589ca9d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -134,6 +134,18 @@ static inline bool arch_faults_on_old_pte(void)
 }
 #endif
 
+#ifndef arch_wants_old_prefaulted_pte
+static inline bool arch_wants_old_prefaulted_pte(void)
+{
+	/*
+	 * Transitioning a PTE from 'old' to 'young' can be expensive on
+	 * some architectures, even if it's performed in hardware. By
+	 * default, "false" means prefaulted entries will be 'young'.
+	 */
+	return false;
+}
+#endif
+
 static int __init disable_randmaps(char *s)
 {
 	randomize_va_space = 0;
@@ -3725,11 +3737,17 @@ void do_set_pte(struct vm_fault *vmf, struct page *page)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
+	bool prefault = vmf->flags & FAULT_FLAG_PREFAULT;
 	pte_t entry;
 
 	flush_icache_page(vma, page);
 	entry = mk_pte(page, vma->vm_page_prot);
-	entry = pte_sw_mkyoung(entry);
+
+	if (prefault && arch_wants_old_prefaulted_pte())
+		entry = pte_mkold(entry);
+	else
+		entry = pte_sw_mkyoung(entry);
+
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	/* copy-on-write page */
-- 
2.29.2.729.g45daf8777d-goog


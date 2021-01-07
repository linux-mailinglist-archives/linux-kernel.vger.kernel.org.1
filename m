Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913BC2EE68C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbhAGUFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:05:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbhAGUFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610049856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TISzhw64TZ2TP4IkjeSd/YhcRqzAwfX+QzRYX4JpuNw=;
        b=HPl2+lt8xveM7UI9TC+9JPPRhyXtuenjyPxMWjVtzJnmfG091BnEpJ2rZQRB/Lw4cbTAW2
        68Io0knOEoZcWGhQUw0OAbOXibRllIT1rp2twMtSyIBo2632pi9HQTApP7ja5ARHHSpIWB
        5iJxc3XmbjscAIe7OGwZw5Plr1jTZrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-SKRQLejOP_qK39OqgzE4Uw-1; Thu, 07 Jan 2021 15:04:13 -0500
X-MC-Unique: SKRQLejOP_qK39OqgzE4Uw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB23A80362B;
        Thu,  7 Jan 2021 20:04:10 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 519B46062F;
        Thu,  7 Jan 2021 20:04:03 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: [PATCH 1/2] mm: proc: Invalidate TLB after clearing soft-dirty page state
Date:   Thu,  7 Jan 2021 15:04:01 -0500
Message-Id: <20210107200402.31095-2-aarcange@redhat.com>
In-Reply-To: <20210107200402.31095-1-aarcange@redhat.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

Since commit 0758cd830494 ("asm-generic/tlb: avoid potential double
flush"), TLB invalidation is elided in tlb_finish_mmu() if no entries
were batched via the tlb_remove_*() functions. Consequently, the
page-table modifications performed by clear_refs_write() in response to
a write to /proc/<pid>/clear_refs do not perform TLB invalidation.
Although this is fine when simply aging the ptes, in the case of
clearing the "soft-dirty" state we can end up with entries where
pte_write() is false, yet a writable mapping remains in the TLB.

Fix this by avoiding the mmu_gather API altogether: managing both the
'tlb_flush_pending' flag on the 'mm_struct' and explicit TLB
invalidation for the sort-dirty path, much like mprotect() does already.

Fixes: 0758cd830494 ("asm-generic/tlb: avoid potential double flush")
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 fs/proc/task_mmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ee5a235b3056..a127262ba517 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1189,7 +1189,6 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	enum clear_refs_types type;
-	struct mmu_gather tlb;
 	int itype;
 	int rv;
 
@@ -1234,7 +1233,6 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 			count = -EINTR;
 			goto out_mm;
 		}
-		tlb_gather_mmu(&tlb, mm, 0, -1);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			for (vma = mm->mmap; vma; vma = vma->vm_next) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
@@ -1252,15 +1250,18 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 				break;
 			}
 
+			inc_tlb_flush_pending(mm);
 			mmu_notifier_range_init(&range, MMU_NOTIFY_SOFT_DIRTY,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
 		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
 				&cp);
-		if (type == CLEAR_REFS_SOFT_DIRTY)
+		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
-		tlb_finish_mmu(&tlb, 0, -1);
+			flush_tlb_mm(mm);
+			dec_tlb_flush_pending(mm);
+		}
 		mmap_read_unlock(mm);
 out_mm:
 		mmput(mm);


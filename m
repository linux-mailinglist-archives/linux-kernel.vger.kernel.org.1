Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEE02F049C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 01:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhAJAqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 19:46:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbhAJAqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 19:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610239490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CqK8azDEkQlFAx4cQjQ1mitiuP209BuEVBOgEEqwJfc=;
        b=afEL3epU/EZ7eHLJlCtD+E5bfBpdTQ+Nzn7qMQ6Y65+hy5O+ck07TgkDLewpWpRkUBTlLE
        4teTED+gHaA+De/ZhZL5+zCqkKY//bAOrIFNR9KCkqNHqlkMrRNu8Yq9PvUl7SnJKQfGg2
        oB7mz1hsyeTTMmpQfE+MjwIZoQDQ1LM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-qYHT5iFfNI-Th912qjUjZA-1; Sat, 09 Jan 2021 19:44:47 -0500
X-MC-Unique: qYHT5iFfNI-Th912qjUjZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76A05801A9D;
        Sun, 10 Jan 2021 00:44:43 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F2D32C167;
        Sun, 10 Jan 2021 00:44:36 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/1] mm: restore full accuracy in COW page reuse
Date:   Sat,  9 Jan 2021 19:44:35 -0500
Message-Id: <20210110004435.26382-2-aarcange@redhat.com>
In-Reply-To: <20210110004435.26382-1-aarcange@redhat.com>
References: <20210110004435.26382-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 09854ba94c6aad7886996bfbee2530b3d8a7f4f4.
This reverts commit be068f29034fb00530a053d18b8cf140c32b12b3.
This reverts commit 1a0cf26323c80e2f1c58fc04f15686de61bfab0c.

This example below uses O_DIRECT, on a process under
clear_refs. There's no FOLL_LONGTERM involvement. All GUP pins are
transient. fork is never called and even when clear_refs is cleared by
an external program, fork() would not be involved.

thread0				thread1			other process
							(or thread 3)
=============			=============		===========
read syscall
O_DIRECT
read DMA to vaddr+0
len = 512 bytes
GUP(FOLL_WRITE)
DMA writing to RAM started
							clear_refs
							pte_wrprotect
				write vaddrA+512
				page_count == 2
				wp_copy_page
read syscall returns
read lost

Notwithstanding the fact that failing O_DIRECT at sub-PAGE_SIZE
granularity is an ABI break by itself, this is of course not just
about O_DIRECT. recvmsg kernel TLS and plenty of other GUP FOLL_WRITE
iov_iter_get_pages users would write to the memory with sub-PAGE_SIZE
granularity, depending on the msghdr iov tiny buffers. Those recvmsg
are already silently lost too as well as the above O_DIRECT already
get lost.

The fact COW must not happen too much is documented in commit
6d0a07edd17cfc12fdc1f36de8072fa17cc3666f:

==
This will provide fully accuracy to the mapcount calculation in the
write protect faults, so page pinning will not get broken by false
positive copy-on-writes.
==

And in the current comment above the THP mapcount:

==
 * [..] we only use
 * page_trans_huge_mapcount() in the copy-on-write faults where we
 * need full accuracy to avoid breaking page pinning, [..]
==

Quote from the Link tagged:

==
In other words, the page_count check in do_wp_page, extends the old
fork vs gup vs threads race, so that it also happens within a single
thread without fork() involvement.
===

In addition FOLL_LONGTERM breaks for readonly DMA, despite
FOLL_LONGTERM pages are now treated specially and copied in fork().

FOLL_LONGTERM is in no way special with regard to the VM core and it
can't be. From the VM standpoint all GUP in are equal and breaking
one, means breaking them all the same.

It is not possible to resolve this by looking only at FOLL_LONGTERM,
that only hides the problem, but it doesn't fully resolve it as shown
above.

In addition this avoids storms of extra false positive COWs if the THP
are shared by different processes, which causes extra overhead, but
the several performance considerations are only a secondary concern.

After this commit, the copy in fork() for FOLL_LONGTERM also must be
extended to all GUP pins including transient pins or we shouldn't even
copy FOLL_LONGTERM pinned pages. Treating FOLL_LONGTERM any different
from transient GUP pin is sign that something is fundamentally flawed.

FOLL_LONGTERM can be treated different in writeback and during GUP
runtime itself, but not in the VM-core when deciding when to COW or
not to COW an anonymous page.

This revert causes no theoretical security regression because THP is
not yet using page_count in do_huge_pmd_wp_page.

The alternative of this patch would be to replace the mapcount with
the page_count in do_huge_pmd_wp_page too in order to really close the
vmsplice attack from child to parent that way.

However since a single transient GUP pin on a tail page, would elevate
the page_count for all other tail pages (unlike the mapcount which is
subpage granular), the above "fork-less" race would span over a
HPAGE_PMD_SIZE range, it would even cross different vmas and the
effect would happen at a distance in vma of different processes
allowing a child to corrupt memory in the parent. That's a problem
that could happen not-maliciously too. So the scenario described
above, if extended to THP new refcounting, would be more concerning
than the vmsplice issue, that can be tackled first in vmsplice itself,
and only at a second stage in the COW code.

Link: https://lkml.kernel.org/r/20210107200402.31095-1-aarcange@redhat.com
Cc: stable@kernel.org
Fixes: 09854ba94c6a ("mm: do_wp_page() simplification")
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 include/linux/ksm.h |  7 ++++++
 mm/ksm.c            | 25 +++++++++++++++++++
 mm/memory.c         | 59 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 74 insertions(+), 17 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 161e8164abcf..e48b1e453ff5 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -53,6 +53,8 @@ struct page *ksm_might_need_to_copy(struct page *page,
 
 void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc);
 void ksm_migrate_page(struct page *newpage, struct page *oldpage);
+bool reuse_ksm_page(struct page *page,
+			struct vm_area_struct *vma, unsigned long address);
 
 #else  /* !CONFIG_KSM */
 
@@ -86,6 +88,11 @@ static inline void rmap_walk_ksm(struct page *page,
 static inline void ksm_migrate_page(struct page *newpage, struct page *oldpage)
 {
 }
+static inline bool reuse_ksm_page(struct page *page,
+			struct vm_area_struct *vma, unsigned long address)
+{
+	return false;
+}
 #endif /* CONFIG_MMU */
 #endif /* !CONFIG_KSM */
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 9694ee2c71de..9503e11ab5b4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2665,6 +2665,31 @@ void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc)
 		goto again;
 }
 
+bool reuse_ksm_page(struct page *page,
+		    struct vm_area_struct *vma,
+		    unsigned long address)
+{
+#ifdef CONFIG_DEBUG_VM
+	if (WARN_ON(is_zero_pfn(page_to_pfn(page))) ||
+			WARN_ON(!page_mapped(page)) ||
+			WARN_ON(!PageLocked(page))) {
+		dump_page(page, "reuse_ksm_page");
+		return false;
+	}
+#endif
+
+	if (PageSwapCache(page) || !page_stable_node(page))
+		return false;
+	/* Prohibit parallel get_ksm_page() */
+	if (!page_ref_freeze(page, 1))
+		return false;
+
+	page_move_anon_rmap(page, vma);
+	page->index = linear_page_index(vma, address);
+	page_ref_unfreeze(page, 1);
+
+	return true;
+}
 #ifdef CONFIG_MIGRATION
 void ksm_migrate_page(struct page *newpage, struct page *oldpage)
 {
diff --git a/mm/memory.c b/mm/memory.c
index feff48e1465a..2587d6b5b0b2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3114,25 +3114,50 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	 * not dirty accountable.
 	 */
 	if (PageAnon(vmf->page)) {
-		struct page *page = vmf->page;
-
-		/* PageKsm() doesn't necessarily raise the page refcount */
-		if (PageKsm(page) || page_count(page) != 1)
-			goto copy;
-		if (!trylock_page(page))
-			goto copy;
-		if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
-			unlock_page(page);
+		int total_map_swapcount;
+		if (PageKsm(vmf->page) && (PageSwapCache(vmf->page) ||
+					   page_count(vmf->page) != 1))
 			goto copy;
+		if (!trylock_page(vmf->page)) {
+			get_page(vmf->page);
+			pte_unmap_unlock(vmf->pte, vmf->ptl);
+			lock_page(vmf->page);
+			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+					vmf->address, &vmf->ptl);
+			if (!pte_same(*vmf->pte, vmf->orig_pte)) {
+				update_mmu_tlb(vma, vmf->address, vmf->pte);
+				unlock_page(vmf->page);
+				pte_unmap_unlock(vmf->pte, vmf->ptl);
+				put_page(vmf->page);
+				return 0;
+			}
+			put_page(vmf->page);
 		}
-		/*
-		 * Ok, we've got the only map reference, and the only
-		 * page count reference, and the page is locked,
-		 * it's dark out, and we're wearing sunglasses. Hit it.
-		 */
-		unlock_page(page);
-		wp_page_reuse(vmf);
-		return VM_FAULT_WRITE;
+		if (PageKsm(vmf->page)) {
+			bool reused = reuse_ksm_page(vmf->page, vmf->vma,
+						     vmf->address);
+			unlock_page(vmf->page);
+			if (!reused)
+				goto copy;
+			wp_page_reuse(vmf);
+			return VM_FAULT_WRITE;
+		}
+		if (reuse_swap_page(vmf->page, &total_map_swapcount)) {
+			if (total_map_swapcount == 1) {
+				/*
+				 * The page is all ours. Move it to
+				 * our anon_vma so the rmap code will
+				 * not search our parent or siblings.
+				 * Protected against the rmap code by
+				 * the page lock.
+				 */
+				page_move_anon_rmap(vmf->page, vma);
+			}
+			unlock_page(vmf->page);
+			wp_page_reuse(vmf);
+			return VM_FAULT_WRITE;
+		}
+		unlock_page(vmf->page);
 	} else if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
 					(VM_WRITE|VM_SHARED))) {
 		return wp_page_shared(vmf);


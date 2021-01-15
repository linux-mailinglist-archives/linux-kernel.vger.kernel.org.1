Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB7D2F81E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387699AbhAORNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:13:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728818AbhAORNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5KLb2lATkQ/XNiv9F7KPoJriimXjMJy8UfLukuBk5Y=;
        b=ByAyTtr4FaXoTSEM7NMgrS/2pV6NGqhNTHVnOix3ys46fvdUL61O5V4sfXy6YERBwIjvxs
        9qu99MP+n1b2kizALmqPYPm9M+izbE5Tp0N8i9kVD+fqKU3Q9M/R8yAJ1PrcsDeq9X1BoE
        k3qvN13e3mUVJ0+R2SEWaNkigzYm7GE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-15TJhtwPP7iAPw6hWIQefA-1; Fri, 15 Jan 2021 12:09:37 -0500
X-MC-Unique: 15TJhtwPP7iAPw6hWIQefA-1
Received: by mail-qk1-f198.google.com with SMTP id f27so8614470qkh.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5KLb2lATkQ/XNiv9F7KPoJriimXjMJy8UfLukuBk5Y=;
        b=qa0DB7SU48puxLoZ0KViVJoWafEKwb30p1rbHQBpYogjxlGID8z3SpHcPbnzp0v+YV
         ftbufbFN+Nnoxe1UDsQP9wvyKCtTh+2kzmdnD9WWaTOwDrwlr4GWc8UzdtAc92Fbj5RI
         MgMuuae16+JPMPKtrcDlRZmmshPvJrOeXAurRom9Hapyvc87yaHwDVtguifEKuLS1oY1
         rA40fFeXvFAmB/tOyN8VgRP/OEz6m3ApJTCFjKQVtnPw13n+E+9hou/3PkYKzjaxzDDw
         v40QkGQ+NCUwRlfMn/F0+kOXhq2WxbiCM3XcBIn0F/eKaWdvxlxYVEGy33NLigvFpzk1
         EG1A==
X-Gm-Message-State: AOAM531kO9J0Fe5sWqjuKpH1Ndwo1SwZWClBoLa7DKSOTTG12Ijvuenk
        LaiNVeeZ14jceFXW32266f+lDVE6I15wCtpK3Pa1hw8rNqEvD3N69QMDCtb7d8o2AlFsKYgFEqQ
        rsRM5qDp3CXUyEG1M0+ZoQRZ5CSiV5pMXx/YzoAQT757j4wGXoMtmYEX0xRFxW+fSCKTFxjNc8A
        ==
X-Received: by 2002:ac8:396d:: with SMTP id t42mr12482442qtb.273.1610730576025;
        Fri, 15 Jan 2021 09:09:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwx+fHE05WbMDp5unvCgzYCvNrqmnR+hBQDHIuSFam5gLX1Ken6kJ60Sbq11jUg42je7VpxZw==
X-Received: by 2002:ac8:396d:: with SMTP id t42mr12482366qtb.273.1610730575395;
        Fri, 15 Jan 2021 09:09:35 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:34 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH RFC 13/30] shmem/userfaultfd: Persist uffd-wp bit across zapping for file-backed
Date:   Fri, 15 Jan 2021 12:08:50 -0500
Message-Id: <20210115170907.24498-14-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File-backed memory is prone to being unmapped at any time.  It means all
information in the pte will be dropped, including the uffd-wp flag.

Since the uffd-wp info cannot be stored in page cache or swap cache, persist
this wr-protect information by installing the special uffd-wp marker pte when
we're going to unmap a uffd wr-protected pte.  When the pte is accessed again,
we will know it's previously wr-protected by recognizing the special pte.

Meanwhile add a new flag ZAP_FLAG_DROP_FILE_UFFD_WP when we don't want to
persist such an information.  For example, when destroying the whole vma, or
punching a hole in a shmem file.  For the latter, we can only drop the uffd-wp
bit when holding the page lock.  It means the unmap_mapping_range() in
shmem_fallocate() still reuqires to zap without ZAP_FLAG_DROP_FILE_UFFD_WP
because that's still racy with the page faults.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h        | 11 ++++++++++
 include/linux/mm_inline.h | 43 +++++++++++++++++++++++++++++++++++++++
 mm/memory.c               | 42 +++++++++++++++++++++++++++++++++++++-
 mm/rmap.c                 |  8 ++++++++
 mm/truncate.c             |  8 +++++++-
 5 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 57bb3d680844..e4aba745be62 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1634,6 +1634,8 @@ extern void user_shm_unlock(size_t, struct user_struct *);
 #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
 /* Whether to skip zapping swap entries */
 #define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
+/* Whether to completely drop uffd-wp entries for file-backed memory */
+#define  ZAP_FLAG_DROP_FILE_UFFD_WP         BIT(2)
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
@@ -1666,6 +1668,15 @@ zap_skip_swap(struct zap_details *details)
 	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
 }
 
+static inline bool
+zap_drop_file_uffd_wp(struct zap_details *details)
+{
+	if (!details)
+		return false;
+
+	return details->zap_flags & ZAP_FLAG_DROP_FILE_UFFD_WP;
+}
+
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 8fc71e9d7bb0..da4c710859e6 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -4,6 +4,8 @@
 
 #include <linux/huge_mm.h>
 #include <linux/swap.h>
+#include <linux/userfaultfd_k.h>
+#include <linux/swapops.h>
 
 /**
  * page_is_file_lru - should the page be on a file LRU or anon LRU?
@@ -125,4 +127,45 @@ static __always_inline enum lru_list page_lru(struct page *page)
 	}
 	return lru;
 }
+
+/*
+ * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
+ * replace a none pte.  NOTE!  This should only be called when *pte is already
+ * cleared so we will never accidentally replace something valuable.  Meanwhile
+ * none pte also means we are not demoting the pte so if tlb flushed then we
+ * don't need to do it again; otherwise if tlb flush is postponed then it's
+ * even better.
+ *
+ * Must be called with pgtable lock held.
+ */
+static inline void
+pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
+			      pte_t *pte, pte_t pteval)
+{
+#ifdef CONFIG_USERFAULTFD
+	bool arm_uffd_pte = false;
+
+	/* The current status of the pte should be "cleared" before calling */
+	WARN_ON_ONCE(!pte_none(*pte));
+
+	if (vma_is_anonymous(vma))
+		return;
+
+	/* A uffd-wp wr-protected normal pte */
+	if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
+		arm_uffd_pte = true;
+
+	/*
+	 * A uffd-wp wr-protected swap pte.  Note: this should even work for
+	 * pte_swp_uffd_wp_special() too.
+	 */
+	if (unlikely(is_swap_pte(pteval) && pte_swp_uffd_wp(pteval)))
+		arm_uffd_pte = true;
+
+	if (unlikely(arm_uffd_pte))
+		set_pte_at(vma->vm_mm, addr, pte,
+			   pte_swp_mkuffd_wp_special(vma));
+#endif
+}
+
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index afe09fccdee1..f87b5a8a098e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -73,6 +73,7 @@
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
+#include <linux/mm_inline.h>
 
 #include <trace/events/kmem.h>
 
@@ -1194,6 +1195,21 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	return ret;
 }
 
+/*
+ * This function makes sure that we'll replace the none pte with an uffd-wp
+ * swap special pte marker when necessary. Must be with the pgtable lock held.
+ */
+static inline void
+zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
+			      unsigned long addr, pte_t *pte,
+			      struct zap_details *details, pte_t pteval)
+{
+	if (zap_drop_file_uffd_wp(details))
+		return;
+
+	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
@@ -1231,6 +1247,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
+			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
+						      ptent);
 			if (unlikely(!page))
 				continue;
 
@@ -1255,6 +1273,22 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			continue;
 		}
 
+		/*
+		 * If this is a special uffd-wp marker pte... Drop it only if
+		 * enforced to do so.
+		 */
+		if (unlikely(is_swap_special_pte(ptent))) {
+			WARN_ON_ONCE(!pte_swp_uffd_wp_special(ptent));
+			/*
+			 * If this is a common unmap of ptes, keep this as is.
+			 * Drop it only if this is a whole-vma destruction.
+			 */
+			if (zap_drop_file_uffd_wp(details))
+				ptep_get_and_clear_full(mm, addr, pte,
+							tlb->fullmm);
+			continue;
+		}
+
 		entry = pte_to_swp_entry(ptent);
 		if (is_device_private_entry(entry)) {
 			struct page *page = device_private_entry_to_page(entry);
@@ -1265,6 +1299,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			rss[mm_counter(page)]--;
 			page_remove_rmap(page, false);
 			put_page(page);
+			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
+						      ptent);
 			continue;
 		}
 
@@ -1282,6 +1318,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		if (unlikely(!free_swap_and_cache(entry)))
 			print_bad_pte(vma, addr, ptent, NULL);
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
 	add_mm_rss_vec(mm, rss);
@@ -1481,12 +1518,15 @@ void unmap_vmas(struct mmu_gather *tlb,
 		unsigned long end_addr)
 {
 	struct mmu_notifier_range range;
+	struct zap_details details = {
+		.zap_flags = ZAP_FLAG_DROP_FILE_UFFD_WP,
+	};
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
 	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next)
-		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
+		unmap_single_vma(tlb, vma, start_addr, end_addr, &details);
 	mmu_notifier_invalidate_range_end(&range);
 }
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 31b29321adfe..f6cc0b9b1963 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -72,6 +72,7 @@
 #include <linux/page_idle.h>
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/mm_inline.h>
 
 #include <asm/tlbflush.h>
 
@@ -1560,6 +1561,13 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			pteval = ptep_clear_flush(vma, address, pvmw.pte);
 		}
 
+		/*
+		 * Now the pte is cleared.  If this is uffd-wp armed pte, we
+		 * may want to replace a none pte with a marker pte if it's
+		 * file-backed, so we don't lose the tracking information.
+		 */
+		pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);
+
 		/* Move the dirty bit to the page. Now the pte is gone. */
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
diff --git a/mm/truncate.c b/mm/truncate.c
index dac66749e400..35df3b1d301e 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -179,7 +179,13 @@ truncate_cleanup_page(struct address_space *mapping, struct page *page)
 	if (page_mapped(page)) {
 		unsigned int nr = thp_nr_pages(page);
 		unmap_mapping_pages(mapping, page->index, nr,
-				    ZAP_FLAG_CHECK_MAPPING);
+				    ZAP_FLAG_CHECK_MAPPING |
+				    /*
+				     * Now it's safe to drop uffd-wp because
+				     * we're with page lock, and the page is
+				     * being truncated.
+				     */
+				    ZAP_FLAG_DROP_FILE_UFFD_WP);
 	}
 
 	if (page_has_private(page))
-- 
2.26.2


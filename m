Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F1F2F81BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732992AbhAORK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:10:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732707AbhAORKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pU1W6eF+5acoXg0XrMV/kYBFP7oiRoIxFmy0y+UKd/k=;
        b=BqK0i76oHblEKMM5o3Yrb+fc74QuUzrOwh1jKwtiW7y84xVhB6Vqp18iMauh/wCCYY8K76
        mAV0uFo0Q6S++1IBn4ojt+NEw3GXMY8Qn4eWEm7OrrNdyBN/d+QYYIKIYtYCw2mtY1F44S
        YVqSYOmcacsUA2c/zPX4wLqeK58aF34=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-GTGuzSfRNn-gTLgVgvMX1g-1; Fri, 15 Jan 2021 12:09:26 -0500
X-MC-Unique: GTGuzSfRNn-gTLgVgvMX1g-1
Received: by mail-qv1-f69.google.com with SMTP id f7so8266721qvr.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pU1W6eF+5acoXg0XrMV/kYBFP7oiRoIxFmy0y+UKd/k=;
        b=Azti7AORYnakeJ/kONASZBPYsb7F+K9BvuJS/B5NCVN9OlJ9q2aCFtOdL+olCfLkGX
         Na/wr+gleQbD1fX+gZVZtsQt1CBKLKc7H73rzn2KlIvtkSBk86Q568Rv2fDW1DLdRrKu
         zuKILyXt05EqaLAC4Ckmi4B30T4wGdfzvXHz70aG8xB/F8ypEByNsY3CJYe/7V+qNAwc
         oREyTnPcSKtsKbGlv/zC9WN+QUsk4XM0eBFWT1wAq3EB1dnzRfjHseznCO1CFbPDL3CW
         uHLFLkfqHVHIHJ3kUt+Q8vmqvTgIFfi4mLoaIjbVO2tv50hYlUf4QneC77G0O0J03nbD
         X/QQ==
X-Gm-Message-State: AOAM533UujHww2pKylqzm0jGTBirJ0PyY5f3CczxDoxckYv9qwhRS+bL
        x9ZIKUoPGHIBAt0kZZVUw9bsDFMziyucu9uoSe3m3o9GXemSA+hYWXxbIfWDCG4uCMEU3jhfF6S
        oEoQ2aujjV9ermXRnIzPBDZsnMASp9G78q/CEomzzeXyURokzrZn2kaDmSJ2GM5ha25y9GCv3zw
        ==
X-Received: by 2002:a0c:bd2b:: with SMTP id m43mr12934485qvg.32.1610730564996;
        Fri, 15 Jan 2021 09:09:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynSq2SBFF8P8zjh3jGjKduQkRr9w+ZGRCy7Dj1mcGpq2w7EdvE3LxZusU0Nl55C86yHtpjRA==
X-Received: by 2002:a0c:bd2b:: with SMTP id m43mr12934439qvg.32.1610730564546;
        Fri, 15 Jan 2021 09:09:24 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:23 -0800 (PST)
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
Subject: [PATCH RFC 08/30] shmem/userfaultfd: Handle uffd-wp special pte in page fault handler
Date:   Fri, 15 Jan 2021 12:08:45 -0500
Message-Id: <20210115170907.24498-9-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File-backed memories are prone to unmap/swap so the ptes are always unstable.
This could lead to userfaultfd-wp information got lost when unmapped or swapped
out on such types of memory, for example, shmem.  To keep such an information
persistent, we will start to use the newly introduced swap-like special ptes to
replace a null pte when those ptes were removed.

Prepare this by handling such a special pte first before it is applied.  Here
a new fault flag FAULT_FLAG_UFFD_WP is introduced.  When this flag is set, it
means the current fault is to resolve a page access (either read or write) to
the uffd-wp special pte.

The handling of this special pte page fault is similar to missing fault, but it
should happen after the pte missing logic since the special pte is designed to
be a swap-like pte.  Meanwhile it should be handled before do_swap_page() so
that the swap core logic won't be confused to see such an illegal swap pte.

This is a slow path of uffd-wp handling, because unmap of wr-protected shmem
ptes should be rare.  So far it should only trigger in two conditions:

  (1) When trying to punch holes in shmem_fallocate(), there will be a
      pre-unmap optimization before evicting the page.  That will create
      unmapped shmem ptes with wr-protected pages covered.

  (2) Swapping out of shmem pages

Because of this, the page fault handling is simplifed too by always assuming
it's a read fault when calling do_fault().  When it's a write fault, it'll
fault again when retry the page access, then do_wp_page() will handle the rest
of message generation and delivery to the userfaultfd.

Disable fault-around for such a special page fault, because the introduced new
flag (FAULT_FLAG_UFFD_WP) only applies to current pte rather than all the pages
around it.  Doing fault-around with the new flag could confuse all the rest of
pages when installing ptes from page cache when there's a cache hit.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |   2 +
 mm/memory.c        | 107 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6ae4d3fb4e..85d928764b64 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -426,6 +426,7 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ * @FAULT_FLAG_UFFD_WP: When install new page entries, set uffd-wp bit.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -456,6 +457,7 @@ extern pgprot_t protection_map[16];
 #define FAULT_FLAG_REMOTE			0x80
 #define FAULT_FLAG_INSTRUCTION  		0x100
 #define FAULT_FLAG_INTERRUPTIBLE		0x200
+#define FAULT_FLAG_UFFD_WP			0x400
 
 /*
  * The default fault flags that should be used by most of the
diff --git a/mm/memory.c b/mm/memory.c
index 394c2602dce7..0b687f0be4d0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3797,6 +3797,7 @@ static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	bool pte_changed, uffd_wp = vmf->flags & FAULT_FLAG_UFFD_WP;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	pte_t entry;
 	vm_fault_t ret;
@@ -3807,14 +3808,27 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
 			return ret;
 	}
 
+	/*
+	 * Note: besides pte missing, FAULT_FLAG_UFFD_WP could also trigger
+	 * this path where vmf->pte got released before reaching here.  In that
+	 * case, even if vmf->pte==NULL, the pte actually still contains the
+	 * protection pte (by pte_swp_mkuffd_wp_special()).  For that case,
+	 * we'd also like to allocate a new pte like pte none, but check
+	 * differently for changing pte.
+	 */
 	if (!vmf->pte) {
 		ret = pte_alloc_one_map(vmf);
 		if (ret)
 			return ret;
 	}
 
+	if (unlikely(uffd_wp))
+		pte_changed = !pte_swp_uffd_wp_special(*vmf->pte);
+	else
+		pte_changed = !pte_none(*vmf->pte);
+
 	/* Re-check under ptl */
-	if (unlikely(!pte_none(*vmf->pte))) {
+	if (unlikely(pte_changed)) {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
 		return VM_FAULT_NOPAGE;
 	}
@@ -3824,6 +3838,11 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
 	entry = pte_sw_mkyoung(entry);
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	if (uffd_wp) {
+		/* This should only be triggered by a read fault */
+		WARN_ON_ONCE(write);
+		entry = pte_mkuffd_wp(pte_wrprotect(entry));
+	}
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
@@ -3997,9 +4016,27 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	return ret;
 }
 
+/* Return true if we should do read fault-around, false otherwise */
+static inline bool should_fault_around(struct vm_fault *vmf)
+{
+	/* No ->map_pages?  No way to fault around... */
+	if (!vmf->vma->vm_ops->map_pages)
+		return false;
+
+	/*
+	 * Don't do fault around for FAULT_FLAG_UFFD_WP because it means we
+	 * want to recover a previously wr-protected pte.  This flag is a
+	 * per-pte information, so it could confuse all the pages around the
+	 * current page when faulted in.  Give up on that quickly.
+	 */
+	if (vmf->flags & FAULT_FLAG_UFFD_WP)
+		return false;
+
+	return fault_around_bytes >> PAGE_SHIFT > 1;
+}
+
 static vm_fault_t do_read_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
 
 	/*
@@ -4007,7 +4044,7 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 	 * if page by the offset is not ready to be mapped (cold cache or
 	 * something).
 	 */
-	if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {
+	if (should_fault_around(vmf)) {
 		ret = do_fault_around(vmf);
 		if (ret)
 			return ret;
@@ -4322,6 +4359,68 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 	return VM_FAULT_FALLBACK;
 }
 
+static vm_fault_t uffd_wp_clear_special(struct vm_fault *vmf)
+{
+	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
+				       vmf->address, &vmf->ptl);
+	/*
+	 * Be careful so that we will only recover a special uffd-wp pte into a
+	 * none pte.  Otherwise it means the pte could have changed, so retry.
+	 */
+	if (pte_swp_uffd_wp_special(*vmf->pte))
+		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	return 0;
+}
+
+/*
+ * This is actually a page-missing access, but with uffd-wp special pte
+ * installed.  It means this pte was wr-protected before being unmapped.
+ */
+vm_fault_t uffd_wp_handle_special(struct vm_fault *vmf)
+{
+	/* Careful!  vmf->pte unmapped after return */
+	if (!pte_unmap_same(vmf))
+		return 0;
+
+	/*
+	 * Just in case there're leftover special ptes even after the region
+	 * got unregistered - we can simply clear them.
+	 */
+	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
+		return uffd_wp_clear_special(vmf);
+
+	/*
+	 * Tell all the rest of the fault code: we're handling a special pte,
+	 * always remember to arm the uffd-wp bit when intalling the new pte.
+	 */
+	vmf->flags |= FAULT_FLAG_UFFD_WP;
+
+	/*
+	 * Let's assume this is a read fault no matter what.  If it is a real
+	 * write access, it'll fault again into do_wp_page() where the message
+	 * will be generated before the thread yields itself.
+	 *
+	 * Ideally we can also handle write immediately before return, but this
+	 * should be a slow path already (pte unmapped), so be simple first.
+	 */
+	vmf->flags &= ~FAULT_FLAG_WRITE;
+
+	return do_fault(vmf);
+}
+
+static vm_fault_t do_swap_pte(struct vm_fault *vmf)
+{
+	/*
+	 * We need to handle special swap ptes before handling ptes that
+	 * contain swap entries, always.
+	 */
+	if (unlikely(pte_swp_uffd_wp_special(vmf->orig_pte)))
+		return uffd_wp_handle_special(vmf);
+
+	return do_swap_page(vmf);
+}
+
 /*
  * These routines also need to handle stuff like marking pages dirty
  * and/or accessed for architectures that don't do it in hardware (most
@@ -4385,7 +4484,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	}
 
 	if (!pte_present(vmf->orig_pte))
-		return do_swap_page(vmf);
+		return do_swap_pte(vmf);
 
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
-- 
2.26.2


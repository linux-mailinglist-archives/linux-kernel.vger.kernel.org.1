Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955DC2C69D6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbgK0QmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731917AbgK0QmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:42:23 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1C3C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:42:21 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id v14so51012wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IQJA1R0+ZH6n/mEKPADOgPQGKUArlTZB9O6d5bikysY=;
        b=OtmAW3iOTc0HSyFQEwC0X0vHiCdbf0tuM40NfRGt+FHWZYtusfAnhybqEVYgX5kDKI
         AwsRf7JPHaB7KR0lk+QvX0Rm3bB4VooWt/7DvonmcX64OLYl8a0EkJMkJpwUj9a2zhom
         ogpnl2izGcaJ7n5DKWa46N9m9wCn2IMsyebDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQJA1R0+ZH6n/mEKPADOgPQGKUArlTZB9O6d5bikysY=;
        b=cBNd35mlz0ZeUQN06zPJP5I0VQyf4oYYxTMPuAFrMbVFj2Vu6K0lzZ6Z1HQB31Xr/W
         GK7sXMvR2nC50FUzyHQ55J7dlk+qHKjnJf7IfWNrNA8vsX3EQpNylhw1meWg8VSmu46U
         IHJAXTPQ2jbYxyzFC4jkW5eEiPpAh7gMsT9kNO8A4qheasRMi0o8O3hrx08gn5l1fMhQ
         qC6yqBUkMwyf5CnOFnQf2wwt6La0MVqeDRZvNT7jjNWOcgXYHqgJsZj6vPfUGqTxNQx9
         mKeKGnbQFPuCO79bVFsUO2J7pMsAK6QPqsaQK3n1E2avcUvS9J/UzwViYqtx94kiJdKy
         eQyQ==
X-Gm-Message-State: AOAM532TRP0MZi1y14MKMM/rMfpJwTgv7ZgrSiC/PJEMDQmeEojc3Ymn
        ki/lFWRnOIgnOg1z2l8VX4KYpA==
X-Google-Smtp-Source: ABdhPJy48zVCdGXpcjP3gsbBjW7jvfyFIGztqRyOmt6l9YLmPyEcfoLcyF0d5n5x9HOet3r6YUkIWQ==
X-Received: by 2002:a1c:9c53:: with SMTP id f80mr9983697wme.19.1606495340315;
        Fri, 27 Nov 2020 08:42:20 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q12sm14859078wrx.86.2020.11.27.08.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:42:19 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v7 17/17] mm: add mmu_notifier argument to follow_pfn
Date:   Fri, 27 Nov 2020 17:41:31 +0100
Message-Id: <20201127164131.2244124-18-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127164131.2244124-1-daniel.vetter@ffwll.ch>
References: <20201127164131.2244124-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only safe way for non core/arch code to use follow_pfn() is
together with an mmu_notifier subscription. follow_pfn() is already
marked as _GPL and the kerneldoc explains this restriction.

This patch here enforces all this by adding a mmu_notifier argument
and verifying that it is registered for the correct mm_struct.

Motivated by discussions with Christoph Hellwig and Jason Gunthorpe.

Since requiring an mmu_notifier makes it very clear that follow_pfn()
cannot be used on !CONFIG_MMU hardware, remove it from there. The sole
user kvm not existing on such hardware also supports that.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: kvm@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
--
v7: Comments from Jason:
- ditch follow_pfn from nommu.c
- simplify mmu_notifer->mm check
---
 include/linux/mm.h  |  3 ++-
 mm/memory.c         | 38 ++++++++++++++++++++++++--------------
 mm/nommu.c          | 27 +++++----------------------
 virt/kvm/kvm_main.c |  4 ++--
 4 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bb3e926afd91..2a564bfd818c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1651,6 +1651,7 @@ void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 		unsigned long start, unsigned long end);
 
 struct mmu_notifier_range;
+struct mmu_notifier;
 
 void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 		unsigned long end, unsigned long floor, unsigned long ceiling);
@@ -1660,7 +1661,7 @@ int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 		   struct mmu_notifier_range *range,
 		   pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp);
 int follow_pfn(struct vm_area_struct *vma, unsigned long address,
-	unsigned long *pfn);
+	unsigned long *pfn, struct mmu_notifier *subscription);
 int unsafe_follow_pfn(struct vm_area_struct *vma, unsigned long address,
 		      unsigned long *pfn);
 int follow_phys(struct vm_area_struct *vma, unsigned long address,
diff --git a/mm/memory.c b/mm/memory.c
index 0db0c5e233fd..a27b9b9c22c2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4789,11 +4789,30 @@ int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 }
 EXPORT_SYMBOL(follow_pte_pmd);
 
+static int __follow_pfn(struct vm_area_struct *vma, unsigned long address,
+			unsigned long *pfn)
+{
+	int ret = -EINVAL;
+	spinlock_t *ptl;
+	pte_t *ptep;
+
+	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
+		return ret;
+
+	ret = follow_pte(vma->vm_mm, address, &ptep, &ptl);
+	if (ret)
+		return ret;
+	*pfn = pte_pfn(*ptep);
+	pte_unmap_unlock(ptep, ptl);
+	return 0;
+}
+
 /**
  * follow_pfn - look up PFN at a user virtual address
  * @vma: memory mapping
  * @address: user virtual address
  * @pfn: location to store found PFN
+ * @subscription: mmu_notifier subscription for the mm @vma is part of
  *
  * Only IO mappings and raw PFN mappings are allowed. Note that callers must
  * ensure coherency with pte updates by using a &mmu_notifier to follow updates.
@@ -4805,21 +4824,12 @@ EXPORT_SYMBOL(follow_pte_pmd);
  * Return: zero and the pfn at @pfn on success, -ve otherwise.
  */
 int follow_pfn(struct vm_area_struct *vma, unsigned long address,
-	unsigned long *pfn)
+	unsigned long *pfn, struct mmu_notifier *subscription)
 {
-	int ret = -EINVAL;
-	spinlock_t *ptl;
-	pte_t *ptep;
-
-	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
-		return ret;
+	if (WARN_ON(subscription->mm != vma->vm_mm))
+		return -EINVAL;
 
-	ret = follow_pte(vma->vm_mm, address, &ptep, &ptl);
-	if (ret)
-		return ret;
-	*pfn = pte_pfn(*ptep);
-	pte_unmap_unlock(ptep, ptl);
-	return 0;
+	return __follow_pfn(vma, address, pfn);
 }
 EXPORT_SYMBOL_GPL(follow_pfn);
 
@@ -4844,7 +4854,7 @@ int unsafe_follow_pfn(struct vm_area_struct *vma, unsigned long address,
 	WARN_ONCE(1, "unsafe follow_pfn usage\n");
 	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
 
-	return follow_pfn(vma, address, pfn);
+	return __follow_pfn(vma, address, pfn);
 }
 EXPORT_SYMBOL(unsafe_follow_pfn);
 
diff --git a/mm/nommu.c b/mm/nommu.c
index 79fc98a6c94a..a1e178401146 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -111,27 +111,6 @@ unsigned int kobjsize(const void *objp)
 	return page_size(page);
 }
 
-/**
- * follow_pfn - look up PFN at a user virtual address
- * @vma: memory mapping
- * @address: user virtual address
- * @pfn: location to store found PFN
- *
- * Only IO mappings and raw PFN mappings are allowed.
- *
- * Returns zero and the pfn at @pfn on success, -ve otherwise.
- */
-int follow_pfn(struct vm_area_struct *vma, unsigned long address,
-	unsigned long *pfn)
-{
-	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
-		return -EINVAL;
-
-	*pfn = address >> PAGE_SHIFT;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(follow_pfn);
-
 /**
  * unsafe_follow_pfn - look up PFN at a user virtual address
  * @vma: memory mapping
@@ -153,7 +132,11 @@ int unsafe_follow_pfn(struct vm_area_struct *vma, unsigned long address,
 	WARN_ONCE(1, "unsafe follow_pfn usage\n");
 	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
 
-	return follow_pfn(vma, address, pfn);
+	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
+		return -EINVAL;
+
+	*pfn = address >> PAGE_SHIFT;
+	return 0;
 }
 EXPORT_SYMBOL(unsafe_follow_pfn);
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 417f3d470c3e..6f6786524eff 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1891,7 +1891,7 @@ static int hva_to_pfn_remapped(struct kvm *kvm, struct vm_area_struct *vma,
 	unsigned long pfn;
 	int r;
 
-	r = follow_pfn(vma, addr, &pfn);
+	r = follow_pfn(vma, addr, &pfn, &kvm->mmu_notifier);
 	if (r) {
 		/*
 		 * get_user_pages fails for VM_IO and VM_PFNMAP vmas and does
@@ -1906,7 +1906,7 @@ static int hva_to_pfn_remapped(struct kvm *kvm, struct vm_area_struct *vma,
 		if (r)
 			return r;
 
-		r = follow_pfn(vma, addr, &pfn);
+		r = follow_pfn(vma, addr, &pfn, &kvm->mmu_notifier);
 		if (r)
 			return r;
 
-- 
2.29.2


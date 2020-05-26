Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822101C1CCE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 20:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgEASVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 14:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729953AbgEASUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:20:51 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A80C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 11:20:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s63so10084788qke.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 11:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LoRnv3MJMcc5R6wMX7ungIenWv5IUWDZm/Clv25vaHM=;
        b=YoPQ7p3DgSN6JbL1dnHTqtWXFzHMMLbQhH8TlbK78XgMlRTwjTbRgMVww0HyP9XQ9x
         BLVwOgDq23eZkLWlrjWjNoGjIpFe7BKs60me3V+ElNn9Tkf0n5KgKKp/Sp/nxYnjNvR/
         KkB2PqnPgEa7uaW2INGkLNDWYN4e+Xpcml6wHXsxisJ31etdCbGgisP6csrT1wLlHLqN
         Dp+UOuUAVFRc1GkoV5i4mdxfeLRMonR52AR/SFZkVxlNrDMEiSDjkU3kDNSqdVLLvaX2
         39eL3p294dxNWnivxacW3r7eU9u+O361CSi4gCysksoU4rJq0qu1HB9cEwBvFXssowZG
         fskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LoRnv3MJMcc5R6wMX7ungIenWv5IUWDZm/Clv25vaHM=;
        b=Z1yHt9sX6k/+AeWUoe1a+7Wpejr0idzGukyy4qwNJ+YaBCpCaLWWRUXq5Uypzm/0qp
         QFL05nzlnst1Hz8QiHW208LRdEzunlyAhjKggze5EVb/G/jAqWVsF5s5K+UseFEyGn2u
         d9QY5j6A/SxE/Td6iyecv+CbzXtlvGClCYp9QR4J+02JvS+EcMitlmC2P1ADf+XdKxCP
         bkjPmsqX9A+rPOJ0SUTFw6m4StMxXIa+3QebtAXHhX/jUAeVnhmBOZcyNXztX31oFrks
         PRJ1m1hllltBAESX47eLYwZGEEZR2xTzKrsZ73GOi3R9FN9CCZ+XJrBNRQlZhgr5AQSb
         sygg==
X-Gm-Message-State: AGi0PubujO4CFW1B8Jh6G+IvoVgLOHfDLFx/LqSa9wY8/QHiTPU95AI9
        Wz7tywAFWBuNrblZ68dJGXEGgg==
X-Google-Smtp-Source: APiQypINrFGKPWJ9LGXxo8qg5utpqCz9CorlKv7gkQ57lFnz/QdRnE9rkygWWec0WwhkNohUM1FdyA==
X-Received: by 2002:ae9:ee0a:: with SMTP id i10mr5057917qkg.367.1588357250872;
        Fri, 01 May 2020 11:20:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d69sm3197804qke.111.2020.05.01.11.20.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 May 2020 11:20:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jUaHI-0006oV-JN; Fri, 01 May 2020 15:20:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        dri-devel@lists.freedesktop.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        intel-gfx@lists.freedesktop.org,
        =?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        nouveau@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
Subject: [PATCH hmm v2 2/5] mm/hmm: make hmm_range_fault return 0 or -1
Date:   Fri,  1 May 2020 15:20:45 -0300
Message-Id: <2-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
In-Reply-To: <0-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

hmm_vma_walk->last is supposed to be updated after every write to the
pfns, so that it can be returned by hmm_range_fault(). However, this is
not done consistently. Fortunately nothing checks the return code of
hmm_range_fault() for anything other than error.

More importantly last must be set before returning -EBUSY as it is used to
prevent reading an output pfn as an input flags when the loop restarts.

For clarity and simplicity make hmm_range_fault() return 0 or -ERRNO. Only
set last when returning -EBUSY.

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Tested-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 Documentation/vm/hmm.rst                |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  4 ++--
 drivers/gpu/drm/nouveau/nouveau_svm.c   |  6 +++---
 include/linux/hmm.h                     |  2 +-
 mm/hmm.c                                | 25 +++++++++----------------
 5 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 4e3e9362afeb10..9924f2caa0184c 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -161,7 +161,7 @@ device must complete the update before the driver callback returns.
 When the device driver wants to populate a range of virtual addresses, it can
 use::
 
-  long hmm_range_fault(struct hmm_range *range);
+  int hmm_range_fault(struct hmm_range *range);
 
 It will trigger a page fault on missing or read-only entries if write access is
 requested (see below). Page faults use the generic mm page fault code path just
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6309ff72bd7876..7eb745b8acce0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -852,12 +852,12 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	down_read(&mm->mmap_sem);
 	r = hmm_range_fault(range);
 	up_read(&mm->mmap_sem);
-	if (unlikely(r <= 0)) {
+	if (unlikely(r)) {
 		/*
 		 * FIXME: This timeout should encompass the retry from
 		 * mmu_interval_read_retry() as well.
 		 */
-		if ((r == 0 || r == -EBUSY) && !time_after(jiffies, timeout))
+		if (r == -EBUSY && !time_after(jiffies, timeout))
 			goto retry;
 		goto out_free_pfns;
 	}
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 645fedd77e21b4..c68e9317cf0740 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -536,7 +536,7 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
 		.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT,
 	};
 	struct mm_struct *mm = notifier->notifier.mm;
-	long ret;
+	int ret;
 
 	while (true) {
 		if (time_after(jiffies, timeout))
@@ -548,8 +548,8 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
 		down_read(&mm->mmap_sem);
 		ret = hmm_range_fault(&range);
 		up_read(&mm->mmap_sem);
-		if (ret <= 0) {
-			if (ret == 0 || ret == -EBUSY)
+		if (ret) {
+			if (ret == -EBUSY)
 				continue;
 			return ret;
 		}
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 7475051100c782..0df27dd03d53d7 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -120,7 +120,7 @@ static inline struct page *hmm_device_entry_to_page(const struct hmm_range *rang
 /*
  * Please see Documentation/vm/hmm.rst for how to use the range API.
  */
-long hmm_range_fault(struct hmm_range *range);
+int hmm_range_fault(struct hmm_range *range);
 
 /*
  * HMM_RANGE_DEFAULT_TIMEOUT - default timeout (ms) when waiting for a range
diff --git a/mm/hmm.c b/mm/hmm.c
index 280585833adfc1..f06bcac948a79b 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -174,7 +174,6 @@ static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
 	}
 	if (required_fault)
 		return hmm_vma_fault(addr, end, required_fault, walk);
-	hmm_vma_walk->last = addr;
 	return hmm_pfns_fill(addr, end, range, HMM_PFN_NONE);
 }
 
@@ -207,7 +206,6 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 	pfn = pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
 	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++)
 		pfns[i] = hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
-	hmm_vma_walk->last = end;
 	return 0;
 }
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -386,13 +384,10 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, pfns);
 		if (r) {
 			/* hmm_vma_handle_pte() did pte_unmap() */
-			hmm_vma_walk->last = addr;
 			return r;
 		}
 	}
 	pte_unmap(ptep - 1);
-
-	hmm_vma_walk->last = addr;
 	return 0;
 }
 
@@ -455,7 +450,6 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		for (i = 0; i < npages; ++i, ++pfn)
 			pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
 				  cpu_flags;
-		hmm_vma_walk->last = end;
 		goto out_unlock;
 	}
 
@@ -500,7 +494,6 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	for (; addr < end; addr += PAGE_SIZE, i++, pfn++)
 		range->pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
 				 cpu_flags;
-	hmm_vma_walk->last = end;
 	spin_unlock(ptl);
 	return 0;
 }
@@ -537,7 +530,6 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
 		return -EFAULT;
 
 	hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
-	hmm_vma_walk->last = end;
 
 	/* Skip this vma and continue processing the next vma. */
 	return 1;
@@ -555,9 +547,7 @@ static const struct mm_walk_ops hmm_walk_ops = {
  * hmm_range_fault - try to fault some address in a virtual address range
  * @range:	argument structure
  *
- * Return: the number of valid pages in range->pfns[] (from range start
- * address), which may be zero.  On error one of the following status codes
- * can be returned:
+ * Returns 0 on success or one of the following error codes:
  *
  * -EINVAL:	Invalid arguments or mm or virtual address is in an invalid vma
  *		(e.g., device file vma).
@@ -572,7 +562,7 @@ static const struct mm_walk_ops hmm_walk_ops = {
  * This is similar to get_user_pages(), except that it can read the page tables
  * without mutating them (ie causing faults).
  */
-long hmm_range_fault(struct hmm_range *range)
+int hmm_range_fault(struct hmm_range *range)
 {
 	struct hmm_vma_walk hmm_vma_walk = {
 		.range = range,
@@ -590,10 +580,13 @@ long hmm_range_fault(struct hmm_range *range)
 			return -EBUSY;
 		ret = walk_page_range(mm, hmm_vma_walk.last, range->end,
 				      &hmm_walk_ops, &hmm_vma_walk);
+		/*
+		 * When -EBUSY is returned the loop restarts with
+		 * hmm_vma_walk.last set to an address that has not been stored
+		 * in pfns. All entries < last in the pfn array are set to their
+		 * output, and all >= are still at their input values.
+		 */
 	} while (ret == -EBUSY);
-
-	if (ret)
-		return ret;
-	return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
+	return ret;
 }
 EXPORT_SYMBOL(hmm_range_fault);
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAC623AA38
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgHCQKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 12:10:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:50702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgHCQKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:10:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9FF41B717;
        Mon,  3 Aug 2020 16:10:19 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     amit.pundir@linaro.org, hch@lst.de, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     rientjes@google.com, jeremy.linton@arm.com,
        linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2 1/2] dma-pool: fix coherent pool allocations for IOMMU mappings
Date:   Mon,  3 Aug 2020 18:09:55 +0200
Message-Id: <20200803160956.19235-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803160956.19235-1-nsaenzjulienne@suse.de>
References: <20200803160956.19235-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

When allocating coherent pool memory for an IOMMU mapping we don't care
about the DMA mask.  Move the guess for the initial GFP mask into the
dma_direct_alloc_pages and pass dma_coherent_ok as a function pointer
argument so that it doesn't get applied to the IOMMU case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - Check if phys_addr_ok() exists prior calling it

 drivers/iommu/dma-iommu.c   |   4 +-
 include/linux/dma-direct.h  |   3 -
 include/linux/dma-mapping.h |   5 +-
 kernel/dma/direct.c         |  13 ++--
 kernel/dma/pool.c           | 114 +++++++++++++++---------------------
 5 files changed, 62 insertions(+), 77 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4959f5df21bd..5141d49a046b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1035,8 +1035,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    !gfpflags_allow_blocking(gfp) && !coherent)
-		cpu_addr = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page,
-					       gfp);
+		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
+					       gfp, NULL);
 	else
 		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
 	if (!cpu_addr)
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index ab2e20cba951..ba22952c24e2 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -67,9 +67,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
 }
 
 u64 dma_direct_get_required_mask(struct device *dev);
-gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
-				  u64 *phys_mask);
-bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size);
 void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a33ed3954ed4..0dc08701d7b7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -715,8 +715,9 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 			pgprot_t prot, const void *caller);
 void dma_common_free_remap(void *cpu_addr, size_t size);
 
-void *dma_alloc_from_pool(struct device *dev, size_t size,
-			  struct page **ret_page, gfp_t flags);
+struct page *dma_alloc_from_pool(struct device *dev, size_t size,
+		void **cpu_addr, gfp_t flags,
+		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
 bool dma_free_from_pool(struct device *dev, void *start, size_t size);
 
 int
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 67f060b86a73..f17aec9d01f0 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -45,7 +45,7 @@ u64 dma_direct_get_required_mask(struct device *dev)
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
 
-gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
+static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
 				  u64 *phys_limit)
 {
 	u64 dma_limit = min_not_zero(dma_mask, dev->bus_dma_limit);
@@ -70,7 +70,7 @@ gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
 	return 0;
 }
 
-bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
+static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
 	return phys_to_dma_direct(dev, phys) + size - 1 <=
 			min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
@@ -163,8 +163,13 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	size = PAGE_ALIGN(size);
 
 	if (dma_should_alloc_from_pool(dev, gfp, attrs)) {
-		ret = dma_alloc_from_pool(dev, size, &page, gfp);
-		if (!ret)
+		u64 phys_mask;
+
+		gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
+				&phys_mask);
+		page = dma_alloc_from_pool(dev, size, &ret, gfp,
+				dma_coherent_ok);
+		if (!page)
 			return NULL;
 		goto done;
 	}
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 6bc74a2d5127..5d071d4a3cba 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -196,93 +196,75 @@ static int __init dma_atomic_pool_init(void)
 }
 postcore_initcall(dma_atomic_pool_init);
 
-static inline struct gen_pool *dma_guess_pool_from_device(struct device *dev)
+static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
 {
-	u64 phys_mask;
-	gfp_t gfp;
-
-	gfp = dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
-					  &phys_mask);
-	if (IS_ENABLED(CONFIG_ZONE_DMA) && gfp == GFP_DMA)
+	if (prev == NULL) {
+		if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
+			return atomic_pool_dma32;
+		if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
+			return atomic_pool_dma;
+		return atomic_pool_kernel;
+	}
+	if (prev == atomic_pool_kernel)
+		return atomic_pool_dma32 ? atomic_pool_dma32 : atomic_pool_dma;
+	if (prev == atomic_pool_dma32)
 		return atomic_pool_dma;
-	if (IS_ENABLED(CONFIG_ZONE_DMA32) && gfp == GFP_DMA32)
-		return atomic_pool_dma32;
-	return atomic_pool_kernel;
+	return NULL;
 }
 
-static inline struct gen_pool *dma_get_safer_pool(struct gen_pool *bad_pool)
+static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
+		struct gen_pool *pool, void **cpu_addr,
+		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
 {
-	if (bad_pool == atomic_pool_kernel)
-		return atomic_pool_dma32 ? : atomic_pool_dma;
+	unsigned long addr;
+	phys_addr_t phys;
 
-	if (bad_pool == atomic_pool_dma32)
-		return atomic_pool_dma;
+	addr = gen_pool_alloc(pool, size);
+	if (!addr)
+		return NULL;
 
-	return NULL;
-}
+	phys = gen_pool_virt_to_phys(pool, addr);
+	if (phys_addr_ok && !phys_addr_ok(dev, phys, size)) {
+		gen_pool_free(pool, addr, size);
+		return NULL;
+	}
 
-static inline struct gen_pool *dma_guess_pool(struct device *dev,
-					      struct gen_pool *bad_pool)
-{
-	if (bad_pool)
-		return dma_get_safer_pool(bad_pool);
+	if (gen_pool_avail(pool) < atomic_pool_size)
+		schedule_work(&atomic_pool_work);
 
-	return dma_guess_pool_from_device(dev);
+	*cpu_addr = (void *)addr;
+	memset(*cpu_addr, 0, size);
+	return pfn_to_page(__phys_to_pfn(phys));
 }
 
-void *dma_alloc_from_pool(struct device *dev, size_t size,
-			  struct page **ret_page, gfp_t flags)
+struct page *dma_alloc_from_pool(struct device *dev, size_t size,
+		void **cpu_addr, gfp_t gfp,
+		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
 {
 	struct gen_pool *pool = NULL;
-	unsigned long val = 0;
-	void *ptr = NULL;
-	phys_addr_t phys;
-
-	while (1) {
-		pool = dma_guess_pool(dev, pool);
-		if (!pool) {
-			WARN(1, "Failed to get suitable pool for %s\n",
-			     dev_name(dev));
-			break;
-		}
-
-		val = gen_pool_alloc(pool, size);
-		if (!val)
-			continue;
-
-		phys = gen_pool_virt_to_phys(pool, val);
-		if (dma_coherent_ok(dev, phys, size))
-			break;
-
-		gen_pool_free(pool, val, size);
-		val = 0;
-	}
-
-
-	if (val) {
-		*ret_page = pfn_to_page(__phys_to_pfn(phys));
-		ptr = (void *)val;
-		memset(ptr, 0, size);
+	struct page *page;
 
-		if (gen_pool_avail(pool) < atomic_pool_size)
-			schedule_work(&atomic_pool_work);
+	while ((pool = dma_guess_pool(pool, gfp))) {
+		page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
+					     phys_addr_ok);
+		if (page)
+			return page;
 	}
 
-	return ptr;
+	WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
+	return NULL;
 }
 
 bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
 	struct gen_pool *pool = NULL;
 
-	while (1) {
-		pool = dma_guess_pool(dev, pool);
-		if (!pool)
-			return false;
-
-		if (gen_pool_has_addr(pool, (unsigned long)start, size)) {
-			gen_pool_free(pool, (unsigned long)start, size);
-			return true;
-		}
+	while ((pool = dma_guess_pool(pool, 0))) {
+		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
+			continue;
+		gen_pool_free(pool, (unsigned long)start, size);
+		return true;
 	}
+
+	return false;
 }
-- 
2.28.0


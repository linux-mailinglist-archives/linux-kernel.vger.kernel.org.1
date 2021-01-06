Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A5B2EB88A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 04:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbhAFDmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 22:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbhAFDmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 22:42:53 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492D7C06135C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 19:41:55 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id h10so934809pfo.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 19:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sg3W40DneGLjbdEt4n7awoP/HejFEoiSmlpzE0xyHEk=;
        b=MpYV6agHmz95gEj7SCzmo0uVfEOUSkdlTyOlztpXyiM9mVjfI+VmZ30LY4vs93D3RG
         XL3036gp7fiugceUrf7+Wu1bMGhE56AAt2H7O51hd3s/xGQ24fPUO8LI/afPiBLogXia
         rnNt07TLLVkWc0kKZNGZg/M72o6OTpF2dX1Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sg3W40DneGLjbdEt4n7awoP/HejFEoiSmlpzE0xyHEk=;
        b=PEfNXAbvXSQ48WKHtlPOz2fnuFzgqk5vJo03MIH/50qV6Vb/7Q1L9NkzLNztPgjD+a
         sy9ZbOoDLdzn02dJ/66dRu67PZ4wbLkPvnRrc/ElOfW3PWUkbPozeQjudE3chEXOvlr7
         2pRuQi4rD0WYV+WZFOx1TbZ0Y0ib1TdnrM4xx4SwlsrZNptm7cVRPKM7RW1UHi+JvjUa
         mItpkxqgbHHY7gS7wPk7gPA8zuMpfDDWNte2boKGY1gYONdf3JyT6GyNpQ8cvZJvrcLD
         5YwkfiPvA7k79YaTE7arI4lCUd12F6FFWOeRYyUQvaCmXvXq9uwwVAZJCzyRxMtEtwTs
         aPPw==
X-Gm-Message-State: AOAM530jzho2vG2/DsDChXLDs2vVYpxacu5CPcAQKNgj/fODMRq2ElWt
        t++JesO1Gls1y3XUu2N/bfRzpg==
X-Google-Smtp-Source: ABdhPJwnAO/axR+zC2onQD7uPzcTloFfMHRHayZ5ujUz+VO3ZSqsCh60UtW6TVUumKw3QDxHltKi2Q==
X-Received: by 2002:a63:d214:: with SMTP id a20mr2337441pgg.63.1609904514755;
        Tue, 05 Jan 2021 19:41:54 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id y8sm563699pji.55.2021.01.05.19.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 19:41:54 -0800 (PST)
From:   Claire Chang <tientzu@chromium.org>
To:     robh+dt@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, joro@8bytes.org, will@kernel.org,
        frowand.list@gmail.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com
Cc:     grant.likely@arm.com, xypron.glpk@gmx.de, treding@nvidia.com,
        mingo@kernel.org, bauerman@linux.ibm.com, peterz@infradead.org,
        gregkh@linuxfoundation.org, saravanak@google.com,
        rafael.j.wysocki@intel.com, heikki.krogerus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, rdunlap@infradead.org,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, tfiga@chromium.org,
        drinkcat@chromium.org, Claire Chang <tientzu@chromium.org>
Subject: [RFC PATCH v3 3/6] swiotlb: Use restricted DMA pool if available
Date:   Wed,  6 Jan 2021 11:41:21 +0800
Message-Id: <20210106034124.30560-4-tientzu@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210106034124.30560-1-tientzu@chromium.org>
References: <20210106034124.30560-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regardless of swiotlb setting, the restricted DMA pool is preferred if
available.

The restricted DMA pools provide a basic level of protection against
the DMA overwriting buffer contents at unexpected times. However, to
protect against general data leakage and system memory corruption, the
system needs to provide a way to restrict the DMA to a predefined memory
region.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/iommu/dma-iommu.c | 12 ++++++------
 include/linux/swiotlb.h   | 17 +++++++++++------
 kernel/dma/direct.c       |  8 ++++----
 kernel/dma/direct.h       | 10 ++++++----
 kernel/dma/swiotlb.c      | 13 ++++++-------
 5 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f0305e6aac1b..1343cc2ef27a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -516,7 +516,7 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
 
 	__iommu_dma_unmap(dev, dma_addr, size);
 
-	if (unlikely(is_swiotlb_buffer(phys)))
+	if (unlikely(is_swiotlb_buffer(dev, phys)))
 		swiotlb_tbl_unmap_single(dev, phys, size,
 				iova_align(iovad, size), dir, attrs);
 }
@@ -592,7 +592,7 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 	}
 
 	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
-	if ((iova == DMA_MAPPING_ERROR) && is_swiotlb_buffer(phys))
+	if ((iova == DMA_MAPPING_ERROR) && is_swiotlb_buffer(dev, phys))
 		swiotlb_tbl_unmap_single(dev, phys, org_size,
 				aligned_size, dir, attrs);
 
@@ -764,7 +764,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_cpu(phys, size, dir);
 
-	if (is_swiotlb_buffer(phys))
+	if (is_swiotlb_buffer(dev, phys))
 		swiotlb_tbl_sync_single(dev, phys, size, dir, SYNC_FOR_CPU);
 }
 
@@ -777,7 +777,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
-	if (is_swiotlb_buffer(phys))
+	if (is_swiotlb_buffer(dev, phys))
 		swiotlb_tbl_sync_single(dev, phys, size, dir, SYNC_FOR_DEVICE);
 
 	if (!dev_is_dma_coherent(dev))
@@ -798,7 +798,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 		if (!dev_is_dma_coherent(dev))
 			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
 
-		if (is_swiotlb_buffer(sg_phys(sg)))
+		if (is_swiotlb_buffer(dev, sg_phys(sg)))
 			swiotlb_tbl_sync_single(dev, sg_phys(sg), sg->length,
 						dir, SYNC_FOR_CPU);
 	}
@@ -815,7 +815,7 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 		return;
 
 	for_each_sg(sgl, sg, nelems, i) {
-		if (is_swiotlb_buffer(sg_phys(sg)))
+		if (is_swiotlb_buffer(dev, sg_phys(sg)))
 			swiotlb_tbl_sync_single(dev, sg_phys(sg), sg->length,
 						dir, SYNC_FOR_DEVICE);
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index a1bbd7788885..5135e5636042 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -2,12 +2,12 @@
 #ifndef __LINUX_SWIOTLB_H
 #define __LINUX_SWIOTLB_H
 
+#include <linux/device.h>
 #include <linux/dma-direction.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/limits.h>
 
-struct device;
 struct page;
 struct scatterlist;
 
@@ -106,9 +106,14 @@ struct io_tlb_mem {
 };
 extern struct io_tlb_mem io_tlb_default_mem;
 
-static inline bool is_swiotlb_buffer(phys_addr_t paddr)
+static inline struct io_tlb_mem *get_io_tlb_mem(struct device *dev)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	return dev->dma_io_tlb_mem ? dev->dma_io_tlb_mem : &io_tlb_default_mem;
+}
+
+static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
+{
+	struct io_tlb_mem *mem = get_io_tlb_mem(dev);
 
 	return paddr >= mem->start && paddr < mem->end;
 }
@@ -116,11 +121,11 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
-bool is_swiotlb_active(void);
+bool is_swiotlb_active(struct device *dev);
 void __init swiotlb_adjust_size(unsigned long new_size);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
-static inline bool is_swiotlb_buffer(phys_addr_t paddr)
+static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	return false;
 }
@@ -136,7 +141,7 @@ static inline size_t swiotlb_max_mapping_size(struct device *dev)
 	return SIZE_MAX;
 }
 
-static inline bool is_swiotlb_active(void)
+static inline bool is_swiotlb_active(struct device *dev)
 {
 	return false;
 }
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 002268262c9a..30ccbc08e229 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -343,7 +343,7 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 	for_each_sg(sgl, sg, nents, i) {
 		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
 
-		if (unlikely(is_swiotlb_buffer(paddr)))
+		if (unlikely(is_swiotlb_buffer(dev, paddr)))
 			swiotlb_tbl_sync_single(dev, paddr, sg->length,
 					dir, SYNC_FOR_DEVICE);
 
@@ -369,7 +369,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		if (!dev_is_dma_coherent(dev))
 			arch_sync_dma_for_cpu(paddr, sg->length, dir);
 
-		if (unlikely(is_swiotlb_buffer(paddr)))
+		if (unlikely(is_swiotlb_buffer(dev, paddr)))
 			swiotlb_tbl_sync_single(dev, paddr, sg->length, dir,
 					SYNC_FOR_CPU);
 
@@ -495,7 +495,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
 size_t dma_direct_max_mapping_size(struct device *dev)
 {
 	/* If SWIOTLB is active, use its maximum mapping size */
-	if (is_swiotlb_active() &&
+	if (is_swiotlb_active(dev) &&
 	    (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE))
 		return swiotlb_max_mapping_size(dev);
 	return SIZE_MAX;
@@ -504,7 +504,7 @@ size_t dma_direct_max_mapping_size(struct device *dev)
 bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	return !dev_is_dma_coherent(dev) ||
-		is_swiotlb_buffer(dma_to_phys(dev, dma_addr));
+		is_swiotlb_buffer(dev, dma_to_phys(dev, dma_addr));
 }
 
 /**
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index b98615578737..7188834cc4c7 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -56,7 +56,7 @@ static inline void dma_direct_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t paddr = dma_to_phys(dev, addr);
 
-	if (unlikely(is_swiotlb_buffer(paddr)))
+	if (unlikely(is_swiotlb_buffer(dev, paddr)))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
 
 	if (!dev_is_dma_coherent(dev))
@@ -73,7 +73,7 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 		arch_sync_dma_for_cpu_all();
 	}
 
-	if (unlikely(is_swiotlb_buffer(paddr)))
+	if (unlikely(is_swiotlb_buffer(dev, paddr)))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
 
 	if (dir == DMA_FROM_DEVICE)
@@ -87,8 +87,10 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 	phys_addr_t phys = page_to_phys(page) + offset;
 	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
-	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
+#ifdef CONFIG_SWIOTLB
+	if (unlikely(swiotlb_force == SWIOTLB_FORCE) || dev->dma_io_tlb_mem)
 		return swiotlb_map(dev, phys, size, dir, attrs);
+#endif
 
 	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
 		if (swiotlb_force != SWIOTLB_NO_FORCE)
@@ -113,7 +115,7 @@ static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
 
-	if (unlikely(is_swiotlb_buffer(phys)))
+	if (unlikely(is_swiotlb_buffer(dev, phys)))
 		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
 }
 #endif /* _KERNEL_DMA_DIRECT_H */
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7fb2ac087d23..1f05af09e61a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -222,7 +222,6 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 		mem->orig_addr[i] = INVALID_PHYS_ADDR;
 	}
 	mem->index = 0;
-	no_iotlb_memory = false;
 
 	if (verbose)
 		swiotlb_print_info();
@@ -464,7 +463,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	struct io_tlb_mem *mem = get_io_tlb_mem(hwdev);
 	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, mem->start);
 	unsigned long flags;
 	phys_addr_t tlb_addr;
@@ -475,7 +474,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	unsigned long max_slots;
 	unsigned long tmp_io_tlb_used;
 
-	if (no_iotlb_memory)
+	if (no_iotlb_memory && !hwdev->dma_io_tlb_mem)
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
 
 	if (mem_encrypt_active())
@@ -597,7 +596,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      size_t mapping_size, size_t alloc_size,
 			      enum dma_data_direction dir, unsigned long attrs)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	struct io_tlb_mem *mem = get_io_tlb_mem(hwdev);
 	unsigned long flags;
 	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
@@ -645,7 +644,7 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 			     size_t size, enum dma_data_direction dir,
 			     enum dma_sync_target target)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	struct io_tlb_mem *mem = get_io_tlb_mem(hwdev);
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = mem->orig_addr[index];
 
@@ -712,13 +711,13 @@ size_t swiotlb_max_mapping_size(struct device *dev)
 	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
 }
 
-bool is_swiotlb_active(void)
+bool is_swiotlb_active(struct device *dev)
 {
 	/*
 	 * When SWIOTLB is initialized, even if mem->start points to physical
 	 * address zero, mem->end surely doesn't.
 	 */
-	return io_tlb_default_mem.end != 0;
+	return io_tlb_default_mem.end != 0 || dev->dma_io_tlb_mem;
 }
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.29.2.729.g45daf8777d-goog


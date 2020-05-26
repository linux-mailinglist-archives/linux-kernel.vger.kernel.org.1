Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BFC1BBC96
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 13:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgD1LkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 07:40:14 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:42628 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726750AbgD1LkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:40:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588074011; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Ic5PAM9vc1XfgijUSdoG2PECaN335jbhSTijBUOxs58=; b=GSSfGXuCPFIX5Qo/e7x/Z6IIeTi9daS/jRoZQ78DJ8R/slLqd4njIyc3dEKj/Bm6do2YmFBl
 okak8ZHEpy4aw3obYC2m49V3Duj/1QppIPtqgkAeyB3e/vKKUFdveRrjXmKVQw845zV6Px06
 vVNnF3JdGUQPLAd0zI30ukWtf4Q=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea81604.7f19b6b57538-smtp-out-n02;
 Tue, 28 Apr 2020 11:39:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BB0BDC4478F; Tue, 28 Apr 2020 11:39:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-31.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: svaddagi)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9AA4C433D2;
        Tue, 28 Apr 2020 11:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9AA4C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vatsa@codeaurora.org
From:   Srivatsa Vaddagiri <vatsa@codeaurora.org>
To:     konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
        jan.kiszka@siemens.com, will@kernel.org,
        stefano.stabellini@xilinx.com
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, vatsa@codeaurora.org,
        christoffer.dall@arm.com, alex.bennee@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] swiotlb: Add alloc and free APIs
Date:   Tue, 28 Apr 2020 17:09:16 +0530
Message-Id: <1588073958-1793-4-git-send-email-vatsa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the memory allocation and free portion of swiotlb driver
into independent routines. They will be useful for drivers that
need swiotlb driver to just allocate/free memory chunks and not
additionally bounce memory.

Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
---
 include/linux/swiotlb.h |  17 ++++++
 kernel/dma/swiotlb.c    | 151 ++++++++++++++++++++++++++++--------------------
 2 files changed, 106 insertions(+), 62 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index c634b4d..957697e 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -186,6 +186,10 @@ void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(void);
+extern phys_addr_t swiotlb_alloc(struct swiotlb_pool *pool, size_t alloc_size,
+		unsigned long tbl_dma_addr, unsigned long mask);
+extern void swiotlb_free(struct swiotlb_pool *pool,
+			phys_addr_t tlb_addr, size_t alloc_size);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
 
@@ -219,6 +223,19 @@ static inline bool is_swiotlb_active(void)
 {
 	return false;
 }
+
+static inline phys_addr_t swiotlb_alloc(struct swiotlb_pool *pool,
+		size_t alloc_size, unsigned long tbl_dma_addr,
+		unsigned long mask)
+{
+	return DMA_MAPPING_ERROR;
+}
+
+static inline void swiotlb_free(struct swiotlb_pool *pool,
+			phys_addr_t tlb_addr, size_t alloc_size)
+{
+}
+
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8cf0b57..7411ce5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -444,37 +444,14 @@ static inline void *tlb_vaddr(struct swiotlb_pool *pool, phys_addr_t tlb_addr)
 	return pool->io_tlb_vstart + (tlb_addr - pool->io_tlb_start);
 }
 
-phys_addr_t _swiotlb_tbl_map_single(struct swiotlb_pool *pool,
-				   struct device *hwdev,
-				   dma_addr_t tbl_dma_addr,
-				   phys_addr_t orig_addr,
-				   size_t mapping_size,
-				   size_t alloc_size,
-				   enum dma_data_direction dir,
-				   unsigned long attrs)
+phys_addr_t swiotlb_alloc(struct swiotlb_pool *pool, size_t alloc_size,
+		unsigned long tbl_dma_addr, unsigned long mask)
 {
 	unsigned long flags;
 	phys_addr_t tlb_addr;
-	unsigned int nslots, stride, index, wrap;
-	int i;
-	unsigned long mask;
+	unsigned int i, nslots, stride, index, wrap;
 	unsigned long offset_slots;
 	unsigned long max_slots;
-	unsigned long tmp_io_tlb_used;
-
-	if (pool->no_iotlb_memory)
-		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
-
-	if (mem_encrypt_active())
-		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
-
-	if (mapping_size > alloc_size) {
-		dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
-			      mapping_size, alloc_size);
-		return (phys_addr_t)DMA_MAPPING_ERROR;
-	}
-
-	mask = dma_get_seg_boundary(hwdev);
 
 	tbl_dma_addr &= mask;
 
@@ -555,54 +532,23 @@ phys_addr_t _swiotlb_tbl_map_single(struct swiotlb_pool *pool,
 	} while (index != wrap);
 
 not_found:
-	tmp_io_tlb_used = pool->io_tlb_used;
-
 	spin_unlock_irqrestore(&pool->io_tlb_lock, flags);
-	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
-		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
-			 alloc_size, pool->io_tlb_nslabs, tmp_io_tlb_used);
 	return (phys_addr_t)DMA_MAPPING_ERROR;
+
 found:
 	pool->io_tlb_used += nslots;
 	spin_unlock_irqrestore(&pool->io_tlb_lock, flags);
 
-	/*
-	 * Save away the mapping from the original address to the DMA address.
-	 * This is needed when we sync the memory.  Then we sync the buffer if
-	 * needed.
-	 */
-	for (i = 0; i < nslots; i++)
-		pool->io_tlb_orig_addr[index+i] = orig_addr +
-						(i << IO_TLB_SHIFT);
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
-					mapping_size, DMA_TO_DEVICE);
-
 	return tlb_addr;
 }
 
-/*
- * tlb_addr is the physical address of the bounce buffer to unmap.
- */
-void _swiotlb_tbl_unmap_single(struct swiotlb_pool *pool,
-			struct device *hwdev, phys_addr_t tlb_addr,
-			size_t mapping_size, size_t alloc_size,
-			enum dma_data_direction dir, unsigned long attrs)
+void swiotlb_free(struct swiotlb_pool *pool,
+			phys_addr_t tlb_addr, size_t alloc_size)
 {
 	unsigned long flags;
-	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	int i, count;
+	int nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 	int index = (tlb_addr - pool->io_tlb_start) >> IO_TLB_SHIFT;
-	phys_addr_t orig_addr = pool->io_tlb_orig_addr[index];
-
-	/*
-	 * First, sync the memory before unmapping the entry
-	 */
-	if (orig_addr != INVALID_PHYS_ADDR &&
-	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
-		swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
-						mapping_size, DMA_FROM_DEVICE);
 
 	/*
 	 * Return the buffer to the free list by setting the corresponding
@@ -636,6 +582,87 @@ void _swiotlb_tbl_unmap_single(struct swiotlb_pool *pool,
 	spin_unlock_irqrestore(&pool->io_tlb_lock, flags);
 }
 
+phys_addr_t _swiotlb_tbl_map_single(struct swiotlb_pool *pool,
+				   struct device *hwdev,
+				   dma_addr_t tbl_dma_addr,
+				   phys_addr_t orig_addr,
+				   size_t mapping_size,
+				   size_t alloc_size,
+				   enum dma_data_direction dir,
+				   unsigned long attrs)
+{
+	phys_addr_t tlb_addr;
+	unsigned int nslots, index;
+	int i;
+	unsigned long mask;
+
+	if (pool->no_iotlb_memory)
+		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
+
+	if (mem_encrypt_active())
+		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
+
+	if (mapping_size > alloc_size) {
+		dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
+			      mapping_size, alloc_size);
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+	}
+
+	mask = dma_get_seg_boundary(hwdev);
+
+	tlb_addr = swiotlb_alloc(pool, alloc_size, tbl_dma_addr, mask);
+
+	if (tlb_addr == DMA_MAPPING_ERROR) {
+		if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
+			dev_warn(hwdev, "swiotlb buffer is full (sz: %zd "
+				"bytes), total %lu (slots), used %lu (slots)\n",
+				alloc_size, pool->io_tlb_nslabs,
+				pool->io_tlb_used);
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+	}
+
+	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	index = (tlb_addr - pool->io_tlb_start) >> IO_TLB_SHIFT;
+
+	/*
+	 * Save away the mapping from the original address to the DMA address.
+	 * This is needed when we sync the memory.  Then we sync the buffer if
+	 * needed.
+	 */
+	for (i = 0; i < nslots; i++)
+		pool->io_tlb_orig_addr[index+i] = orig_addr +
+						(i << IO_TLB_SHIFT);
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
+		swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
+					mapping_size, DMA_TO_DEVICE);
+
+	return tlb_addr;
+}
+
+/*
+ * tlb_addr is the physical address of the bounce buffer to unmap.
+ */
+void _swiotlb_tbl_unmap_single(struct swiotlb_pool *pool,
+			struct device *hwdev, phys_addr_t tlb_addr,
+			size_t mapping_size, size_t alloc_size,
+			enum dma_data_direction dir, unsigned long attrs)
+{
+	int index = (tlb_addr - pool->io_tlb_start) >> IO_TLB_SHIFT;
+	phys_addr_t orig_addr = pool->io_tlb_orig_addr[index];
+
+	/*
+	 * First, sync the memory before unmapping the entry
+	 */
+	if (orig_addr != INVALID_PHYS_ADDR &&
+	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
+		swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
+						mapping_size, DMA_FROM_DEVICE);
+
+	swiotlb_free(pool, tlb_addr, alloc_size);
+}
+
 void _swiotlb_tbl_sync_single(struct swiotlb_pool *pool,
 			struct device *hwdev, phys_addr_t tlb_addr,
 			size_t size, enum dma_data_direction dir,
-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

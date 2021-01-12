Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A9D2F3398
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbhALPIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbhALPIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:08:15 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A1C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:07:34 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c124so2169731wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QrSUhzeqlYOl8AzS2dSJWRipeoYaUiWJQ+wst9DqYus=;
        b=L8k8rDxFkn1XMdMIHeaFstQYhTwmHZWx201jsZG2UZo0zXiirRYiaLS9l4YYRN+cU4
         M1rz0h3fLFJBLH6AYmhy1ELtR+8UbFhrqzb8rmzApsRImgnPm4o+z8P+wXfbXPo4hKX2
         9+Q6QGDZsJaCvXavYNrDY919lJgmzFtbwzEATNF5Jr+EdOBWVTC1ZxEPN8mTiZhhjSdf
         boGeVv0LIvMnc/dfmjpY3FQw4Ric5W6cBTudHFzg2DFV4+NQVKlNVLeTohzBQL+oqUvW
         PznHqwDa2rLDyZwp/EzzGenkhjnibwT5QlNYtNPXXhtI9pdz8uF0MGMYak8DYQqOwGdr
         boOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QrSUhzeqlYOl8AzS2dSJWRipeoYaUiWJQ+wst9DqYus=;
        b=n6qxw01Wqq7oIIrYaTFsI6/9bgVZUvmS6NECXM8l5dS1Su7eL9kdRweqFvzpgbxigR
         RoNWLd55ZpJT97BCTeGQBrPnNKY/o1W41GBCvKYmKMZNXSa6Pvi9ZykmgwlrOgLqftYk
         W2Htc3DFu68VkP1PC1IGwlfjRwE4xfbo7/vymrjBmKppbE3pYAz86s6S6dN/5aFFXQEU
         iJGkIqEb4Q8X2XV7gca8V+Xze98zQxMqALKAEIvYx/2Lln3dH6CAqRwZfevl4ea6oqPH
         C75hPAQNnfDvTCWfm3RMWw7RWPTqbzvcj+7IzHvaEaqOlr5FZI+BoCsqT9hoEO/BABZ3
         EWvQ==
X-Gm-Message-State: AOAM533PANcJRGkKHGzR+dF56CoqsXUvWjd56/DTCeeKXGhJ+SvK6t3n
        ZzXE3N3vuJbg+98em+CxWas=
X-Google-Smtp-Source: ABdhPJwOlPiRU413ETPWokvCH5KEyBUnR7vgess0L0NVV2CBVS6AaEhmQmXOAkcGZZWQS3CTTx+fRg==
X-Received: by 2002:a1c:2188:: with SMTP id h130mr3980398wmh.176.1610464053456;
        Tue, 12 Jan 2021 07:07:33 -0800 (PST)
Received: from martin (p578aa711.dip0.t-ipconnect.de. [87.138.167.17])
        by smtp.gmail.com with ESMTPSA id o3sm5128319wrc.93.2021.01.12.07.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:07:32 -0800 (PST)
Date:   Tue, 12 Jan 2021 16:07:29 +0100
From:   Martin Radev <martin.b.radev@gmail.com>
To:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        kirill.shutemov@linux.intel.com, thomas.lendacky@amd.com
Cc:     robert.buhren@sect.tu-berlin.de, file@sect.tu-berlin.de,
        mathias.morbitzer@aisec.fraunhofer.de
Subject: [PATCH] swiotlb: Validate bounce size in the sync/unmap path
Message-ID: <X/27MSbfDGCY9WZu@martin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of the buffer being bounced is not checked if it happens
to be larger than the size of the mapped buffer. Because the size
can be controlled by a device, as it's the case with virtio devices,
this can lead to memory corruption.

This patch saves the remaining buffer memory for each slab and uses
that information for validation in the sync/unmap paths before
swiotlb_bounce is called.

Validating this argument is important under the threat models of
AMD SEV-SNP and Intel TDX, where the HV is considered untrusted.

Signed-off-by: Martin Radev <martin.b.radev@gmail.com>
---
 kernel/dma/swiotlb.c | 52 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7c42df6e6100..98d79103aa1f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -102,6 +102,11 @@ static unsigned int max_segment;
 #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
 static phys_addr_t *io_tlb_orig_addr;
 
+/*
+ * The mapped buffer's size should be validated during a sync operation.
+ */
+static size_t *io_tlb_orig_size;
+
 /*
  * Protect the above data structures in the map and unmap calls
  */
@@ -240,9 +245,16 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
 
+	alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(size_t));
+	io_tlb_orig_size = memblock_alloc(alloc_size, PAGE_SIZE);
+	if (!io_tlb_orig_size)
+		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
+		      __func__, alloc_size, PAGE_SIZE);
+
 	for (i = 0; i < io_tlb_nslabs; i++) {
 		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
 		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
+		io_tlb_orig_size[i] = 0;
 	}
 	io_tlb_index = 0;
 	no_iotlb_memory = false;
@@ -363,7 +375,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	 * between io_tlb_start and io_tlb_end.
 	 */
 	io_tlb_list = (unsigned int *)__get_free_pages(GFP_KERNEL,
-	                              get_order(io_tlb_nslabs * sizeof(int)));
+				      get_order(io_tlb_nslabs * sizeof(int)));
 	if (!io_tlb_list)
 		goto cleanup3;
 
@@ -374,9 +386,18 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	if (!io_tlb_orig_addr)
 		goto cleanup4;
 
+	io_tlb_orig_size = (size_t *)
+		__get_free_pages(GFP_KERNEL,
+				 get_order(io_tlb_nslabs *
+					   sizeof(size_t)));
+	if (!io_tlb_orig_size)
+		goto cleanup5;
+
+
 	for (i = 0; i < io_tlb_nslabs; i++) {
 		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
 		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
+		io_tlb_orig_size[i] = 0;
 	}
 	io_tlb_index = 0;
 	no_iotlb_memory = false;
@@ -389,6 +410,10 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 
 	return 0;
 
+cleanup5:
+	free_pages((unsigned long)io_tlb_orig_addr, get_order(io_tlb_nslabs *
+							      sizeof(phys_addr_t)));
+
 cleanup4:
 	free_pages((unsigned long)io_tlb_list, get_order(io_tlb_nslabs *
 	                                                 sizeof(int)));
@@ -404,6 +429,8 @@ void __init swiotlb_exit(void)
 		return;
 
 	if (late_alloc) {
+		free_pages((unsigned long)io_tlb_orig_size,
+			   get_order(io_tlb_nslabs * sizeof(size_t)));
 		free_pages((unsigned long)io_tlb_orig_addr,
 			   get_order(io_tlb_nslabs * sizeof(phys_addr_t)));
 		free_pages((unsigned long)io_tlb_list, get_order(io_tlb_nslabs *
@@ -413,6 +440,8 @@ void __init swiotlb_exit(void)
 	} else {
 		memblock_free_late(__pa(io_tlb_orig_addr),
 				   PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)));
+		memblock_free_late(__pa(io_tlb_orig_size),
+				   PAGE_ALIGN(io_tlb_nslabs * sizeof(size_t)));
 		memblock_free_late(__pa(io_tlb_list),
 				   PAGE_ALIGN(io_tlb_nslabs * sizeof(int)));
 		memblock_free_late(io_tlb_start,
@@ -581,8 +610,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	 * This is needed when we sync the memory.  Then we sync the buffer if
 	 * needed.
 	 */
-	for (i = 0; i < nslots; i++)
+	for (i = 0; i < nslots; i++) {
 		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
+		io_tlb_orig_size[index+i] = alloc_size - (i << IO_TLB_SHIFT);
+	}
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
@@ -590,6 +621,17 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	return tlb_addr;
 }
 
+static void validate_sync_size_and_truncate(struct device *hwdev, size_t orig_size, size_t *size)
+{
+	if (*size > orig_size) {
+		/* Warn and truncate mapping_size */
+		dev_WARN_ONCE(hwdev, 1,
+			"Attempt for buffer overflow. Original size: %zu. Mapping size: %zu.\n",
+			orig_size, *size);
+		*size = orig_size;
+	}
+}
+
 /*
  * tlb_addr is the physical address of the bounce buffer to unmap.
  */
@@ -602,6 +644,8 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = io_tlb_orig_addr[index];
 
+	validate_sync_size_and_truncate(hwdev, io_tlb_orig_size[index], &mapping_size);
+
 	/*
 	 * First, sync the memory before unmapping the entry
 	 */
@@ -627,6 +671,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 		for (i = index + nslots - 1; i >= index; i--) {
 			io_tlb_list[i] = ++count;
 			io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
+			io_tlb_orig_size[i] = 0;
 		}
 		/*
 		 * Step 2: merge the returned slots with the preceding slots,
@@ -645,12 +690,15 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 			     enum dma_sync_target target)
 {
 	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
+	size_t orig_size = io_tlb_orig_size[index];
 	phys_addr_t orig_addr = io_tlb_orig_addr[index];
 
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
 	orig_addr += (unsigned long)tlb_addr & ((1 << IO_TLB_SHIFT) - 1);
 
+	validate_sync_size_and_truncate(hwdev, orig_size, &size);
+
 	switch (target) {
 	case SYNC_FOR_CPU:
 		if (likely(dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
-- 
2.17.1


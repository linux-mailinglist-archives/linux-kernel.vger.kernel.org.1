Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31EA26B6C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgIPAKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:10:33 -0400
Received: from verein.lst.de ([213.95.11.211]:47944 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgIOO0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:26:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9107768BFE; Tue, 15 Sep 2020 16:26:25 +0200 (CEST)
Date:   Tue, 15 Sep 2020 16:26:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Tai <thomas.tai@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, konrad.wilk@oracle.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Fix potential NULL pointer dereference
Message-ID: <20200915142624.GA16005@lst.de>
References: <1600178594-22801-1-git-send-email-thomas.tai@oracle.com> <20200915140719.GA14831@lst.de> <f5cba632-421a-f375-3697-51a182a53a32@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5cba632-421a-f375-3697-51a182a53a32@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:11:51AM -0400, Thomas Tai wrote:
>
>
> On 2020-09-15 10:07 a.m., Christoph Hellwig wrote:
>> On Tue, Sep 15, 2020 at 08:03:14AM -0600, Thomas Tai wrote:
>>> When booting the kernel v5.9-rc4 on a VM, the kernel would panic when
>>> printing a warning message in swiotlb_map(). It is because dev->dma_mask
>>> can potentially be a null pointer. Using the dma_get_mask() macro can
>>> avoid the NULL pointer dereference.
>>
>> dma_mask must not be zero.  This means drm is calling DMA API functions
>> on something weird.  This needs to be fixed in the caller.
>>
>
> Thanks, Christoph for your comment. The caller already fixed the null 
> pointer in the latest v5.9-rc5. I am thinking that if we had used the 
> dma_get_mask(), the kernel couldn't panic and could properly print out the 
> warning message.

If we want to solve this something like this patch is probably the
right way:



diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 6e87225600ae35..064870844f06c1 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -62,9 +62,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
 {
 	dma_addr_t end = addr + size - 1;
 
-	if (!dev->dma_mask)
-		return false;
-
 	if (is_ram && !IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
 	    min(addr, end) < phys_to_dma(dev, PFN_PHYS(min_low_pfn)))
 		return false;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 0d129421e75fc8..2b01d8f7baf160 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -144,6 +144,10 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
+
+	if (WARN_ON_ONCE(!dev->dma_mask))
+		return DMA_MAPPING_ERROR;
+
 	if (dma_map_direct(dev, ops))
 		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
 	else
@@ -179,6 +183,10 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 	int ents;
 
 	BUG_ON(!valid_dma_direction(dir));
+
+	if (WARN_ON_ONCE(!dev->dma_mask))
+		return 0;
+
 	if (dma_map_direct(dev, ops))
 		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
 	else
@@ -217,6 +225,9 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
 		return DMA_MAPPING_ERROR;
 
+	if (WARN_ON_ONCE(!dev->dma_mask))
+		return DMA_MAPPING_ERROR;
+
 	if (dma_map_direct(dev, ops))
 		addr = dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
 	else if (ops->map_resource)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F061DA2B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 22:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgESUfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 16:35:07 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:35322 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727939AbgESUfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:35:02 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 6C53B30D82B;
        Tue, 19 May 2020 13:33:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 6C53B30D82B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1589920418;
        bh=idCAwH65TvJoECMSQ+xjnD19SjnYnIujkrcbMhDjDEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJ8daraqpkzatWJq9eG4T9sG9xvEc1Xi2vT9BJYubzwEJQmcU1rNmwywqjPM60845
         syYRRu1GASzkAg/4B2CdK+67D4pNMlJOqnp/UkRQUH1QYqTyvCKvzzuYdOetgHjsPj
         tGXOQhjA0cfEhoSiVrzmS4gn/EeACUuPhUAZ/IOg=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id B6AED14008D;
        Tue, 19 May 2020 13:34:59 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     james.quinlan@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/15] dma-direct: Invoke dma offset func if needed
Date:   Tue, 19 May 2020 16:34:08 -0400
Message-Id: <20200519203419.12369-11-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519203419.12369-1-james.quinlan@broadcom.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like dma_pfn_offset, another offset is added to
the dma/phys translation if there happen to be multiple
regions that have different mapping offsets.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 include/linux/dma-direct.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 24b8684aa21d..825a773dbbc3 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -15,6 +15,14 @@ static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	dma_addr_t dev_addr = (dma_addr_t)paddr;
 
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+	if (unlikely(dev->dma_offset_map)) {
+		unsigned long dma_pfn_offset =	dma_pfn_offset_frm_phys_addr(
+			dev->dma_offset_map, paddr);
+
+		return dev_addr - ((dma_addr_t)dma_pfn_offset << PAGE_SHIFT);
+	}
+#endif
 	return dev_addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
 }
 
@@ -22,6 +30,14 @@ static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 {
 	phys_addr_t paddr = (phys_addr_t)dev_addr;
 
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+	if (unlikely(dev->dma_offset_map)) {
+		unsigned long dma_pfn_offset = dma_pfn_offset_frm_dma_addr(
+			dev->dma_offset_map, dev_addr);
+
+		return paddr + ((phys_addr_t)dma_pfn_offset << PAGE_SHIFT);
+	}
+#endif
 	return paddr + ((phys_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
 }
 #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
-- 
2.17.1


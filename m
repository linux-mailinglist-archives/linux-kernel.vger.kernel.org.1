Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97393274362
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgIVNjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgIVNjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:39:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AAAC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Dj0SE+agkMPt4RtgGrQDspMH2G8cNUOwicknqNk5yZA=; b=Qcrd+4KUpPW6lmO0FyhIU3+sBa
        wcNoL5YDdT1H4u8iBEIvwmObNtIoR1ZviLjJ8tXgpCye/WihOtGde4DhWNMNxHD13FMMAXE0sTTcZ
        auTQJKt3wq7plJ23hsuk5XTAR7DxcrqEjSVgG1xP9d7CTRWmaPQ5GiskA31NGC3ivN0ul1ceZ7OOH
        Fo+fEFx4PkPZihLWHcNDXtta+Od+ryR7qYyhKdFZEjl9QWZSvHg1fCjidzuZd6I+CPZwj8EjvfPMm
        dM7f57AEH6xyO0u1pgXUo5w9NFqN9iU5kP5TijIPzv/fT6fNXx8NMtHVWZxWwNm9MhQOm6vbF4KSN
        O1SgBZdg==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKiWC-0005MM-RC; Tue, 22 Sep 2020 13:39:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dma-mapping: better document dma_addr_t and DMA_MAPPING_ERROR
Date:   Tue, 22 Sep 2020 15:40:02 +0200
Message-Id: <20200922134002.1227279-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922134002.1227279-1-hch@lst.de>
References: <20200922134002.1227279-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the comment documenting dma_addr_t away from the dma_map_ops
definition which isn't very related to it, and toward DMA_MAPPING_ERROR,
which is somewhat related.  Add a little blurb about DMA_MAPPING_ERROR
as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 51e93d44b826c8..c4395cf7e265dd 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -67,12 +67,6 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
-/*
- * A dma_addr_t can hold any valid DMA or bus address for the platform.
- * It can be given to a device to use as a DMA source or target.  A CPU cannot
- * reference a dma_addr_t directly because there may be translation between
- * its physical address space and the bus address space.
- */
 struct dma_map_ops {
 	void* (*alloc)(struct device *dev, size_t size,
 				dma_addr_t *dma_handle, gfp_t gfp,
@@ -131,6 +125,16 @@ struct dma_map_ops {
 	unsigned long (*get_merge_boundary)(struct device *dev);
 };
 
+/*
+ * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
+ * be given to a device to use as a DMA source or target.  A CPU cannot
+ * reference a dma_addr_t directly because there may be translation between its
+ * physical address space and the bus address space.
+ *
+ * DMA_MAPPING_ERROR is the magic error code if a mapping failed.  It should not
+ * be used directly in drivers, but checked for using dma_mapping_error()
+ * instead.
+ */
 #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
 
 extern const struct dma_map_ops dma_virt_ops;
-- 
2.28.0


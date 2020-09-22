Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEEB27435C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIVNjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgIVNjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:39:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CF1C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TW4HF4UNXK4k3VZxzu0QvqfItRwA9waS7E5349XKG5g=; b=b4ImiuW8O74awq/o/PA9Fq702/
        kf02jCe7wdTk/hcyClX7EyumlmM3ocHR0NDc7HN9kZY908uBfDM4pkM1D+e2xEnDvxdNFHlUVAV2Q
        DOtteGsOyDgEt+KjftqyrWHgvb+d5mSbvTz6DJyTlYLZorTSrfXUaZXuTY6Xj/vRhCYTxmcqKLy5I
        Z0X+PI69+GPVBOOeeLsxs8R09sZxkp++fS+HlWjI0w1S3p7tKHxG9XGGvpYxoJT3KRQn0nmss62k3
        mppxdfH/STzLV2PFsKDecsK9AGmjNcPnoR7TjbKbPIZw/Km9Uw7lVoVGE9Cintxxp/MFrP5IiGcPX
        wpwG4wbQ==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKiWB-0005M9-Fu; Tue, 22 Sep 2020 13:39:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dma-mapping: move valid_dma_direction to dma-direction.h
Date:   Tue, 22 Sep 2020 15:40:01 +0200
Message-Id: <20200922134002.1227279-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922134002.1227279-1-hch@lst.de>
References: <20200922134002.1227279-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the valid_dma_direction helper to a more suitable header, and
clean it up to use the proper enum as well as removing pointless braces.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-direction.h | 8 +++++++-
 include/linux/dma-mapping.h   | 7 -------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/dma-direction.h b/include/linux/dma-direction.h
index 9c96e30e6a0bb0..a2fe4571bc9279 100644
--- a/include/linux/dma-direction.h
+++ b/include/linux/dma-direction.h
@@ -9,4 +9,10 @@ enum dma_data_direction {
 	DMA_NONE = 3,
 };
 
-#endif
+static inline int valid_dma_direction(enum dma_data_direction dir)
+{
+	return dir == DMA_BIDIRECTIONAL || dir == DMA_TO_DEVICE ||
+		dir == DMA_FROM_DEVICE;
+}
+
+#endif /* _LINUX_DMA_DIRECTION_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e074588d753ff6..51e93d44b826c8 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -138,13 +138,6 @@ extern const struct dma_map_ops dma_dummy_ops;
 
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
 
-static inline int valid_dma_direction(int dma_direction)
-{
-	return ((dma_direction == DMA_BIDIRECTIONAL) ||
-		(dma_direction == DMA_TO_DEVICE) ||
-		(dma_direction == DMA_FROM_DEVICE));
-}
-
 #ifdef CONFIG_DMA_DECLARE_COHERENT
 /*
  * These three functions are only for dma allocator.
-- 
2.28.0


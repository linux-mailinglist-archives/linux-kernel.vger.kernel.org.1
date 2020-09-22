Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E35A27435A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgIVNjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgIVNjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:39:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20355C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=949fIlFJxhHftxK0F0GIl/omAnloK0lrmH1lk+jzSZ8=; b=RbkWoWrCf5xaBUbunWQCzfjwUc
        oDOkMeUm6Z5seq7uxsDIBMWyWWt4jxGsX5okbeTWhUGZPFBmobf0GC5jFVxLOEWcnb3Rw/KTaQ6C2
        PkR2JzqlA4AHqgUPLtts1LY+dHW0J6jNKjAyVFNW5dW4y/YbqMgiInjuqywcxgPvgt9j159owP2b5
        N1vH6DrLidLzLEMC1pXnWUQCCo9tdbu7tIhLCVsS6OCksmbewe9q1FxhiHS0onuHN6EHQfq8AnVqw
        Y5iW0MJ513T2EHvvUcfAvt7Ublr95NFq9IbMf2dZX+D4BPPvUdtdBomp21JE6bSG7Mh27JUQ+L2I0
        4/wzcOUg==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKiW9-0005M2-S5; Tue, 22 Sep 2020 13:39:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dma-mapping: remove DMA_MASK_NONE
Date:   Tue, 22 Sep 2020 15:40:00 +0200
Message-Id: <20200922134002.1227279-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922134002.1227279-1-hch@lst.de>
References: <20200922134002.1227279-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This value is only used by a PCMCIA driver and not very useful.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pcmcia/ds.c         | 2 +-
 include/linux/dma-mapping.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 09d06b082f8b8c..72114907c0e4d2 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -516,7 +516,7 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
 	p_dev->dev.parent = s->dev.parent;
 	p_dev->dev.release = pcmcia_release_dev;
 	/* by default don't allow DMA */
-	p_dev->dma_mask = DMA_MASK_NONE;
+	p_dev->dma_mask = 0;
 	p_dev->dev.dma_mask = &p_dev->dma_mask;
 	dev_set_name(&p_dev->dev, "%d.%d", p_dev->socket->sock, p_dev->device_no);
 	if (!dev_name(&p_dev->dev))
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index bb138ac6f5e63e..e074588d753ff6 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -138,8 +138,6 @@ extern const struct dma_map_ops dma_dummy_ops;
 
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
 
-#define DMA_MASK_NONE	0x0ULL
-
 static inline int valid_dma_direction(int dma_direction)
 {
 	return ((dma_direction == DMA_BIDIRECTIONAL) ||
-- 
2.28.0


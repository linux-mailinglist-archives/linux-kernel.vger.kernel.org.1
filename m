Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8032803BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbgJAQSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:18:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:57864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732705AbgJAQR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:17:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 558ADAD32;
        Thu,  1 Oct 2020 16:17:56 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        robin.murphy@arm.com, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     will@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 2/4] dma-direct: Turn zone_dma_bits default value into a define
Date:   Thu,  1 Oct 2020 18:17:38 +0200
Message-Id: <20201001161740.29064-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001161740.29064-1-nsaenzjulienne@suse.de>
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other code might need to reference it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 include/linux/dma-direct.h | 1 +
 kernel/dma/direct.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 38ed3b55034d..ef19ff505d09 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -12,6 +12,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/swiotlb.h>
 
+#define ZONE_DMA_BITS_DEFAULT	24
 extern unsigned int zone_dma_bits;
 
 /*
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 121a9c1969dd..4b3cfa02532b 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -20,7 +20,7 @@
  * it for entirely different regions. In that case the arch code needs to
  * override the variable below for dma-direct to work properly.
  */
-unsigned int zone_dma_bits __ro_after_init = 24;
+unsigned int zone_dma_bits __ro_after_init = ZONE_DMA_BITS_DEFAULT;
 
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
 		phys_addr_t phys)
-- 
2.28.0


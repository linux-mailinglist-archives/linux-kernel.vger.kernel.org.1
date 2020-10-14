Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7462428E703
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390362AbgJNTM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:12:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:52310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390311AbgJNTMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:12:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 25507B2B3;
        Wed, 14 Oct 2020 19:12:22 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v3 5/8] dma-direct: Turn zone_dma_bits default value into a define
Date:   Wed, 14 Oct 2020 21:12:07 +0200
Message-Id: <20201014191211.27029-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014191211.27029-1-nsaenzjulienne@suse.de>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set zone_dma_bits default value through a define so as for architectures
to be able to override it with their default value.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 include/linux/dma-direct.h | 3 +++
 kernel/dma/direct.c        | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 18aade195884..e433d90cbacf 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -12,6 +12,9 @@
 #include <linux/mem_encrypt.h>
 #include <linux/swiotlb.h>
 
+#ifndef ZONE_DMA_BITS_DEFAULT
+#define ZONE_DMA_BITS_DEFAULT	24
+#endif
 extern unsigned int zone_dma_bits;
 
 /*
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 06c111544f61..c0d97f536e93 100644
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


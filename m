Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A9E28A32C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbgJJW5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:57:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:48180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732216AbgJJTny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:43:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D158B052;
        Sat, 10 Oct 2020 15:12:45 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 1/5] arm64: mm: Move zone_dma_bits initialization into zone_sizes_init()
Date:   Sat, 10 Oct 2020 17:12:31 +0200
Message-Id: <20201010151235.20585-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201010151235.20585-1-nsaenzjulienne@suse.de>
References: <20201010151235.20585-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There no use for initializing it earlier in arm64_memblock_init().

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm64/mm/init.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f6902a2b4ea6..0eca5865dcb1 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -196,14 +196,16 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
 
 #ifdef CONFIG_ZONE_DMA
+	zone_dma_bits = ARM64_ZONE_DMA_BITS;
+
 	if (IS_ENABLED(CONFIG_ACPI)) {
 		extern unsigned int acpi_iort_get_zone_dma_size(void);
 
 		zone_dma_bits = min(zone_dma_bits,
 				    acpi_iort_get_zone_dma_size());
-		arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
 	}
 
+	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
 #endif
 #ifdef CONFIG_ZONE_DMA32
@@ -394,11 +396,6 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
-		zone_dma_bits = ARM64_ZONE_DMA_BITS;
-		arm64_dma_phys_limit = max_zone_phys(ARM64_ZONE_DMA_BITS);
-	}
-
 	if (IS_ENABLED(CONFIG_ZONE_DMA32))
 		arm64_dma32_phys_limit = max_zone_phys(32);
 	else
-- 
2.28.0


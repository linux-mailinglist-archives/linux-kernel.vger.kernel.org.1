Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2EE2B9A31
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgKSRy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:54:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:40718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729335AbgKSRyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:54:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D67BFACEB;
        Thu, 19 Nov 2020 17:54:07 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        will@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v7 2/7] arm64: mm: Move zone_dma_bits initialization into zone_sizes_init()
Date:   Thu, 19 Nov 2020 18:53:54 +0100
Message-Id: <20201119175400.9995-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119175400.9995-1-nsaenzjulienne@suse.de>
References: <20201119175400.9995-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zone_dma_bits's initialization happens earlier that it's actually
needed, in arm64_memblock_init(). So move it into the more suitable
zone_sizes_init().

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/mm/init.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index fafdf992fd32..0954ea736987 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -190,6 +190,8 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
 
 #ifdef CONFIG_ZONE_DMA
+	zone_dma_bits = ARM64_ZONE_DMA_BITS;
+	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
 #endif
 #ifdef CONFIG_ZONE_DMA32
@@ -379,11 +381,6 @@ void __init arm64_memblock_init(void)
 
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
2.29.2


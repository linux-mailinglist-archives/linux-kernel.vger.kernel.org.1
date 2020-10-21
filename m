Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C26294CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442427AbgJUMfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:35:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:50874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442398AbgJUMfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:35:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5D12AEB6;
        Wed, 21 Oct 2020 12:35:32 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        will@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v4 5/7] arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges
Date:   Wed, 21 Oct 2020 14:34:35 +0200
Message-Id: <20201021123437.21538-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021123437.21538-1-nsaenzjulienne@suse.de>
References: <20201021123437.21538-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently introduced a 1 GB sized ZONE_DMA to cater for platforms
incorporating masters that can address less than 32 bits of DMA, in
particular the Raspberry Pi 4, which has 4 or 8 GB of DRAM, but has
peripherals that can only address up to 1 GB (and its PCIe host
bridge can only access the bottom 3 GB)

The DMA layer also needs to be able to allocate memory that is
guaranteed to meet those DMA constraints, for bounce buffering as well
as allocating the backing for consistent mappings. This is why the 1 GB
ZONE_DMA was introduced recently. Unfortunately, it turns out the having
a 1 GB ZONE_DMA as well as a ZONE_DMA32 causes problems with kdump, and
potentially in other places where allocations cannot cross zone
boundaries. Therefore, we should avoid having two separate DMA zones
when possible.

So, with the help of of_dma_get_max_cpu_address() get the topmost
physical address accessible to all DMA masters in system and use that
information to fine-tune ZONE_DMA's size. In the absence of addressing
limited masters ZONE_DMA will span the whole 32-bit address space,
otherwise, in the case of the Raspberry Pi 4 it'll only span the 30-bit
address space, and have ZONE_DMA32 cover the rest of the 32-bit address
space.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Changes since v3:
 - Simplify code for readability.

Changes since v2:
 - Updated commit log by shamelessly copying Ard's ACPI commit log

 arch/arm64/mm/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 410721fc4fc0..94e38f99748b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -42,8 +42,6 @@
 #include <asm/tlb.h>
 #include <asm/alternative.h>
 
-#define ARM64_ZONE_DMA_BITS	30
-
 /*
  * We need to be able to catch inadvertent references to memstart_addr
  * that occur (potentially in generic code) before arm64_memblock_init()
@@ -188,9 +186,11 @@ static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
 static void __init zone_sizes_init(unsigned long min, unsigned long max)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
+	unsigned int __maybe_unused dt_zone_dma_bits;
 
 #ifdef CONFIG_ZONE_DMA
-	zone_dma_bits = ARM64_ZONE_DMA_BITS;
+	dt_zone_dma_bits = ilog2(of_dma_get_max_cpu_address(NULL));
+	zone_dma_bits = min(32U, dt_zone_dma_bits);
 	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
 #endif
-- 
2.28.0


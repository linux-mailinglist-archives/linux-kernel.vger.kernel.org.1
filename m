Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1002228E6FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390346AbgJNTM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:12:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:52338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390312AbgJNTMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:12:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA1D2B2B2;
        Wed, 14 Oct 2020 19:12:22 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v3 6/8] arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges
Date:   Wed, 14 Oct 2020 21:12:08 +0200
Message-Id: <20201014191211.27029-7-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014191211.27029-1-nsaenzjulienne@suse.de>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
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

Changes since v2:
 - Updated commit log by shamelessly copying Ard's ACPI counterpart commit log

 arch/arm64/include/asm/processor.h | 1 +
 arch/arm64/mm/init.c               | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index fce8cbecd6bc..c09d3f1a9a6b 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -97,6 +97,7 @@
 
 extern phys_addr_t arm64_dma_phys_limit;
 #define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit - 1)
+#define ZONE_DMA_BITS_DEFAULT	32
 
 struct debug_info {
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ef0ef0087e2c..97b0d2768349 100644
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
@@ -196,7 +194,8 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
 
 #ifdef CONFIG_ZONE_DMA
-	zone_dma_bits = ARM64_ZONE_DMA_BITS;
+	zone_dma_bits = min(zone_dma_bits,
+			    (unsigned int)ilog2(of_dma_get_max_cpu_address(NULL)));
 	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
 #endif
-- 
2.28.0


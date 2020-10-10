Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6663A28A359
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390446AbgJJW5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:57:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:48186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732221AbgJJTnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:43:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45896B14F;
        Sat, 10 Oct 2020 15:12:48 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 4/5] arm64: mm: Dynamically resize zone_dma_bits based on system's constraints
Date:   Sat, 10 Oct 2020 17:12:34 +0200
Message-Id: <20201010151235.20585-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201010151235.20585-1-nsaenzjulienne@suse.de>
References: <20201010151235.20585-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the help of of_dma_safe_phys_limit() we can get the topmost
physical address accessible for DMA to the whole system and use that
information to properly setup zone_dma_bits.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
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
index 0eca5865dcb1..5934df93bf4d 100644
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
+			    (unsigned int)ilog2(of_dma_safe_phys_limit()));
 
 	if (IS_ENABLED(CONFIG_ACPI)) {
 		extern unsigned int acpi_iort_get_zone_dma_size(void);
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FD929F310
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgJ2R0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:26:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgJ2RZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:25:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3242CACF6;
        Thu, 29 Oct 2020 17:25:57 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        will@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v5 1/7] arm64: mm: Move reserve_crashkernel() into mem_init()
Date:   Thu, 29 Oct 2020 18:25:44 +0100
Message-Id: <20201029172550.3523-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029172550.3523-1-nsaenzjulienne@suse.de>
References: <20201029172550.3523-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crashkernel might reserve memory located in ZONE_DMA. We plan to delay
ZONE_DMA's initialization after unflattening the devicetree and ACPI's
boot table initialization, so move it later in the boot process.
Specifically into mem_init(), this is the last place crashkernel will be
able to reserve the memory before the page allocator kicks in. There
isn't any apparent reason for doing this earlier.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 095540667f0f..fc4ab0d6d5d2 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -386,8 +386,6 @@ void __init arm64_memblock_init(void)
 	else
 		arm64_dma32_phys_limit = PHYS_MASK + 1;
 
-	reserve_crashkernel();
-
 	reserve_elfcorehdr();
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
@@ -508,6 +506,8 @@ void __init mem_init(void)
 	else
 		swiotlb_force = SWIOTLB_NO_FORCE;
 
+	reserve_crashkernel();
+
 	set_max_mapnr(max_pfn - PHYS_PFN_OFFSET);
 
 #ifndef CONFIG_SPARSEMEM_VMEMMAP
-- 
2.29.0


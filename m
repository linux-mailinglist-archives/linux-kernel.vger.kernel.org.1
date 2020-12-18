Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC1A2DE77E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgLRQdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:33:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:48912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgLRQdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:33:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73BDFACC6;
        Fri, 18 Dec 2020 16:33:12 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     peng.fan@nxp.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mm: Fix ARCH_LOW_ADDRESS_LIMIT when !CONFIG_ZONE_DMA
Date:   Fri, 18 Dec 2020 17:33:07 +0100
Message-Id: <20201218163307.10150-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Systems configured with CONFIG_ZONE_DMA32, CONFIG_ZONE_NORMAL and
!CONFIG_ZONE_DMA will fail to properly setup ARCH_LOW_ADDRESS_LIMIT. The
limit will default to ~0ULL, effectively spanning the whole memory,
which is too high for a configuration that expects low memory to be
capped at 4GB.

Fix ARCH_LOW_ADDRESS_LIMIT by falling back to arm64_dma32_phys_limit
when arm64_dma_phys_limit isn't set. arm64_dma32_phys_limit will honour
CONFIG_ZONE_DMA32, or span the entire memory when not enabled.

Fixes: 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm64/include/asm/processor.h | 3 ++-
 arch/arm64/mm/init.c               | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index ca2cd75d3286..69ad25fbeae4 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -94,7 +94,8 @@
 #endif /* CONFIG_ARM64_FORCE_52BIT */
 
 extern phys_addr_t arm64_dma_phys_limit;
-#define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit - 1)
+extern phys_addr_t arm64_dma32_phys_limit;
+#define ARCH_LOW_ADDRESS_LIMIT	((arm64_dma_phys_limit ? : arm64_dma32_phys_limit) - 1)
 
 struct debug_info {
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 75addb36354a..7deddf56f7c3 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -59,7 +59,7 @@ EXPORT_SYMBOL(memstart_addr);
  * bit addressable memory area.
  */
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
-static phys_addr_t arm64_dma32_phys_limit __ro_after_init;
+phys_addr_t arm64_dma32_phys_limit __ro_after_init;
 
 #ifdef CONFIG_KEXEC_CORE
 /*
-- 
2.29.2


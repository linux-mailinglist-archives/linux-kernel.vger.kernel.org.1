Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D662F395F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406459AbhALTCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:02:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406358AbhALTCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:02:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E42E123123
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 19:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610478115;
        bh=CsKBwc8JRYTVpl6XBHHCcnBay+uzbIm+YDXT2KQwEbI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=I5f7kBhZStcBPLeDgqfnooQAVfHhkJP5deH8iH/QewusqxgSH/31EDeNj2SWHYs2R
         qK565IlxjpMvVwt1inTLVX5t0MpGLDMV6BseTdP/RMgR9crVOHe8hqy+yPhIhNg/l1
         VtFW6K4E2NLuTHLYVKpJcF74ztmROx7Dx13FrVNzzhzaWU15mds0GVNzD5TtagV+EY
         nrgf0nsSHA1Q0brUMoY2nRIrnvYOmwkWLOw+pWLeIFf4jTPhsGeL995Hp9q5BBYUn4
         i2UoHUQLqdnYQ3vBKlKRQEYvFGlm8W5hRNK+ofl2nSCUnagKJbzPtgBHs1miQy5boa
         R5xmmHBY5joVQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] habanalabs: prevent soft lockup during unmap
Date:   Tue, 12 Jan 2021 21:01:49 +0200
Message-Id: <20210112190149.11661-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210112190149.11661-1-ogabbay@kernel.org>
References: <20210112190149.11661-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using Deep learning framework such as tensorflow or pytorch, there
are tens of thousands of host memory mappings. When the user frees
all those mappings at the same time, the process of unmapping and
unpinning them can take a long time, which may cause a soft lockup
bug.

To prevent this, we need to free the core to do other things during
the unmapping process. For now, we chose to do it every 32K unmappings
(each unmap is a single 4K page).

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  1 +
 drivers/misc/habanalabs/common/memory.c     | 10 ++++++++--
 drivers/misc/habanalabs/common/mmu.c        |  6 +++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index e0d7f5fbaa5c..60e16dc4bcac 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2182,6 +2182,7 @@ void hl_mmu_v1_set_funcs(struct hl_device *hdev, struct hl_mmu_funcs *mmu);
 int hl_mmu_va_to_pa(struct hl_ctx *ctx, u64 virt_addr, u64 *phys_addr);
 int hl_mmu_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
 			struct hl_mmu_hop_info *hops);
+bool hl_is_dram_va(struct hl_device *hdev, u64 virt_addr);
 
 int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 				void __iomem *dst, u32 src_offset, u32 size);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index cbe9da4e0211..5d4fbdcaefe3 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -886,8 +886,10 @@ static void unmap_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 {
 	struct hl_device *hdev = ctx->hdev;
 	u64 next_vaddr, i;
+	bool is_host_addr;
 	u32 page_size;
 
+	is_host_addr = !hl_is_dram_va(hdev, vaddr);
 	page_size = phys_pg_pack->page_size;
 	next_vaddr = vaddr;
 
@@ -900,9 +902,13 @@ static void unmap_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 		/*
 		 * unmapping on Palladium can be really long, so avoid a CPU
 		 * soft lockup bug by sleeping a little between unmapping pages
+		 *
+		 * In addition, when unmapping host memory we pass through
+		 * the Linux kernel to unpin the pages and that takes a long
+		 * time. Therefore, sleep every 32K pages to avoid soft lockup
 		 */
-		if (hdev->pldm)
-			usleep_range(500, 1000);
+		if (hdev->pldm || (is_host_addr && (i & 0x7FFF) == 0))
+			usleep_range(50, 200);
 	}
 }
 
diff --git a/drivers/misc/habanalabs/common/mmu.c b/drivers/misc/habanalabs/common/mmu.c
index 33ae953d3a36..28a4638741d8 100644
--- a/drivers/misc/habanalabs/common/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu.c
@@ -9,7 +9,7 @@
 
 #include "habanalabs.h"
 
-static bool is_dram_va(struct hl_device *hdev, u64 virt_addr)
+bool hl_is_dram_va(struct hl_device *hdev, u64 virt_addr)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 
@@ -156,7 +156,7 @@ int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 	if (!hdev->mmu_enable)
 		return 0;
 
-	is_dram_addr = is_dram_va(hdev, virt_addr);
+	is_dram_addr = hl_is_dram_va(hdev, virt_addr);
 
 	if (is_dram_addr)
 		mmu_prop = &prop->dmmu;
@@ -236,7 +236,7 @@ int hl_mmu_map_page(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 	if (!hdev->mmu_enable)
 		return 0;
 
-	is_dram_addr = is_dram_va(hdev, virt_addr);
+	is_dram_addr = hl_is_dram_va(hdev, virt_addr);
 
 	if (is_dram_addr)
 		mmu_prop = &prop->dmmu;
-- 
2.25.1


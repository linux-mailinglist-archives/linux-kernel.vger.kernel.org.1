Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E122F24BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405090AbhALAZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:11 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47448 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404201AbhAKXrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610408850; x=1641944850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Io1Pp7bw+RC8AMMDpe1YABzZYAEHgEO0leECzsL7CUo=;
  b=AxJOahA3U9KDEXjIeQEzQSrwM0++rzAl6Rou3dMJ13MG/X+6wzAQJfy+
   8fETRLpIL3MMZGqJhMCIPje73e2rWoFmD9dk/XRvtSXMJHrbqOWIZ+VUD
   zI0AjbMIIIN1vtbdT0hpKr/uxi7iGUScEUfCXfLozZFx7UFtqNoQFODVO
   yxpUyz2YdzL0RKJkMcctEUCb747066YAbIrgoXgJyTrkXCP/o7E1uK16u
   BnFI55P9slVCkQZ9zzFcNM2DzizITkbVSCUgCtPnqKZrjGuFfS5LV44gh
   PJS8ig7WtNp2xVg5Kt4atL8zBc6g4vpDJD+d1Bg5nWpnvt51mlPn96kJR
   g==;
IronPort-SDR: IlIY8lPXgpOD/y6B2YZpnjtT7jRaR5gUt2+uyEiQzUeDf3a8KnenXA140RuhuwBWbBDIQDOdPf
 BUZNZFYtDsu2EERGe9rVRk1Ut+O//j0yigfI/cNim2doHCgNqo6jaLiAc7ZAFii+yoia3mbFss
 /OSQfA3LWViAY8nbSbipBpeJrMejjwAOfX6JiDZuDUSAZoHOoAy4V+GrbtLTx2IxnE2MC1Tmad
 XsGVVC+hLyfkEwnpFZNfjZcsFfrKbygD4x7wgMiDaBuvxSaI7WKroWqDncJ5QvieUVAzRS/sEi
 FNo=
X-IronPort-AV: E=Sophos;i="5.79,339,1602518400"; 
   d="scan'208";a="157190572"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 07:45:20 +0800
IronPort-SDR: KLMsq1jS897mCYt3+F2kZnLNCjdIGUH4K+VYLsD5fvISVF7ItLODvzgmrm4WEfq77VD2a3Kr2x
 Ew7Kg/g1PrQ3NYToicKOj2/eQKsn1ZjjrpSHH+MhIw2sZChNTFyyExQrmVDiK9GHEudXLSQXkg
 lrWDlMnGAvF/l0zpQCLDE7Na8fJSukHZNo9X03wy6p1NPULxRbozDx3JTFrDzsAaUV15E2o9MJ
 FrqwnD1VbX6keAFGbchLRxopgjRWMYiYOzdiID896AvGA9lxVi2633wfoWCsW8TUHziEGvsvS8
 vECN69Mn3HWrq9GuNVcXwJEh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 15:28:14 -0800
IronPort-SDR: ox38t4igJU0HZ0yuKw/XhjcfplepASAM4Swjrpnp6n6vw7ZypirIWOtHz0UmDIdPF9RtAITyO8
 +hBx6NYdR/CaTPR+Gi11KbHw+YZQVRLWaKSeqGuFNX1YVm8W83SIb+sqUEEInb0H0nD/HoecjS
 MTEYF2NATdI4+nLTlJ2MC3WJprR4XaR7eYkiHc6zB2UsP/WdwzKhFTW99qt7w/4uXOX6gdewmG
 XuDPYwEfN7zQw1X5o2WM1P8ofysAfLWfH6GJKsBBpIbSWBLCDgzsZdWfJv+ohqqh8wHzXY2VwG
 W/Y=
WDCIronportException: Internal
Received: from usa002483.ad.shared (HELO jedi-01.hgst.com) ([10.86.62.194])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 15:45:20 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2 2/4] RISC-V: Set current memblock limit
Date:   Mon, 11 Jan 2021 15:45:02 -0800
Message-Id: <20210111234504.3782179-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111234504.3782179-1-atish.patra@wdc.com>
References: <20210111234504.3782179-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, linux kernel can not use last 4k bytes of addressable space
because IS_ERR_VALUE macro treats those as an error. This will be an issue
for RV32 as any memblock allocator potentially allocate chunk of memory
from the end of DRAM (2GB) leading bad address error even though the
address was technically valid.

Fix this issue by limiting the memblock if available memory spans the
entire address space.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/init.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index bf5379135e39..7cd4993f4ff2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -157,9 +157,10 @@ static void __init setup_initrd(void)
 void __init setup_bootmem(void)
 {
 	phys_addr_t mem_start = 0;
-	phys_addr_t start, end = 0;
+	phys_addr_t start, dram_end, end = 0;
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
 	phys_addr_t vmlinux_start = __pa_symbol(&_start);
+	phys_addr_t max_mapped_addr = __pa(~(ulong)0);
 	u64 i;
 
 	/* Find the memory region containing the kernel */
@@ -181,7 +182,18 @@ void __init setup_bootmem(void)
 	/* Reserve from the start of the kernel to the end of the kernel */
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
-	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
+	dram_end = memblock_end_of_DRAM();
+
+	/*
+	 * memblock allocator is not aware of the fact that last 4K bytes of
+	 * the addressable memory can not be mapped because of IS_ERR_VALUE
+	 * macro. Make sure that last 4k bytes are not usable by memblock
+	 * if end of dram is equal to maximum addressable memory.
+	 */
+	if (max_mapped_addr == (dram_end - 1))
+		memblock_set_current_limit(max_mapped_addr - 4096);
+
+	max_pfn = PFN_DOWN(dram_end);
 	max_low_pfn = max_pfn;
 	dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));
 	set_max_mapnr(max_low_pfn);
-- 
2.25.1


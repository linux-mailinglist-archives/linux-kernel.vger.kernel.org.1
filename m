Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189E4280771
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732998AbgJATGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:06:09 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19201 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732981AbgJATGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601579168; x=1633115168;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ulQnabrQ3jIylqco3wGP6BdFDL6aVGXR3PWdQHcEP2w=;
  b=hh4DGE0HNqjV+I15ClShmzNjjRZRID9mt9l3uUxIcsFHfC9CR+IuNzIB
   1Rjn7Z+pHiRhLzck5CAx2hY+mpI+tXIHOnNvnwliGMJbyYqeLduT3durL
   QpuCtUp+v42I53TtkVheRK7avPso2czUDyU8na5SMsqoXl7gDbisdOXe9
   GrNKAESoxl74yXoVyRIKMoFzQhwPkzAsg7SKBv/yr3TKB1N+DkapNfNW3
   RyzlyyHegm07Vm4a7Hfb4HOVoHZh6bXOLyDdFW4hCkX7GeT46WYXGlAmC
   fRlhwSlHX7nmNRkchw2/i0vah4QCVQhPv4hcBvjkurTUa9a2EunEbD8Ej
   w==;
IronPort-SDR: nRW10HwRqpy34LWFKHb630lU+QeYe4O/8qM8RVYNHlCwFeAVtlOZppVdoXkpneA+13OI5KSfxX
 s3SFebRGaYIrDxnzQmMWPtwXlVTUmgxbUVoWtE0UKCB0ZdOqLi1O1QXB9SIWpXpWFJfucth+v5
 fXcSOdqMMq+nMV8ASeKBra3c/hBo3JuiUFA2DmsxW/Unn3mbbfqcQnFUcDjO4iMtJqTKvm3F2g
 7MwqBoImLSgj5aedLvqtSWDI2iDJMHSpcZ+rvIJvP+8TIADj7DVkbkaB0IY4wItvJTvs15QwCH
 7uA=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="148739978"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 03:06:00 +0800
IronPort-SDR: w1iQ4dMUuLMnOsuu8PwCTrOmadLwkRLA+zrLjj0MatJyH8oFFGWt2xXOoMACmLNtql/iavrhUW
 j1oJdcPpF3pw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:51:57 -0700
IronPort-SDR: mvbPBDuJNTR0nqO9Lt8qZ/T52jy0A+M4P5lzYhD22tEfN/14+jnWpZRem5hTJzK89KUjTP6zXy
 4Tdxnni4PDFQ==
WDCIronportException: Internal
Received: from 30tyk72.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.249])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 12:05:59 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v3] RISC-V: Remove any memblock representing unusable memory area
Date:   Thu,  1 Oct 2020 12:05:57 -0700
Message-Id: <20201001190557.2860741-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V limits the physical memory size by -PAGE_OFFSET. Any memory beyond
that size from DRAM start is unusable. Just remove any memblock pointing
to those memory region without worrying about computing the maximum size.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

---
Changes from v2->v3
Updated comment as per Mike's suggestion.
---
 arch/riscv/mm/init.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index ca03762a3733..564e0be677b7 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -146,8 +146,6 @@ static phys_addr_t dtb_early_pa __initdata;
 void __init setup_bootmem(void)
 {
 	struct memblock_region *reg;
-	phys_addr_t mem_size = 0;
-	phys_addr_t total_mem = 0;
 	phys_addr_t mem_start, end = 0;
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
 	phys_addr_t vmlinux_start = __pa_symbol(&_start);
@@ -155,21 +153,18 @@ void __init setup_bootmem(void)
 	/* Find the memory region containing the kernel */
 	for_each_memblock(memory, reg) {
 		end = reg->base + reg->size;
-		if (!total_mem)
+		if (!mem_start)
 			mem_start = reg->base;
 		if (reg->base <= vmlinux_start && vmlinux_end <= end)
 			BUG_ON(reg->size == 0);
-		total_mem = total_mem + reg->size;
 	}
 
 	/*
-	 * Remove memblock from the end of usable area to the
-	 * end of region
+	 * The maximal physical memory size is -PAGE_OFFSET.
+	 * Make sure that any memory beyond mem_start + (-PAGE_OFFSET) is removed
+	 * as it is unusable by kernel.
 	 */
-	mem_size = min(total_mem, (phys_addr_t)-PAGE_OFFSET);
-	if (mem_start + mem_size < end)
-		memblock_remove(mem_start + mem_size,
-				end - mem_start - mem_size);
+	memblock_enforce_memory_limit(mem_start - PAGE_OFFSET);
 
 	/* Reserve from the start of the kernel to the end of the kernel */
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
-- 
2.25.1


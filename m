Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B825E286A83
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 23:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgJGVwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 17:52:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:18796 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgJGVwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602107530; x=1633643530;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/oniEhso/26JSasHkIO1CiOAfMMzjz+yrKndXGJYt70=;
  b=UEV3JjLg6Zj+rQrcQVji/WSPpCr9wvJ6YE4ahE4K9szdS5vakmS+nxfk
   4+XwGtBhyI9Q0MYo8R6jA8lOGd3dTwvqeZti7u4glejZlrL7U3k45na5e
   tMC8Mprnm3ak1qC60/sZ9H2aN2851r+o7aquOmg86d3GRpuja26EgvwdY
   TPP9x9wGUdSmW61XPTfcU1pI/7Z5OoK6pJnR45t6hrBc6irDfVWc/57l9
   t32pJr9Ql4LqjUel2V5W0N1n1UXhgaSMcilyYtHUH6Ylozp6MME0BA4Eq
   A+DxfvyNE6E3CU7pmXF9ERuJg1KdSBUrvrUZj6ovlgdF6ELcXtOKZHcAt
   Q==;
IronPort-SDR: B1lRd0c2gCniF1MP3+KGyoSvDaW+yyeNKZAoTi8hppcxcVATGXl4MmxIUeQxhP7THgUYThvUdI
 NDGG2pYzfoRuqf80HPgXwN+v6E7izI9eoNyHyNyCVFM+aUvky1DiIioj+r4WwUBYoTe4P4Q1h0
 B2CGiJZKIThCzAaBia6l/2ja8A4Z8p7wosAveblAt6tH4wDWvU5/oKHnB8pRF54eCm1C08Jq/1
 agknYtFwUF0kfs/K3WV/kNJrMLon+COPuhb4OwreAGbRYORHK+rU80hIF/rooMFCG5PcnSBzXj
 35w=
X-IronPort-AV: E=Sophos;i="5.77,348,1596470400"; 
   d="scan'208";a="150516942"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2020 05:52:10 +0800
IronPort-SDR: ydK2G7FvMxT8CW3Nkw4Zr3VpYxxyaIv4Lp9T+rk6lWTQeEU6Bs/sSDrLXNRV/t33Uz/HRRpDXO
 XOrygZbnNKXQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 14:38:53 -0700
IronPort-SDR: RTUD36E2uQ6HTNvp95Nc4RYgHy3IZEnDnWXYqosV2EdlYL1oeBgiWSZWnD3sUoTup3xtIfelVs
 rKc9ml7jxhVg==
WDCIronportException: Internal
Received: from b9f8262.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.253])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Oct 2020 14:52:09 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v4] RISC-V: Remove any memblock representing unusable memory area
Date:   Wed,  7 Oct 2020 14:51:59 -0700
Message-Id: <20201007215159.1287602-1-atish.patra@wdc.com>
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
Changes from v3->v4:
1. Rebased on top of for-next.
---
 arch/riscv/mm/init.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4eda1a7e8521..da43c17544c5 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -156,9 +156,8 @@ static void __init setup_initrd(void)
 
 void __init setup_bootmem(void)
 {
-	phys_addr_t mem_size = 0;
-	phys_addr_t total_mem = 0;
-	phys_addr_t mem_start, start, end = 0;
+	phys_addr_t mem_start = 0;
+	phys_addr_t start, end = 0;
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
 	phys_addr_t vmlinux_start = __pa_symbol(&_start);
 	u64 i;
@@ -166,21 +165,18 @@ void __init setup_bootmem(void)
 	/* Find the memory region containing the kernel */
 	for_each_mem_range(i, &start, &end) {
 		phys_addr_t size = end - start;
-		if (!total_mem)
+		if (!mem_start)
 			mem_start = start;
 		if (start <= vmlinux_start && vmlinux_end <= end)
 			BUG_ON(size == 0);
-		total_mem = total_mem + size;
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


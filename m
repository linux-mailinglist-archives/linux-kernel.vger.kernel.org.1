Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A4326E998
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 01:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgIQXsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 19:48:19 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7161 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIQXsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 19:48:19 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 19:48:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600386498; x=1631922498;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NBBooLWx4dX/xQPDDaQE8cweQZvaQZMOQrLJFZ3y+F8=;
  b=OBLbyrq0WDJ3o1iriXKRzpSxV2wtqjUmLpiucxaPX1K0PdyUUcLMLtYM
   oFZcQexR9+kHSHz/7+s3wXAurkay3FxYHniXOYFtnYHeOjy4sTDinlXDD
   HL1YV8GJhXqs0GNkCei+VnI8i5MzgsdayKyjz1V8xh+nzanId4XRFCwpA
   TeOXjpIPcFUbRXnDCr1GqUCkPnxKNdXlWSEx6cQ+qVQTifC/RTX0XRDhb
   NnLjn8aa/gWP+AZmbGxZaX9sg7Ot1D5HQfwtWRkwIKOc9ktpHb1g2WiJX
   YsJmslM6j71zFaLWJ/DiNF9rb7QWybhMAWw1lUAopEBguJKxf7Ldu8Yvt
   g==;
IronPort-SDR: HfUd6SkO8FlvnknEWqFVfwQap0PGjsJOJy5HhkrriClTP3lS9QzpqTGKGGqkQuEkMh9DN1ZKK2
 1DMRAvJiu15eQwTiDdJEiybOlpoa1Q0UvVoHHKjNr6mAb6wrzUibo1MaWtvnjgaB3PNMejmva7
 2sPNDalJgznJXvDTQ6RH5q5NaZfXK3n515B1PpemRjztwcyBh5kqM3Z8nYm3QfigfOS6sSvgZu
 0X5+313QxlnRhQHvCFZoM3aNcWX4mPP5IKwtqkDm9L86wa2hkmv/TgsSyAqc0y/eXexrCNyVhK
 d/M=
X-IronPort-AV: E=Sophos;i="5.77,272,1596470400"; 
   d="scan'208";a="147686926"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2020 07:41:12 +0800
IronPort-SDR: 3x+HY9WmWXg1nve/XUN8wbJvpKagMDBY+axKiJ4d5LC9U0G/p5dr7EkgkuNGDWCjmKSeIJepG7
 BcSESe2nTgKA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 16:27:25 -0700
IronPort-SDR: AqIqh7onWLPTwrZYu9YWnVbKUodp27nHtfmGPfYmcgIhjqU7JYKDqG8BcMfwhGPkzpN2rbC4Nq
 EDgcRgO12Pgw==
WDCIronportException: Internal
Received: from use204338.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.39])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Sep 2020 16:41:11 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>, Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2] RISC-V: Remove any memblock representing unusable memory area
Date:   Thu, 17 Sep 2020 16:40:55 -0700
Message-Id: <20200917234055.2321977-1-atish.patra@wdc.com>
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
---
Changes from v1->v2:
Used memblock_enforce_memory_limit instead of memblock_remove without
computing the maximum memory size.
---
 arch/riscv/mm/init.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 787c75f751a5..ed6e83871112 100644
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
+	 * The maximum physical memory supported is -PAGE_OFFSET.
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


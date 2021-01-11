Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0282F24BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405078AbhALAZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:11 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38128 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404197AbhAKXrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610408825; x=1641944825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oZ32JyRr/0hov1ExpFgrBbBCQ8Msd+e4ScJeLBVGhAo=;
  b=hZkEm0hqB38LSuGgN8tMdCZDLZluo4u/2R/gFtBtAhxY/zxNbcV7EYrc
   BKqgdn3Gj768gS0l7xQNeQoGjMlw1iYkhIKJhPfd5Z9jM1AEZDvuEcvjv
   CzO8nC769XJGYUICKFGAKoUAB4ocSRspwhwnY9aioZlRQPmJ4rI8S3iNj
   BTwK0xHcOCiwWvyd0k2Rohkx8B8yHrvxaUxrOZyZxS1MwKMlH7r4X15jz
   VFwZxYLWqX8KJnWSf1O7PHvuiU0E+YaqidkG1bPDGSKTkTFyD8c+hDHGX
   R1hDVWnWAIxBXZL1cVqeBJrhoM0zR9l9rf+g83sRPLb6CnQCHS+SGB3z4
   A==;
IronPort-SDR: HdPtYY28sQ+SYd//sRbfSRf6Lnov0AexRvq9iqYXgRyuKI96tJbYw06hSSldYYuZEKim4RaHCW
 uUuevTQwBrWff/af53aiA702hG2isNt+MkuEV5X56qtNnNBT+PArfjuqh3rYoymCZfEkvRWEY6
 UfsNC07fGeAq9T93G9cQLSHWshmSdEEs0m7MQFGc1vOSGT3wRH6cLp/2b/lPofOjLn4pqdHsh+
 hFws7F8dpiP9V97YbxEfCNIo9/y9DdOa/O1TS2piIzZ++HYZDr3Uq2hPB1/QXT/wz/O+rT7t2/
 br0=
X-IronPort-AV: E=Sophos;i="5.79,339,1602518400"; 
   d="scan'208";a="157190570"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 07:45:19 +0800
IronPort-SDR: IYtMAHpSW2Uhop3PGeqDjii12Ae7Z9+xNWsE1pMM/VibhDYO6XV6NEMBWBD8leLqeHSjCEqkWk
 K3RGD7hOP4DVMhxu2XiSFRL/E39ECCncUTof97zZGB72J3EW+Ud1zAwWsMdJJ7dHAEGVFwE4wk
 k9pa/CnCYG4F+cWP0Qetb4jsL9QCDgQ1Cc7URBNv2AsQ0guC0XKRD4vLPpFaeG1hCJ4hCdMa7x
 XJeSEA6OtLshWLJcDVShLvIk7D9RzKRni4CeFjteG3VV2AyhyaaKA9Y1YtpZwaemx0FlSdkGlX
 jAPuy7IKPeHSDkU4d8hQynIK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 15:28:13 -0800
IronPort-SDR: JGAiHmoKynGPRy8l4SeqkvGkhiqKA9dy8OgqjlzdySKCZqlN+fM35WStMKIu/dQcHvAYEBREKx
 vrrLSQEwSqCV1oG1Ga+TJiuHFmBK8gv2uCTC4MRL4c7R6PjsJGRhDosYmDStYKfzH0oiSXV1Dw
 3DrShXs2GtwtlCOBk/fC6zHdqnPtXapj4pdfCaIDHSITwRLVHnhDja3zu8QLqYzcnCXSk+evex
 qNi5d4QynM9trXGsrADNHKZyJWUiTpOb0AxYLTJw6ee3OYgzmMLF5ap0TfphnjpN82/9l1VpA2
 trY=
WDCIronportException: Internal
Received: from usa002483.ad.shared (HELO jedi-01.hgst.com) ([10.86.62.194])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 15:45:20 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2 1/4] RISC-V: Do not allocate memblock while iterating reserved memblocks
Date:   Mon, 11 Jan 2021 15:45:01 -0800
Message-Id: <20210111234504.3782179-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111234504.3782179-1-atish.patra@wdc.com>
References: <20210111234504.3782179-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, resource tree allocates memory blocks while iterating on the
list. It leads to following kernel warning because memblock allocation
also invokes memory block reservation API.

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/resource.c:795
__insert_resource+0x8e/0xd0
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
5.10.0-00022-ge20097fb37e2-dirty #549
[    0.000000] epc: c00125c2 ra : c001262c sp : c1c01f50
[    0.000000]  gp : c1d456e0 tp : c1c0a980 t0 : ffffcf20
[    0.000000]  t1 : 00000000 t2 : 00000000 s0 : c1c01f60
[    0.000000]  s1 : ffffcf00 a0 : ffffff00 a1 : c1c0c0c4
[    0.000000]  a2 : 80c12b15 a3 : 80402000 a4 : 80402000
[    0.000000]  a5 : c1c0c0c4 a6 : 80c12b15 a7 : f5faf600
[    0.000000]  s2 : c1c0c0c4 s3 : c1c0e000 s4 : c1009a80
[    0.000000]  s5 : c1c0c000 s6 : c1d48000 s7 : c1613b4c
[    0.000000]  s8 : 00000fff s9 : 80000200 s10: c1613b40
[    0.000000]  s11: 00000000 t3 : c1d4a000 t4 : ffffffff

This is also unnecessary as we can pre-compute the total memblocks required
for each memory region and allocate it before the loop. It save precious
boot time not going through memblock allocation code every time.

Fixes: 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")

Reviewed-by: Anup Patel <anup@brainfault.org>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/setup.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 1d85e9bf783c..3fa3f26dde85 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -127,7 +127,9 @@ static void __init init_resources(void)
 {
 	struct memblock_region *region = NULL;
 	struct resource *res = NULL;
-	int ret = 0;
+	struct resource *mem_res = NULL;
+	size_t mem_res_sz = 0;
+	int ret = 0, i = 0;
 
 	code_res.start = __pa_symbol(_text);
 	code_res.end = __pa_symbol(_etext) - 1;
@@ -145,16 +147,17 @@ static void __init init_resources(void)
 	bss_res.end = __pa_symbol(__bss_stop) - 1;
 	bss_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 
+	mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt) * sizeof(*mem_res);
+	mem_res = memblock_alloc(mem_res_sz, SMP_CACHE_BYTES);
+	if (!mem_res)
+		panic("%s: Failed to allocate %zu bytes\n", __func__, mem_res_sz);
 	/*
 	 * Start by adding the reserved regions, if they overlap
 	 * with /memory regions, insert_resource later on will take
 	 * care of it.
 	 */
 	for_each_reserved_mem_region(region) {
-		res = memblock_alloc(sizeof(struct resource), SMP_CACHE_BYTES);
-		if (!res)
-			panic("%s: Failed to allocate %zu bytes\n", __func__,
-			      sizeof(struct resource));
+		res = &mem_res[i++];
 
 		res->name = "Reserved";
 		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
@@ -171,8 +174,10 @@ static void __init init_resources(void)
 		 * Ignore any other reserved regions within
 		 * system memory.
 		 */
-		if (memblock_is_memory(res->start))
+		if (memblock_is_memory(res->start)) {
+			memblock_free((phys_addr_t) res, sizeof(struct resource));
 			continue;
+		}
 
 		ret = add_resource(&iomem_resource, res);
 		if (ret < 0)
@@ -181,10 +186,7 @@ static void __init init_resources(void)
 
 	/* Add /memory regions to the resource tree */
 	for_each_mem_region(region) {
-		res = memblock_alloc(sizeof(struct resource), SMP_CACHE_BYTES);
-		if (!res)
-			panic("%s: Failed to allocate %zu bytes\n", __func__,
-			      sizeof(struct resource));
+		res = &mem_res[i++];
 
 		if (unlikely(memblock_is_nomap(region))) {
 			res->name = "Reserved";
@@ -205,9 +207,9 @@ static void __init init_resources(void)
 	return;
 
  error:
-	memblock_free((phys_addr_t) res, sizeof(struct resource));
 	/* Better an empty resource tree than an inconsistent one */
 	release_child_resources(&iomem_resource);
+	memblock_free((phys_addr_t) mem_res, mem_res_sz);
 }
 
 
-- 
2.25.1


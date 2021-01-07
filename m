Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5EE2ECCC7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbhAGJ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:29:16 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58328 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbhAGJ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610011755; x=1641547755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HZSbgxwC4YIGgbIv1CVEHDpNY53JBS2SY0k5ZL1SxFM=;
  b=GYiWZ5R9L8W+cdRXKg2hquPTeL3+udLt6ZoLnISEGUxh3BI3sTEj/ipi
   Y2zW4R33wOE/AnkE31pJS70inxoZpIp2TFup4/1zrux7p1HBQ1JQGZZmA
   uOfc9aiEhHEJGIQjJfkbrz/ihxg8e5frcAgk2A+CW1EleE904u+ezrGVg
   7D07a/CvphJ38XPlOC9sEnN1ncUVW/OYborwgFBEbMxlZRZhz5mn0suV6
   /bU6k0gBmmz2WsT228WVjxqIDRD0f1GUREqOKj+KkPwJ2QNRXcfiMOWXG
   +6qAzSmhRH6GFqBcDbso2vKxH7QJkeTGiPCkVCivrbVYy5jXE59mv3u8B
   g==;
IronPort-SDR: 3HQrcmpqn8e+f30FaqWRXa7DfYv58HvnX4KkEbxLZb2e+wYhBrUr/79V2aPYQBqjwbKjQ/AGSZ
 990rfjWha+MAzsOQMHq5YfwD9BJaY+mTiKGzgiwHt3J1TxPmHh73NlaH1ShZ/kdQy4LBDrqZdg
 mC3EmAz1PVxEnWv7tzJGqKipw+m5o2jU5iht2FLtz9Y0X2HuGHXMWHHz7d4Xbrkrabuxb49gm3
 HqRtQaPerS3ORme1gt2QljV98UY5yaBz5jwPK/s1WYSrTDwmC0NBqqpkTKdAfNTyw5oKXW1mIm
 NUQ=
X-IronPort-AV: E=Sophos;i="5.79,329,1602518400"; 
   d="scan'208";a="156695567"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2021 17:27:29 +0800
IronPort-SDR: vL4WCw2EnlZh0RI+cgbBRGXDYHr3y/Z82SMuPMS49w3ebtdNX4evo9Y/3EaZEXLOKUy8v4VIbt
 XN0ECrjat/U7F8vKVVaDCdHUXP1SrIeGtnn/9Xj9BqhXyprGT0bI2bkkTAzg42lQ08VFNSsPxU
 yFmeTk81L2jrlLbin/TyjiclZ9KqgWWq0Mu2B2pvQmX6QwqW+Ir4JcvJf+gerkGFqvIDuPViYN
 Ofw6R37IXPQvLAR067j/gk5DGEReiw4C1XCe7GIdyGafjCkYir2CgX5AA/Wx1rsZlWT7KtGG3D
 3dpJGkm8E/KVpS9hnJRxVeCy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 01:12:21 -0800
IronPort-SDR: kLjln25qDdG41vstcY7mxJThPxVXQ/G2dXUPRPrEz9UusObiazDjcJWc4TGnfb78oBBRrAekYv
 fMAAxVLqu30wqz8KSo7SSDLnGGvWvJ6ERVRwjPOoBs9aGEUYf8TszF9EozC23jrGSNALnWwpwE
 3aaM3Tc5VSM1ABuLJmiF+3Bk5xyeZ9T/qfF+g6XGvQJ3UbtvKcEKk4DbaT3XrkXZvbnahQauLJ
 vnXDruup40/3utsPciFdH+xPcMI17iYVnjhzwioPMhRAbvqtBu8YwVC0hfyfQJ6mdl23Qrf46y
 XSA=
WDCIronportException: Internal
Received: from usa002483.ad.shared (HELO jedi-01.hgst.com) ([10.86.62.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jan 2021 01:27:29 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH 1/4] RISC-V: Do not allocate memblock while iterating reserved memblocks
Date:   Thu,  7 Jan 2021 01:26:49 -0800
Message-Id: <20210107092652.3438696-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107092652.3438696-1-atish.patra@wdc.com>
References: <20210107092652.3438696-1-atish.patra@wdc.com>
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


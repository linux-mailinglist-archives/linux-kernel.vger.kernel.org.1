Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9135F27AAB7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgI1J1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:27:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbgI1J1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:27:05 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 10E3F171D3C77CA7B15C;
        Mon, 28 Sep 2020 17:27:04 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 17:26:54 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/2] ARM: decompressor: relax the loading restriction of the decompressed kernel
Date:   Mon, 28 Sep 2020 17:26:41 +0800
Message-ID: <20200928092641.2070-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200928092641.2070-1-thunder.leizhen@huawei.com>
References: <20200928092641.2070-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mov	r4, pc
and	r4, r4, #0xf8000000	//truncated to 128MiB boundary
add	r4, r4, #TEXT_OFFSET	//PA(_start)

Currently, the decompressed kernel must be placed at the position: 128MiB
boundary + TEXT_OFFSET. This limitation is just because we masked PC with
0xf80000000. Actually, we can directly obtain PA(_start) by using formula
: VA(_start) + (PHYS_OFFSET - PAGE_OFFSET).

So the "PA(_start) - TEXT_OFFSET" can be 2MiB boundary, 1MiB boundary,
and so on.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/boot/compressed/head.S | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 434a16982e344fe..e5ba2ad2ea4700f 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -255,26 +255,16 @@ not_angel:
 
 #ifdef CONFIG_AUTO_ZRELADDR
 		/*
-		 * Find the start of physical memory.  As we are executing
-		 * without the MMU on, we are in the physical address space.
-		 * We just need to get rid of any offset by aligning the
-		 * address.
-		 *
-		 * This alignment is a balance between the requirements of
-		 * different platforms - we have chosen 128MB to allow
-		 * platforms which align the start of their physical memory
-		 * to 128MB to use this feature, while allowing the zImage
-		 * to be placed within the first 128MB of memory on other
-		 * platforms.  Increasing the alignment means we place
-		 * stricter alignment requirements on the start of physical
-		 * memory, but relaxing it means that we break people who
-		 * are already placing their zImage in (eg) the top 64MB
-		 * of this range.
+		 * Find ZRELADDR (Address where the decompressed kernel was
+		 * placed, usually == PHYS_OFFSET + TEXT_OFFSET). That's the
+		 * start physical address of the text section, PA(_start).
+		 * As we are executing without the MMU on, we are in the
+		 * physical address space.
 		 */
-		mov	r4, pc
-		and	r4, r4, #0xf8000000
-		/* Determine final kernel image address. */
-		add	r4, r4, #TEXT_OFFSET
+		adr	r0, LC2
+		ldmia	r0, {r3-r4}
+		sub	r3, r0, r3		@ PHYS_OFFSET - PAGE_OFFSET
+		add	r4, r4, r3		@ PA(_start)
 #else
 		ldr	r4, =zreladdr
 #endif
@@ -660,6 +650,11 @@ LC1:		.word	.L_user_stack_end - LC1	@ sp
 		.word	_edata - LC1		@ r6
 		.size	LC1, . - LC1
 
+		.align	2
+		.type	LC2, #object
+LC2:		.word	LC2
+		.word	_start			@ start VA of text section
+
 .Lheadroom:
 		.word	_end - restart + 16384 + 1024*1024
 
-- 
1.8.3



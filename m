Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599742E77B6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 11:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgL3KRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 05:17:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10011 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgL3KRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 05:17:54 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D5Ryc0ffHzj1Hp;
        Wed, 30 Dec 2020 18:16:24 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 30 Dec 2020 18:17:05 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <ardb@kernel.org>, <akpm@linux-foundation.org>,
        <nsaenzjulienne@suse.de>, <rppt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>
Subject: [PATCH v2 3/3] arm64: mm: reserve CMA and crashkernel in ZONE_DMA if enabled
Date:   Wed, 30 Dec 2020 18:23:22 +0800
Message-ID: <20201230102322.176313-4-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201230102322.176313-1-chenzhou10@huawei.com>
References: <20201230102322.176313-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, CMA and crashkernel are reserved in ZONE_DMA32, which
is OK for majority of devices. But the ones that need them in ZONE_DMA
need to configure it explicitly.

Since patchset "arm64: Default to 32-bit wide ZONE_DMA", ZONE_DMA's
size is fine-tuned. So we could directly reserve CMA and crashkernel
in ZONE_DMA if CONFIG_ZONE_DMA is enabled, otherwise, reserving in
ZONE_DMA32.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Suggested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm64/mm/init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 64a0e8f551d6..26de149b21c7 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -85,7 +85,8 @@ static void __init reserve_crashkernel(void)
 
 	if (crash_base == 0) {
 		/* Current arm64 boot protocol requires 2MB alignment */
-		crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
+		crash_base = memblock_find_in_range(0,
+				arm64_dma_phys_limit ? : arm64_dma32_phys_limit,
 				crash_size, SZ_2M);
 		if (crash_base == 0) {
 			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
@@ -443,7 +444,7 @@ void __init bootmem_init(void)
 	 */
 	reserve_crashkernel();
 
-	dma_contiguous_reserve(arm64_dma32_phys_limit);
+	dma_contiguous_reserve(arm64_dma_phys_limit ? : arm64_dma32_phys_limit);
 
 	memblock_dump_all();
 }
-- 
2.20.1


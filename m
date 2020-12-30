Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBE42E77B8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 11:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgL3KR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 05:17:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9661 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgL3KRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 05:17:55 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D5Ryb5s2Xz15kbL;
        Wed, 30 Dec 2020 18:16:23 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 30 Dec 2020 18:17:03 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <ardb@kernel.org>, <akpm@linux-foundation.org>,
        <nsaenzjulienne@suse.de>, <rppt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>
Subject: [PATCH v2 1/3] arm64: mm: update the comments about ZONE_DMA
Date:   Wed, 30 Dec 2020 18:23:20 +0800
Message-ID: <20201230102322.176313-2-chenzhou10@huawei.com>
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

Since patchset "arm64: Default to 32-bit wide ZONE_DMA", ZONE_DMA's
size is fine-tuned. In the absence of addressing limited masters,
ZONE_DMA will span the whole 32-bit address space, otherwise, in
the case of the Raspberry Pi 4, it'll only span the 30-bit address
space. Update the comments.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm64/mm/init.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 75addb36354a..7b9809e39927 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -53,10 +53,11 @@ s64 memstart_addr __ro_after_init = -1;
 EXPORT_SYMBOL(memstart_addr);
 
 /*
- * We create both ZONE_DMA and ZONE_DMA32. ZONE_DMA covers the first 1G of
- * memory as some devices, namely the Raspberry Pi 4, have peripherals with
- * this limited view of the memory. ZONE_DMA32 will cover the rest of the 32
- * bit addressable memory area.
+ * We create both ZONE_DMA and ZONE_DMA32. ZONE_DMA's size is fine-tuned.
+ * In the absence of addressing limited masters, ZONE_DMA will span the
+ * whole 32-bit address space, otherwise, in the case of the Raspberry Pi 4,
+ * it'll only span the 30-bit address space. ZONE_DMA32 will cover the rest
+ * of the 32 bit addressable memory area.
  */
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 static phys_addr_t arm64_dma32_phys_limit __ro_after_init;
-- 
2.20.1


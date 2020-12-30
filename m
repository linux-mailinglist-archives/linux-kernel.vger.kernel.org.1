Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67652E77B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 11:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgL3KR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 05:17:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9662 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgL3KRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 05:17:55 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D5Ryb5cjZz15jxr;
        Wed, 30 Dec 2020 18:16:23 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 30 Dec 2020 18:17:04 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <ardb@kernel.org>, <akpm@linux-foundation.org>,
        <nsaenzjulienne@suse.de>, <rppt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>
Subject: [PATCH v2 2/3] arm64: mm: move dma_contiguous_reserve() to bootmem_init()
Date:   Wed, 30 Dec 2020 18:23:21 +0800
Message-ID: <20201230102322.176313-3-chenzhou10@huawei.com>
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

Like crashkernel, CMA might also reserve memory located in ZONE_DMA,
so move dma_contiguous_reserve() to bootmem_init() to make sure that
arm64_dma_phys_limit is populated.

Just place dma_contiguous_reserve() after reserve_crashkernel() as
before.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Suggested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm64/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 7b9809e39927..64a0e8f551d6 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -403,8 +403,6 @@ void __init arm64_memblock_init(void)
 	reserve_elfcorehdr();
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
-
-	dma_contiguous_reserve(arm64_dma32_phys_limit);
 }
 
 void __init bootmem_init(void)
@@ -445,6 +443,8 @@ void __init bootmem_init(void)
 	 */
 	reserve_crashkernel();
 
+	dma_contiguous_reserve(arm64_dma32_phys_limit);
+
 	memblock_dump_all();
 }
 
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB0D2E77B9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 11:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgL3KR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 05:17:57 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9660 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgL3KRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 05:17:55 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D5Ryb5Mp3z15YX4;
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
Subject: [PATCH v2 0/3] arm64: mm: reserve CMA and crashkernel in ZONE_DMA if enabled 
Date:   Wed, 30 Dec 2020 18:23:19 +0800
Message-ID: <20201230102322.176313-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
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

Patch 1 updates the comments about the ZONE_DMA.
Patch 2 move dma_contiguous_reserve() to bootmem_init()
Patch 3 reserve CMA and crashkernel in ZONE_DMA if enabled

Changes since v1:
- Add Reviewed-by for patch 1 from Nicolas.
- Suggested by Nicolas, also reserve CMA in ZONE_DMA if enabled.

Chen Zhou (3):
  arm64: mm: update the comments about ZONE_DMA
  arm64: mm: move dma_contiguous_reserve() to bootmem_init()
  arm64: mm: reserve CMA and crashkernel in ZONE_DMA if enabled

 arch/arm64/mm/init.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.20.1


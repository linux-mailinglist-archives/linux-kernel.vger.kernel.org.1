Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243E5234E48
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 01:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGaXOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 19:14:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51930 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbgGaXOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:14:04 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 96E5CE463A56E57665E3;
        Sat,  1 Aug 2020 07:14:02 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.125) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Sat, 1 Aug 2020 07:13:55 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <will@kernel.org>, <ganapatrao.kulkarni@cavium.com>,
        <catalin.marinas@arm.com>
CC:     <iommu@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>, <huangdaode@huawei.com>,
        <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v5 2/2] arm64: mm: reserve per-numa CMA to localize coherent dma buffers
Date:   Sat, 1 Aug 2020 11:11:19 +1200
Message-ID: <20200731231119.10416-3-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200731231119.10416-1-song.bao.hua@hisilicon.com>
References: <20200731231119.10416-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.125]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, smmu is using dma_alloc_coherent() to get memory to save queues
and tables. Typically, on ARM64 server, there is a default CMA located at
node0, which could be far away from node2, node3 etc.
with this patch, smmu will get memory from local numa node to save command
queues and page tables. that means dma_unmap latency will be shrunk much.
Meanwhile, when iommu.passthrough is on, device drivers which call dma_
alloc_coherent() will also get local memory and avoid the travel between
numa nodes.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 arch/arm64/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index b6881d61b818..a6e19145ebb3 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -437,6 +437,8 @@ void __init bootmem_init(void)
 	arm64_hugetlb_cma_reserve();
 #endif
 
+	dma_pernuma_cma_reserve();
+
 	memblock_dump_all();
 }
 
-- 
2.27.0



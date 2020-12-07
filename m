Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FF52D0D23
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgLGJgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:36:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52127 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725770AbgLGJgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:36:46 -0500
X-UUID: 409aee5ba71640c3a4ec31d2a59bce0b-20201207
X-UUID: 409aee5ba71640c3a4ec31d2a59bce0b-20201207
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 128335919; Mon, 07 Dec 2020 17:36:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Dec 2020 17:35:57 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Dec 2020 17:35:56 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>
Subject: [PATCH v2] iommu: Improve the performance for direct_mapping
Date:   Mon, 7 Dec 2020 17:35:53 +0800
Message-ID: <20201207093553.8635-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently direct_mapping always use the smallest pgsize which is SZ_4K
normally to mapping. This is unnecessary. we could gather the size, and
call iommu_map then, iommu_map could decide how to map better with the
just right pgsize.

From the original comment, we should take care overlap, otherwise,
iommu_map may return -EEXIST. In this overlap case, we should map the
previous region before overlap firstly. then map the left part.

Each a iommu device will call this direct_mapping when its iommu
initialize, This patch is effective to improve the boot/initialization
time especially while it only needs level 1 mapping.

Signed-off-by: Anan Sun <anan.sun@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
change notes:
v2: Refine the code flow.
v1: https://lore.kernel.org/linux-iommu/20201120090628.6566-1-yong.wu@mediatek.com/
base on v5.10-rc1.
---
 drivers/iommu/iommu.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c470f451a32..1a91decb95fa 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -737,6 +737,7 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 	/* We need to consider overlapping regions for different devices */
 	list_for_each_entry(entry, &mappings, list) {
 		dma_addr_t start, end, addr;
+		size_t map_size = 0;
 
 		if (domain->ops->apply_resv_region)
 			domain->ops->apply_resv_region(dev, domain, entry);
@@ -748,16 +749,27 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 		    entry->type != IOMMU_RESV_DIRECT_RELAXABLE)
 			continue;
 
-		for (addr = start; addr < end; addr += pg_size) {
+		for (addr = start; addr <= end; addr += pg_size) {
 			phys_addr_t phys_addr;
 
+			if (addr == end)
+				goto map_end;
+
 			phys_addr = iommu_iova_to_phys(domain, addr);
-			if (phys_addr)
+			if (!phys_addr) {
+				map_size += pg_size;
 				continue;
+			}
 
-			ret = iommu_map(domain, addr, addr, pg_size, entry->prot);
-			if (ret)
-				goto out;
+map_end:
+			if (map_size) {
+				ret = iommu_map(domain, addr - map_size,
+						addr - map_size, map_size,
+						entry->prot);
+				if (ret)
+					goto out;
+				map_size = 0;
+			}
 		}
 
 	}
-- 
2.18.0


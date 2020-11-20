Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AC82BA579
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgKTJHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:07:18 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:35188 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726701AbgKTJHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:07:17 -0500
X-UUID: d44ab65c4cb644f39c8bfc2208586de6-20201120
X-UUID: d44ab65c4cb644f39c8bfc2208586de6-20201120
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1967541814; Fri, 20 Nov 2020 17:07:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 Nov 2020 17:07:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 Nov 2020 17:07:10 +0800
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
Subject: [PATCH] iommu: Improve the performance for direct_mapping
Date:   Fri, 20 Nov 2020 17:06:28 +0800
Message-ID: <20201120090628.6566-1-yong.wu@mediatek.com>
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
 drivers/iommu/iommu.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index df87c8e825f7..854a8fcb928d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -737,6 +737,7 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 	/* We need to consider overlapping regions for different devices */
 	list_for_each_entry(entry, &mappings, list) {
 		dma_addr_t start, end, addr;
+		size_t unmapped_sz = 0;
 
 		if (domain->ops->apply_resv_region)
 			domain->ops->apply_resv_region(dev, domain, entry);
@@ -752,10 +753,25 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 			phys_addr_t phys_addr;
 
 			phys_addr = iommu_iova_to_phys(domain, addr);
-			if (phys_addr)
+			if (phys_addr == 0) {
+				unmapped_sz += pg_size; /* Gather the size. */
 				continue;
+			}
 
-			ret = iommu_map(domain, addr, addr, pg_size, entry->prot);
+			if (unmapped_sz) {
+				/* Map the region before the overlap. */
+				ret = iommu_map(domain, start, start,
+						unmapped_sz, entry->prot);
+				if (ret)
+					goto out;
+				start += unmapped_sz;
+				unmapped_sz = 0;
+			}
+			start += pg_size;
+		}
+		if (unmapped_sz) {
+			ret = iommu_map(domain, start, start, unmapped_sz,
+					entry->prot);
 			if (ret)
 				goto out;
 		}
-- 
2.18.0


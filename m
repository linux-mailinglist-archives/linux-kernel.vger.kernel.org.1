Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842942D3CCE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgLIIEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:04:38 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:50360 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727720AbgLIIEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:04:25 -0500
X-UUID: 711a3382d9ae4e35adb8b2637ae0397b-20201209
X-UUID: 711a3382d9ae4e35adb8b2637ae0397b-20201209
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1396262683; Wed, 09 Dec 2020 16:03:43 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Dec 2020 16:03:38 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Dec 2020 16:03:41 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>
Subject: [PATCH v5 15/27] iommu/mediatek: Add fail handle for sysfs_add and device_register
Date:   Wed, 9 Dec 2020 16:00:50 +0800
Message-ID: <20201209080102.26626-16-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201209080102.26626-1-yong.wu@mediatek.com>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fail handle for iommu_device_sysfs_add and iommu_device_register.

Fixes: b16c0170b53c ("iommu/mediatek: Make use of iommu_device_register interface")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 39478cfbe0f1..09c8c58feb78 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -746,7 +746,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 
 	ret = iommu_device_register(&data->iommu);
 	if (ret)
-		return ret;
+		goto out_sysfs_remove;
 
 	spin_lock_init(&data->tlb_lock);
 	list_add_tail(&data->list, &m4ulist);
@@ -754,7 +754,16 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (!iommu_present(&platform_bus_type))
 		bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
 
-	return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
+	ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
+	if (ret)
+		goto out_dev_unreg;
+	return ret;
+
+out_dev_unreg:
+	iommu_device_unregister(&data->iommu);
+out_sysfs_remove:
+	iommu_device_sysfs_remove(&data->iommu);
+	return ret;
 }
 
 static int mtk_iommu_remove(struct platform_device *pdev)
-- 
2.18.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749CC2B8B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgKSGTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:19:24 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40215 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgKSGTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:19:24 -0500
X-UUID: 83c82368deb24aa7914bdd595376d73a-20201119
X-UUID: 83c82368deb24aa7914bdd595376d73a-20201119
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2069203104; Thu, 19 Nov 2020 14:19:19 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 Nov 2020 14:19:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 Nov 2020 14:19:16 +0800
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
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <jun.wen@mediatek.com>
Subject: [PATCH v2 5/6] iommu/mediatek: Enable granule_ignore for unmap
Date:   Thu, 19 Nov 2020 14:18:35 +0800
Message-ID: <20201119061836.15238-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201119061836.15238-1-yong.wu@mediatek.com>
References: <20201119061836.15238-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek IOMMU HW don't care about granule when it flush tlb.
In order to flush tlb once when unmap, Enable this flag to gather all
the iova chunk of unmap.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 8c2d4a225666..94786860bd84 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -432,6 +432,7 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
+	gather->granule_ignore = true;
 	return dom->iop->unmap(dom->iop, iova, size, gather);
 }
 
-- 
2.18.0


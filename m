Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A24A2B8B87
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgKSGSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:18:50 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39577 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgKSGSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:18:50 -0500
X-UUID: c867fb6f2b3f4e09acb102905d195901-20201119
X-UUID: c867fb6f2b3f4e09acb102905d195901-20201119
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1304192711; Thu, 19 Nov 2020 14:18:44 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 Nov 2020 14:18:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 Nov 2020 14:18:42 +0800
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
Subject: [PATCH v2 0/6] MediaTek IOMMU improve tlb flush performance in map/unmap
Date:   Thu, 19 Nov 2020 14:18:30 +0800
Message-ID: <20201119061836.15238-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is to improve tlb flushing performance in iommu_map/unmap
for MediaTek IOMMU.

For iommu_map, currently MediaTek IOMMU use IO_PGTABLE_QUIRK_TLBI_ON_MAP
to do tlb_flush for each a memory chunk. this is so unnecessary. we could
improve it by tlb flushing one time at the end of iommu_map.

For iommu_unmap, currently we have already improve this performance by
gather. But the current gather should take care its granule size. if the
granule size is different, it will do tlb flush and gather again. Our HW
don't care about granule size. thus I add a flag(granule_ignore) for this
case.

After this patchset, we could achieve only tlb flushing once in iommu_map
and iommu_unmap.

Regardless of sg, for each a segment, I did a simple test:
  
  size = 20 * SZ_1M;
  /* the worst case, all are 4k mapping. */
  ret = iommu_map(domain, 0x5bb02000, 0x123f1000, size, IOMMU_READ);
  iommu_unmap(domain, 0x5bb02000, size);

This is the comparing time(unit is us):
              original-time  after-improve
   map-20M    59943           2347
   unmap-20M  264             36

This patchset also flush tlb once in the iommu_map_sg case.

patch [1/6][2/6][3/6] are for map while the others are for unmap.

change note:
v2: Refactor all the code.
    base on v5.10-rc1.

v1: https://lore.kernel.org/linux-iommu/20201019113100.23661-1-chao.hao@mediatek.com/

Yong Wu (6):
  iommu: Move iotlb_sync_map out from __iommu_map
  iommu: Add iova and size as parameters in iommu_iotlb_map
  iommu/mediatek: Add iotlb_sync_map to sync whole the iova range
  iommu: Add granule_ignore when tlb gather
  iommu/mediatek: Enable granule_ignore for unmap
  iommu/mediatek: Convert tlb_flush_walk to gather_add_page

 drivers/iommu/iommu.c      | 24 +++++++++++++++++++-----
 drivers/iommu/mtk_iommu.c  | 32 ++++++++++++++++++++++++++------
 drivers/iommu/tegra-gart.c |  3 ++-
 include/linux/iommu.h      |  7 +++++--
 4 files changed, 52 insertions(+), 14 deletions(-)

-- 
2.18.0



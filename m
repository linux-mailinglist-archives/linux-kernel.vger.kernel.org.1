Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3E62DBEC4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 11:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgLPKhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 05:37:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33909 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726143AbgLPKg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 05:36:59 -0500
X-UUID: cc3bd593fb8b4318ba4878f0f99a0b23-20201216
X-UUID: cc3bd593fb8b4318ba4878f0f99a0b23-20201216
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 436696254; Wed, 16 Dec 2020 18:36:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Dec 2020 18:36:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Dec 2020 18:36:11 +0800
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
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>
Subject: [PATCH v3 0/7] MediaTek IOMMU improve tlb flush performance in map/unmap
Date:   Wed, 16 Dec 2020 18:36:00 +0800
Message-ID: <20201216103607.23050-1-yong.wu@mediatek.com>
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
don't care about granule size. thus I gather the range in our file.

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

patch [1/7][2/7][3/7] are for map while the others are for unmap.

This patchset base on:
  a) mt8192 iommu v5
https://lore.kernel.org/linux-iommu/20201209080102.26626-1-yong.wu@mediatek.com/T/#t
  b) iommu/io-pgtable: Remove tlb_flush_leaf
https://lore.kernel.org/linux-iommu/160744101816.3622130.16266834943434854326.b4-ty@kernel.org/T/#mc8fbc98bee8bca865d73c873275ab34fed1c25c7

change note:
v3: Refactor the unmap flow suggested by Robin.
     
v2: https://lore.kernel.org/linux-iommu/20201119061836.15238-1-yong.wu@mediatek.com/
    Refactor all the code.
    base on v5.10-rc1.

Yong Wu (7):
  iommu: Move iotlb_sync_map out from __iommu_map
  iommu: Add iova and size as parameters in iotlb_sync_map
  iommu/mediatek: Add iotlb_sync_map to sync whole the iova range
  iommu: Switch gather->end to unsigned long long
  iommu: Allow io_pgtable_tlb ops optional
  iommu/mediatek: Gather iova in iommu_unmap to achieve tlb sync once
  iommu/mediatek: Remove the tlb-ops for v7s

 drivers/iommu/iommu.c      | 24 +++++++++++++++-----
 drivers/iommu/mtk_iommu.c  | 45 +++++++++++++++-----------------------
 drivers/iommu/tegra-gart.c |  3 ++-
 include/linux/io-pgtable.h |  8 ++++---
 include/linux/iommu.h      |  8 ++++---
 5 files changed, 49 insertions(+), 39 deletions(-)

-- 
2.18.0



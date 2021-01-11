Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD72F1106
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbhAKLUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:20:12 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43750 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728318AbhAKLUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:20:11 -0500
X-UUID: e4e974fdc73441cebd2fa83495b0f4ff-20210111
X-UUID: e4e974fdc73441cebd2fa83495b0f4ff-20210111
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 22183689; Mon, 11 Jan 2021 19:19:27 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:19:22 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:19:22 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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
Subject: [PATCH v6 00/33] MT8192 IOMMU support
Date:   Mon, 11 Jan 2021 19:18:41 +0800
Message-ID: <20210111111914.22211-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch mainly adds support for mt8192 Multimedia IOMMU and SMI.

mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
table format. The M4U-SMI HW diagram is as below:

                          EMI
                           |
                          M4U
                           |
                      ------------
                       SMI Common
                      ------------
                           |
  +-------+------+------+----------------------+-------+
  |       |      |      |       ......         |       |
  |       |      |      |                      |       |
larb0   larb1  larb2  larb4     ......      larb19   larb20
disp0   disp1   mdp    vdec                   IPE      IPE

All the connections are HW fixed, SW can NOT adjust it.

Comparing with the preview SoC, this patchset mainly adds two new functions:
a) add iova 34 bits support.
b) add multi domains support since several HW has the special iova
region requirement.

change note:
v6:a) base on v5.11-rc1. and tlb v4:
      https://lore.kernel.org/linux-mediatek/20210107122909.16317-1-yong.wu@mediatek.com/T/#t 
   b) Remove the "domain id" definition in the binding header file.
      Get the domain from dev->dma_range_map.
      After this, Change many codes flow.
   c) the patchset adds a new common file(mtk_smi-larb-port.h).
      This version changes that name into mtk-memory-port.h which reflect 
      its file path. This only changes the file name. no other change.
      thus I keep all the Reviewed-by Tags.
      (another reason is that we will add some iommu ports unrelated with
       smi-larb)
   d) Refactor the power-domain flow suggestted by Tomasz.
   e) Some other small fix. use different oas for different soc; Change the
   macro for 34bit iova tlb flush.

v5: https://lore.kernel.org/linux-iommu/20201209080102.26626-1-yong.wu@mediatek.com/
    a) Add a new patch for the header guard for smi-larb-port.h in [5/27].
    b) Add a new patch for error handle for iommu_device_sysfs_add and
 iommu_device_register[15/27].
    c) Add a flag for the iova "ias == 34" case. the previous SoC still keep
 32bits to save 16KB*3 lvl1 pgtable memory[13/27].
    d) Add include <linux/bitfield.h> for FIELD_GET build fail.
    e) In PM power domain patch, add a checking "pm_runtime_enabled" when call
 pm_runtime_get_sync for non power-domain case. and add a pm_runtime_put_noidle
 while pm_runtime_get_sync fail case.

v4: https://lore.kernel.org/linux-iommu/20201111123838.15682-1-yong.wu@mediatek.com/
  a) rebase on v5.10-rc1
  b) Move the smi part to a independent patchset.
  c) Improve v7s code from Robin and Will.
  d) Add a mediatek iommu entry patch in MAINTAIN.

v3: https://lore.kernel.org/linux-iommu/20200930070647.10188-1-yong.wu@mediatek.com/
  a) Fix DT schema issue commented from Rob.
  b) Fix a v7s issue. Use "_lvl" instead of "_l" in the macro(ARM_V7S_PTES_PER_LVL) since 
  it is called in ARM_V7S_LVL_IDX which has already used "_l".
  c) Fix a PM suspend issue: Avoid pm suspend in pm runtime case.

v2: https://lore.kernel.org/linux-iommu/20200905080920.13396-1-yong.wu@mediatek.com/
  a) Convert IOMMU/SMI dt-binding to DT schema.
  b) Fix some comment from Pi-Hsun and Nicolas. like use
  generic_iommu_put_resv_regions.
  c) Reword some comment, like add how to use domain-id.

v1: https://lore.kernel.org/linux-iommu/20200711064846.16007-1-yong.wu@mediatek.com/

Yong Wu (33):
  dt-bindings: iommu: mediatek: Convert IOMMU to DT schema
  dt-bindings: memory: mediatek: Add a common memory header file
  dt-bindings: memory: mediatek: Extend LARB_NR_MAX to 32
  dt-bindings: memory: mediatek: Rename header guard for SMI header file
  dt-bindings: mediatek: Add binding for mt8192 IOMMU
  of/device: Move dma_range_map before of_iommu_configure
  iommu: Avoid reallocate default domain for a group
  iommu/mediatek: Use the common mtk-memory-port.h
  iommu/io-pgtable-arm-v7s: Use ias to check the valid iova in unmap
  iommu/io-pgtable-arm-v7s: Extend PA34 for MediaTek
  iommu/io-pgtable-arm-v7s: Clarify LVL_SHIFT/BITS macro
  iommu/io-pgtable-arm-v7s: Add cfg as a param in some macros
  iommu/io-pgtable-arm-v7s: Quad lvl1 pgtable for MediaTek
  iommu/mediatek: Add a flag for iova 34bits case
  iommu/mediatek: Update oas for v7s
  iommu/mediatek: Move hw_init into attach_device
  iommu/mediatek: Add error handle for mtk_iommu_probe
  iommu/mediatek: Add device link for smi-common and m4u
  iommu/mediatek: Add pm runtime callback
  iommu/mediatek: Add power-domain operation
  iommu/mediatek: Support up to 34bit iova in tlb flush
  iommu/mediatek: Support report iova 34bit translation fault in ISR
  iommu/mediatek: Adjust the structure
  iommu/mediatek: Move domain_finalise into attach_device
  iommu/mediatek: Move geometry.aperture updating into domain_finalise
  iommu/mediatek: Add iova_region structure
  iommu/mediatek: Add get_domain_id from dev->dma_range_map
  iommu/mediatek: Support for multi domains
  iommu/mediatek: Add iova reserved function
  iommu/mediatek: Support master use iova over 32bit
  iommu/mediatek: Remove unnecessary check in attach_device
  iommu/mediatek: Add mt8192 support
  MAINTAINERS: Add entry for MediaTek IOMMU

 .../bindings/iommu/mediatek,iommu.txt         | 105 -----
 .../bindings/iommu/mediatek,iommu.yaml        | 183 +++++++++
 MAINTAINERS                                   |   9 +
 drivers/iommu/io-pgtable-arm-v7s.c            |  56 +--
 drivers/iommu/iommu.c                         |   3 +-
 drivers/iommu/mtk_iommu.c                     | 366 ++++++++++++++----
 drivers/iommu/mtk_iommu.h                     |  12 +-
 drivers/memory/mtk-smi.c                      |   8 +
 drivers/of/device.c                           |   3 +-
 include/dt-bindings/memory/mt2701-larb-port.h |   4 +-
 include/dt-bindings/memory/mt2712-larb-port.h |   6 +-
 include/dt-bindings/memory/mt6779-larb-port.h |   6 +-
 include/dt-bindings/memory/mt8167-larb-port.h |   6 +-
 include/dt-bindings/memory/mt8173-larb-port.h |   6 +-
 include/dt-bindings/memory/mt8183-larb-port.h |   6 +-
 include/dt-bindings/memory/mt8192-larb-port.h | 243 ++++++++++++
 include/dt-bindings/memory/mtk-memory-port.h  |  15 +
 include/linux/io-pgtable.h                    |   4 +-
 include/soc/mediatek/smi.h                    |   3 +-
 19 files changed, 810 insertions(+), 234 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
 create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
 create mode 100644 include/dt-bindings/memory/mtk-memory-port.h

-- 
2.18.0



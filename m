Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778432D844D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 05:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438126AbgLLENT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 23:13:19 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:38987 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2438041AbgLLEMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 23:12:55 -0500
X-UUID: ae8caa889a4b48009cdf03b6d2b6f2de-20201212
X-UUID: ae8caa889a4b48009cdf03b6d2b6f2de-20201212
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1996836764; Sat, 12 Dec 2020 12:12:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 12 Dec 2020 12:12:01 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 12 Dec 2020 12:12:00 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v2, 00/17] drm/mediatek: add support for mediatek SOC MT8192
Date:   Sat, 12 Dec 2020 12:11:40 +0800
Message-ID: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on 5.10-rc1 and provid 17 patch
to support mediatek SOC MT8192

Changes in v2:
- base mmsys
https://patchwork.kernel.org/project/linux-mediatek/cover/1607506379-10998-1-git-send-email-yongqiang.niu@mediatek.com/
- base mt8192 gce dtbinding file
https://patchwork.kernel.org/project/linux-mediatek/patch/1607141728-17307-2-git-send-email-yongqiang.niu@mediatek.com/
- add dt-bindings description for post mask
- add dt-bindings description for mt8192 display
- fix some comment in v1
- add mt8192 mmsys function call

Changes in v1:
- add some more ddp component
- add mt8192 mmsys support
- add ovl mount on support
- add 2 more clock into mutex device
- fix ovl smi_id_en and fb null software bug
- fix ddp compoent size config bug
- add mt8192 drm support
- add ddp bypass shadow register function
- add 8192 dts description

Yongqiang Niu (17):
  dt-bindings: mediatek: add description for postmask
  dt-bindings: mediatek: add CLK_MM_DISP_CONFIG control description for
    mt8192 display
  dt-bindings: mediatek: add description for mt8192 display
  drm/mediatek: add component OVL_2L2
  drm/mediatek: add component POSTMASK
  drm/mediatek: add component RDMA4
  drm/mediatek: add disp config and mm 26mhz clock into mutex device
  drm/mediatek: enable OVL_LAYER_SMI_ID_EN for multi-layer usecase
  drm/mediatek: check if fb is null
  drm/mediatek: fix aal size config
  drm/mediatek: fix dither size config
  drm/mediatek: fix gamma size config
  drm/mediatek: fix ccorr size config
  soc: mediatek: mmsys: Use function call for setting mmsys ovl mout
    register
  soc: mediatek: mmsys: add mt8192 mmsys support
  drm/mediatek: add support for mediatek SOC MT8192
  arm64: dts: mt8192: add display node

 .../bindings/display/mediatek/mediatek,disp.txt    |   6 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi           | 130 +++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_color.c          |   6 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |  34 +++++-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |   6 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             |  84 +++++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  50 +++++++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  48 ++++++++
 drivers/soc/mediatek/mmsys/Makefile                |   1 +
 drivers/soc/mediatek/mmsys/mt8192-mmsys.c          | 119 +++++++++++++++++++
 drivers/soc/mediatek/mmsys/mtk-mmsys.c             |  18 +++
 include/linux/soc/mediatek/mtk-mmsys.h             |   7 ++
 13 files changed, 496 insertions(+), 14 deletions(-)
 create mode 100644 drivers/soc/mediatek/mmsys/mt8192-mmsys.c

-- 
1.8.1.1.dirty


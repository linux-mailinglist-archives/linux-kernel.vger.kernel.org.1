Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51F52F0D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbhAKHoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:44:44 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:36036 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727283AbhAKHon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:44:43 -0500
X-UUID: 3dc67136ad5d4e48b333a4ec52266c16-20210111
X-UUID: 3dc67136ad5d4e48b333a4ec52266c16-20210111
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1224801398; Mon, 11 Jan 2021 15:43:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 15:43:55 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 15:43:55 +0800
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v3, 00/15] drm/mediatek: add support for mediatek SOC MT8192
Date:   Mon, 11 Jan 2021 15:43:36 +0800
Message-ID: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on 5.11-rc1 and SoC MT8183,
and provide 15 patch to support mediatek SOC MT8192

Changes since v2:
- fix review comment in v2
- add pm runtime for gamma and color 
- move ddp path select patch to mmsys series
- remove some useless patch

Yongqiang Niu (15):
  dt-bindings: mediatek: add description for postmask
  dt-bindings: mediatek: add description for mt8192 display
  arm64: dts: mt8192: add display node
  drm/mediatek: add component OVL_2L2
  drm/mediatek: add component POSTMASK
  drm/mediatek: add component RDMA4
  drm/mediatek: enable OVL_LAYER_SMI_ID_EN for multi-layer usecase
  drm/mediatek: check if fb is null
  drm/mediatek: Add pm runtime support for gamma
  drm/mediatek: Add pm runtime support for color
  drm/mediatek: fix aal size config
  drm/mediatek: separate ccorr module
  drm/mediatek: add matrix bits private data for ccorr
  drm/mediatek: add DDP support for MT8192
  drm/mediatek: add support for mediatek SOC MT8192

 .../bindings/display/mediatek/mediatek,disp.txt    |   3 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi           | 134 +++++++++++
 drivers/gpu/drm/mediatek/Makefile                  |   4 +-
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c          | 245 +++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_color.c          |   5 +
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c          |   5 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |  34 ++-
 drivers/gpu/drm/mediatek/mtk_disp_postmask.c       | 161 ++++++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |   6 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             |  35 +++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  98 +--------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  52 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   2 +
 14 files changed, 687 insertions(+), 98 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_postmask.c

-- 
1.8.1.1.dirty


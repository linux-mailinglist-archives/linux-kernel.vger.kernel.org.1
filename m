Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E0F2B54D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 00:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgKPXO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 18:14:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbgKPXO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:14:28 -0500
Received: from DESKTOP-GFFITBK.localdomain (218-161-90-76.HINET-IP.hinet.net [218.161.90.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C5F2223D;
        Mon, 16 Nov 2020 23:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605568467;
        bh=5Dwq9VBI7Qs1RjpdmmRJuv1bZLk0Qmz9ychYpZvyTz8=;
        h=From:To:Cc:Subject:Date:From;
        b=ZjkrxrG8i6i+0j7nlXNNPusw9X0ikl4bP8wr87301wagkaDHaitCXfJmZEGtUDDFB
         D7ydI/NfwuqWlzDJjmolw8+ff+hE3P2qPxPZ2QKrOm3en0xIHvkatGfaZP3E9u0Bhh
         pHvbJprD06r37dVpkZ8OyGmwBI6LTq/k7QiOH/sw=
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [RESEND PATCH 0/3] Move Mediatek MIPI DSI PHY driver from DRM folder to PHY folder
Date:   Tue, 17 Nov 2020 07:14:04 +0800
Message-Id: <20201116231407.94-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_mipi_dsi_phy is currently placed inside mediatek drm driver, but it's
more suitable to place a phy driver into phy driver folder, so move
mtk_mipi_dsi_phy driver into phy driver folder.

Chun-Kuang Hu (3):
  drm/mediatek: Separate mtk_mipi_tx to an independent module
  phy: mediatek: Move mtk_mipi_dsi_phy driver into drivers/phy/mediatek
    folder
  MAINTAINERS: add files for Mediatek DRM drivers

 MAINTAINERS                                                | 1 +
 drivers/gpu/drm/mediatek/Kconfig                           | 1 +
 drivers/gpu/drm/mediatek/Makefile                          | 3 ---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                     | 1 -
 drivers/gpu/drm/mediatek/mtk_drm_drv.h                     | 1 -
 drivers/phy/mediatek/Kconfig                               | 7 +++++++
 drivers/phy/mediatek/Makefile                              | 5 +++++
 .../mediatek/phy-mtk-mipi-dsi-mt8173.c}                    | 2 +-
 .../mediatek/phy-mtk-mipi-dsi-mt8183.c}                    | 2 +-
 .../mtk_mipi_tx.c => phy/mediatek/phy-mtk-mipi-dsi.c}      | 5 ++++-
 .../mtk_mipi_tx.h => phy/mediatek/phy-mtk-mipi-dsi.h}      | 0
 11 files changed, 20 insertions(+), 8 deletions(-)
 rename drivers/{gpu/drm/mediatek/mtk_mt8173_mipi_tx.c => phy/mediatek/phy-mtk-mipi-dsi-mt8173.c} (99%)
 rename drivers/{gpu/drm/mediatek/mtk_mt8183_mipi_tx.c => phy/mediatek/phy-mtk-mipi-dsi-mt8183.c} (99%)
 rename drivers/{gpu/drm/mediatek/mtk_mipi_tx.c => phy/mediatek/phy-mtk-mipi-dsi.c} (97%)
 rename drivers/{gpu/drm/mediatek/mtk_mipi_tx.h => phy/mediatek/phy-mtk-mipi-dsi.h} (100%)

-- 
2.17.1


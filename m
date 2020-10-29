Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F1729EFD4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgJ2P2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:28:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbgJ2P1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:27:54 -0400
Received: from DESKTOP-GFFITBK.localdomain (218-161-90-76.HINET-IP.hinet.net [218.161.90.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7F2E206F4;
        Thu, 29 Oct 2020 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603985273;
        bh=5Dwq9VBI7Qs1RjpdmmRJuv1bZLk0Qmz9ychYpZvyTz8=;
        h=From:To:Cc:Subject:Date:From;
        b=aUc0qQBvuDFYnjIMpiu0ud1L8YbtRoaWvwBA4Cpx2ZaGdlxa0Wvux37wNwqvRymUP
         vnQPcq1hpkqVgGnTYIM/o1T97V4UbpyO/DmmdT7iT3RnBxW7u8o/mkBmHIvve4iEND
         A63kVVBJpthPyCxew7wgDk942dv+oXuTTKhf7oAg=
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 0/3] Move Mediatek MIPI DSI PHY driver from DRM folder to PHY folder
Date:   Thu, 29 Oct 2020 23:26:59 +0800
Message-Id: <20201029152702.533-1-chunkuang.hu@kernel.org>
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


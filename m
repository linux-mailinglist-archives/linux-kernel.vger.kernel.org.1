Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424CC2EC6B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 00:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbhAFXST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 18:18:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbhAFXSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 18:18:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC14023332;
        Wed,  6 Jan 2021 23:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609975058;
        bh=vKhyMmIuw4dVwfOPSyfNwOpSYaEo7Zn9XZymkFCSHQU=;
        h=From:To:Cc:Subject:Date:From;
        b=h41X+2ABQGKohRVdjEt2dYr3etneeWKi9iNfXaPDBQFjBuflnIYSmANx9OQf+8t87
         RbI1Jr+VAtYTytEu92EVPbgRebX5SuoygMEHw8sZGDMpYWA6ICzTE7PK7vYEr9c6bP
         zj00b4vPMiJ2ovmsYqYgoE1Yl8b90qULYrS8P+7LyBb2ll1d+SKBprgDTL0NfYx5jO
         tPGb5MLJV7kxIVinQ4gCfB8RJAPcMmSTpVLsaqXWDj6K+28me7F+qVnlOqO+mEqhGo
         Xg86qtucp1LJ0lxKC+rgcI+j3a03+tWjU+4zh6/lTJrZRpPfBM+UyFx6RKftdgkZ6V
         FcfTAfLpHzxIg==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v2 0/5] Share mtk mutex driver for both DRM and MDP
Date:   Thu,  7 Jan 2021 07:17:24 +0800
Message-Id: <20210106231729.17173-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk mutex is a driver used by DRM and MDP [1], so this series move
mtk mutex driver from DRM folder to soc folder, so it could be used
by DRM and MDP.

Changes in v2:
1. Rebase onto mediatek-drm-next [2].
2. Export symbol for mtk-mutex API.

[1] https://patchwork.kernel.org/patch/11140751/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/log/?h=mediatek-drm-next

CK Hu (5):
  drm/mediatek: Remove redundant file including
  drm/mediatek: Rename file mtk_drm_ddp to mtk_mutex
  drm/mediatek: Change disp/ddp term to mutex in mtk mutex driver
  drm/mediatek: Automatically search unclaimed mtk mutex in
    mtk_mutex_get()
  soc / drm: mediatek: Move mtk mutex driver to soc folder

 drivers/gpu/drm/mediatek/Makefile             |   1 -
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |  32 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h        |  28 --
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   3 -
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   1 -
 drivers/soc/mediatek/Makefile                 |   1 +
 .../mediatek/mtk-mutex.c}                     | 328 +++++++++---------
 include/linux/soc/mediatek/mtk-mutex.h        |  26 ++
 8 files changed, 212 insertions(+), 208 deletions(-)
 delete mode 100644 drivers/gpu/drm/mediatek/mtk_drm_ddp.h
 rename drivers/{gpu/drm/mediatek/mtk_drm_ddp.c => soc/mediatek/mtk-mutex.c} (53%)
 create mode 100644 include/linux/soc/mediatek/mtk-mutex.h

-- 
2.17.1


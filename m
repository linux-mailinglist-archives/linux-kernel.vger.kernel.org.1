Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB02DF2C8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 03:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgLTChw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 21:37:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbgLTChv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 21:37:51 -0500
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 0/5] Share mtk mutex driver for both DRM and MDP
Date:   Sun, 20 Dec 2020 10:36:50 +0800
Message-Id: <20201220023655.30795-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk mutex is a driver used by DRM and MDP [1], so this series move
mtk mutex driver from DRM folder to soc folder, so it could be used
by DRM and MDP.

This series based on linux-next next-20201218 [2]

[1] https://patchwork.kernel.org/patch/11140751/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=next-20201218

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
 .../mediatek/mtk-mutex.c}                     | 317 +++++++++---------
 include/linux/soc/mediatek/mtk-mutex.h        |  26 ++
 8 files changed, 201 insertions(+), 208 deletions(-)
 delete mode 100644 drivers/gpu/drm/mediatek/mtk_drm_ddp.h
 rename drivers/{gpu/drm/mediatek/mtk_drm_ddp.c => soc/mediatek/mtk-mutex.c} (54%)
 create mode 100644 include/linux/soc/mediatek/mtk-mutex.h

-- 
2.17.1


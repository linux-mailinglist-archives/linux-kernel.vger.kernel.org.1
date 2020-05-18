Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E331D874D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 20:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgERRjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 13:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgERRjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:39:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581A2C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:39:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 614452A0C85
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Cc:     narmstrong@baylibre.com, a.hajda@samsung.com,
        boris.brezillon@collabora.com, laurent.pinchart@ideasonboard.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [RESEND PATCH 0/3] Convert mtk-dpi to drm_bridge API
Date:   Mon, 18 May 2020 19:39:06 +0200
Message-Id: <20200518173909.2259259-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason for this resend is because I forget to add some bridge
maintainers. So adding them and collect the actual tags.

The mtk-dpi driver still uses the drm_encoder API which is now somewhat
deprecated. We started to move all the Mediatek drivers to the drm_bridge API,
like we did for the mtk-dsi driver [1], this is another small step to be able to
fully convert the DRM Mediatek drivers to the drm_bridge API. A dummy
drm_encoder is maintained in the mtk-dpi driver but the end goal is move all the
dummy drm_encoder (mtk-dsi, mtk-dpi, etc) to the main mtk_drm_drv driver.

[1] https://lore.kernel.org/patchwork/project/lkml/list/?series=441559


Enric Balletbo i Serra (3):
  drm/mediatek: mtk_dpi: Rename bridge to next_bridge
  drm/mediatek: mtk_dpi: Convert to bridge driver
  drm/mediatek: mtk_dpi: Use simple encoder

 drivers/gpu/drm/mediatek/mtk_dpi.c | 84 ++++++++++++++----------------
 1 file changed, 39 insertions(+), 45 deletions(-)

-- 
2.26.2


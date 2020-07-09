Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1CA219E68
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 12:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgGIKzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 06:55:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57194 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgGIKzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:55:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id EF41C2A6383
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Cc:     narmstrong@baylibre.com, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org, a.hajda@samsung.com,
        boris.brezillon@collabora.com, laurent.pinchart@ideasonboard.com,
        sam@ravnborg.org, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/2] Convert mtk-dpi to drm_bridge API
Date:   Thu,  9 Jul 2020 12:54:59 +0200
Message-Id: <20200709105501.1465636-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtk-dpi driver still uses the drm_encoder API which is now somewhat
deprecated. We started to move all the Mediatek drivers to the drm_bridge API,
like we did for the mtk-dsi driver [1], this is another small step to be able to
fully convert the DRM Mediatek drivers to the drm_bridge API. A dummy
drm_encoder is maintained in the mtk-dpi driver but the end goal is move all the
dummy drm_encoder (mtk-dsi, mtk-dpi, etc) to the main mtk_drm_drv driver.

[1] https://lore.kernel.org/patchwork/project/lkml/list/?series=441559

Changes in v2:
- Maintain error message when attach to bridge fails. (Boris)
- Drop the third patch.

Enric Balletbo i Serra (2):
  drm/mediatek: mtk_dpi: Rename bridge to next_bridge
  drm/mediatek: mtk_dpi: Convert to bridge driver

 drivers/gpu/drm/mediatek/mtk_dpi.c | 77 +++++++++++++++++-------------
 1 file changed, 45 insertions(+), 32 deletions(-)

-- 
2.27.0


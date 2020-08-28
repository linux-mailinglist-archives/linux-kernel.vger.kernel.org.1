Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF01625594D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 13:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgH1LZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 07:25:18 -0400
Received: from vps.xff.cz ([195.181.215.36]:37914 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbgH1LY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1598613887; bh=v6vwqjlQVjAwBtNJBEWlutEj4KTBBjU4D4rsUlgzXqE=;
        h=From:To:Cc:Subject:Date:From;
        b=T0Lb7AqUQwuKpKxGUr18AG0ZbMbTYK5V5hNDxOWWpo3BCtI2rtPdfvsI2KF8A4DBB
         +SYE8pEkXBeiqn026A1KgfZgKl68yaf2PXHHozlgl7SJXflps3OpkWcV/39i/Q6g6u
         ywrIox9b2qCqrvR0ikmW0sNmLTxvQcK728IjaT88=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ALLWINNER
        A10),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/sun4i: Fix dsi dcs long write function
Date:   Fri, 28 Aug 2020 13:24:44 +0200
Message-Id: <20200828112444.916455-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's writing too much data. regmap_bulk_write expects number of
register sized chunks to write, not a byte sized length of the
bounce buffer. Bounce buffer needs to be padded too, so that
regmap_bulk_write will not read past the end of the buffer.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 7f13f4d715bf..840fad1b68dd 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -889,7 +889,7 @@ static int sun6i_dsi_dcs_write_long(struct sun6i_dsi *dsi,
 	regmap_write(dsi->regs, SUN6I_DSI_CMD_TX_REG(0),
 		     sun6i_dsi_dcs_build_pkt_hdr(dsi, msg));
 
-	bounce = kzalloc(msg->tx_len + sizeof(crc), GFP_KERNEL);
+	bounce = kzalloc(msg->tx_len + sizeof(crc) + 3, GFP_KERNEL);
 	if (!bounce)
 		return -ENOMEM;
 
@@ -900,7 +900,7 @@ static int sun6i_dsi_dcs_write_long(struct sun6i_dsi *dsi,
 	memcpy((u8 *)bounce + msg->tx_len, &crc, sizeof(crc));
 	len += sizeof(crc);
 
-	regmap_bulk_write(dsi->regs, SUN6I_DSI_CMD_TX_REG(1), bounce, len);
+	regmap_bulk_write(dsi->regs, SUN6I_DSI_CMD_TX_REG(1), bounce, DIV_ROUND_UP(len, 4));
 	regmap_write(dsi->regs, SUN6I_DSI_CMD_CTL_REG, len + 4 - 1);
 	kfree(bounce);
 
-- 
2.28.0


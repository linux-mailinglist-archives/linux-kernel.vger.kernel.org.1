Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29122B1B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKMMhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:37:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54258 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMMhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:37:52 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kdYKn-0000Dr-Kq; Fri, 13 Nov 2020 12:37:45 +0000
From:   Colin King <colin.king@canonical.com>
To:     Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/kmb: fix potential integer overflow on multiplication
Date:   Fri, 13 Nov 2020 12:37:45 +0000
Message-Id: <20201113123745.36799-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a potential integer overflow when multiplying various sized
integers that are cast to u32 integers using u32 multiplication and
then assigning the result to a u64. Fix this by casting MIPI_TX_BPP
to a u64 to force the multiplication to use u64 math and hence avoid
any potential overflows.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: 98521f4d4b4c ("drm/kmb: Mipi DSI part of the display driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/kmb/kmb_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
index 4b5d82af84b3..6c3081356bd9 100644
--- a/drivers/gpu/drm/kmb/kmb_dsi.c
+++ b/drivers/gpu/drm/kmb/kmb_dsi.c
@@ -1369,7 +1369,7 @@ int kmb_dsi_mode_set(struct kmb_dsi *kmb_dsi, struct drm_display_mode *mode,
 	 */
 	data_rate = ((((u32)mode->crtc_vtotal *	(u32)mode->crtc_htotal) *
 			(u32)(drm_mode_vrefresh(mode)) *
-			MIPI_TX_BPP) / mipi_tx_init_cfg.active_lanes) /	1000000;
+			(u64)MIPI_TX_BPP) / mipi_tx_init_cfg.active_lanes) / 1000000;
 
 	dev_dbg(kmb_dsi->dev, "data_rate=%u active_lanes=%d\n",
 		(u32)data_rate, mipi_tx_init_cfg.active_lanes);
-- 
2.28.0


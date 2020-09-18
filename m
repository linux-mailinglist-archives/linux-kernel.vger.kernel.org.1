Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFAC27015A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIRPvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:51:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43152 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRPvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:51:43 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kJIfg-00061Y-B1; Fri, 18 Sep 2020 15:51:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH][next] drm/panel: fix null pointer dereference on pointer mode
Date:   Fri, 18 Sep 2020 16:51:36 +0100
Message-Id: <20200918155136.28958-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently a null pointer check on pointer mode is passing mode to
function drm_mode_vrefresh and this causes a null pointer dereference
on mode.  Fix this by not calling drm_mode_vrefresh since the call
is only required for error reporting.

Addresses-Coverity: ("Dereference after null check")
Fixes: 72967d5616d3 ("drm/panel: Add panel driver for the Mantix MLAF057WE51-X DSI panel")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
index 3482e28e30fc..be4761a643f9 100644
--- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
+++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
@@ -202,9 +202,8 @@ static int mantix_get_modes(struct drm_panel *panel,
 
 	mode = drm_mode_duplicate(connector->dev, &default_mode);
 	if (!mode) {
-		dev_err(ctx->dev, "Failed to add mode %ux%u@%u\n",
-			default_mode.hdisplay, default_mode.vdisplay,
-			drm_mode_vrefresh(mode));
+		dev_err(ctx->dev, "Failed to add mode %ux%u\n",
+			default_mode.hdisplay, default_mode.vdisplay);
 		return -ENOMEM;
 	}
 
-- 
2.27.0


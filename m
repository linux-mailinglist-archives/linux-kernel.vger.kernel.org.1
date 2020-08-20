Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2394424BA9A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 14:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgHTMNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 08:13:18 -0400
Received: from crapouillou.net ([89.234.176.41]:47078 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728432AbgHTMNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597925583; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cvfqokvJjJRDHqpcvn1CFRGBXyq8hxfGePqgX0+Z6F4=;
        b=LtgwUm8buWv6hWZGys+DG4WS+MDEUISCg4IkvO42mHToB8Om6L8FH1GoNE7FiVHQz5OE64
        83BvSojIvNK8F6W7nWrV0e4fCRN/HZFgrQZWfwRf9yWYoIYbWISJLCTeesCeqTrhfrYUSB
        KCj7cQB361s8B6qI4s6KzFYDvTo9tkc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/2] drm/panel: novatek,nt39016: Reorder calls in probe
Date:   Thu, 20 Aug 2020 14:12:55 +0200
Message-Id: <20200820121256.32037-2-paul@crapouillou.net>
In-Reply-To: <20200820121256.32037-1-paul@crapouillou.net>
References: <20200820121256.32037-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_panel_of_backlight() function must be called after
drm_panel_init(), according to the function's documentation; otherwise
the backlight won't be properly initialized.

v2: New patch

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-novatek-nt39016.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
index 39f7be679da5..daa583030246 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
@@ -285,6 +285,9 @@ static int nt39016_probe(struct spi_device *spi)
 		return PTR_ERR(panel->map);
 	}
 
+	drm_panel_init(&panel->drm_panel, dev, &nt39016_funcs,
+		       DRM_MODE_CONNECTOR_DPI);
+
 	err = drm_panel_of_backlight(&panel->drm_panel);
 	if (err) {
 		if (err != -EPROBE_DEFER)
@@ -292,9 +295,6 @@ static int nt39016_probe(struct spi_device *spi)
 		return err;
 	}
 
-	drm_panel_init(&panel->drm_panel, dev, &nt39016_funcs,
-		       DRM_MODE_CONNECTOR_DPI);
-
 	drm_panel_add(&panel->drm_panel);
 
 	return 0;
-- 
2.28.0


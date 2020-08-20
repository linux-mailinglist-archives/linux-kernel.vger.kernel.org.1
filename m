Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F9A24BA9B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 14:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgHTMNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 08:13:41 -0400
Received: from crapouillou.net ([89.234.176.41]:47104 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729772AbgHTMNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597925584; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6AaeB90PvxfVY9WrxZtIpss3tNLOtB/nIbF3+2oWDU=;
        b=vdG3dLdP29l0b+5WTSa+a7bQKELcpbNkcBt5KYifC1zXijOJWMYVWaj4wKDywkLpevPwvV
        NxiEnhaTd2cE1wSUvOOQeDxiryKXQfFIE+02B5SaCbWeZfbAld2P9VBYGJtd83odbuPqNH
        JDMRJkliPlN5CVce7xZyVvl9wsRK7m0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/2] drm/panel: novatek,nt39016: Remove 'dev' field in priv struct
Date:   Thu, 20 Aug 2020 14:12:56 +0200
Message-Id: <20200820121256.32037-3-paul@crapouillou.net>
In-Reply-To: <20200820121256.32037-1-paul@crapouillou.net>
References: <20200820121256.32037-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already a 'struct device' pointer in the drm_panel structure,
that we can access easily from our priv structure, so there's no need
for a separate 'dev' field there.

v2: Don't initialize drm_panel->dev manually, it is done by
drm_panel_init().

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-novatek-nt39016.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
index daa583030246..f8151fe3ac9a 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
@@ -56,7 +56,6 @@ struct nt39016_panel_info {
 
 struct nt39016 {
 	struct drm_panel drm_panel;
-	struct device *dev;
 	struct regmap *map;
 	struct regulator *supply;
 	const struct nt39016_panel_info *panel_info;
@@ -124,7 +123,7 @@ static int nt39016_prepare(struct drm_panel *drm_panel)
 
 	err = regulator_enable(panel->supply);
 	if (err) {
-		dev_err(panel->dev, "Failed to enable power supply: %d\n", err);
+		dev_err(drm_panel->dev, "Failed to enable power supply: %d\n", err);
 		return err;
 	}
 
@@ -143,7 +142,7 @@ static int nt39016_prepare(struct drm_panel *drm_panel)
 	err = regmap_multi_reg_write(panel->map, nt39016_panel_regs,
 				     ARRAY_SIZE(nt39016_panel_regs));
 	if (err) {
-		dev_err(panel->dev, "Failed to init registers: %d\n", err);
+		dev_err(drm_panel->dev, "Failed to init registers: %d\n", err);
 		goto err_disable_regulator;
 	}
 
@@ -173,7 +172,7 @@ static int nt39016_enable(struct drm_panel *drm_panel)
 	ret = regmap_write(panel->map, NT39016_REG_SYSTEM,
 			   NT39016_SYSTEM_RESET_N | NT39016_SYSTEM_STANDBY);
 	if (ret) {
-		dev_err(panel->dev, "Unable to enable panel: %d\n", ret);
+		dev_err(drm_panel->dev, "Unable to enable panel: %d\n", ret);
 		return ret;
 	}
 
@@ -193,7 +192,7 @@ static int nt39016_disable(struct drm_panel *drm_panel)
 	err = regmap_write(panel->map, NT39016_REG_SYSTEM,
 			   NT39016_SYSTEM_RESET_N);
 	if (err) {
-		dev_err(panel->dev, "Unable to disable panel: %d\n", err);
+		dev_err(drm_panel->dev, "Unable to disable panel: %d\n", err);
 		return err;
 	}
 
@@ -252,7 +251,6 @@ static int nt39016_probe(struct spi_device *spi)
 	if (!panel)
 		return -ENOMEM;
 
-	panel->dev = dev;
 	spi_set_drvdata(spi, panel);
 
 	panel->panel_info = of_device_get_match_data(dev);
-- 
2.28.0


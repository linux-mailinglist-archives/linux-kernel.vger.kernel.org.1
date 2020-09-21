Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8CF272F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbgIUQ4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:56:08 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:39514 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbgIUQ4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:56:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 0DE81FB05;
        Mon, 21 Sep 2020 18:55:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kXa4Z1C41mUZ; Mon, 21 Sep 2020 18:55:53 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 0511245678; Mon, 21 Sep 2020 18:55:53 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/3] drm/panel: mantix: Fix panel reset
Date:   Mon, 21 Sep 2020 18:55:51 +0200
Message-Id: <66973d8182164fca9fc0f57970a6cd8f110759bb.1600707235.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600707235.git.agx@sigxcpu.org>
References: <cover.1600707235.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mantix panel needs two reset lines (RESX and TP_RSTN) deasserted to
output an image. Only deasserting RESX is not enough and the display
will stay blank. Deassert in prepare() and assert in unprepare() to keep
device held in reset when off.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 37 ++++++++++++-------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
index 4a7fbf64bb7a..29d28c63bb72 100644
--- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
+++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
@@ -23,10 +23,13 @@
 #define MANTIX_CMD_OTP_STOP_RELOAD_MIPI 0x41
 #define MANTIX_CMD_INT_CANCEL           0x4C
 
+#define MANTIX_NUM_RESETS 2
+
 struct mantix {
 	struct device *dev;
 	struct drm_panel panel;
-	struct gpio_desc *reset_gpio;
+	/* RESX and TP_RSTN */
+	struct gpio_descs *reset_gpios;
 
 	struct regulator *avdd;
 	struct regulator *avee;
@@ -122,8 +125,13 @@ static int mantix_disable(struct drm_panel *panel)
 
 static int mantix_unprepare(struct drm_panel *panel)
 {
+	DECLARE_BITMAP(asserted_values, BITS_PER_TYPE(1));
 	struct mantix *ctx = panel_to_mantix(panel);
 
+	gpiod_set_array_value_cansleep(ctx->reset_gpios->ndescs,
+				       ctx->reset_gpios->desc,
+				       ctx->reset_gpios->info, asserted_values);
+
 	regulator_disable(ctx->avee);
 	regulator_disable(ctx->avdd);
 	/* T11 */
@@ -137,6 +145,7 @@ static int mantix_unprepare(struct drm_panel *panel)
 
 static int mantix_prepare(struct drm_panel *panel)
 {
+	DECLARE_BITMAP(deasserted_values, BITS_PER_TYPE(0));
 	struct mantix *ctx = panel_to_mantix(panel);
 	int ret;
 
@@ -165,14 +174,11 @@ static int mantix_prepare(struct drm_panel *panel)
 		return ret;
 	}
 
-	/* T3+T5 */
-	usleep_range(10000, 12000);
-
-	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
-	usleep_range(5150, 7000);
-
-	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
-
+	/* T3 + T4 + time for voltage to become stable: */
+	usleep_range(6000, 7000);
+	gpiod_set_array_value_cansleep(ctx->reset_gpios->ndescs,
+				       ctx->reset_gpios->desc,
+				       ctx->reset_gpios->info, deasserted_values);
 	/* T6 */
 	msleep(50);
 
@@ -236,10 +242,15 @@ static int mantix_probe(struct mipi_dsi_device *dsi)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(ctx->reset_gpio)) {
-		dev_err(dev, "cannot get reset gpio\n");
-		return PTR_ERR(ctx->reset_gpio);
+	ctx->reset_gpios = devm_gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset_gpios)) {
+		dev_err(dev, "cannot get reset gpios\n");
+		return PTR_ERR(ctx->reset_gpios);
+	}
+
+	if (ctx->reset_gpios->ndescs != MANTIX_NUM_RESETS) {
+		dev_err(dev, "Need exactly %d reset-gpios\n", MANTIX_NUM_RESETS);
+		return -EINVAL;
 	}
 
 	mipi_dsi_set_drvdata(dsi, ctx);
-- 
2.26.2


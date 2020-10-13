Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E517128CBB6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbgJMKc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:32:56 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:45934 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730322AbgJMKcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:32:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id CB939FB02;
        Tue, 13 Oct 2020 12:32:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NZmo5Bvm5eqH; Tue, 13 Oct 2020 12:32:49 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9411E402FA; Tue, 13 Oct 2020 12:32:48 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/panel: mantix: Fix panel reset
Date:   Tue, 13 Oct 2020 12:32:47 +0200
Message-Id: <ba71a8ab010d263a8058dd4f711e3bcd95877bf2.1602584953.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602584953.git.agx@sigxcpu.org>
References: <cover.1602584953.git.agx@sigxcpu.org>
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
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
index 4a7fbf64bb7a..0c5f22e95c2d 100644
--- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
+++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
@@ -26,7 +26,9 @@
 struct mantix {
 	struct device *dev;
 	struct drm_panel panel;
+
 	struct gpio_desc *reset_gpio;
+	struct gpio_desc *tp_rstn_gpio;
 
 	struct regulator *avdd;
 	struct regulator *avee;
@@ -124,6 +126,10 @@ static int mantix_unprepare(struct drm_panel *panel)
 {
 	struct mantix *ctx = panel_to_mantix(panel);
 
+	gpiod_set_value_cansleep(ctx->tp_rstn_gpio, 1);
+	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+
 	regulator_disable(ctx->avee);
 	regulator_disable(ctx->avdd);
 	/* T11 */
@@ -165,13 +171,10 @@ static int mantix_prepare(struct drm_panel *panel)
 		return ret;
 	}
 
-	/* T3+T5 */
-	usleep_range(10000, 12000);
-
-	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
-	usleep_range(5150, 7000);
-
+	/* T3 + T4 + time for voltage to become stable: */
+	usleep_range(6000, 7000);
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	gpiod_set_value_cansleep(ctx->tp_rstn_gpio, 0);
 
 	/* T6 */
 	msleep(50);
@@ -236,12 +239,18 @@ static int mantix_probe(struct mipi_dsi_device *dsi)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(ctx->reset_gpio)) {
 		dev_err(dev, "cannot get reset gpio\n");
 		return PTR_ERR(ctx->reset_gpio);
 	}
 
+	ctx->tp_rstn_gpio = devm_gpiod_get(dev, "mantix,tp-rstn", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->tp_rstn_gpio)) {
+		dev_err(dev, "cannot get tp-rstn gpio\n");
+		return PTR_ERR(ctx->tp_rstn_gpio);
+	}
+
 	mipi_dsi_set_drvdata(dsi, ctx);
 	ctx->dev = dev;
 
-- 
2.28.0


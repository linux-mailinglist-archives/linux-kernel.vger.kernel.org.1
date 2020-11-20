Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A232BA66F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgKTJmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:42:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbgKTJmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:42:12 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90CF922404;
        Fri, 20 Nov 2020 09:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605865331;
        bh=S+wE9QoVUo+/NGuaJNIMv0SkfSy9gzrpeluikKZydfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ezrj4DbhHlbAjzVH/o1uRfz51aDcm4hQB9vH8gVL6j/wK/SLh2tLAkrMsxJ2inwy6
         TWe6t5s2AgZslMdtShWW2+KzMtYiJiCnaLCqlr5Wq/jSEZybwss01Jdadyv5q7WfwB
         FrbJM0VypjRQJ0GQE2kbeAW0JiY1j573wxTzg5Eo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kg2vh-00CDFB-No; Fri, 20 Nov 2020 09:42:09 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/meson: dw-hdmi: Disable clocks on driver teardown
Date:   Fri, 20 Nov 2020 09:42:04 +0000
Message-Id: <20201120094205.525228-2-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201120094205.525228-1-maz@kernel.org>
References: <20201120094205.525228-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: narmstrong@baylibre.com, khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, guillaume.tucker@collabora.com, kernel-team@android.com, dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDMI driver request clocks early, but never disable them, leaving
the clocks on even when the driver is removed.

Fix it by slightly refactoring the clock code, and register a devm
action that will eventually disable/unprepare the enabled clocks.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 43 ++++++++++++++++++---------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 7f8eea494147..29623b309cb1 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -145,8 +145,6 @@ struct meson_dw_hdmi {
 	struct reset_control *hdmitx_apb;
 	struct reset_control *hdmitx_ctrl;
 	struct reset_control *hdmitx_phy;
-	struct clk *hdmi_pclk;
-	struct clk *venci_clk;
 	struct regulator *hdmi_supply;
 	u32 irq_stat;
 	struct dw_hdmi *hdmi;
@@ -946,6 +944,29 @@ static void meson_disable_regulator(void *data)
 	regulator_disable(data);
 }
 
+static void meson_disable_clk(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static int meson_enable_clk(struct device *dev, char *name)
+{
+	struct clk *clk;
+	int ret;
+
+	clk = devm_clk_get(dev, name);
+	if (IS_ERR(clk)) {
+		dev_err(dev, "Unable to get %s pclk\n", name);
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (!ret)
+		ret = devm_add_action_or_reset(dev, meson_disable_clk, clk);
+
+	return ret;
+}
+
 static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 				void *data)
 {
@@ -1026,19 +1047,13 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	if (IS_ERR(meson_dw_hdmi->hdmitx))
 		return PTR_ERR(meson_dw_hdmi->hdmitx);
 
-	meson_dw_hdmi->hdmi_pclk = devm_clk_get(dev, "isfr");
-	if (IS_ERR(meson_dw_hdmi->hdmi_pclk)) {
-		dev_err(dev, "Unable to get HDMI pclk\n");
-		return PTR_ERR(meson_dw_hdmi->hdmi_pclk);
-	}
-	clk_prepare_enable(meson_dw_hdmi->hdmi_pclk);
+	ret = meson_enable_clk(dev, "isfr");
+	if (ret)
+		return ret;
 
-	meson_dw_hdmi->venci_clk = devm_clk_get(dev, "venci");
-	if (IS_ERR(meson_dw_hdmi->venci_clk)) {
-		dev_err(dev, "Unable to get venci clk\n");
-		return PTR_ERR(meson_dw_hdmi->venci_clk);
-	}
-	clk_prepare_enable(meson_dw_hdmi->venci_clk);
+	ret = meson_enable_clk(dev, "venci");
+	if (ret)
+		return ret;
 
 	dw_plat_data->regm = devm_regmap_init(dev, NULL, meson_dw_hdmi,
 					      &meson_dw_hdmi_regmap_config);
-- 
2.28.0


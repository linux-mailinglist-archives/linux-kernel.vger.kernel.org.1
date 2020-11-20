Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CE72BA671
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgKTJmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:42:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbgKTJmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:42:13 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 228D62240A;
        Fri, 20 Nov 2020 09:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605865332;
        bh=iQcVnrGpf37U4002Avz2RPHVjfPk0q8ZDK+TTqhRmEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tI0i1HgoMJfpibnKglXJjmS1wJO8PAk9CTLWx2bG4/DhR/xFFoQhhHvyKfMTQ7YQp
         /kYqRu+xQDD/bOwUT1E60aktiEEdq46ogUSv9OGITvPFZvm4Utwctfj6FJTV3Csgmz
         1mYvZpBIy4k2GzKUYWWF7ih/FQ8J1cxwfJYmxzQc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kg2vi-00CDFB-92; Fri, 20 Nov 2020 09:42:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/meson: dw-hdmi: Enable the iahb clock early enough
Date:   Fri, 20 Nov 2020 09:42:05 +0000
Message-Id: <20201120094205.525228-3-maz@kernel.org>
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

Instead of moving meson_dw_hdmi_init() around which breaks existing
platform, let's enable the clock meson_dw_hdmi_init() depends on.
This means we don't have to worry about this clock being enabled or
not, depending on the boot-loader features.

Fixes: b33340e33acd ("drm/meson: dw-hdmi: Ensure that clocks are enabled before touching the TOP registers")
Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Tested-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 29623b309cb1..aad75a22dc33 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -1051,6 +1051,10 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	if (ret)
 		return ret;
 
+	ret = meson_enable_clk(dev, "iahb");
+	if (ret)
+		return ret;
+
 	ret = meson_enable_clk(dev, "venci");
 	if (ret)
 		return ret;
@@ -1086,6 +1090,8 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 
 	encoder->possible_crtcs = BIT(0);
 
+	meson_dw_hdmi_init(meson_dw_hdmi);
+
 	DRM_DEBUG_DRIVER("encoder initialized\n");
 
 	/* Bridge / Connector */
@@ -1110,8 +1116,6 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	if (IS_ERR(meson_dw_hdmi->hdmi))
 		return PTR_ERR(meson_dw_hdmi->hdmi);
 
-	meson_dw_hdmi_init(meson_dw_hdmi);
-
 	next_bridge = of_drm_find_bridge(pdev->dev.of_node);
 	if (next_bridge)
 		drm_bridge_attach(encoder, next_bridge,
-- 
2.28.0


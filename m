Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10A22DEED8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 13:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgLSMpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 07:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgLSMpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 07:45:33 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E473C06138C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 04:44:52 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id w1so7088384ejf.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 04:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NkMmsvTcFvgCKGh0W4qI91nkVM/LPyxlJYr5p+foOoc=;
        b=XdHmS1KVx7mnaH5egFpezUrxOQUtD9wgaYneo4d/472nDXjDq88dsVPgxAsnC1Xxv+
         hI9xA2ZFKJZI02FmHoNOEMpyjSpGFdH1AtTqz0+QHon0rOzqAu33qjXLae9FqKA0oQ2D
         y04j0M4iRxyNhxOiO27eI4FbXkaIUdWGcakUum99lIwuoqC/29Sgq0FFhNMa4SUoSHY0
         FJTtea7vd3F5YBnpGfKdZtvT5KSC3DZpf8RFHP4pPdFmuMaN9q3g2foe7gQ+s9cof0DQ
         cogIMy+Wp7yXMPifPbvjYErq7ufYr0ZNEymt9tOHb0LYHrcyeeWIgNhBgUXGAumWzjjk
         0BWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NkMmsvTcFvgCKGh0W4qI91nkVM/LPyxlJYr5p+foOoc=;
        b=K77ih2MQlg+vml9LElMmuvs8rdQt/al81jQ99vc6cp78nhMXVLYGg0/3VCZwR6zAOI
         ZLelm/f8oktG4c9lUnFzblGe/rIrj1DQ/4PMT37ko6JG6WlRgZPYVy2UiB5G1+GX7oQ+
         Rs4cNz7VbY9rpywz6Ht54Kqn6NeN29lI86V4jaKqWgr3AcZCycMAocCbOBUN4MNsQANj
         7vwLdF2CU6zvt3p/eK2UL7I5LShSfIJQZVeUO6XYJKiFbfgot6w1pJ4e2dYmENmY+EVV
         B0LruyAmXXfeBYlpx/zMIDK96aQY6tNJGooTnwE9a7Sj8HirOvddkr6hiGaWCHLB1QJz
         j5vw==
X-Gm-Message-State: AOAM5314m4R4RWRuebjYY7Mr/3UuFspn01DHvkV6DsiRQObDopmi+c27
        dCwvAHBddJ6WNLrmcSnNnAA=
X-Google-Smtp-Source: ABdhPJwfs8eWqjjbyDLxo+NBP7Q7yexeknWwqJhrVwWI2Vj+bUabe8y4HZst6LMPV+DrX7JqSxp13g==
X-Received: by 2002:a17:906:d152:: with SMTP id br18mr4575862ejb.297.1608381890210;
        Sat, 19 Dec 2020 04:44:50 -0800 (PST)
Received: from localhost (124-155-N1.p43.customer.vsm.sh. [91.106.155.124])
        by smtp.gmail.com with ESMTPSA id be6sm26278815edb.29.2020.12.19.04.44.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Dec 2020 04:44:49 -0800 (PST)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     thierry.reding@gmail.com
Cc:     sam@ravnborg.org, m.felsch@pengutronix.de, festevam@gmail.com,
        Oliver Graute <oliver.graute@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/panel: simple: add SGD GKTW70SDAD1SD
Date:   Sat, 19 Dec 2020 13:44:12 +0100
Message-Id: <1608381853-18582-1-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Patchwork-Bot: notify
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Solomon Goldentek Display Model: GKTW70SDAD1SD
to panel-simple.

The panel spec from Variscite can be found at:
https://www.variscite.com/wp-content/uploads/2017/12/VLCD-CAP-GLD-RGB.pdf

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
---

panel-timing {
		clock-frequency = <35000000>;
		hactive = <800>;
		vactive = <480>;
		hback-porch = <39>;
		hfront-porch = <39>;
		vback-porch = <29>;
		vfront-porch = <13>;
		hsync-len = <48>;
		vsync-len = <3>;
		hsync-active = <0>;
		vsync-active = <0>;
		de-active = <1>;
		pixelclk-active = <0>;
	};

 drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c1374be..c2f20ac 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3139,6 +3139,29 @@ static const struct panel_desc satoz_sat050at40h12r2 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing sgd_gktw70sdad1sd_timing = {
+	.pixelclock = {35000000, 35000000, 35000000},
+	.hactive = { 800, 800, 800},
+	.hfront_porch = {39, 39, 39},
+	.hback_porch = {39, 39, 39},
+	.hsync_len = {48, 48, 48},
+	.vactive = {480, 480, 480},
+	.vfront_porch = {13, 13, 13},
+	.vback_porch = {29, 29, 29},
+	.vsync_len = {3, 3, 3},
+};
+
+static const struct panel_desc sgd_gktw70sdad1sd = {
+	.timings = &sgd_gktw70sdad1sd_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 153,
+		.height = 86,
+	},
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+};
+
 static const struct drm_display_mode sharp_ld_d5116z01b_mode = {
 	.clock = 168480,
 	.hdisplay = 1920,
@@ -3999,6 +4022,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "satoz,sat050at40h12r2",
 		.data = &satoz_sat050at40h12r2,
 	}, {
+		.compatible = "sgd,gktw70sdad1sd",
+		.data = &sgd_gktw70sdad1sd,
+	}, {
 		.compatible = "sharp,ld-d5116z01b",
 		.data = &sharp_ld_d5116z01b,
 	}, {
-- 
2.7.4


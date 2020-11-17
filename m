Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A522B6C54
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbgKQRt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:49:58 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:34918 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbgKQRtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:49:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 9AE73FB04;
        Tue, 17 Nov 2020 18:49:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LTzbWBHTT_Ih; Tue, 17 Nov 2020 18:49:39 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 145A843F6F; Tue, 17 Nov 2020 18:49:38 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/6] drm/panel: mantix: Tweak init sequence
Date:   Tue, 17 Nov 2020 18:49:33 +0100
Message-Id: <1321f3abdc3df6e9d1999bd32b436ae71e89c27e.1605635248.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605635248.git.agx@sigxcpu.org>
References: <cover.1605635248.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've seen some (non permanent) burn in and bad white balance
on some of the panels. Adding this bit from a vendor supplied
sequence fixes it.

Fixes: 72967d5616d3 ("drm/panel: Add panel driver for the Mantix MLAF057WE51-X DSI panel")
Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
index 0c5f22e95c2d..624d17b96a69 100644
--- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
+++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
@@ -22,6 +22,7 @@
 /* Manufacturer specific Commands send via DSI */
 #define MANTIX_CMD_OTP_STOP_RELOAD_MIPI 0x41
 #define MANTIX_CMD_INT_CANCEL           0x4C
+#define MANTIX_CMD_SPI_FINISH           0x90
 
 struct mantix {
 	struct device *dev;
@@ -66,6 +67,10 @@ static int mantix_init_sequence(struct mantix *ctx)
 	dsi_generic_write_seq(dsi, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
 	msleep(20);
 
+	dsi_generic_write_seq(dsi, MANTIX_CMD_SPI_FINISH, 0xA5);
+	dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
+	msleep(20);
+
 	dev_dbg(dev, "Panel init sequence done\n");
 	return 0;
 }
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CF72929B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgJSOsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbgJSOsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:48:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E1FC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:48:15 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j7so7688915wrt.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IByM6fAwfV36/UB3A2tjIml0N5VQ5jxPxkeC7coc2Zo=;
        b=B0exkIpg0jMlPZlUstcDD5IUDvafjKZ0dLq9ENV4r1ik//YotB6f5RDT3Zlsrq3ksL
         Cy0Ah3L2cdAUA/f7e0k39eR40fAnLIkY6l5PzanT45X0tYhCkVaN1YtmcnsYMP3XAs7c
         mSxsP7lSE/RsvWRc3LjojkCUZXMUNqvOwLD0YVyG7neHJz1HSKSD9dFdN8xE1k//L63T
         ckutiqsTzwdREsi+ewYourmbEmfPMLTc2n3lKA+xiTH8Z4fP8V7Z3SovGtrd31G4I1gH
         K2EiQxzBLgl7qUUWMrq8wN6A5/8nuazOrZ4hkwUPhoNyFrgx/DiMTClXCwTsRK+6NFq5
         2WzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IByM6fAwfV36/UB3A2tjIml0N5VQ5jxPxkeC7coc2Zo=;
        b=Q1ySn4UNemXVRhibXoZG1rnczroH4tr7W5NALCF3svLkR1c74v/iilJoKaCzkY4VDB
         smWyf0avco3BWZ92lhu7OEoy/j5TnznWftneYspZHwpD2w/klt285nFC+KwTbAeeAHiF
         PRfo8oPrjMZOHH7B7Gm38reyz8ED001c5HgT1gVJl0Hvv4LYDr81/RbG5nyhwBXEYyNz
         y0zCh4x3F0sSe5DRQGFfvN/miaUxEzQD9Z81ALYWlW3pnJTuNsu4Kt6LgI6p7DQ6URKT
         VpZg/dppKkPeD+Eky++hamFxUs/3mQWHx/NDGrbTa5Krek3cxDvoRDpihfYhh41hASZ7
         dmEQ==
X-Gm-Message-State: AOAM533ZwIBGCOOf5hoXJyNm+5I5Fv26hOtbI8wWC7mz/KeE/Imar3zJ
        lYNBSBhtMbEeYJTT4qTi+7Z95g==
X-Google-Smtp-Source: ABdhPJyV1Y3VAHw8VVM4EZvMv63AARzDLXjLHn4YWRX67f3y+tTQEujcWlBoxLgd5gIIkgCKnNmQbg==
X-Received: by 2002:a5d:4c4b:: with SMTP id n11mr19735303wrt.171.1603118894402;
        Mon, 19 Oct 2020 07:48:14 -0700 (PDT)
Received: from bojack.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v6sm334971wmj.6.2020.10.19.07.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 07:48:13 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     p.zabel@pengutronix.de
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2] reset: meson: make it possible to build as a module
Date:   Mon, 19 Oct 2020 16:48:09 +0200
Message-Id: <20201019144809.943608-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reduce the kernel Image size on multi-platform distributions,
make it possible to build the reset controller driver as a module.

This partially reverts 8290924e ("reset: meson: make it explicitly non-modular")

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
Changes since v1 at [1]:
- Fix Kconfig depends
- Add missing MODULE_DEVICE_TABLE
- Add kevin's review & test tags

[1] http://lore.kernel.org/r/20201013133943.412119-1-narmstrong@baylibre.com

 drivers/reset/Kconfig       | 3 ++-
 drivers/reset/reset-meson.c | 8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index d9efbfd29646..9a36111cfd2c 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -94,7 +94,8 @@ config RESET_LPC18XX
 	  This enables the reset controller driver for NXP LPC18xx/43xx SoCs.
 
 config RESET_MESON
-	bool "Meson Reset Driver" if COMPILE_TEST
+	tristate "Meson Reset Driver"
+	depends on ARCH_MESON || COMPILE_TEST
 	default ARCH_MESON
 	help
 	  This enables the reset driver for Amlogic Meson SoCs.
diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 94d7ba88d7d2..c9bc325ad65a 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
@@ -104,6 +105,7 @@ static const struct of_device_id meson_reset_dt_ids[] = {
 	 { .compatible = "amlogic,meson-a1-reset",   .data = &meson_a1_param},
 	 { /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
 
 static int meson_reset_probe(struct platform_device *pdev)
 {
@@ -142,4 +144,8 @@ static struct platform_driver meson_reset_driver = {
 		.of_match_table	= meson_reset_dt_ids,
 	},
 };
-builtin_platform_driver(meson_reset_driver);
+module_platform_driver(meson_reset_driver);
+
+MODULE_DESCRIPTION("Amlogic Meson Reset Controller driver");
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9DF28CF49
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgJMNjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbgJMNju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:39:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C939CC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 06:39:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n18so24112927wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 06:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jXRjLc7/VTEbu9Wec7fe96yx2W0L+RJ0lJ0eWgO4l8k=;
        b=C6o1y4t+MuEjWBFxxfMHkiKE9hKTunN1ZAxXs7BX+1bkNrdkVoE+4zaHPwDHmtRsPx
         +3QNThqorMTFNot7GJWTBjH5hVUAZlGmrHliHv4dLeMpWYjwojz+jrKWHMjymc4tDbQG
         txNGcm1PDd/CShcBMp5w2bA72yMKwJ3gJjQFUZrO1FHXdmiKr1GliE2gPe7ttv47iImF
         qivhlzeHhFNa2y+cfh5f87l2euYkJrZQGeVPmZshj7P1jLWR+7SojEzsegtVV7fyEySq
         3WaooC4Ly0yJN6FNT1ZDnUO+PRyThM6IEtSSpg1vApUKDGVIVffSQgxnaNoG6aRV9krN
         wJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jXRjLc7/VTEbu9Wec7fe96yx2W0L+RJ0lJ0eWgO4l8k=;
        b=Hu8OQ44lRjiEMQIUWly7bKIaYO9hK/TvFa2B/4/SREb9rQ2GHXMmfU9nnp1Q7cEd1M
         JiNptkSyrNVt4STDFI4VZy2sAl02rcF/wNuEvQW4beG1q0I5Fko1yv4pGG9EPEhMMpSO
         U59mBKhE2gDSLtsjdLY6oLNxNbqm6NST/5/51cfCJKkhG1FiVt/gUooxVjliYOwT1pyA
         rvr3WK2rhs9cj8OLLWzYQJNMJ6QQI+zdYLk7v0ue1mofycf+RC3W0HR8hnn5LUNqFN5i
         RhwpIjGvd1EmIh1993ZWWR17OELX2L6bo7hNEEVzma27ve6NGctyeWbuV79bxAdSQZhn
         jLVw==
X-Gm-Message-State: AOAM5303vQENGsZF+mc4H3yTenJofmH7g8F5QnoGBQJy4xg93FYom028
        EJiHPhL6k3M+8G0QuwqVV37r5A==
X-Google-Smtp-Source: ABdhPJzy4dVRESkN3Bx5r5311HsleVWTAcXGJiqtKKLkhwTtL3zXyGUYK0ZRUJYDJImBG2gvXk1GlA==
X-Received: by 2002:adf:9793:: with SMTP id s19mr14206935wrb.139.1602596387316;
        Tue, 13 Oct 2020 06:39:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:f4da:39ea:5653:71fc])
        by smtp.gmail.com with ESMTPSA id t7sm6803949wrx.42.2020.10.13.06.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 06:39:46 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     p.zabel@pengutronix.de
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] reset: meson: make it possible to build as a module
Date:   Tue, 13 Oct 2020 15:39:43 +0200
Message-Id: <20201013133943.412119-1-narmstrong@baylibre.com>
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
---
 drivers/reset/Kconfig       | 4 ++--
 drivers/reset/reset-meson.c | 7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index d9efbfd29646..ab315617565f 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -94,8 +94,8 @@ config RESET_LPC18XX
 	  This enables the reset controller driver for NXP LPC18xx/43xx SoCs.
 
 config RESET_MESON
-	bool "Meson Reset Driver" if COMPILE_TEST
-	default ARCH_MESON
+	tristate "Meson Reset Driver"
+	default ARCH_MESON || COMPILE_TEST
 	help
 	  This enables the reset driver for Amlogic Meson SoCs.
 
diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 94d7ba88d7d2..434d5c0f877e 100644
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
@@ -142,4 +143,8 @@ static struct platform_driver meson_reset_driver = {
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


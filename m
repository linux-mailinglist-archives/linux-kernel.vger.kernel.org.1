Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77AD2C38AB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 06:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgKYF3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 00:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgKYF3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 00:29:20 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3102DC0613D4;
        Tue, 24 Nov 2020 21:29:20 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so890357wml.2;
        Tue, 24 Nov 2020 21:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9/VyulasGLfNRZhFbuEx/v+zb6WhDEFLeGB6bc5kOlw=;
        b=V6PyMx1YCB2d4scqQohV3x/vNdZFji6nnwTpeehpun0H0R9lj1a05oNcwWLxaOhn71
         tJQYzPjCeZu/7s3tIWP8tEMaaM5MsZCroauf4358BJ1JfZqjxbMDPP20Ck8UyMmlsjb3
         LRXyCZLlZXynxwim7MRT/+CuD8CiBAiedm1k7RxOyIYjwWcpXQRPn1vjJMMpTBeYtwRQ
         vuTNl21ynhZjClO8LgJEraTHyWDgfQUnuHrNg0xwTlbi9kUD9yGYimSKxAwAZSmCRpuo
         SXgzps5XgZZyrkb8MXks5bmWsnZ+/lIXYklb5YBwE/l/DcUe1zQQLvcMJoE8ucmBVHG0
         uyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9/VyulasGLfNRZhFbuEx/v+zb6WhDEFLeGB6bc5kOlw=;
        b=B/jSdnAfMt/WHIgVyxwZw/f9wNC424o8/Q4VdE4Lp7n40/SVNUB16pS5oF8EGiC0kd
         YPUAFQxP7VWjqbWJ7EDFbbJECWxX+fioSHkwMnaznOq2kCV5HMm+6zwJicruUj1ZyO3R
         io3CuiIeGGuxtAWazaWtub/V+hL9oJ+dyZRtz8FxInVthmh69cY4/tnUd5uqu3AMeudB
         UBaNo7aYB+LWzxWcUp7dhbYWfnFht6mMRcAkvrgxz3Qzvmh9TEO+J+UV50UjVsivAn9K
         +vU37KqZZiZ0CvIYjjP3FO81AtxwrkPxYXfUMlEa2dNTnfS/vCQhueTV9H5M7CPy7Fx4
         /Pag==
X-Gm-Message-State: AOAM530KkxjTYi+Gj7qC18IO6u+hYzb+2VqyYxBjAfqXP3Fqcmmjv9rd
        nxfp9DZX6aT7cixYeVs4d291tkoU2dgvPg==
X-Google-Smtp-Source: ABdhPJzzC91a7bxl4p9PJJ0B1x51PIcIGJdAXL14Xb8n+0yVk6tn7FR2vhinu4Fc//tJsTOPPYpZDQ==
X-Received: by 2002:a7b:cf09:: with SMTP id l9mr1860237wmg.54.1606282158885;
        Tue, 24 Nov 2020 21:29:18 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id d128sm2430249wmc.7.2020.11.24.21.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 21:29:18 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Artem Lapkin <art@khadas.com>
Subject: [PATCH] arm64: dts: meson: update the Khadas VIM3/3L LED bindings
Date:   Wed, 25 Nov 2020 05:29:14 +0000
Message-Id: <20201125052914.4092-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the VIM3/3L common dtsi to use the new function/color bindings.

Suggested-by: Artem Lapkin <art@khadas.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
This supersedes a previous submission from Art [0] and uses the updated
LED bindings suggested by Neil.

[0] https://patchwork.kernel.org/project/linux-amlogic/patch/20200925033017.1790973-4-art@khadas.com/

 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 87bd8c9516f2..8f8656262ae7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
 #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
@@ -42,14 +43,16 @@
 	leds {
 		compatible = "gpio-leds";
 
-		led-white {
-			label = "vim3:white:sys";
+		white {
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_STATUS;
 			gpios = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		led-red {
-			label = "vim3:red";
+		red {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_STATUS;
 			gpios = <&gpio_expander 5 GPIO_ACTIVE_HIGH>;
 		};
 	};
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79E728AAA2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 23:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbgJKVOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 17:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbgJKVOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 17:14:47 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2436C0613CE;
        Sun, 11 Oct 2020 14:14:46 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id bl9so7518659qvb.10;
        Sun, 11 Oct 2020 14:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QhmDxxDGKX1YozmvjqVq9UocysPhEwMN1IelbdsB+sI=;
        b=qTPnI04EOSkJ8gdcT9/cztv6OnMi1OI7pj3npgvjpUMkObZPDxF3XHxJVMFO222+K/
         oAj8yg/0z/iOkqLfd4E293ESSo/PDy6uD13jIH8MqbDL4MbFt7e9vZ8geG/A6a4MgMV5
         t/GVZlsd0l9cxbTsbZ5HlIJtbpeaOtAc4EZJQ5QWs2cZV47baYddsXOKe/WbXtfdceV6
         Pg+bzd70S65XDYE4LbmEdkWZYiWk5tg8PkvhVDFESwTUyUOQST4Fovsp2BfDqLu7LtO/
         2qKRUxNrcptDno0GCzppHArVXLM+ukrf464gnohl1jhwHf9LJK4uutdeeGAwTDE2UW7c
         KBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QhmDxxDGKX1YozmvjqVq9UocysPhEwMN1IelbdsB+sI=;
        b=pvVISEdQNODYGHOkG1N+HYul0YDY7+X7wUIU/cDmImXZrYvNfa7ayUAUNmgxZ0SYnP
         K7BPsbazC1P6f/Z9JTEgFzeBsbeDUWdN9hB/r0MoGuLbY8lgg9cCrdSP9T7rtPXuzhhK
         9K744KLMZLIM9Jpka3xGLB2aahYDeEvQZidEUoBVVEL2mP3EqSP0YKtE5NBxD/SofGvQ
         mk2HUTZ+Xt5qyuOwmaQeE1FLUvn5o4j2UoAWfhz5Eztb24XlOxdDM6LctPMJKItM71hh
         Zy/fVdJL+dNmlHm0gh8+lSvRLRUfIslRGptGZhQCPV7ZqPLdKR/QFYl1X+aoFe8wlEd7
         P2CA==
X-Gm-Message-State: AOAM532K+d1rhUvg5kCdwSDeyFBhuRfQchR2CpHODYyfk7Xxbk63K8vq
        9ScmsTPc7QowuQaTfjY3lak=
X-Google-Smtp-Source: ABdhPJyD3QF/g7iKXbXNBhbFQ7ULA4RT1EdBH2X4tnmWJKiXzsHxThXG7vWtEenVh6rGuSMZxqKCJw==
X-Received: by 2002:ad4:4e73:: with SMTP id ec19mr21177629qvb.58.1602450885985;
        Sun, 11 Oct 2020 14:14:45 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id t186sm11252818qkf.48.2020.10.11.14.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 14:14:45 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: beelink-gs1: Update LED power node
Date:   Sun, 11 Oct 2020 23:14:28 +0200
Message-Id: <20201011211428.154793-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beelink GS1 LED trigger a warning when running dtbs_check.

Update the node with a valid pattern property.

Also add the function and the color of the LED and drop the
label which is deprecated.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 3f7ceeb1a767..f506d6fa8017 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -7,6 +7,7 @@
 #include "sun50i-h6-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "Beelink GS1";
@@ -43,8 +44,9 @@ ext_osc32k: ext_osc32k_clk {
 	leds {
 		compatible = "gpio-leds";
 
-		power {
-			label = "beelink:white:power";
+		led-0 {
+			function = LED_FUNCTION_POWER;
+			color = LED_COLOR_ID_WHITE;
 			gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
 			default-state = "on";
 		};
-- 
2.25.1


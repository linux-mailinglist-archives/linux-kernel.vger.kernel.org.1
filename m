Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66272DEA9B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 21:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgLRUzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 15:55:47 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:42878 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgLRUzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 15:55:46 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id E5A6EBFDE9;
        Fri, 18 Dec 2020 21:55:03 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 58D14C1D27; Fri, 18 Dec 2020 21:55:03 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 4F57AC1D23;
        Fri, 18 Dec 2020 21:54:38 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 2/2] ARM: dts: sun8i-v3s: Add PWM controller and pins definitions
Date:   Fri, 18 Dec 2020 21:54:36 +0100
Message-Id: <20201218205436.2326872-2-contact@paulk.fr>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218205436.2326872-1-contact@paulk.fr>
References: <20201218205436.2326872-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces definitions for the PWM controller found in the V3s,
as well as associated pins. This fashion of the controller has two PWM
outputs and is register-compatible with the A20.

Both PWM outputs were tested on a Lichee Pi Zero with a simple
transistor-LED setup.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index bff822b9fa01..f02aa988156d 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -404,6 +404,16 @@ spi0_pins: spi0-pins {
 				pins = "PC0", "PC1", "PC2", "PC3";
 				function = "spi0";
 			};
+
+			pwm0_pin: pwm0-pin {
+				pins = "PB4";
+				function = "pwm0";
+			};
+
+			pwm1_pin: pwm1-pin {
+				pins = "PB5";
+				function = "pwm1";
+			};
 		};
 
 		timer@1c20c00 {
@@ -422,6 +432,15 @@ wdt0: watchdog@1c20ca0 {
 			clocks = <&osc24M>;
 		};
 
+		pwm: pwm@1c21400 {
+			compatible = "allwinner,sun8i-v3s-pwm",
+				     "allwinner,sun7i-a20-pwm";
+			reg = <0x01c21400 0xc>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		lradc: lradc@1c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x400>;
-- 
2.29.2


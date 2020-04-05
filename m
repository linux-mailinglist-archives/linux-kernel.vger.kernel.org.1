Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 040A019ED0F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgDERkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 13:40:00 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:17359 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgDERj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1586108397;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=5eexSbKaD4PWK4+vSfn+rMLl0XvRZRi7o/XZA3aRFVw=;
        b=mLNl0fT+W7Cfi1klpdFU0PGzxPA4ud8b2TxqpRhTkWW59oMZzKPdjFFK4C2gE7FBEZ
        10hffU65TTBjTeG94yd+v0YMd0hsJsA6LGk4mZIwRdkzVqYbEhr7Z/nLXwlvOMN62dpt
        ZF9caWImJwIyMf6ogveFYM/j4OU6XaAMgYrCJY0L663PHCStruGq//o/IiuWzjbmoLbh
        Eoj7fj9WGUqlYKlp/LjCkYyzzFOp7LkPy/uXnue8ieXCPA7EvBIbpATVyudc7KORsHTL
        EXqAV4oFeTEwwpC7KTGQ3NQ3VeRaf1djZgbJ1ycD3SyAh/C8araeaXDJxgkxfrBNh/ab
        9Kzg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526NfqU="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id u043b8w35HXqxmd
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 5 Apr 2020 19:33:52 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/2] ARM: dts: ux500: samsung-golden: Add proximity sensor
Date:   Sun,  5 Apr 2020 19:32:51 +0200
Message-Id: <20200405173252.67614-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

samsung-golden has the same sharp,gp2ap002s00f proximity sensor
that is also used in samsung-skomer.

A driver was added for it in
commit 97d642e23037 ("iio: light: Add a driver for Sharp GP2AP002x00F").

Now that it was merged we can add an entry for it in the device tree
for samsung-golden.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../arm/boot/dts/ste-ux500-samsung-golden.dts | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
index 313f0ab16866..0e9e33f4ca3c 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
@@ -146,6 +146,32 @@ uart@80007000 {
 			pinctrl-1 = <&u2rxtx_c_1_sleep>;
 		};
 
+		i2c@80004000 {
+			status = "okay";
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c0_a_1_default>;
+			pinctrl-1 = <&i2c0_a_1_sleep>;
+
+			proximity@44 {
+				compatible = "sharp,gp2ap002s00f";
+				reg = <0x44>;
+
+				/* GPIO146 (PS_INT) */
+				interrupt-parent = <&gpio4>;
+				interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vio-supply = <&ab8500_ldo_aux8_reg>;
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&proximity_default>;
+
+				sharp,proximity-far-hysteresis = <0x40>;
+				sharp,proximity-close-hysteresis = <0x0f>;
+			};
+		};
+
 		i2c@80128000 {
 			status = "okay";
 
@@ -375,6 +401,15 @@ golden_cfg1 {
 		};
 	};
 
+	proximity {
+		proximity_default: proximity_default {
+			golden_cfg1 {
+				pins = "GPIO146_D13";	/* PS_INT */
+				ste,config = <&gpio_in_nopull>;
+			};
+		};
+	};
+
 	imu {
 		imu_default: imu_default {
 			golden_cfg1 {
-- 
2.26.0


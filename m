Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E003521416F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jul 2020 00:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgGCWOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 18:14:31 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43018 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgGCWOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 18:14:31 -0400
Received: from p5b127e6f.dip0.t-ipconnect.de ([91.18.126.111] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jrTwz-0000rS-27; Sat, 04 Jul 2020 00:14:29 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH] arm64: dts: rockchip: add adc joystick to Odroid Go Advance
Date:   Sat,  4 Jul 2020 00:14:13 +0200
Message-Id: <20200703221413.269800-1-heiko@sntech.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Add the now usable adc-joystick node that describes the analog
joystick connected to two saradc channels from the rk3326 soc.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
This still needs the iio-joystick driver to get merged first.
See http://lore.kernel.org/r/20200517194904.34758-1-contact@artur-rojek.eu

 .../boot/dts/rockchip/rk3326-odroid-go2.dts   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index b3a8f936578f..91b6d1a1839d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -24,6 +24,30 @@ backlight: backlight {
 		pwms = <&pwm1 0 25000 0>;
 	};
 
+	adc-joystick {
+		compatible = "adc-joystick";
+		io-channels = <&saradc 1>,
+			      <&saradc 2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		axis@0 {
+			reg = <0>;
+			abs-range = <172 772>;
+			abs-fuzz = <10>;
+			abs-flat = <10>;
+			linux,code = <ABS_X>;
+		};
+
+		axis@1 {
+			reg = <1>;
+			abs-range = <278 815>;
+			abs-fuzz = <10>;
+			abs-flat = <10>;
+			linux,code = <ABS_Y>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
-- 
2.26.2


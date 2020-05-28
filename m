Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F421E68A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 19:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405583AbgE1R0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 13:26:24 -0400
Received: from mail.manjaro.org ([176.9.38.148]:53292 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405465AbgE1R0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:26:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 62E2937CC722;
        Thu, 28 May 2020 19:26:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Kr2DGfvXLuqX; Thu, 28 May 2020 19:26:08 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 1/1] arm64: dts: rockchip: add fuel gauge to Pinebook Pro dts
Date:   Thu, 28 May 2020 19:25:50 +0200
Message-Id: <20200528172550.2324722-2-t.schramm@manjaro.org>
In-Reply-To: <20200528172550.2324722-1-t.schramm@manjaro.org>
References: <20200528172550.2324722-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds cw2015 fuel gauge and battery to the Pinebook Pro dts.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 5ea281b55fe2..28afe89ca283 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -28,6 +28,13 @@ backlight: edp-backlight {
 		pwms = <&pwm0 0 740740 0>;
 	};
 
+	bat: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <9800000>;
+		voltage-max-design-microvolt = <4350000>;
+		voltage-min-design-microvolt = <3000000>;
+	};
+
 	edp_panel: edp-panel {
 		compatible = "boe,nv140fhmn49";
 		backlight = <&backlight>;
@@ -740,6 +747,24 @@ usbc_dp: endpoint {
 			};
 		};
 	};
+
+	cw2015@62 {
+		compatible = "cellwise,cw2015";
+		reg = <0x62>;
+		cellwise,battery-profile = /bits/ 8 <
+			0x17 0x67 0x80 0x73 0x6E 0x6C 0x6B 0x63
+			0x77 0x51 0x5C 0x58 0x50 0x4C 0x48 0x36
+			0x15 0x0C 0x0C 0x19 0x5B 0x7D 0x6F 0x69
+			0x69 0x5B 0x0C 0x29 0x20 0x40 0x52 0x59
+			0x57 0x56 0x54 0x4F 0x3B 0x1F 0x7F 0x17
+			0x06 0x1A 0x30 0x5A 0x85 0x93 0x96 0x2D
+			0x48 0x77 0x9C 0xB3 0x80 0x52 0x94 0xCB
+			0x2F 0x00 0x64 0xA5 0xB5 0x11 0xF0 0x11
+		>;
+		cellwise,monitor-interval-ms = <5000>;
+		monitored-battery = <&bat>;
+		power-supplies = <&mains_charger>, <&fusb0>;
+	};
 };
 
 &i2s1 {
-- 
2.26.0


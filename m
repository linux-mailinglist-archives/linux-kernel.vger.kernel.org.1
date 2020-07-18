Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F21224DF6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 22:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgGRUvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 16:51:03 -0400
Received: from v6.sk ([167.172.42.174]:37580 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgGRUvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:51:01 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 1B92660D35;
        Sat, 18 Jul 2020 20:51:00 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 08/13] ARM: dts: mmp2: Add SSPA nodes
Date:   Sat, 18 Jul 2020 22:50:14 +0200
Message-Id: <20200718205019.184927-9-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718205019.184927-1-lkundrak@v3.sk>
References: <20200718205019.184927-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two I2S-capable audio serial port blocks.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index dd7fba65799ea..31592acd3ef4f 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -223,6 +223,32 @@ audio_clk: clocks@d42a0c30 {
 				#clock-cells = <1>;
 				status = "disabled";
 			};
+
+			sspa0: audio-controller@d42a0c00 {
+				compatible = "marvell,mmp-sspa";
+				reg = <0xd42a0c00 0x30>,
+				      <0xd42a0c80 0x30>;
+				interrupts = <2>;
+				clock-names = "audio", "bitclk";
+				clocks = <&soc_clocks MMP2_CLK_AUDIO>,
+					 <&audio_clk 1>;
+				power-domains = <&soc_clocks MMP2_POWER_DOMAIN_AUDIO>;
+				#sound-dai-cells = <0>;
+				status = "disabled";
+			};
+
+			sspa1: audio-controller@d42a0d00 {
+				compatible = "marvell,mmp-sspa";
+				reg = <0xd42a0d00 0x30>,
+				      <0xd42a0d80 0x30>;
+				interrupts = <3>;
+				clock-names = "audio", "bitclk";
+				clocks = <&soc_clocks MMP2_CLK_AUDIO>,
+					 <&audio_clk 2>;
+				power-domains = <&soc_clocks MMP2_POWER_DOMAIN_AUDIO>;
+				#sound-dai-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		apb@d4000000 {	/* APB */
-- 
2.26.2


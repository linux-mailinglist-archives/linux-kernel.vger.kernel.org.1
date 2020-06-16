Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F781FBDF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 20:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgFPSYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 14:24:13 -0400
Received: from v6.sk ([167.172.42.174]:47594 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729964AbgFPSYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:24:08 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id CF5746162D;
        Tue, 16 Jun 2020 18:24:06 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 07/13] ARM: dts: mmp2: Add Audio Clock controller
Date:   Tue, 16 Jun 2020 20:23:35 +0200
Message-Id: <20200616182341.944473-8-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616182341.944473-1-lkundrak@v3.sk>
References: <20200616182341.944473-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device generates the audio codec master clock and bit clock.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index b349f4f35706b..dd7fba65799ea 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -210,6 +210,19 @@ adma1: dma-controller@d42a0900 {
 				#dma-cells = <1>;
 				status = "disabled";
 			};
+
+			audio_clk: clocks@d42a0c30 {
+				compatible = "marvell,mmp2-audio-clock";
+				reg = <0xd42a0c30 0x10>;
+				clock-names = "audio", "vctcxo", "i2s0", "i2s1";
+				clocks = <&soc_clocks MMP2_CLK_AUDIO>,
+					 <&soc_clocks MMP2_CLK_VCTCXO>,
+					 <&soc_clocks MMP2_CLK_I2S0>,
+					 <&soc_clocks MMP2_CLK_I2S1>;
+				power-domains = <&soc_clocks MMP2_POWER_DOMAIN_AUDIO>;
+				#clock-cells = <1>;
+				status = "disabled";
+			};
 		};
 
 		apb@d4000000 {	/* APB */
-- 
2.26.2


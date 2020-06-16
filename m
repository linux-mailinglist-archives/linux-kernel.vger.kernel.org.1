Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B141FBDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 20:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgFPSYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 14:24:18 -0400
Received: from v6.sk ([167.172.42.174]:47662 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730077AbgFPSYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:24:13 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 796A361630;
        Tue, 16 Jun 2020 18:24:12 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 10/13] ARM: dts: mmp2: Add the GPU
Date:   Tue, 16 Jun 2020 20:23:38 +0200
Message-Id: <20200616182341.944473-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616182341.944473-1-lkundrak@v3.sk>
References: <20200616182341.944473-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a GC860 2D + 3D core.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 31592acd3ef4f..445bdcd50b9ed 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/clock/marvell,mmp2.h>
+#include <dt-bindings/power/marvell,mmp2.h>
 
 / {
 	#address-cells = <1>;
@@ -38,6 +39,17 @@ axi@d4200000 {	/* AXI */
 			reg = <0xd4200000 0x00200000>;
 			ranges;
 
+			gpu: gpu@d420d000 {
+				compatible = "vivante,gc";
+				reg = <0xd420d000 0x4000>;
+				interrupts = <8>;
+				status = "disabled";
+				clocks = <&soc_clocks MMP2_CLK_GPU_3D>,
+					 <&soc_clocks MMP2_CLK_GPU_BUS>;
+				clock-names = "core", "bus";
+				power-domains = <&soc_clocks MMP2_POWER_DOMAIN_GPU>;
+			};
+
 			intc: interrupt-controller@d4282000 {
 				compatible = "mrvl,mmp2-intc";
 				interrupt-controller;
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623DB2F11C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbhAKLqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:46:53 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:42329 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbhAKLqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:46:52 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DE42723E4A;
        Mon, 11 Jan 2021 12:46:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1610365570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D5g8T7+ZpKplsj2ntYskL6wMxURRtOLCbLA2e3+ppjI=;
        b=THHpSn2aoROHYHixeJt3f6tgXVG8KsnXr0w4V9c6ujOkzOsiwn0OvBpDlwebxwUpWC+zOL
        XAFSpEh4/fM4OVag9yaJMViCFcq1ndjdoCJkZMji9pDXmFsQRT/TZMzfySF7mfHCSdzQ1K
        IIqLbLm40JdrMaKyO2391I8aY4KuCqg=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH RESEND v3] arm64: dts: ls1028a: fix FlexSPI clock
Date:   Mon, 11 Jan 2021 12:45:55 +0100
Message-Id: <20210111114555.28903-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a proper driver for the FlexSPI interface use it. This
will fix SCK frequency switching on Layerscape SoCs.

This was tested on the Kontron sl28 board.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Hi Shawn,

this is the last remaining piece of my previous series [1]. Now with the
actual clock driver in v5.11 and the clockgen constants patches in your
for-next branch, there are no further dependencies.

[1] https://lore.kernel.org/lkml/20201108185113.31377-1-michael@walle.cc/

Changlog from the old series:
Changes since v2:
 - use device tree constants for clockgen
 - also use &fspi_clk for fspi_en clock

Changes since v1:
 - none

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index e00acad9a5c1..0a5923e96d7f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -206,9 +206,20 @@
 		};
 
 		dcfg: syscon@1e00000 {
-			compatible = "fsl,ls1028a-dcfg", "syscon";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,ls1028a-dcfg", "syscon", "simple-mfd";
 			reg = <0x0 0x1e00000 0x0 0x10000>;
+			ranges = <0x0 0x0 0x1e00000 0x10000>;
 			little-endian;
+
+			fspi_clk: clock-controller@900 {
+				compatible = "fsl,ls1028a-flexspi-clk";
+				reg = <0x900 0x4>;
+				#clock-cells = <0>;
+				clocks = <&clockgen QORIQ_CLK_HWACCEL 0>;
+				clock-output-names = "fspi_clk";
+			};
 		};
 
 		rst: syscon@1e60000 {
@@ -326,8 +337,7 @@
 			      <0x0 0x20000000 0x0 0x10000000>;
 			reg-names = "fspi_base", "fspi_mmap";
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen QORIQ_CLK_HWACCEL 0>,
-				 <&clockgen QORIQ_CLK_HWACCEL 0>;
+			clocks = <&fspi_clk>, <&fspi_clk>;
 			clock-names = "fspi_en", "fspi";
 			status = "disabled";
 		};
-- 
2.20.1


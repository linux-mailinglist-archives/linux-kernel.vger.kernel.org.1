Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AFA23A09F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 10:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHCIF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 04:05:59 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49610 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgHCIF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:05:59 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 758A11A0148;
        Mon,  3 Aug 2020 10:05:57 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F7981A0181;
        Mon,  3 Aug 2020 10:05:53 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 05E47402BE;
        Mon,  3 Aug 2020 10:05:47 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx7ulp: Correct gpio ranges
Date:   Mon,  3 Aug 2020 16:01:24 +0800
Message-Id: <1596441684-30127-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct gpio ranges according to i.MX7ULP pinctrl driver:

gpio_ptc: ONLY pin 0~19 are available;
gpio_ptd: ONLY pin 0~11 are available;
gpio_pte: ONLY pin 0~15 are available;
gpio_ptf: ONLY pin 0~19 are available;

Fixes: 20434dc92c05 ("ARM: dts: imx: add common imx7ulp dtsi support")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
index 3674396..b7ea37a 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -394,7 +394,7 @@
 			clocks = <&pcc2 IMX7ULP_CLK_RGPIO2P1>,
 				 <&pcc3 IMX7ULP_CLK_PCTLC>;
 			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc1 0 0 32>;
+			gpio-ranges = <&iomuxc1 0 0 20>;
 		};
 
 		gpio_ptd: gpio@40af0000 {
@@ -408,7 +408,7 @@
 			clocks = <&pcc2 IMX7ULP_CLK_RGPIO2P1>,
 				 <&pcc3 IMX7ULP_CLK_PCTLD>;
 			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc1 0 32 32>;
+			gpio-ranges = <&iomuxc1 0 32 12>;
 		};
 
 		gpio_pte: gpio@40b00000 {
@@ -422,7 +422,7 @@
 			clocks = <&pcc2 IMX7ULP_CLK_RGPIO2P1>,
 				 <&pcc3 IMX7ULP_CLK_PCTLE>;
 			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc1 0 64 32>;
+			gpio-ranges = <&iomuxc1 0 64 16>;
 		};
 
 		gpio_ptf: gpio@40b10000 {
@@ -436,7 +436,7 @@
 			clocks = <&pcc2 IMX7ULP_CLK_RGPIO2P1>,
 				 <&pcc3 IMX7ULP_CLK_PCTLF>;
 			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc1 0 96 32>;
+			gpio-ranges = <&iomuxc1 0 96 20>;
 		};
 	};
 
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7982CB3E6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 05:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgLBEZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 23:25:39 -0500
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:48302 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLBEZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 23:25:38 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 0B24NQkS004748; Wed, 2 Dec 2020 13:23:26 +0900
X-Iguazu-Qid: 2wHHLA7xMrK9hzHsja
X-Iguazu-QSIG: v=2; s=0; t=1606883005; q=2wHHLA7xMrK9hzHsja; m=9kndqBkhNoeLZTFSkFktiR9GybtrNFjZ/4++PtVYSXs=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1112) id 0B24NPkk040487;
        Wed, 2 Dec 2020 13:23:25 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 0B24NP0g021396;
        Wed, 2 Dec 2020 13:23:25 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 0B24NOCH020075;
        Wed, 2 Dec 2020 13:23:24 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     linux-arm-kernel@lists.infradead.org
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH] arm64: dts: visconti: Add watchdog support for TMPV7708 SoC
Date:   Wed,  2 Dec 2020 22:21:43 +0900
X-TSB-HOP: ON
Message-Id: <20201202132143.2408012-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add watchdog node in TMPV7708's dtsi, and tmpv7708-rm-mbrc boards's
dts.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts |  5 +++++
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi        | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts b/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts
index ed0bf7f13f54..37da418393e0 100644
--- a/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts
@@ -41,3 +41,8 @@ &uart1 {
 	clocks = <&uart_clk>;
 	clock-names = "apb_pclk";
 };
+
+&wdt {
+	status = "okay";
+	clocks = <&wdt_clk>;
+};
diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
index 242f25f4e12a..c360e68bef1d 100644
--- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
@@ -134,6 +134,12 @@ uart_clk: uart-clk {
 		#clock-cells = <0>;
 	};
 
+	wdt_clk: wdt-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <150000000>;
+		#clock-cells = <0>;
+	};
+
 	soc {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -384,6 +390,12 @@ spi6: spi@28146000 {
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		wdt: wdt@28330000 {
+			compatible = "toshiba,visconti-wdt";
+			reg = <0 0x28330000 0 0x1000>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.29.2


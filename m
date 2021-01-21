Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7632FF2CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389641AbhAUSEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbhAUK2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:28:48 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA779C061796
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:15 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id g12so1840894ejf.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vr+TeRCEd/es2ypf0pZcHtu1JbAC7tTtccdv1K53z90=;
        b=m5owuoT53/nJkvxi3a+HWaGFuvhItn8fp9QD1TnR4w+WVygtHMCki6VnRakFIm4ONh
         RzhsQqqMBhGf+sRk+Tv96T2QHlv0MTSljk0Lx4nG+PC6dMRf6f9+n1a8pBOSoD3Z2+0G
         cIIrFQPSqKhBFkgQ06dKyaWacDzUDm9wnMYURUdC2Zka0gA4Y87XOByAQkHmjn8E1DUH
         Zce/JGmnYqRFLtterj03RLP824pRq/ybOiF/W7nC66d6WzRF8jQJZhftHJmo5/bNFLB1
         nxZo3ZWfqAyljsgViYoYRPtnOe0H9EoFu4W70Mkq0qzMNHyza/JOlLtVQTV71dkbyB0K
         dtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Vr+TeRCEd/es2ypf0pZcHtu1JbAC7tTtccdv1K53z90=;
        b=GnUfR7SLLMYBeKMpNiHQrsYXePqegjkH8z1OOEXtCcZjPKQ3/y4GXRL+gSi2CeKNRV
         S7T4wkQfj7SdZaWJyDaBFMijfqcFYhbormuQKu1kVqlZhkEW3Bo9y/2tjpiq8lAgwVD7
         cpsc34WtuoFDuYtmSvjGGNm4Q/t5IvLkeaYSa+W9QBV2u8Fw8Jnz63k7nrVI4ASiNW3t
         fy5DMEYE9AfcR358gowDMAFLg7IGYlxtsd+1+8VNqTDzFlxE30Q58zgiSSs4co3D3H0L
         zBG4u0ef9tTamvOdWA0pGLTKfuOCj4mrELubj8GwqdRxxLQxn/nFws/k76Lq2TDaqPLn
         N6zg==
X-Gm-Message-State: AOAM531iF0oKPfFOTzfa8zj2xM00eN9xgD66+0qh924GmrkHdG232xPy
        mOX4Rg7NT009l/7JHtVzsU5vnfXXYDaVbGnT
X-Google-Smtp-Source: ABdhPJzlbZ2UYdqKj341iVcPZ4qwO9MApLYuQsw9mnxN0GtqobAUE5U513lgz4ato4mUj+F2qQHALQ==
X-Received: by 2002:a17:906:4d8f:: with SMTP id s15mr8859438eju.389.1611224834281;
        Thu, 21 Jan 2021 02:27:14 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id e10sm2026339ejx.48.2021.01.21.02.27.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 02:27:13 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 05/12] arm64: dts: zynqmp: Enable phy driver for Sata on zcu102/zcu104/zcu106
Date:   Thu, 21 Jan 2021 11:26:53 +0100
Message-Id: <80b52ef97501968ee97fc152363bc4b9b7bb2cff.1611224800.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611224800.git.michal.simek@xilinx.com>
References: <cover.1611224800.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable psgtr driver and write clocks property to get sata to work.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 10 +++++++
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 28 +++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 10 +++++++
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 10 +++++++
 4 files changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 68c2ad30d62d..d92698ffbf8c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -13,6 +13,7 @@
 #include "zynqmp-clk-ccf.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
 
 / {
 	model = "ZynqMP ZCU102 RevA";
@@ -663,6 +664,13 @@ &pcie {
 	status = "okay";
 };
 
+&psgtr {
+	status = "okay";
+	/* pcie, sata, usb3, dp */
+	clocks = <&si5341 0 5>, <&si5341 0 3>, <&si5341 0 2>, <&si5341 0 0>;
+	clock-names = "ref0", "ref1", "ref2", "ref3";
+};
+
 &rtc {
 	status = "okay";
 };
@@ -678,6 +686,8 @@ &sata {
 	ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
 	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
 	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	phy-names = "sata-phy";
+	phys = <&psgtr 3 PHY_TYPE_SATA 1 1>;
 };
 
 /* SD1 with level shifter */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 7a4614e3f5fa..5e2be9abc175 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -12,6 +12,7 @@
 #include "zynqmp.dtsi"
 #include "zynqmp-clk-ccf.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
 
 / {
 	model = "ZynqMP ZCU104 RevA";
@@ -36,6 +37,24 @@ memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+
+	clock_8t49n287_5: clk125 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	clock_8t49n287_2: clk26 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+	};
+
+	clock_8t49n287_3: clk27 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <27000000>;
+	};
 };
 
 &can1 {
@@ -158,6 +177,13 @@ &rtc {
 	status = "okay";
 };
 
+&psgtr {
+	status = "okay";
+	/* nc, sata, usb3, dp */
+	clocks = <&clock_8t49n287_5>, <&clock_8t49n287_2>, <&clock_8t49n287_3>;
+	clock-names = "ref1", "ref2", "ref3";
+};
+
 &sata {
 	status = "okay";
 	/* SATA OOB timing settings */
@@ -169,6 +195,8 @@ &sata {
 	ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
 	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
 	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	phy-names = "sata-phy";
+	phys = <&psgtr 3 PHY_TYPE_SATA 1 1>;
 };
 
 /* SD1 with level shifter */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index a29ff20090ce..4ec6715abab7 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -13,6 +13,7 @@
 #include "zynqmp-clk-ccf.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
 
 / {
 	model = "ZynqMP ZCU106 RevA";
@@ -658,6 +659,13 @@ i2c@7 {
 	};
 };
 
+&psgtr {
+	status = "okay";
+	/* nc, sata, usb3, dp */
+	clocks = <&si5341 0 3>, <&si5341 0 2>, <&si5341 0 0>;
+	clock-names = "ref1", "ref2", "ref3";
+};
+
 &rtc {
 	status = "okay";
 };
@@ -673,6 +681,8 @@ &sata {
 	ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
 	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
 	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	phy-names = "sata-phy";
+	phys = <&psgtr 3 PHY_TYPE_SATA 1 1>;
 };
 
 /* SD1 with level shifter */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 92b3cee62d11..2969c4b71384 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -13,6 +13,7 @@
 #include "zynqmp-clk-ccf.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
 
 / {
 	model = "ZynqMP ZCU111 RevA";
@@ -541,6 +542,13 @@ i2c@7 {
 	};
 };
 
+&psgtr {
+	status = "okay";
+	/* nc, sata, usb3, dp */
+	clocks = <&si5341 0 3>, <&si5341 0 2>, <&si5341 0 0>;
+	clock-names = "ref1", "ref2", "ref3";
+};
+
 &rtc {
 	status = "okay";
 };
@@ -556,6 +564,8 @@ &sata {
 	ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
 	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
 	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	phy-names = "sata-phy";
+	phys = <&psgtr 3 PHY_TYPE_SATA 1 1>;
 };
 
 /* SD1 with level shifter */
-- 
2.30.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CD32E7423
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgL2VSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgL2VSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:18:16 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6166C061793;
        Tue, 29 Dec 2020 13:17:35 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id b2so13761737edm.3;
        Tue, 29 Dec 2020 13:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ar3X1iKV0NeTR7s69OFJ0FOTJoZy8+AuhYe5PERLjMk=;
        b=lKJWnyUOF4e79sq7/KKorzUtrXFUwh1bxgdn2aCFDXXIzHFARNwQRVGXSUqqD0ynvK
         W4Z3tY83FxCfozdfbDZytJD2tRe5GQBDLyBQVkXRfDywOZFY6HvtghnB756dhx6yuSd6
         sZ8xi/hm4SVd5qp//bpZDnEmS0gK+MiCc8bN/+/3dmX4N6CrzxHwawm0sCZbOxcxfwqc
         IPVBCBmTbxbcRxLuzp7jfR1iBSjc/9yWhAezXrnB3hoysOm3wtKTO8t/UdwxHPbz5zb8
         M6dXyjtnYsDyO+ZjPSfB6fGxdFi0d/A7fPg/D9PO+2T0bDfd8M9pp+Llk5sOM4ZaCxUS
         pHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ar3X1iKV0NeTR7s69OFJ0FOTJoZy8+AuhYe5PERLjMk=;
        b=RypVpBwLjs/Dq4maIb4dw/H1KcAlNlodpnuvr2lV2fyIklLBDfeF8IOzUjxSJvROC8
         nfFc7p0CeUBVxifR2DkA4JuGJLQ7EJRpcRw46ApaDWZQBlk0lfzC8Btw5tO93V/tIPV2
         OPvL7vqgt3hP1EdrvbSEzP+fKgu99NvsB31GWhY7VTNgkNZBB63sNUbnk+ENdEGfmcUZ
         MT/+85hlTm+S4NOIK9Bc547MHrP+ewEEceAeZ1kkNPJAo04RH7dElBucyCWCfGEIJTqM
         IwFoIaiz2PitV7FMUKqxLzYkltZitDGFTTQ5dfdBx+96OLUUIIk3ApynrYtI03x7FIL4
         MP7w==
X-Gm-Message-State: AOAM530YVo09+IG9mfjRrSz5S9xMzUm6yOkvNaVqTuPIhs4ABRewUNHj
        G5xzsOF7EyzVLPNWdtdu7uI=
X-Google-Smtp-Source: ABdhPJzRMtSyd/TiOXFzMQY2pCoNyWFRTSEXOmDgI93x/QWGflaOHfMZIUYAIV8HJ5Wxn5SJkQh9kw==
X-Received: by 2002:a50:9310:: with SMTP id m16mr48318482eda.94.1609276654618;
        Tue, 29 Dec 2020 13:17:34 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id u9sm37354553edd.54.2020.12.29.13.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 13:17:33 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/13] arm: dts: owl-s500: Set CMU clocks for UARTs
Date:   Tue, 29 Dec 2020 23:17:17 +0200
Message-Id: <fefb1ed01dacbc79811038d2c871b6528011b63f.1609263738.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set Clock Management Unit clocks for the UART nodes of Actions Semi
S500 SoCs and remove the dummy "uart2_clk" and "uart3_clk" fixed clocks.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Reviewed-by from Mani
 - Removed the dummy 'uart2_clk' and 'uart3_clk' nodes from all owl-s500 DTS,
   per Mani's review

 arch/arm/boot/dts/owl-s500-cubieboard6.dts     | 7 -------
 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts | 7 -------
 arch/arm/boot/dts/owl-s500-labrador-base-m.dts | 7 -------
 arch/arm/boot/dts/owl-s500-roseapplepi.dts     | 7 -------
 arch/arm/boot/dts/owl-s500-sparky.dts          | 7 -------
 arch/arm/boot/dts/owl-s500.dtsi                | 7 +++++++
 6 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/arch/arm/boot/dts/owl-s500-cubieboard6.dts b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
index 7c96c59b610d..c2b02895910c 100644
--- a/arch/arm/boot/dts/owl-s500-cubieboard6.dts
+++ b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
@@ -25,12 +25,6 @@ memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000>;
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &timer {
@@ -39,5 +33,4 @@ &timer {
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
index e610d49395d2..7ae34a23e320 100644
--- a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
+++ b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
@@ -18,15 +18,8 @@ aliases {
 	chosen {
 		stdout-path = "serial3:115200n8";
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500-labrador-base-m.dts b/arch/arm/boot/dts/owl-s500-labrador-base-m.dts
index c92f8bdcb331..1585e33f703b 100644
--- a/arch/arm/boot/dts/owl-s500-labrador-base-m.dts
+++ b/arch/arm/boot/dts/owl-s500-labrador-base-m.dts
@@ -21,15 +21,8 @@ aliases {
 	chosen {
 		stdout-path = "serial3:115200n8";
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
index a2087e617cb2..800edf5d2d12 100644
--- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
+++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
@@ -25,12 +25,6 @@ memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000>; /* 2GB */
 	};
-
-	uart2_clk: uart2-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &twd_timer {
@@ -43,5 +37,4 @@ &timer {
 
 &uart2 {
 	status = "okay";
-	clocks = <&uart2_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500-sparky.dts b/arch/arm/boot/dts/owl-s500-sparky.dts
index c665ce8b88b4..9d8f7336bec0 100644
--- a/arch/arm/boot/dts/owl-s500-sparky.dts
+++ b/arch/arm/boot/dts/owl-s500-sparky.dts
@@ -25,12 +25,6 @@ memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1 or 2 GiB */
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &timer {
@@ -39,5 +33,4 @@ &timer {
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 5d5ad9db549b..ac3d04c75dd5 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -131,6 +131,7 @@ uart0: serial@b0120000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0120000 0x2000>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART0>;
 			status = "disabled";
 		};
 
@@ -138,6 +139,7 @@ uart1: serial@b0122000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0122000 0x2000>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART1>;
 			status = "disabled";
 		};
 
@@ -145,6 +147,7 @@ uart2: serial@b0124000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0124000 0x2000>;
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART2>;
 			status = "disabled";
 		};
 
@@ -152,6 +155,7 @@ uart3: serial@b0126000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0126000 0x2000>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART3>;
 			status = "disabled";
 		};
 
@@ -159,6 +163,7 @@ uart4: serial@b0128000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0128000 0x2000>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART4>;
 			status = "disabled";
 		};
 
@@ -166,6 +171,7 @@ uart5: serial@b012a000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb012a000 0x2000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART5>;
 			status = "disabled";
 		};
 
@@ -173,6 +179,7 @@ uart6: serial@b012c000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb012c000 0x2000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART6>;
 			status = "disabled";
 		};
 
-- 
2.30.0


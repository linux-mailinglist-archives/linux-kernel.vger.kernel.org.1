Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B052FF2D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389071AbhAUSHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbhAUK2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:28:45 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E13C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:10 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id d22so1840299edy.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1eHEW+QzC2xwdpZCYQ8B7dxLc9e/zDObheOb3Ploj10=;
        b=guzBJXAKzZINhmhHwTrjm3eh0IPQZQ7C3LnaL2ALWBfoeUyUiOtXx75JK6r+5Wigpw
         TLKpctJEAXyca+hk0AC+7ryXiilWnsPI4ybDILjHPjoJyU2d2rzXpPjE/9oEaPHZZeUa
         xfoND877EpzerU3IPAtyf87+zuvO79I1+iaj/yPa1tevvuBhyzAjn/1xQRF+eC0yqG4w
         bzoS/BCSRlVepvRc6uQP0qtiJcen7s1CnQzslJmX81J1WjZ+JVXGFfzz3/Rpy8F3ntIT
         kOSbaUb7/fkaGiArq32yPXy6hMZAr3XO7+a7+SaN7dNv7a9p3esECI5f2tPAAl7asHYv
         jl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1eHEW+QzC2xwdpZCYQ8B7dxLc9e/zDObheOb3Ploj10=;
        b=QvQMT+ds0scwKOqDHANVI1TMwsrUzCmUo2urc2mff4dRAmQxD1rxeBVr3O4JOVMC8w
         m+I0m2hmCMX7bF6vqf2qyKNsFec9aXG0VAkzR48IvomORe//VSCpenCiearNi30xeD6m
         YKB7q7MzhmAtJT3GwbhB5DH7jKiGSQkgQWSZh5BBrjkECwQ9LKf3C3d2j5SCQ/vQGFMA
         azI+3KMUBP1Rya3oMOWBKjeIYWvuDo1i4B++qmfaSFlIcDEd6bp+qoKQYIf5JhJB2hm0
         08gYquG5fufo+U+qE9jtMdjB+Qj7U2muKkaurlG+h1OQaIciiOOa/a0iKtRfHZWbH4et
         D5iA==
X-Gm-Message-State: AOAM532KUV/fjZ92xtBfpB8uPRbamIoxIpS3IrXL66bq8EoU0vE2F+gF
        56AaSnIPKEQmqwjT/0yAH9idAS1if26ma5ya
X-Google-Smtp-Source: ABdhPJwXZ72+lpmAS2fYndbpRecB2/4p1VcDXYFnZ7DWsTNNJRr1y4Zjd3cA2SPjf3aH6MdaYPehkA==
X-Received: by 2002:a05:6402:1041:: with SMTP id e1mr11156595edu.54.1611224829153;
        Thu, 21 Jan 2021 02:27:09 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id u23sm2487904edt.78.2021.01.21.02.27.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 02:27:08 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 02/12] arm64: dts: zynqmp: Add DT description for si5328 for zcu102/zcu106
Date:   Thu, 21 Jan 2021 11:26:50 +0100
Message-Id: <82b2b13006307f108ace81c50c213c3857078b57.1611224800.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611224800.git.michal.simek@xilinx.com>
References: <cover.1611224800.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Origin DT binding just specify driver but wasn't aligned with DT binding
which came later. Extend description for zcu102 and zcu106 to cover latest
binding.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 17 ++++++++++++++
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 22 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index f1255f635dfd..5ff7ab665374 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -132,6 +132,12 @@ ina226-u75 {
 		compatible = "iio-hwmon";
 		io-channels = <&u75 0>, <&u75 1>, <&u75 2>, <&u75 3>;
 	};
+
+	refhdmi: refhdmi {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <114285000>;
+	};
 };
 
 &can1 {
@@ -526,6 +532,17 @@ si5328: clock-generator@69 {/* SI5328 - u20 */
 				 * interrupt-parent = <&>;
 				 * interrupts = <>;
 				 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#clock-cells = <1>;
+				clocks = <&refhdmi>;
+				clock-names = "xtal";
+				clock-output-names = "si5328";
+
+				si5328_clk: clk0@0 {
+					reg = <0>;
+					clock-frequency = <27000000>;
+				};
 			};
 		};
 		/* 5 - 7 unconnected */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 6e9efe233838..7910ac125101 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -132,6 +132,12 @@ ina226-u75 {
 		compatible = "iio-hwmon";
 		io-channels = <&u75 0>, <&u75 1>, <&u75 2>, <&u75 3>;
 	};
+
+	refhdmi: refhdmi {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <114285000>;
+	};
 };
 
 &can1 {
@@ -520,6 +526,22 @@ i2c@4 {
 			reg = <4>;
 			si5328: clock-generator@69 {/* SI5328 - u20 */
 				reg = <0x69>;
+				/*
+				 * Chip has interrupt present connected to PL
+				 * interrupt-parent = <&>;
+				 * interrupts = <>;
+				 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#clock-cells = <1>;
+				clocks = <&refhdmi>;
+				clock-names = "xtal";
+				clock-output-names = "si5328";
+
+				si5328_clk: clk0@0 {
+					reg = <0>;
+					clock-frequency = <27000000>;
+				};
 			};
 		};
 		i2c@5 {
-- 
2.30.0


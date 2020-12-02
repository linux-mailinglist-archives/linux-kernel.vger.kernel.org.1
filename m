Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229152CBF0A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388872AbgLBOHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388793AbgLBOHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:07:49 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A26C061A4C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 06:06:26 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y22so4074029edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VYfQkYRVs47XikdYX7n4vb+ADGi5slPK0VELk2dqs+w=;
        b=s4Bt6ond8f+RcQQIlN7GS6FmmNeEmc+S5Cg/HB/z3plHum23LRkkdxEsA6w/gTii8Z
         Lcn2edDloqqFiOOwlWsJN2C344VX3Sc8gF6SZqikVBOuls18ctDdH0yN/L7XuB3hu1ZO
         a5Gq+gROU1V+0Mn7WG31ZSPyUiQaFxULp4DvH7n61qSuZsEZcebQ41Do3QO6048FQ+0e
         p0jKU2T6WBffB4TWU9oZuX/GZ7Bk6iVOFs9sEzmyzpvsXwL1Efr9LdK/GcVC7amwKpTd
         mynZx1XwhWfel8usgnWhWV0dpy04qlQHksklvZ/RnngogwqkRpwQM56mWArd576XS6OR
         1y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VYfQkYRVs47XikdYX7n4vb+ADGi5slPK0VELk2dqs+w=;
        b=ekM09ibN2pB9UV/zuh22dX+MLU3DSh59JsvWMxzRsfa3Jwp+gJWzgzOMO2VMx+fHX2
         HuGyZEZPmJMuAd+dTAdPiXQcZH98BkH79LitTjLYDwmUtTV4gysJ9ofnryrvbBCk1rWy
         GoolHzXUrWt9u8aDUjX4ktm5zm+RkPQrR3YQp7Uz4qORGnaL5gCtNB1A+dMklgsvVFp+
         8M0AebN8iqflle+hEdYO3JtTxaPh9u5pkRu6CtZsJX/w/PmsFCcu8fiCjN27E1QoebfW
         OfjGXO6CFddjXOBGgm3W0U4oymmoRGEYkpqJgJhAVknTLmflK/iwCqKT/nFSAqvLaQXN
         UPbA==
X-Gm-Message-State: AOAM531YN93BX0AmOzw5FcX/zhnB6TACTBfWhht5AUXKPGypvr9oDsPZ
        +01Hk8H5K8HE/ZeJw5PjpRJxeGguASPlaSCL
X-Google-Smtp-Source: ABdhPJxvtX4Ji1KYbcn/ajq6PnsBUNC4t3vFxBkm1PD0RFPAtnvazVtfL9OZ7fuhSbkEmQXwAziEOw==
X-Received: by 2002:a05:6402:1d13:: with SMTP id dg19mr33800edb.111.1606917985305;
        Wed, 02 Dec 2020 06:06:25 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id op5sm966689ejb.43.2020.12.02.06.06.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 06:06:24 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/12] arm64: dts: zynqmp: Enable phy driver for Sata on zcu102/zcu104/zcu106
Date:   Wed,  2 Dec 2020 15:06:04 +0100
Message-Id: <e13ed467d4ef271de41877343fb8f9376f357927.1606917949.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606917949.git.michal.simek@xilinx.com>
References: <cover.1606917949.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable psgtr driver and write clocks property to get sata to work.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

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
2.29.2


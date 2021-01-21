Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F0F2FEA38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbhAUMiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbhAUMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:36:57 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF9FC061794
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:36:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c6so2290589ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvQMuexDbhMSXwYbNjPquFBOfzpSEFh9WcFXAwIfqIo=;
        b=RPjMKN4Cw7l30TUpPlC9C10+HLQlZRMnvHYK3X8rEmCC+WQrV+eWSrXQ9l0ui3SANf
         MJjjskuZAza5KVUrz7ha5z8poBzPMTJDhaBN7H+CCEVHCCo4lE6Fjdhiefits2l/4kSG
         Q2vW5uXdVwpMp5tzQdtNQ6YMe0fyM3rffOy4K844a+jwQ5qAA6w5an0KTHE3ZpiNdh6d
         RP+04glJ1qdkk3zIp2vwTEaq2Y0kAxDh+iBWTuvTBVEmJMKKgYFoPF38IHXhDRpA1oQR
         g68L2UmN2aJsxUtlIBMvwO4ge5+pjofs/YT+2Tt4mFzKAila7jRyionzi45/IyiIjimQ
         DYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yvQMuexDbhMSXwYbNjPquFBOfzpSEFh9WcFXAwIfqIo=;
        b=MW/VCelWNVWSznIxONCw2SzzGY51d1H8oZDO8M7ljqQ09yuYX6gbXusAzaKYhPQRa4
         QsDYg1mlHJ3tPrAIR7SSTmAfenwe2isqpyO5ULE2nkJbKtqRiRoFHXrfgpzPIf3MKevf
         MNBffNjMNqiqiqZGdHTzGnGYQ5TJ1rPv6r1yOT+Rr3GB4Fb7cZ1pWrAihR0Lqz3hfUNg
         b12WdWfPx1gWi6CKU670UlBT9/7Ow3tYWAk8p9as7jNXynAkRHUXRETaKhq41MnzKkKh
         J8nOgwADDmbKWAjNN1YMb1xUECEoPYKEURdM252lX0nWKBDgXaaecEQaBA5BbXVvRAle
         J5Cw==
X-Gm-Message-State: AOAM531KZO1e8dSbDGAX3rl7Uq3O78G0mXiyQbW9cIeqMBVxFFLUhrUB
        smSDOd9z5bHivgQV5OiHwFmSnPO2bdHs2Pep
X-Google-Smtp-Source: ABdhPJy6IVsFSZTBKZ2z3IxDESTrY9sQpHaFjC+3KqiYDyRYVVmhyPMbbr8z+Qbas0Z4odhzdxoJYA==
X-Received: by 2002:aa7:d8c6:: with SMTP id k6mr11070408eds.265.1611232574012;
        Thu, 21 Jan 2021 04:36:14 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id gt12sm2168052ejb.38.2021.01.21.04.36.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 04:36:13 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] arm64: dts: zynqmp: Wire up the DisplayPort subsystem
Date:   Thu, 21 Jan 2021 13:36:07 +0100
Message-Id: <9769d4d103b6eb75e3324825117f6832a746004e.1611232558.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611232558.git.michal.simek@xilinx.com>
References: <cover.1611232558.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Enable the dpsub device and wire it up to the PS-GTR PHY lanes routed to
the DisplayPort connector.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Wire all the boards

---
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 31 +++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 10 ++++++
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 11 +++++++
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 11 +++++++
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 11 +++++++
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 11 +++++++
 6 files changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 71ebcaadb7c8..a53598c3624b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -15,6 +15,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
 
 / {
 	model = "ZynqMP ZCU100 RevC";
@@ -108,6 +109,18 @@ ina226 {
 		compatible = "iio-hwmon";
 		io-channels = <&u35 0>, <&u35 1>, <&u35 2>, <&u35 3>;
 	};
+
+	si5335a_0: clk26 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+	};
+
+	si5335a_1: clk27 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <27000000>;
+	};
 };
 
 &dcc {
@@ -224,6 +237,13 @@ i2csw_7: i2c@7 {
 	};
 };
 
+&psgtr {
+	status = "okay";
+	/* usb3, dps */
+	clocks = <&si5335a_0>, <&si5335a_1>;
+	clock-names = "ref0", "ref1";
+};
+
 &rtc {
 	status = "okay";
 };
@@ -295,3 +315,14 @@ &usb1 {
 &watchdog0 {
 	status = "okay";
 };
+
+&zynqmp_dpdma {
+	status = "okay";
+};
+
+&zynqmp_dpsub {
+	status = "okay";
+	phy-names = "dp-phy0", "dp-phy1";
+	phys = <&psgtr 1 PHY_TYPE_DP 0 1>,
+	       <&psgtr 0 PHY_TYPE_DP 1 1>;
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 9abd10f6785a..12e8bd48dc8c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -714,3 +714,13 @@ &usb0 {
 &watchdog0 {
 	status = "okay";
 };
+
+&zynqmp_dpdma {
+	status = "okay";
+};
+
+&zynqmp_dpsub {
+	status = "okay";
+	phy-names = "dp-phy0";
+	phys = <&psgtr 1 PHY_TYPE_DP 0 3>;
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 8ede619fea52..5637e1c17fdf 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -224,3 +224,14 @@ &usb0 {
 &watchdog0 {
 	status = "okay";
 };
+
+&zynqmp_dpdma {
+	status = "okay";
+};
+
+&zynqmp_dpsub {
+	status = "okay";
+	phy-names = "dp-phy0", "dp-phy1";
+	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
+	       <&psgtr 0 PHY_TYPE_DP 1 3>;
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index 414f98f1831e..7f2e32831b05 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -280,3 +280,14 @@ &usb0 {
 &watchdog0 {
 	status = "okay";
 };
+
+&zynqmp_dpdma {
+	status = "okay";
+};
+
+&zynqmp_dpsub {
+	status = "okay";
+	phy-names = "dp-phy0", "dp-phy1";
+	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
+	       <&psgtr 0 PHY_TYPE_DP 1 3>;
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index d60a30787022..18771e868399 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -156,6 +156,17 @@ &dcc {
 	status = "okay";
 };
 
+&zynqmp_dpdma {
+	status = "okay";
+};
+
+&zynqmp_dpsub {
+	status = "okay";
+	phy-names = "dp-phy0", "dp-phy1";
+	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
+	       <&psgtr 0 PHY_TYPE_DP 1 3>;
+};
+
 /* fpd_dma clk 667MHz, lpd_dma 500MHz */
 &fpd_dma_chan1 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 758de05c4a4b..d4b68f0d0098 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -584,3 +584,14 @@ &usb0 {
 	status = "okay";
 	dr_mode = "host";
 };
+
+&zynqmp_dpdma {
+	status = "okay";
+};
+
+&zynqmp_dpsub {
+	status = "okay";
+	phy-names = "dp-phy0", "dp-phy1";
+	phys = <&psgtr 1 PHY_TYPE_DP 0 1>,
+	       <&psgtr 0 PHY_TYPE_DP 1 1>;
+};
-- 
2.30.0


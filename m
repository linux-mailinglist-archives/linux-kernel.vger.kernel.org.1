Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2D627DECE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 05:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgI3DS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 23:18:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729941AbgI3DSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 23:18:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6F600B744AEFEB29BC7D;
        Wed, 30 Sep 2020 11:18:42 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 11:18:33 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v6 08/17] ARM: dts: add SD5203 dts
Date:   Wed, 30 Sep 2020 11:17:03 +0800
Message-ID: <20200930031712.2365-9-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200930031712.2365-1-thunder.leizhen@huawei.com>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Add sd5203.dts for Hisilicon SD5203 SoC platform.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/boot/dts/Makefile   |  2 +
 arch/arm/boot/dts/sd5203.dts | 96 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 arch/arm/boot/dts/sd5203.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4572db3fa5ae302..1d1262df5c55907 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -357,6 +357,8 @@ dtb-$(CONFIG_ARCH_MPS2) += \
 	mps2-an399.dtb
 dtb-$(CONFIG_ARCH_MOXART) += \
 	moxart-uc7112lx.dtb
+dtb-$(CONFIG_ARCH_SD5203) += \
+	sd5203.dtb
 dtb-$(CONFIG_SOC_IMX1) += \
 	imx1-ads.dtb \
 	imx1-apf9328.dtb
diff --git a/arch/arm/boot/dts/sd5203.dts b/arch/arm/boot/dts/sd5203.dts
new file mode 100644
index 000000000000000..3cc9a23910be62e
--- /dev/null
+++ b/arch/arm/boot/dts/sd5203.dts
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Hisilicon Limited.
+ *
+ * DTS file for Hisilicon SD5203 Board
+ */
+
+/dts-v1/;
+
+/ {
+	model = "Hisilicon SD5203";
+	compatible = "H836ASDJ", "hisilicon,sd5203";
+	interrupt-parent = <&vic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+		bootargs="console=ttyS0,9600 earlycon=uart8250,mmio32,0x1600d000";
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0 {
+			device_type = "cpu";
+			compatible = "arm,arm926ej-s";
+			reg = <0x0>;
+		};
+	};
+
+	memory@30000000 {
+		device_type = "memory";
+		reg = <0x30000000 0x8000000>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		vic: interrupt-controller@10130000 {
+			compatible = "snps,dw-apb-ictl";
+			reg = <0x10130000 0x1000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		refclk125mhz: refclk125mhz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <125000000>;
+		};
+
+		timer0: timer@16002000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x16002000 0x1000>;
+			interrupts = <4>;
+			clocks = <&refclk125mhz>;
+			clock-names = "apb_pclk";
+		};
+
+		timer1: timer@16003000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x16003000 0x1000>;
+			interrupts = <5>;
+			clocks = <&refclk125mhz>;
+			clock-names = "apb_pclk";
+		};
+
+		uart0: serial@1600d000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x1600d000 0x1000>;
+			bus_id = "uart0";
+			clocks = <&refclk125mhz>;
+			clock-names = "baudclk", "apb_pclk";
+			reg-shift = <2>;
+			interrupts = <17>;
+		};
+
+		uart1: serial@1600c000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x1600c000 0x1000>;
+			clocks = <&refclk125mhz>;
+			clock-names = "baudclk", "apb_pclk";
+			reg-shift = <2>;
+			interrupts = <16>;
+			status = "disabled";
+		};
+	};
+};
-- 
1.8.3



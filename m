Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6040B3045E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393959AbhAZSC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:02:57 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:25998 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730535AbhAZJFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:05:36 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10Q8v7lL001167;
        Tue, 26 Jan 2021 10:04:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=iigpl0j/6WWc2dMLOMBjHHZCmMze+zowu8Z2oNJMXJY=;
 b=w0YcaAwcc82dXpJy7MXlxqDK2JA1/tQREdj/3pkvE4NLQ9VmgR9Yo5RaJnEbqNkZZZpZ
 DPpBrZElESXuqB7iQxCW+NgKwE7BoAQtKOsr3kaLwiH6++WAQpkvFcD1v8/7pJyC+P7w
 RWJBsz32ZBMjfwuwitKeT5eKWtqfwMgr+n8GhRMEYEwBRBsFJfcSXw+aTli7AqezfdNj
 +h/xdgu0Ai+J4nn7F9OYbxVR6rc20/R0avvRM41pxJ4ubCfg7HrP9fyf+TXMtqo9flr1
 Ym5qtYoiq7w0za0weZuYpfGqB9FsY+S9g1aLKhYW0nsaU1M/rlOUDX6XtY4Z/V6IvsQ4 Ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 368a56fvj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 10:04:43 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3E01A10002A;
        Tue, 26 Jan 2021 10:04:43 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1D8FC2288C8;
        Tue, 26 Jan 2021 10:04:43 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Jan 2021 10:04:42
 +0100
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        <marex@denx.de>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 14/14] ARM: dts: stm32: introduce basic boot include on stm32mp15x board
Date:   Tue, 26 Jan 2021 10:01:20 +0100
Message-ID: <20210126090120.19900-15-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_06:2021-01-25,2021-01-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Include this .dtsi file to be backward compatible with old basic bootchain.

For example add:
include "stm32mp15-no-scmi.dtsi" in a stm32mp157c*.dts file.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15-no-scmi.dtsi | 158 +++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp15-no-scmi.dtsi

diff --git a/arch/arm/boot/dts/stm32mp15-no-scmi.dtsi b/arch/arm/boot/dts/stm32mp15-no-scmi.dtsi
new file mode 100644
index 000000000000..4939f96da739
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp15-no-scmi.dtsi
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2020 - All Rights Reserved
+ * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
+ */
+
+/ {
+
+	clocks {
+		clk_hse: clk-hse {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+
+		clk_hsi: clk-hsi {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <64000000>;
+		};
+
+		clk_lse: clk-lse {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+		};
+
+		clk_lsi: clk-lsi {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+		};
+
+		clk_csi: clk-csi {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <4000000>;
+		};
+	};
+
+	cpus {
+		cpu0: cpu@0 {
+			clocks = <&rcc CK_MPU>;
+		};
+
+		cpu1: cpu@1 {
+			clocks = <&rcc CK_MPU>;
+		};
+	};
+
+	reboot {
+		compatible = "syscon-reboot";
+		regmap = <&rcc>;
+		offset = <0x404>;
+		mask = <0x1>;
+	};
+
+	soc {
+		m_can1: can@4400e000 {
+			clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
+		};
+
+		m_can2: can@4400f000 {
+			clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
+		};
+
+		cryp1: cryp@54001000 {
+			clocks = <&rcc CRYP1>;
+			resets = <&rcc CRYP1_R>;
+		};
+
+		dsi: dsi@5a000000 {
+			clocks = <&rcc DSI_K>, <&clk_hse>, <&rcc DSI_PX>;
+		};
+	};
+
+	ahb {
+		m4_rproc: m4@10000000 {
+			resets = <&rcc MCU_R>, <&rcc MCU_HOLD_BOOT_R>;
+
+			m4_system_resources {
+				m4_cec: cec@40016000 {
+					clocks = <&rcc CEC_K>, <&rcc CK_LSE>;
+				};
+
+				m4_m_can1: can@4400e000 {
+					clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
+				};
+
+				m4_m_can2: can@4400f000 {
+					clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
+				};
+			};
+		};
+	};
+
+	firmware {
+		/delete-node/ scmi0;
+		/delete-node/ scmi1;
+	};
+	/delete-node/ sram@2ffff000;
+};
+
+&cec {
+	clocks = <&rcc CEC_K>, <&clk_lse>;
+};
+
+&gpioz {
+	clocks = <&rcc GPIOZ>;
+};
+
+&hash1 {
+	clocks = <&rcc HASH1>;
+	resets = <&rcc HASH1_R>;
+};
+
+&i2c4 {
+	clocks = <&rcc I2C4_K>;
+	resets = <&rcc I2C4_R>;
+};
+
+&i2c6 {
+	clocks = <&rcc I2C6_K>;
+	resets = <&rcc I2C6_R>;
+};
+
+&iwdg2 {
+	clocks = <&rcc IWDG2>, <&rcc CK_LSI>;
+};
+
+&mdma1 {
+	clocks = <&rcc MDMA>;
+	resets = <&rcc MDMA_R>;
+};
+
+&rcc {
+	compatible = "st,stm32mp1-rcc", "syscon";
+	clocks = <&clk_hse>, <&clk_hsi>, <&clk_csi>, <&clk_lse>, <&clk_lsi>;
+};
+
+&rng1 {
+	clocks = <&rcc RNG1_K>;
+	resets = <&rcc RNG1_R>;
+};
+
+&rtc {
+	clocks = <&rcc RTCAPB>, <&rcc RTC>;
+};
+
+&spi6 {
+	clocks = <&rcc SPI6_K>;
+	resets = <&rcc SPI6_R>;
+};
+
+&usart1 {
+	clocks = <&rcc USART1_K>;
+	resets = <&rcc USART1_R>;
+};
-- 
2.17.1


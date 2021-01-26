Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B258C3045E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393932AbhAZSCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:02:06 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5510 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730501AbhAZJFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:05:35 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10Q8v018012790;
        Tue, 26 Jan 2021 10:04:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=L3oXnzqCxtzEKvD3E5tAAz6k/cVU4Ajj3BKSHi4lRxU=;
 b=FpeT54MTRrUJi+2ncn3Z55JZTPn9VIfcT7r60uHDV8v++gfUn6UqQ+/fasLl5NNDIxp7
 p4Nuhak5Xpg8fdksZ8IT52SxFEtcX+W8C6DBeUg/cF5EmXvFqPWcxYw0drdIl7yf1QFI
 lWOf/FI9rM/yZsXQyHpXMfhVdgd/BwOQKpTbNcSGQkwuZ4gGUrOvyH5xxLNQ1hBd5gQ3
 MewnQmCraZqvpKbGgY4bBKG4ruWNpivXoQSwl+qQvzWALuGAYlOiUjtLIeK8MF7hyaGu
 CU2K8QYtu9/jioUv8JZkJnOqzregZaL7MyO5/SdpAa4sWzRWD35sY01xX25N909nR12V hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3689tdr2ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 10:04:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0B763100034;
        Tue, 26 Jan 2021 10:04:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E24102288C8;
        Tue, 26 Jan 2021 10:04:40 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Jan 2021 10:04:40
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
Subject: [PATCH v2 11/14] ARM: dts: stm32: define SCMI resources on stm32mp15
Date:   Tue, 26 Jan 2021 10:01:17 +0100
Message-ID: <20210126090120.19900-12-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_06:2021-01-25,2021-01-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Platform stm32mp15 relies on SCMI resources (clocks and reset domains).
This change adds SCMI resources description in the platform device
tree. SCMI resources uses a mailbox based on some shared memory and
a SMC mailbox notification.

SCMI0 exposes clocks and reset controllers for resources under RCC[TZEN]
configuration control. It is default enabled as SoC default
configuration is RCC[TZEN]=1.

SCMI1 exposes clocks for resources under RCC[MCKPROT] control. The node
is disabled by default as default configuration is RCC[MCKPROT]=0.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 50 +++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 3c75abacb374..da3647373365 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -30,6 +30,56 @@
 		interrupt-parent = <&intc>;
 	};
 
+	scmi_sram: sram@2ffff000 {
+		compatible = "mmio-sram";
+		reg = <0x2ffff000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x2ffff000 0x1000>;
+
+		scmi0_shm: scmi_shm@0 {
+			reg = <0 0x80>;
+		};
+
+		scmi1_shm: scmi_shm@200 {
+			reg = <0x200 0x80>;
+		};
+	};
+
+	firmware {
+		scmi0: scmi0 {
+			compatible = "arm,scmi-smc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			arm,smc-id = <0x82002000>;
+			shmem = <&scmi0_shm>;
+
+			scmi0_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+
+			scmi0_reset: protocol@16 {
+				reg = <0x16>;
+				#reset-cells = <1>;
+			};
+		};
+
+		scmi1: scmi1 {
+			compatible = "arm,scmi-smc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			arm,smc-id = <0x82002001>;
+			shmem = <&scmi1_shm>;
+			status = "disabled";
+
+			scmi1_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.17.1


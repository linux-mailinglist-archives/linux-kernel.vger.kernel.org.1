Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A788A273916
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 05:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgIVDHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 23:07:50 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.196]:28159 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726702AbgIVDHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 23:07:50 -0400
X-Greylist: delayed 1331 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 23:07:49 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id ED75AA6AA08
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 21:46:24 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id KYK0k0cMan9FWKYK0kM2Nv; Mon, 21 Sep 2020 21:46:24 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9Y9J//FeBwV9/JkWvBY23E+3tD7zsxvwKo/8wJze+io=; b=ao/rCG591ogC546X8noN3XPHOb
        lBF1by02XVrFPsZ7G4DQHAbV+s4ZnRXx7RcjBQ54XdOODtHBW8OrOHBNoo+sPkXxGXd7opLNIPj56
        35Kvanek7aHIj+CDFalOM3BA+jbFOMh6oAdnDH7/s5LBodSBHJ3urfnh+ELr/kriQwOqopOSd+PBf
        CA5iP/P23zmE3QBFyHAvf04YoTkaCGtPY+wHIMWmQMb3hqN+7W5QqoV7WSNDxi1+3h2/a9cEp/AAy
        erxYbH/U/njIBMh8/moKfUrnW7tt+/z5njNBy7zEchQnUT1X/q210Cld8SR+hQfcyNg9rxlN80yiM
        ecNyVszQ==;
Received: from 179-197-124-241.user.veloxzone.com.br ([179.197.124.241]:43534 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1kKYK0-000jSR-A0; Mon, 21 Sep 2020 23:46:24 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     manivannan.sadhasivam@linaro.org, afaerber@suse.de,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        helen.koike@collabora.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v7 3/4] ARM: dts: Add Caninos Loucos Labrador v2
Date:   Mon, 21 Sep 2020 23:43:01 -0300
Message-Id: <20200922024302.205062-4-matheus@castello.eng.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922024302.205062-1-matheus@castello.eng.br>
References: <20200922024302.205062-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 179.197.124.241
X-Source-L: No
X-Exim-ID: 1kKYK0-000jSR-A0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.user.veloxzone.com.br (localhost.localdomain) [179.197.124.241]:43534
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 44
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Trees for Caninos Loucos Labrador CoM Core v2 and base board
M v1. Based on the work of Andreas Färber on Lemaker Guitar device tree.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm/boot/dts/Makefile                    |  1 +
 .../arm/boot/dts/owl-s500-labrador-base-m.dts | 35 +++++++++++++++++++
 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi   | 22 ++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-base-m.dts
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4572db3fa5ae..5d5e370af290 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -868,6 +868,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
 dtb-$(CONFIG_ARCH_ACTIONS) += \
 	owl-s500-cubieboard6.dtb \
 	owl-s500-guitar-bb-rev-b.dtb \
+	owl-s500-labrador-base-m.dtb \
 	owl-s500-sparky.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += \
 	prima2-evb.dtb
diff --git a/arch/arm/boot/dts/owl-s500-labrador-base-m.dts b/arch/arm/boot/dts/owl-s500-labrador-base-m.dts
new file mode 100644
index 000000000000..c92f8bdcb331
--- /dev/null
+++ b/arch/arm/boot/dts/owl-s500-labrador-base-m.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Caninos Labrador Base Board
+ *
+ * Copyright (c) 2019-2020 Matheus Castello
+ */
+
+/dts-v1/;
+
+#include "owl-s500-labrador-v2.dtsi"
+
+/ {
+	model = "Caninos Labrador Core v2 on Labrador Base-M v1";
+	compatible = "caninos,labrador-base-m",
+		     "caninos,labrador-v2", "actions,s500";
+
+	aliases {
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+
+	uart3_clk: uart3-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <921600>;
+		#clock-cells = <0>;
+	};
+};
+
+&uart3 {
+	status = "okay";
+	clocks = <&uart3_clk>;
+};
diff --git a/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi b/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
new file mode 100644
index 000000000000..883ff2f9886d
--- /dev/null
+++ b/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Caninos Labrador SoM V2
+ *
+ * Copyright (c) 2019-2020 Matheus Castello
+ */
+
+#include "owl-s500.dtsi"
+
+/ {
+	model = "Caninos Labrador Core V2.1";
+	compatible = "caninos,labrador-v2", "actions,s500";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x80000000>;
+	};
+};
+
+&timer {
+	clocks = <&hosc>;
+};
--
2.28.0


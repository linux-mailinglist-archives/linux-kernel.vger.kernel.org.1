Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F9C273917
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 05:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgIVDHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 23:07:53 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.196]:40117 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbgIVDHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 23:07:50 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 73340E1BEA8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 21:46:31 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id KYK7kgRjxPiqfKYK7kMaqR; Mon, 21 Sep 2020 21:46:31 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nMLNyHL3gCzVy5M5DswFBS+GjX6PNKx5n7eP7xYOTc4=; b=hJzSnzJBCPHiEHZ9hgmQKOicV9
        tOup6Kh9rg29jIqzG3jhTLJ2UIOPa/5zS0wuljqbWmDlueCsZePjluqQ1M+aTKQGGG5yoq59g3EIo
        /Hxy8IitikOXlk3AcMwZI3u1D/a1wUjkgFnp2lUM6Zp2TlL2f3sPoZbSRRa9nwtbgLY2zo8Mcnr9+
        3Om4t2i0Hg34SylUMaVizsLej9h+bRIZODGnzPy+bqUWSziF+e82UP0xKHNelOjZ8/SjkYr/zPbCh
        701v202SBkcnjzQnt1ChNNriZynkHteg6QTrv3VsTxH3XthBIbdYN5ELVN53Jt3afIFV7cwwXPCpN
        w8gWkV7Q==;
Received: from 179-197-124-241.user.veloxzone.com.br ([179.197.124.241]:43534 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1kKYK6-000jSR-OZ; Mon, 21 Sep 2020 23:46:31 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     manivannan.sadhasivam@linaro.org, afaerber@suse.de,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        helen.koike@collabora.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v7 4/4] arm64: dts: Add Caninos Loucos Labrador v3
Date:   Mon, 21 Sep 2020 23:43:02 -0300
Message-Id: <20200922024302.205062-5-matheus@castello.eng.br>
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
X-Exim-ID: 1kKYK6-000jSR-OZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.user.veloxzone.com.br (localhost.localdomain) [179.197.124.241]:43534
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 57
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Trees for Caninos Loucos Labrador CoM Core v3 and base board
M v2. Based on the work of Andreas Färber on Cubieboard 7 device tree.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 arch/arm64/boot/dts/actions/Makefile          |   2 +
 .../dts/actions/s700-labrador-base-m2.dts     |  34 +++++
 .../boot/dts/actions/s700-labrador-v3.dtsi    | 122 ++++++++++++++++++
 3 files changed, 158 insertions(+)
 create mode 100644 arch/arm64/boot/dts/actions/s700-labrador-base-m2.dts
 create mode 100644 arch/arm64/boot/dts/actions/s700-labrador-v3.dtsi

diff --git a/arch/arm64/boot/dts/actions/Makefile b/arch/arm64/boot/dts/actions/Makefile
index b57fd2372ecd..3765697fa91e 100644
--- a/arch/arm64/boot/dts/actions/Makefile
+++ b/arch/arm64/boot/dts/actions/Makefile
@@ -2,4 +2,6 @@

 dtb-$(CONFIG_ARCH_ACTIONS) += s700-cubieboard7.dtb

+dtb-$(CONFIG_ARCH_ACTIONS) += s700-labrador-base-m2.dtb
+
 dtb-$(CONFIG_ARCH_ACTIONS) += s900-bubblegum-96.dtb
diff --git a/arch/arm64/boot/dts/actions/s700-labrador-base-m2.dts b/arch/arm64/boot/dts/actions/s700-labrador-base-m2.dts
new file mode 100644
index 000000000000..63bbca46475b
--- /dev/null
+++ b/arch/arm64/boot/dts/actions/s700-labrador-base-m2.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Matheus Castello
+ */
+
+/dts-v1/;
+
+#include "s700-labrador-v3.dtsi"
+
+/ {
+	compatible = "caninos,labrador-base-m2",
+		     "caninos,labrador-v3", "actions,s700";
+	model = "Caninos Labrador Core v3 on Labrador Base-M v2";
+
+	aliases {
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/actions/s700-labrador-v3.dtsi b/arch/arm64/boot/dts/actions/s700-labrador-v3.dtsi
new file mode 100644
index 000000000000..91addba6382b
--- /dev/null
+++ b/arch/arm64/boot/dts/actions/s700-labrador-v3.dtsi
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Matheus Castello
+ */
+
+#include "s700.dtsi"
+
+/ {
+	compatible = "caninos,labrador-v3", "actions,s700";
+	model = "Caninos Labrador Core v3.1";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	memory@1,e0000000 {
+		device_type = "memory";
+		reg = <0x1 0xe0000000 0x0 0x0>;
+	};
+
+	/* Labrador v3 firmware does not support PSCI */
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x1f000020>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x1f000020>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x1f000020>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x1f000020>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	L2: l2-cache {
+		compatible = "cache";
+		cache-level = <2>;
+	};
+};
+
+&timer {
+	clocks = <&hosc>;
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_default>;
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_default>;
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_default>;
+};
+
+&pinctrl {
+	i2c0_default: i2c0_default {
+		pinmux {
+			groups = "i2c0_mfp";
+			function = "i2c0";
+		};
+		pinconf {
+			pins = "i2c0_sclk", "i2c0_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c1_default: i2c1_default {
+		pinmux {
+			groups = "i2c1_dummy";
+			function = "i2c1";
+		};
+		pinconf {
+			pins = "i2c1_sclk", "i2c1_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c2_default: i2c2_default {
+		pinmux {
+			groups = "i2c2_dummy";
+			function = "i2c2";
+		};
+		pinconf {
+			pins = "i2c2_sclk", "i2c2_sdata";
+			bias-pull-up;
+		};
+	};
+};
--
2.28.0


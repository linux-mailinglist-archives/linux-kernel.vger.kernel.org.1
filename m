Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B229D2E7077
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 13:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgL2MEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 07:04:15 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:53529 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgL2MEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 07:04:14 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AA91223E43;
        Tue, 29 Dec 2020 13:03:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1609243409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gnY3UPjYcfWopvtGtV4S3npengn5TNGmu3KQAdET5QM=;
        b=B0D5D+yqmYS3Yqp17VKaNjyePUioCnLagTbgVDdsHZmVF9cznk1cc72MbJIYV16swi94bU
        50s/jHxuQqRxNJ0/VjRH+LHSbnZBUhSkXT8624gDOP/Ay49QnXAQzXgQ9LTwYOYImSg6in
        DNvwXyaIVwSuk75jhCkP2C5LEwBlKTg=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] arm64: dts: freescale: sl28: add variant 1
Date:   Tue, 29 Dec 2020 13:03:21 +0100
Message-Id: <20201229120321.17103-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201229120321.17103-1-michael@walle.cc>
References: <20201229120321.17103-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a new variant 1 of this board available. It features up to four
SerDes lanes for customer use. Add a new device tree which features just
the basic peripherals. A customer will then have to modify or append to
this device tree.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../fsl-ls1028a-kontron-sl28-var1.dts         | 61 +++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 6f0777ee6cd6..79cb0025fcc6 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-kbox-a-230-ls.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var1.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var2.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var3-ads2.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var4.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
new file mode 100644
index 000000000000..52f2f3ffdce1
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Device Tree file for the Kontron SMARC-sAL28 board.
+ *
+ * This is for the network variant 1 which has one ethernet port. It is
+ * different than the base variant, which also has one port, but here the
+ * port is connected via RGMII. This port is not TSN aware.
+ * None of the  four SerDes lanes are used by the module, instead they are
+ * all led out to the carrier for customer use.
+ *
+ * Copyright (C) 2020 Michael Walle <michael@walle.cc>
+ *
+ */
+
+/dts-v1/;
+#include "fsl-ls1028a-kontron-sl28.dts"
+#include <dt-bindings/net/qca-ar803x.h>
+
+/ {
+	model = "Kontron SMARC-sAL28 (4 Lanes)";
+	compatible = "kontron,sl28-var1", "kontron,sl28", "fsl,ls1028a";
+};
+
+&enetc_port0 {
+	status = "disabled";
+	/delete-property/ phy-handle;
+	/delete-node/ mdio;
+};
+
+
+&enetc_port1 {
+	phy-handle = <&phy0>;
+	phy-connection-type = "rgmii-id";
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy@4 {
+			reg = <0x4>;
+			eee-broken-1000t;
+			eee-broken-100tx;
+
+			qca,clk-out-frequency = <125000000>;
+			qca,clk-out-strength = <AR803X_STRENGTH_FULL>;
+
+			vddio-supply = <&vddh>;
+
+			vddio: vddio-regulator {
+				regulator-name = "VDDIO";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			vddh: vddh-regulator {
+				regulator-name = "VDDH";
+			};
+		};
+	};
+};
-- 
2.20.1


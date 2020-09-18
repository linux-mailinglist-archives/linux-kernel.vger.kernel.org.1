Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3008726FB91
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgIRLeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:34:03 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:29647 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgIRLcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:32:36 -0400
IronPort-SDR: d7nGDUSVHu5i9JOM1nkgSd1eZ69YT9ZHDUiOGJeQwa/isoCQ69eg1R7jvnx297YrybeGE4TdL/
 5Xhl1+vwLzwzrAszIzFulSFROj1Vss3T8/5g/2fVIIm8l/hZpBKO5JySBFbKqSskR7JJVHA2on
 GYjWPkEXzwkvH8HdJDY+wx6z6iyg7pl7tp8S6LZxFB6/W0Dz0FZKEgEKr5GY3O/aHMhXZohXwU
 BZckSBFpe1Ir+awdZbDLdL8Euztps6jLf7cQ95lFontyzoVt5O4HSDNV0e+T4aoSLVxb/TabYH
 oNs=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924476"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 18 Sep 2020 13:31:12 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 18 Sep 2020 13:31:12 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 18 Sep 2020 13:31:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1600428672; x=1631964672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GX5wZ0+85IApg4dWTaSj2/Z312SBu1AW0j++N0jj5C4=;
  b=FRetSmtx78LdPe9GEAHmZvVnEyNFcpsQmY0NmuGjnou3+kijzcQVByll
   0WE9GaLcaIhlPR6OxmLrsymey3puDTvUzAFK6+1BSguelXxveDmFhkaVW
   XN3zc5Isq/8LcZaxvp0yk8ZJ1cXYhkcpjlfyNzN8IW2IoKueWR/f7+0zP
   Zh/KMwwoYEvZDZFbAQi/BR0g2TexWwNPzmV+n47JCZaYBJ0iF2oly3kHH
   QGZm6AOxQjnsXyURbG8QrXgTSiSJLSy3ukeLBc/B2G1+gaCd0o7ZwcXWx
   KJNXh+KFSL82jPTs3T5vlrgmqD0p3RByk7ywAmSrvk7GKGTjtqPXlQXx5
   w==;
IronPort-SDR: wv9SZkGA3SujXPvxrD71j8g3dZO6YXyi6pvqp59hobc9H9sK1cygbEb3GYMyHGWvwPCO9A3YdQ
 J9J8EP6h6dlaxMFCIb+sHtGSKrJHfom1hECLcy0rMBzU91NaJrlA8IbMBybsyN9LT38K80K6qs
 XbWcqJl9CkFbUTWGnE1Mb2jBkODSGY0X6qTW+m/ZwDOzcDK6BaTG9YjhB687dyyYGzNrud8iMW
 LuFAjOeSCMqdOsU7C2BF1Jg5LCPxV7EXEtfXOpD7ylFD1MAkZg0OYbZs106wgLQJZK7/ojXDGf
 ff4=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924475"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Sep 2020 13:31:12 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 1FDE1280075;
        Fri, 18 Sep 2020 13:31:12 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 02/13] ARM: dts: imx7-tqma7: add SPI-NOR flash
Date:   Fri, 18 Sep 2020 13:29:31 +0200
Message-Id: <20200918112942.1367-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI-NOR flash on the SoM was missing from the device tree.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/imx7-tqma7.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-tqma7.dtsi b/arch/arm/boot/dts/imx7-tqma7.dtsi
index 8773344b54aa..fd23f764399a 100644
--- a/arch/arm/boot/dts/imx7-tqma7.dtsi
+++ b/arch/arm/boot/dts/imx7-tqma7.dtsi
@@ -160,6 +160,20 @@
 		>;
 	};
 
+	pinctrl_qspi: qspigrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA00__QSPI_A_DATA0	0x5A
+			MX7D_PAD_EPDC_DATA01__QSPI_A_DATA1	0x5A
+			MX7D_PAD_EPDC_DATA02__QSPI_A_DATA2	0x5A
+			MX7D_PAD_EPDC_DATA03__QSPI_A_DATA3	0x5A
+			MX7D_PAD_EPDC_DATA05__QSPI_A_SCLK	0x11
+			MX7D_PAD_EPDC_DATA06__QSPI_A_SS0_B	0x54
+			MX7D_PAD_EPDC_DATA07__QSPI_A_SS1_B	0x54
+			/* #QSPI_RESET */
+			MX7D_PAD_EPDC_DATA04__GPIO2_IO4		0x40000052
+		>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
@@ -217,6 +231,22 @@
 	};
 };
 
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi>;
+	status = "okay";
+
+	flash0: spinor@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <29000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		reg = <0>;
+	};
+};
+
 &sdma {
 	status = "okay";
 };
-- 
2.17.1


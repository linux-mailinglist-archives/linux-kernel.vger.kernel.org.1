Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74C2A02D1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgJ3K11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:27:27 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:6981 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgJ3K1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:27:25 -0400
IronPort-SDR: 6qAHm0gMCJWAd0q5e/VvvgR2/WDscv1B+64p/Fybd7ix+TCorVi5CKIy2rc64CMeciujk7RPBt
 0J01InOFRqc9Ad6bvZO7bkvWJe4G3qv3DQ8RlBdqelLVa4DJgwSDOBdD717GQKgqySfjXaJk7g
 TL4GVfVtavdfTqKqI9HRq9Sb4vivKVPopI/85kkZ+mObX/bG6Ir8iLJ+lMbLD9fXNlQN4/fyWY
 g50ZAiV5RW0d4r5ZJ5zwaSEO9JHb/sbr8pHTboVhv/vQC38rl0c7g2BsL0oMhtbG429CiXc/6V
 S90=
X-IronPort-AV: E=Sophos;i="5.77,432,1596492000"; 
   d="scan'208";a="14511047"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 30 Oct 2020 11:27:21 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 30 Oct 2020 11:27:20 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 30 Oct 2020 11:27:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1604053641; x=1635589641;
  h=from:to:cc:subject:date:message-id;
  bh=s0F/5LqXzRIj9UmZbBqtgCyxmiNUFMVVnpLGmEUgqK4=;
  b=clgBqBIZ7HKqCLJj+unM3xPLv2XSN72Kc6ouXP8NYl3z2EzoKayiJT5c
   l4GD7eyBzYt6thXhX7Ni1edC6yNqi6G7+onShPWmPv7Zd1gXIYcHThhGP
   L7V81ajY6YKi5pKuj2OPRFta9mh+G0AzISE5NfUURL9nI4y+aPR1PUHmY
   ICGLM5FmmNSyJMlc3VS4T6sDmMSs6f9NEoRw8VsQw44SbcxCpQz7sGZ4f
   /GXUBmgOqH2Y98jQq09mpsb3SNtRkVDkl/Nq66bO+xWOv3rjVwt77yB50
   CVAk9O8JeeF2tuW2mgKR3ifLO0JIcVAgZXBH7rRw5mfYAEGCfhk/Qvg1r
   A==;
IronPort-SDR: dvhffsNshKMCV61oP97Vd5G3/2o4QeNhU+ZDYgy0NgNxOdaaWBesO6k26Sa9kK4Xk1UxWTpc9/
 PzKCabYUan4VuKRSRIWJyBHk4iwn84NGVov8lQMuHx/JI+ZCb7CGX3bSDRcTAfI1gtex0Ibcp+
 FMHF4et1mml8w83UruOMxJpKum10MaXaqY8JSr7gjdOhLvMnT8tqcDL/m+bbHanyugnCi6MM9v
 P52YyYdbeMH6EC78tGK3glMLd7eCEnSVAMnMjX0oSJDEYkl7ndI+ozCX/7ChL4Jr+OgF5yx8y5
 9NI=
X-IronPort-AV: E=Sophos;i="5.77,432,1596492000"; 
   d="scan'208";a="14511045"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 30 Oct 2020 11:27:21 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id C4D95280070;
        Fri, 30 Oct 2020 11:27:20 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 1/2] ARM: dts: imx7-tqma7: add SPI-NOR flash
Date:   Fri, 30 Oct 2020 11:26:35 +0100
Message-Id: <20201030102636.16476-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI-NOR flash on the SoM was missing from the device tree.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/imx7-tqma7.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

v2: change node name to flash@0


diff --git a/arch/arm/boot/dts/imx7-tqma7.dtsi b/arch/arm/boot/dts/imx7-tqma7.dtsi
index 8773344b54aa..22f4194322ed 100644
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
+	flash0: flash@0 {
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


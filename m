Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3E026FB8D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIRLef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:34:35 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:29642 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgIRLeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:34:06 -0400
IronPort-SDR: V7WVX72kHlwemhRcgNOeNXZcB1CLd2q9bJoGnudIa7ex4F24XHg9E1lFFW/T9deeWd09gh1dRs
 fZTlHICpOo5p+eCEXyqD14cwpG0XL1tfS+MR7pBvp6h2l55eowHuV+ix7MLXHFSSBzHRoVlm3o
 O9R13QsRUrT1zrRtI1fg2BN/DB1UO7QwFVvvYBSIjZ6JK626M16WIdxCdFwNR0mJylk4RYGymu
 de9RdUK8JnhzEDIQwBsWXcFDmtRipXy10vAWBqKSYuirlPvTNRUaPju1L7rTJy6HYVdGHiYr1S
 e/I=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924490"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 18 Sep 2020 13:31:13 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 18 Sep 2020 13:31:13 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 18 Sep 2020 13:31:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1600428673; x=1631964673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=I10vqLTcoLiOMfZKl6AX4I+2f6thxz8VIpdduM8aJac=;
  b=OTh+syus15S0TFFES7MBicuJAH9ILTar0+tRKOTBl17Fm58tCSJnbbfE
   VSMLneay91FCk0JCgcvEu1U8Wz/GFwCYCBTjvZNM6CAK2g8RVxvUEXz/W
   88GZ2d8juDTNnhEdbBAz6Ubg8G7STM2X7SdVEzxTqmGIEB9P5bRz58M9G
   S+lWwCe0hwL03eujFhLGRlH6ocVLhfbDxQMARo+9Tr1LjNeOnNeNr0JuM
   3YnAJJ81o4BTJcKf2w20MI3xzxSUhTyjKLU0A9A1BZlyD1x6KfYLuGHPE
   1JpyzcuBPEhDRcYPDXSDk5KPH+uqzoytNZjRR7t0/McLnIhZSI2sumGt6
   g==;
IronPort-SDR: Ft+jVMigKDQaYiew1rvqkkV1gBpS94htjQy8Iv4K1ksCEucLt9BOZPGTXslbZpm88wB1mcCt7w
 Gp3r4Brzyw8fAPYzHexNx0cG3k/YGduZ42aErnyD3SwZhmGJkQ1/jA9EAk1pX0fzX1srVk7E6G
 1+c1cVDzcFkKspia6Hmj9kM4fHP6zYrt2Go+fZAiyAK57d1hIL9SVzZDd68qib3RxWCwZqVOv5
 SSj3dY9YXWF0DZiBhaoRtYXc7MPPiy8dD/+8EPWAv9JPdJBlY6zeb29XiIxt+Cj/nktB2WnwII
 NB4=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924489"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Sep 2020 13:31:13 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id ABF3D280070;
        Fri, 18 Sep 2020 13:31:13 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 09/13] ARM: dts: imx7-mba7: add audio support
Date:   Fri, 18 Sep 2020 13:29:38 +0200
Message-Id: <20200918112942.1367-9-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MBa7x is equipped with a TI TLV320AIC3204 audio codec.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/imx7-mba7.dtsi | 38 +++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/imx7-mba7.dtsi
index 215730e0453e..9cfaf0a91100 100644
--- a/arch/arm/boot/dts/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/imx7-mba7.dtsi
@@ -170,6 +170,20 @@
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
+
+	sound {
+		compatible = "fsl,imx-audio-tlv320aic32x4";
+		model = "imx-audio-tlv320aic32x4";
+		ssi-controller = <&sai1>;
+		audio-codec = <&tlv320aic32x4>;
+		audio-routing =
+			"IN3_L", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"IN1_L", "Line In Jack",
+			"IN1_R", "Line In Jack",
+			"Line Out Jack", "LOL",
+			"Line Out Jack", "LOR";
+	};
 };
 
 &adc1 {
@@ -363,13 +377,25 @@
 		>;
 	};
 
-
 	pinctrl_pca9555: pca95550grp {
 		fsl,pins = <
 			MX7D_PAD_ENET1_TX_CLK__GPIO7_IO12	0x78
 		>;
 	};
 
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX7D_PAD_SAI1_MCLK__SAI1_MCLK		0x11
+			MX7D_PAD_SAI1_RX_BCLK__SAI1_RX_BCLK	0x1c
+			MX7D_PAD_SAI1_RX_DATA__SAI1_RX_DATA0	0x1c
+			MX7D_PAD_SAI1_RX_SYNC__SAI2_RX_SYNC	0x1c
+
+			MX7D_PAD_SAI1_TX_BCLK__SAI1_TX_BCLK	0x1c
+			MX7D_PAD_SAI1_TX_DATA__SAI1_TX_DATA0	0x14
+			MX7D_PAD_SAI1_TX_SYNC__SAI1_TX_SYNC	0x14
+		>;
+	};
+
 	pinctrl_uart3: uart3grp {
 		fsl,pins = <
 			MX7D_PAD_UART3_RX_DATA__UART3_DCE_RX	0x7e
@@ -487,6 +513,16 @@
 	status = "okay";
 };
 
+&sai1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	assigned-clocks = <&clks IMX7D_SAI1_ROOT_SRC>,
+			  <&clks IMX7D_SAI1_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
+	assigned-clock-rates = <0>, <36864000>;
+	status = "okay";
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
-- 
2.17.1


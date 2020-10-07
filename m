Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997FE28612D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgJGOYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgJGOYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:24:23 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD98C061755;
        Wed,  7 Oct 2020 07:24:21 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c5so2417897ilr.9;
        Wed, 07 Oct 2020 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSj/UM2360e5ZtD9XOs4mgGC/BNRZvHQoqg5vEMD19s=;
        b=QFpH12dD6BSc3LZwsboImJ1dX8xS7doPSg0RBtp6MYfyDWfgW/KMT3E3FztgFw0XgZ
         siMEl32tRufar+fqwJ6+imEMUQx2VGvYc+JYVMMV+6A9vXi3U96k/5JB1on1K4BG2ZGj
         8h+RJp8X9WFCcNgHG0PwxUAP+LiEg4OgVNGdHQKuvr4n7kk9wrkGaBsrGtaaTcIWDlx6
         F/uLpK95nN9uZl6a1/LItkvvd+QwkQ6fznzAhwuDMv2wpdcwxCnkGjrl53a+AKL2MurV
         NCFLtSVvMedcbmJZRpuIsnpcCOnmSqjQeNiNBM/G116DcEvCkuCwTawby7EH6br+S51J
         wCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSj/UM2360e5ZtD9XOs4mgGC/BNRZvHQoqg5vEMD19s=;
        b=IWOII1dYj6P77epzXdic6GUUzjl4p1PRMCWEFfp6iQfBrWxqkKhUfMN41MqQMyX5U4
         iTincZF9E1Gyi60QJnRhaPcESh9IQEehY+V6iaIZJiwFxPN6BplSQMD94hd79JEuQrf3
         GMH/5lxky1niMAYTMVgp3+97/k0yxtw+4jwD21Lgri3Jeeb6Y7+Vn/RhCNgKqo3tboIM
         dOpG4h7eQGUVqJ5yqaFuahdKvh4EAEy81FPwZSd1SqieZIiNjeaLAmZqsvfMf++RvaQG
         Zcp6CM4qZLF+8JwamSNa7pDR8pxHO1rOyf+1FcvL2XcUTxR32tOLqVz9fyGN/GgFIXZk
         wpMw==
X-Gm-Message-State: AOAM531ewHWtmhmUuW3qrwCdsbv9IRtH/XiVZ9Jm4ALZezYq72rpF/UC
        y11hOMLFQQmw4pLiDT3/BQM=
X-Google-Smtp-Source: ABdhPJwWPdjgMKy0kWogBxnpVfTyUH5LCeUBSX3inRJC3MQQaMDTvOUQ405GSvknXrB2oV07DelT1w==
X-Received: by 2002:a92:4891:: with SMTP id j17mr2733860ilg.65.1602080661196;
        Wed, 07 Oct 2020 07:24:21 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:7c62:dd9d:b755:cfbd])
        by smtp.gmail.com with ESMTPSA id f11sm950788ioj.27.2020.10.07.07.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 07:24:20 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm-beacon-som: Add QSPI NOR flash support
Date:   Wed,  7 Oct 2020 09:24:08 -0500
Message-Id: <20201007142409.235234-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx8mm-beacon-som has a Quad-SPI NOR flash connected to the FlexSPI bus.

This patch enables the FlexSPI bus and configures it to work with the
flash part.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index 397cf8b2f29b..b65059f715cd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -75,6 +75,22 @@ ethphy0: ethernet-phy@0 {
 	};
 };
 
+&flexspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi>;
+	status = "okay";
+
+	flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <80000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
 &i2c1 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -304,6 +320,17 @@ MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
 			>;
 		};
 
+		pinctrl_flexspi: flexspigrp {
+			fsl,pins = <
+				MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK               0x1c2
+				MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B            0x82
+				MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0           0x82
+				MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1           0x82
+				MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2           0x82
+				MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3           0x82
+			>;
+		};
+
 		pinctrl_pmic: pmicirqgrp {
 			fsl,pins = <
 				MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x141
-- 
2.25.1


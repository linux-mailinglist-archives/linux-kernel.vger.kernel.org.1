Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FF02A175D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 13:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgJaMbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 08:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgJaMbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 08:31:36 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E0EC0613D5;
        Sat, 31 Oct 2020 05:31:35 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c11so8877049iln.9;
        Sat, 31 Oct 2020 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nARQl+1h0NGt8ytTBp2IdfDene9e6utN8okCssukx2c=;
        b=kyReB7ZWzGj7gJzszi90EgNq9tg4dwPLJZLRm973Djj74MID9Azk5+/igfh/wTISOd
         QjAYrYLTU4hsKJf31ac5WlbMvqFzSY2NZ3za5upt5G7tNrY/Jt+pAP8AqJ1pHLf8UzA2
         ldb4+fDEVx3lOO05KRVFEq1fPnnNZml40plBwYIsjvqzbmgJgC2RevhYqBdI8QgMfVmS
         WTq2vH+Qq/9Vcd6Ph+FtPklluxvAAgI1bCd09V5cNATUKGvSICwtJl6BTBhPiBaVdTDU
         Rb2Ksq8xbY2zk/sCsIOhItRJHpRfpZQk15ORW0J+nCdzcwhPPkU56oK5pmahBkWW3b8a
         yHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nARQl+1h0NGt8ytTBp2IdfDene9e6utN8okCssukx2c=;
        b=unYfaA09nsec3HGLaXw5BugfsSgBZqS6Wy/SSMWyKIO04xwSBCvRS6fV5R9XSINjzD
         NaCHG/kz8Y6kw6WD7P07g2Rope4MSvQ38RnvyyHwVfESI85a5dxUbS07b4W2/zXGF6hk
         EM53U0YiQs8wHcyqxC5OA5OQH5Fw0DUVB274tj7BEQxhFP4wUy3Qx30ogUWLeP1yzdeN
         boLUCm+s6tfaaIR/K8vSbex6JPOQ9u6bDLkypGgPwYQFFzqaoOoc2axfuf4iu3Bag6Os
         aeuYFZmWrsSWqnLhpzlMR2OQLNH/CNQ8T+9WHvVYoRpPKw8R/6Zfm/razvIJl5cOIY16
         c1Bw==
X-Gm-Message-State: AOAM532KAtPHL9aVntiGyzvT8/31O/tngx8nJLXnXP/h3nT+kdArCrzQ
        3J2a64/YHeRKZqZNZlxKAq4=
X-Google-Smtp-Source: ABdhPJw8YsCunTPo5Gc9nxXhvup7LkS6G9DGzNf+A/5MFC3ov6ZkmONbeXW7P8myLQ4mdWNNs4d1tA==
X-Received: by 2002:a92:5f1a:: with SMTP id t26mr5350295ilb.0.1604147494068;
        Sat, 31 Oct 2020 05:31:34 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:c107:3b4f:7176:6aff])
        by smtp.gmail.com with ESMTPSA id o19sm6821534ilt.24.2020.10.31.05.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 05:31:32 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64: dts: imx8mm-beacon-som: Fix whitespace issue
Date:   Sat, 31 Oct 2020 07:31:14 -0500
Message-Id: <20201031123114.708158-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinmux subnodes are indented too much.  This patch does nothing
more than remove an extra tab.  There are no functional changes.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Rebase on Shawn's branch

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index c74e006ad0e8..6b53830ddf74 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -284,166 +284,166 @@ &wdog1 {
 };
 
 &iomuxc {
-		pinctrl_fec1: fec1grp {
-			fsl,pins = <
-				MX8MM_IOMUXC_ENET_MDC_ENET1_MDC		0x3
-				MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO	0x3
-				MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3	0x1f
-				MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2	0x1f
-				MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1	0x1f
-				MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0	0x1f
-				MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3	0x91
-				MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2	0x91
-				MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1	0x91
-				MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0	0x91
-				MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC	0x1f
-				MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC	0x91
-				MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-				MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-				MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22	0x19
-			>;
-		};
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC		0x3
+			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO	0x3
+			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3	0x1f
+			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2	0x1f
+			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1	0x1f
+			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0	0x1f
+			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3	0x91
+			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2	0x91
+			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1	0x91
+			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0	0x91
+			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC	0x1f
+			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC	0x91
+			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
+			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
+			MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22	0x19
+		>;
+	};
 
-		pinctrl_i2c1: i2c1grp {
-			fsl,pins = <
-				MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c3
-				MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
-			>;
-		};
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c3
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
+		>;
+	};
 
-		pinctrl_i2c3: i2c3grp {
-			fsl,pins = <
-				MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
-				MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
-			>;
-		};
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
+		>;
+	};
 
-		pinctrl_flexspi: flexspigrp {
-			fsl,pins = <
-				MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK               0x1c2
-				MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B            0x82
-				MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0           0x82
-				MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1           0x82
-				MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2           0x82
-				MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3           0x82
-			>;
-		};
+	pinctrl_flexspi: flexspigrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK               0x1c2
+			MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B            0x82
+			MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0           0x82
+			MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1           0x82
+			MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2           0x82
+			MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3           0x82
+		>;
+	};
 
-		pinctrl_pmic: pmicirqgrp {
-			fsl,pins = <
-				MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x141
-			>;
-		};
+	pinctrl_pmic: pmicirqgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x141
+		>;
+	};
 
-		pinctrl_uart1: uart1grp {
-			fsl,pins = <
-				MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
-				MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
-				MX8MM_IOMUXC_UART3_RXD_UART1_DCE_CTS_B	0x140
-				MX8MM_IOMUXC_UART3_TXD_UART1_DCE_RTS_B	0x140
-				MX8MM_IOMUXC_SD1_DATA4_GPIO2_IO6	0x19
-				MX8MM_IOMUXC_SD1_DATA5_GPIO2_IO7	0x19
-				MX8MM_IOMUXC_SD1_DATA6_GPIO2_IO8	0x19
-				MX8MM_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x141
-			>;
-		};
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
+			MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
+			MX8MM_IOMUXC_UART3_RXD_UART1_DCE_CTS_B	0x140
+			MX8MM_IOMUXC_UART3_TXD_UART1_DCE_RTS_B	0x140
+			MX8MM_IOMUXC_SD1_DATA4_GPIO2_IO6	0x19
+			MX8MM_IOMUXC_SD1_DATA5_GPIO2_IO7	0x19
+			MX8MM_IOMUXC_SD1_DATA6_GPIO2_IO8	0x19
+			MX8MM_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x141
+		>;
+	};
 
-		pinctrl_usdhc1_gpio: usdhc1gpiogrp {
-			fsl,pins = <
-				MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x41
-			>;
-		};
+	pinctrl_usdhc1_gpio: usdhc1gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x41
+		>;
+	};
 
-		pinctrl_usdhc1: usdhc1grp {
-			fsl,pins = <
-				MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
-				MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
-				MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
-				MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
-				MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
-				MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
-			>;
-		};
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
+		>;
+	};
 
-		pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
-			fsl,pins = <
-				MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
-				MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
-				MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
-				MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
-				MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
-				MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
-			>;
-		};
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
+		>;
+	};
 
-		pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
-			fsl,pins = <
-				MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
-				MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
-				MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
-				MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
-				MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
-				MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
-			>;
-		};
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
+		>;
+	};
 
-		pinctrl_usdhc3: usdhc3grp {
-			fsl,pins = <
-				MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x190
-				MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d0
-				MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d0
-				MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d0
-				MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d0
-				MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d0
-				MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d0
-				MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d0
-				MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d0
-				MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d0
-				MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x190
-			>;
-		};
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x190
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d0
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d0
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d0
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d0
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d0
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d0
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d0
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d0
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d0
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x190
+		>;
+	};
 
-		pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-			fsl,pins = <
-				MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x194
-				MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4
-				MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d4
-				MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d4
-				MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d4
-				MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d4
-				MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4
-				MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d4
-				MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d4
-				MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4
-				MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x194
-			>;
-		};
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x194
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d4
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d4
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d4
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d4
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d4
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d4
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x194
+		>;
+	};
 
-		pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-			fsl,pins = <
-				MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x196
-				MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6
-				MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d6
-				MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d6
-				MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d6
-				MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d6
-				MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d6
-				MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d6
-				MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d6
-				MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d6
-				MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x196
-			>;
-		};
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x196
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d6
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d6
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d6
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d6
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d6
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d6
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d6
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d6
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x196
+		>;
+	};
 
-		pinctrl_wdog: wdoggrp {
-			fsl,pins = <
-				MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0x166
-			>;
-		};
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0x166
+		>;
+	};
 
-		pinctrl_wlan: wlangrp {
-			fsl,pins = <
-				MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9		0x111
-			>;
-		};
+	pinctrl_wlan: wlangrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9		0x111
+		>;
+	};
 };
-- 
2.25.1


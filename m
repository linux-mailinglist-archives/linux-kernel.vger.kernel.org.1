Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4226E2F7811
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbhAOLyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:54:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbhAOLyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:54:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31A7E2371F;
        Fri, 15 Jan 2021 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610711642;
        bh=fRim8qD8R5lJGkUZ/Ptga+Ex0iMUjyLOdRZwKpko0qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lG9VxK0xVi8PAUOqyy8asqdsKJuYF5pvXGN65ZMJKlX86gjb5GmnmkuWa67LVUoGu
         BXXm7FWiDgUzH+eOHW4/nojjK5NpRqhFGxivJ8nVDQBgVcSwKa5tllXP65whYlA2vu
         Ea5YUNV+PwqBxcyNEAbf8JGuxrQQWdGcjS2XnM+shIThhyrPfLZvTdwSwIXOYIdo38
         Ycw/ijhW80KNdxT29oLHtuA1OLL1NIXoyig95Db/6zGFoGzwMicPu1IEfCKgKi2mt9
         63IhcavjOmNRonIdk5ifCie048fpwCzcvsUr2IiWqXLMXpGVnAyOjY4s2EOyi61p4/
         SAW+HgT/in2Qg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l0Nfz-00FzCF-Pw; Fri, 15 Jan 2021 12:53:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: hikey970-pinctrl.dtsi: add missing pinctrl settings
Date:   Fri, 15 Jan 2021 12:53:57 +0100
Message-Id: <d0246cabeb3873cd5d1ded19fa3b2f964eca8365.1610710288.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610710288.git.mchehab+huawei@kernel.org>
References: <cover.1610710288.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several pinctrl settings that are missing at this
DT file.

Also, the entries are out of order.

Add the missing bits, as they'll be required by the DRM driver - and
probably by other drivers not upstreamed yet.

Reorder the entres, adding the missing bits.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../boot/dts/hisilicon/hikey970-pinctrl.dtsi  | 548 +++++++++++++++++-
 1 file changed, 537 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi
index d456b0aa6f58..75723a1ad5ab 100644
--- a/arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi
@@ -61,6 +61,153 @@ uart6_pmx_func: uart6_pmx_func {
 					0x060 MUX_M1 /* UART6_TXD */
 				>;
 			};
+
+			i2c3_pmx_func: i2c3_pmx_func {
+				pinctrl-single,pins = <
+					0x010 MUX_M1 /* I2C3_SCL */
+					0x014 MUX_M1 /* I2C3_SDA */
+				>;
+			};
+
+			i2c4_pmx_func: i2c4_pmx_func {
+				pinctrl-single,pins = <
+					0x03c MUX_M1 /* I2C4_SCL */
+					0x040 MUX_M1 /* I2C4_SDA */
+				>;
+			};
+
+			cam0_rst_pmx_func: cam0_rst_pmx_func {
+				pinctrl-single,pins = <
+					0x714 MUX_M0 /* CAM0_RST */
+				>;
+			};
+
+			cam1_rst_pmx_func: cam1_rst_pmx_func {
+				pinctrl-single,pins = <
+					0x048 MUX_M0 /* CAM1_RST */
+				>;
+			};
+
+			cam0_pwd_n_pmx_func: cam0_pwd_n_pmx_func {
+				pinctrl-single,pins = <
+					0x098 MUX_M0 /* CAM0_PWD_N */
+				>;
+			};
+
+			cam1_pwd_n_pmx_func: cam1_pwd_n_pmx_func {
+				pinctrl-single,pins = <
+					0x044 MUX_M0 /* CAM1_PWD_N */
+				>;
+			};
+
+			isp0_pmx_func: isp0_pmx_func {
+				pinctrl-single,pins = <
+					0x018 MUX_M1 /* ISP_CLK0 */
+					0x024 MUX_M1 /* ISP_SCL0 */
+					0x028 MUX_M1 /* ISP_SDA0 */
+				>;
+			};
+
+			isp1_pmx_func: isp1_pmx_func {
+				pinctrl-single,pins = <
+					0x01c MUX_M1 /* ISP_CLK1 */
+					0x02c MUX_M1 /* ISP_SCL1 */
+					0x030 MUX_M1 /* ISP_SDA1 */
+				>;
+			};
+		};
+
+		pmx1: pinmux@fff11000 {
+			compatible = "pinctrl-single";
+			reg = <0x0 0xfff11000 0x0 0x73c>;
+			#gpio-range-cells = <0x3>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <0x20>;
+			pinctrl-single,function-mask = <0x7>;
+			/* pin base, nr pins & gpio function */
+			pinctrl-single,gpio-range = <&range 0 46 0>;
+
+			pwr_key_pmx_func: pwr_key_pmx_func {
+				pinctrl-single,pins = <
+					0x064 MUX_M0 /* GPIO_203 */
+				>;
+			};
+
+			pd_pmx_func: pd_pmx_func{
+				pinctrl-single,pins = <
+					0x080 MUX_M0 /* GPIO_221 */
+				>;
+			};
+
+			i2s2_pmx_func: i2s2_pmx_func {
+			    pinctrl-single,pins = <
+					0x050 MUX_M1 /* I2S2_DI */
+					0x054 MUX_M1 /* I2S2_DO */
+					0x058 MUX_M1 /* I2S2_XCLK */
+					0x05c MUX_M1 /* I2S2_XFS */
+			    >;
+			};
+
+			spi0_pmx_func: spi0_pmx_func {
+				pinctrl-single,pins = <
+					0x094 MUX_M1 /* SPI0_CLK */
+					0x098 MUX_M1 /* SPI0_DI */
+					0x09c MUX_M1 /* SPI0_DO */
+					0x0a0 MUX_M1 /* SPI0_CS0_N */
+				>;
+			};
+
+			spi2_pmx_func: spi2_pmx_func {
+				pinctrl-single,pins = <
+					0x710 MUX_M1 /* SPI2_CLK */
+					0x714 MUX_M1 /* SPI2_DI */
+					0x718 MUX_M1 /* SPI2_DO */
+					0x71c MUX_M1 /* SPI2_CS0_N */
+				>;
+			};
+
+			spi3_pmx_func: spi3_pmx_func {
+				pinctrl-single,pins = <
+					0x72c MUX_M1 /* SPI3_CLK */
+					0x730 MUX_M1 /* SPI3_DI */
+					0x734 MUX_M1 /* SPI3_DO */
+					0x738 MUX_M1 /* SPI3_CS0_N */
+				>;
+			};
+
+			i2c0_pmx_func: i2c0_pmx_func {
+				pinctrl-single,pins = <
+					0x020 MUX_M1 /* I2C0_SCL */
+					0x024 MUX_M1 /* I2C0_SDA */
+				>;
+			};
+
+			i2c1_pmx_func: i2c1_pmx_func {
+				pinctrl-single,pins = <
+					0x028 MUX_M1 /* I2C1_SCL */
+					0x02c MUX_M1 /* I2C1_SDA */
+				>;
+			};
+			i2c2_pmx_func: i2c2_pmx_func {
+				pinctrl-single,pins = <
+					0x030 MUX_M1 /* I2C2_SCL */
+					0x034 MUX_M1 /* I2C2_SDA */
+				>;
+			};
+
+			pcie_clkreq_pmx_func: pcie_clkreq_pmx_func {
+				pinctrl-single,pins = <
+					0x084 MUX_M1 /* PCIE0_CLKREQ_N */
+				>;
+			};
+
+			gpio185_pmx_func: gpio185_pmx_func {
+				pinctrl-single,pins = <0x01C    0x1>;
+			};
+
+			gpio185_pmx_idle: gpio185_pmx_idle {
+				pinctrl-single,pins = <0x01C    0x0>;
+			};
 		};
 
 		pmx2: pinmux@e896c800 {
@@ -184,6 +331,108 @@ PULL_UP
 					DRIVE7_02MA DRIVE6_MASK
 				>;
 			};
+
+			i2c3_cfg_func: i2c3_cfg_func {
+				pinctrl-single,pins = <
+					0x014 0x0 /* I2C3_SCL */
+					0x018 0x0 /* I2C3_SDA */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_04MA DRIVE6_MASK
+				>;
+			};
+
+			i2c4_cfg_func: i2c4_cfg_func {
+				pinctrl-single,pins = <
+					0x040 0x0 /* I2C4_SCL */
+					0x044 0x0 /* I2C4_SDA */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_04MA DRIVE6_MASK
+				>;
+			};
+
+			cam0_rst_cfg_func: cam0_rst_cfg_func {
+				pinctrl-single,pins = <
+					0x714 0x0 /* CAM0_RST */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE7_04MA DRIVE6_MASK>;
+			};
+
+			cam1_rst_cfg_func: cam1_rst_cfg_func {
+				pinctrl-single,pins = <
+					0x04C 0x0 /* CAM1_RST */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE7_04MA DRIVE6_MASK>;
+			};
+
+			cam0_pwd_n_cfg_func: cam0_pwd_n_cfg_func {
+				pinctrl-single,pins = <
+					0x09C 0x0 /* CAM0_PWD_N */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE7_04MA DRIVE6_MASK>;
+			};
+
+			cam1_pwd_n_cfg_func: cam1_pwd_n_cfg_func {
+				pinctrl-single,pins = <
+					0x048 0x0 /* CAM1_PWD_N */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE7_04MA DRIVE6_MASK>;
+			};
+
+			isp0_cfg_func: isp0_cfg_func {
+				pinctrl-single,pins = <
+					0x01C 0x0 /* ISP_CLK0 */
+					0x028 0x0 /* ISP_SCL0 */
+					0x02C 0x0 /* ISP_SDA0 */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE7_04MA DRIVE6_MASK>;
+			};
+
+			isp1_cfg_func: isp1_cfg_func {
+				pinctrl-single,pins = <
+					0x020 0x0 /* ISP_CLK1 */
+					0x030 0x0 /* ISP_SCL1 */
+					0x034 0x0 /* ISP_SDA1 */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE7_04MA DRIVE6_MASK>;
+			};
 		};
 
 		pmx5: pinmux@fc182000 {
@@ -338,22 +587,299 @@ DRIVE6_MASK
 			};
 		};
 
-		pmx1: pinmux@fff11000 {
-			compatible = "pinctrl-single";
-			reg = <0x0 0xfff11000 0x0 0x73c>;
-			#gpio-range-cells = <0x3>;
-			#pinctrl-cells = <1>;
-			pinctrl-single,register-width = <0x20>;
-			pinctrl-single,function-mask = <0x7>;
-			/* pin base, nr pins & gpio function */
-			pinctrl-single,gpio-range = <&range 0 46 0>;
-		};
-
 		pmx16: pinmux@fff11800 {
 			compatible = "pinconf-single";
 			reg = <0x0 0xfff11800 0x0 0x73c>;
 			#pinctrl-cells = <1>;
 			pinctrl-single,register-width = <0x20>;
+
+			pwr_key_cfg_func: pwr_key_cfg_func {
+				pinctrl-single,pins = <
+					0x090 0x0 /* GPIO_203 */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_UP  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE7_02MA DRIVE6_MASK>;
+			};
+
+			usb_cfg_func: usb_cfg_func {
+				pinctrl-single,pins = <
+					0x0AC 0x0 /* GPIO_221 */
+				>;
+				pinctrl-single,bias-pulldown  = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup    = <
+					PULL_UP
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_02MA DRIVE6_MASK
+				>;
+			};
+
+			spi0_cfg_func: spi0_cfg_func {
+				pinctrl-single,pins = <
+					0x0c8 0x0 /* SPI0_DI */
+					0x0cc 0x0 /* SPI0_DO */
+					0x0d0 0x0 /* SPI0_CS0_N */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_06MA DRIVE6_MASK
+				>;
+			};
+
+			spi2_cfg_func: spi2_cfg_func {
+				pinctrl-single,pins = <
+					0x714 0x0 /* SPI2_DI */
+					0x718 0x0 /* SPI2_DO */
+					0x71c 0x0 /* SPI2_CS0_N */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_06MA DRIVE6_MASK
+				>;
+			};
+
+			spi3_cfg_func: spi3_cfg_func {
+				pinctrl-single,pins = <
+					0x730 0x0 /* SPI3_DI */
+					0x734 0x0 /* SPI3_DO */
+					0x738 0x0 /* SPI3_CS0_N */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_06MA DRIVE6_MASK
+				>;
+			};
+
+			spi0_clk_cfg_func: spi0_clk_cfg_func {
+				pinctrl-single,pins = <
+					0x0c4 0x0 /* SPI0_CLK */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_10MA DRIVE6_MASK
+				>;
+			};
+
+			spi2_clk_cfg_func: spi2_clk_cfg_func {
+				pinctrl-single,pins = <
+					0x710 0x0 /* SPI2_CLK */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_10MA DRIVE6_MASK
+				>;
+			};
+
+			spi3_clk_cfg_func: spi3_clk_cfg_func {
+				pinctrl-single,pins = <
+					0x72c 0x0 /* SPI3_CLK */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_10MA DRIVE6_MASK
+				>;
+			};
+
+			i2c0_cfg_func: i2c0_cfg_func {
+				pinctrl-single,pins = <
+					0x04c 0x0 /* I2C0_SCL */
+					0x050 0x0 /* I2C0_SDA */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_04MA DRIVE6_MASK
+				>;
+			};
+
+			i2c1_cfg_func: i2c1_cfg_func {
+				pinctrl-single,pins = <
+					0x054 0x0 /* I2C1_SCL */
+					0x058 0x0 /* I2C1_SDA */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_04MA DRIVE6_MASK
+				>;
+			};
+
+			i2c2_cfg_func: i2c2_cfg_func {
+				pinctrl-single,pins = <
+					0x05c 0x0 /* I2C2_SCL */
+					0x060 0x0 /* I2C2_SDA */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_04MA DRIVE6_MASK
+				>;
+			};
+
+			pcie_clkreq_cfg_func: pcie_clkreq_cfg_func {
+				pinctrl-single,pins = <
+					0x0b0 0x0
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_06MA DRIVE6_MASK
+				>;
+			};
+			i2s2_cfg_func: i2s2_cfg_func {
+				pinctrl-single,pins = <
+					0x07c 0x0 /* I2S2_DI */
+					0x080 0x0 /* I2S2_DO */
+					0x084 0x0 /* I2S2_XCLK */
+					0x088 0x0 /* I2S2_XFS */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_UP
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_02MA DRIVE6_MASK
+				>;
+			};
+
+			gpio185_cfg_func: gpio185_cfg_func {
+				pinctrl-single,pins = <0x048  0>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x00 0x70>;
+				pinctrl-single,slew-rate = <0x0 0x80>;
+			};
+
+			gpio185_cfg_idle: gpio185_cfg_idle {
+				pinctrl-single,pins = <0x048  0>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x00 0x70>;
+				pinctrl-single,slew-rate = <0x0 0x80>;
+			};
 		};
 	};
 };
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97072F7810
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbhAOLyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:54:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbhAOLyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:54:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3528923772;
        Fri, 15 Jan 2021 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610711642;
        bh=USV92BMs6IiraYniF5uVCN42ogiz53DxcKlZ0h19L4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLntkJ8hfIPdicIbnRbvflk3WEMNHOA0PZl5sfeIxSt+doVvCi269WyOKjGN+oAN8
         rN9UYqKTHeqdcSPplg/5EeDyc/XwIqGv7TmOyboDD+yGrwSdpu4p5EuVPVnjKJ9dfB
         Im8UP7cJbId+v0m4r7xUkMAcl7IVC63J2Ic20z12EpZMl7U8gxyI8EOkJ/g2pIKi44
         sNnifuOrcp3l6on1K1XUfum/Wboe3Ir3SvGvYjepecMq593CrHvJi8i3aLoCO5jj1C
         RAS4wUfQ/ryoy4lcZN1TelA1ZyeXASJ3GbiAXXEmulOFWe/U8QuFMROAhgUHAYbDsx
         gacn2J8r7zFFw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l0Nfz-00FzCH-RL; Fri, 15 Jan 2021 12:53:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: hisilicon: hi3670.dtsi: add I2C settings
Date:   Fri, 15 Jan 2021 12:53:58 +0100
Message-Id: <d3e129b4520cb725283ae798664667b6a41837bf.1610710288.git.mchehab+huawei@kernel.org>
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

The I2C buses are not declared at the device tree. As this will
be needed by further patches, add them, keeping all in
disabled state. Per-board settings can override it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 71 +++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 4e73c4614a71..36d3ae493c7d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -715,5 +715,76 @@ dwmmc2: dwmmc2@fc183000 {
 			card-detect-delay = <200>;
 			status = "disabled";
 		};
+
+		/* I2C */
+		i2c0: i2c@ffd71000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xffd71000 0x0 0x1000>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <400000>;
+			clocks = <&iomcu HI3670_CLK_GATE_I2C0>;
+			resets = <&iomcu_rst 0x20 3>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@ffd72000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xffd72000 0x0 0x1000>;
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <400000>;
+			clocks = <&iomcu HI3670_CLK_GATE_I2C1>;
+			resets = <&iomcu_rst 0x20 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pmx_func &i2c1_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@ffd73000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xffd73000 0x0 0x1000>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <400000>;
+			clocks = <&iomcu HI3670_CLK_GATE_I2C2>;
+			resets = <&iomcu_rst 0x20 5>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pmx_func &i2c2_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@fdf0c000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xfdf0c000 0x0 0x1000>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <400000>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_I2C3>;
+			resets = <&crg_rst 0x78 7>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c3_pmx_func &i2c3_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@fdf0d000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xfdf0d000 0x0 0x1000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <400000>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_I2C4>;
+			resets = <&crg_rst 0x78 27>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c4_pmx_func &i2c4_cfg_func>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.29.2


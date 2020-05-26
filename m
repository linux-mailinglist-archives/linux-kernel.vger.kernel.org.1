Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA0C219C3A5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 16:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbgDBOMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 10:12:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40814 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731823AbgDBOL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:11:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id t24so1892613pgj.7;
        Thu, 02 Apr 2020 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KRil4IG/RY96nscl8h3n0Ow1s/U/cZE1l2gDbraOSck=;
        b=PIC13765bN2s0STyZE3R63JlJatZkjsCAY9M0BYQONZWkYyBnMl2sf2DwT/Gasiipt
         F+AZiTp3qjGJDYDj2ghb+i5NCNYR+rAxTbric07Rk/5uOXhSm+Csh7sWNt4w/IoQjDHp
         SvHkozzTqBY23Ywc+3ggPWDcqkLVr8ORrUvlS+NqGO/lPv+1WMid7ndMiFHedP/l8mJN
         vsViU3PVPMxlXQ8yZisLxOkEGjLLVMVZOUJCn5OsuZT2jA2DLTB4lNOKujN2PS0R5aRw
         2kUuegfiWI+dXAwK3pQTCFUVmQyBwBaUvfDhj8ip20xR2GXc1UZz+/f0qg6QZlQ84LjG
         UgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KRil4IG/RY96nscl8h3n0Ow1s/U/cZE1l2gDbraOSck=;
        b=C/1IlQwHsWqkbUoN2BlFq/DhVdtFPWHt+vd/gVk80LeA8qqAylaJKyyF5hAoxwpps5
         JMTkP6Qk4C3TaZw7QAGq1b1/JDmPscwgxh6+jDf439f5xB5S30vl3nt06BYpwQu+tlS+
         pNYP0YfonWZX+bZ5YyUoqL9waAx3uZUbtgOupbAzM7gG7qZob/hB1ctZ7VyOSP/p3lvB
         8iC+3BoF0Mrl0uunrtLFtd1Uj022VWaFGviAOCaKOgt5EugnJpVXvA3pnV6i6MfG+UNa
         4dcT7Oi7ooQ5xjSzwe8QFSVeAE+CxNANmM4VB9UVPHzZspSucV0oNntEzK3Z2NDm8mAd
         OrmA==
X-Gm-Message-State: AGi0PubNmVRby3n4AVLtJ+rokst1+J5VbEvBiOCicjtSqSY2mhhTSrku
        DkIhseEgCIc24xIcWeXIDzk+cYJf
X-Google-Smtp-Source: APiQypIWILFF8219H+fW+mfg8OMS0kZ8gQYTFp44wgce3ClTX4l8bjO2uhgzCPWz03GlHvRVtmpcdw==
X-Received: by 2002:a62:e20c:: with SMTP id a12mr3422338pfi.37.1585836716316;
        Thu, 02 Apr 2020 07:11:56 -0700 (PDT)
Received: from cnn ([42.111.167.250])
        by smtp.gmail.com with ESMTPSA id h64sm3739427pfg.191.2020.04.02.07.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 07:11:55 -0700 (PDT)
Date:   Thu, 2 Apr 2020 19:41:35 +0530
From:   Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
To:     andrew@aj.id.au, joel@jms.id.au
Cc:     sdasari@fb.com, vijaykhemka@fb.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, manikandan.e@hcl.com
Subject: [PATCH v8] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Message-ID: <20200402141135.GA19190@cnn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Yosemite V2 is a facebook multi-node server
platform that host four OCP server. The BMC
in the Yosemite V2 platform based on AST2500 SoC.

This patch adds linux device tree entry related to
Yosemite V2 specific devices connected to BMC SoC.

Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
Acked-by     : Andrew Jeffery <andrew@aj.id.au>
Reviewed-by  : Vijay Khemka <vkhemka@fb.com>
---
---      v8 - Added dtb entry in Makefile as review comment.
---           -Added IPMB bridge device details as review comment.
---      v7 - Added multi-host SOL feature.
---      v6 - Added device tree property for multi-host Mellanox NIC in the ncsi driver.
---      v5 - Spell and contributor name correction.
---           - License identifier changed to GPL-2.0-or-later.
---           - aspeed-gpio.h removed.
---           - FAN2 tacho channel changed.
---      v4 - Bootargs removed.
---      v3 - Uart1 Debug removed .
---      v2 - LPC and VUART removed .
---      v1 - Initial draft.
---
---
 arch/arm/boot/dts/Makefile                         |   1 +
 .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 231 +++++++++++++++++++++
 2 files changed, 232 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fcd607f..00b6649 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1289,6 +1289,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-wedge40.dtb \
 	aspeed-bmc-facebook-wedge100.dtb \
 	aspeed-bmc-facebook-yamp.dtb \
+	aspeed-bmc-facebook-yosemitev2.dtb \
 	aspeed-bmc-ibm-rainier.dtb \
 	aspeed-bmc-intel-s2600wf.dtb \
 	aspeed-bmc-inspur-fp5280g2.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
new file mode 100644
index 0000000..8864e9c
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2018 Facebook Inc.
+/dts-v1/;
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "Facebook Yosemitev2 BMC";
+	compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
+	aliases {
+		serial4 = &uart5;
+	};
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	iio-hwmon {
+		// VOLATAGE SENSOR
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
+		<&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
+		<&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
+		<&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+	};
+};
+&uart1 {
+	// Host1 Console
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+		     &pinctrl_rxd1_default>;
+};
+
+&uart2 {
+	// Host2 Console
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd2_default
+		     &pinctrl_rxd2_default>;
+
+};
+
+&uart3 {
+	// Host3 Console
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd3_default
+		     &pinctrl_rxd3_default>;
+};
+
+&uart4 {
+	// Host4 Console
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd4_default
+		     &pinctrl_rxd4_default>;
+};
+
+&uart5 {
+	// BMC Console
+	status = "okay";
+};
+
+&vuart {
+	// Virtual UART
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	use-ncsi;
+	mlx,multi-host;
+};
+
+&adc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default
+			&pinctrl_adc1_default
+			&pinctrl_adc2_default
+			&pinctrl_adc3_default
+			&pinctrl_adc4_default
+			&pinctrl_adc5_default
+			&pinctrl_adc6_default
+			&pinctrl_adc7_default
+			&pinctrl_adc8_default
+			&pinctrl_adc9_default
+			&pinctrl_adc10_default
+			&pinctrl_adc11_default
+			&pinctrl_adc12_default
+			&pinctrl_adc13_default
+			&pinctrl_adc14_default
+			&pinctrl_adc15_default>;
+};
+
+&i2c1 {
+	//Host1 IPMB bus
+	status = "okay";
+	multi-master;
+	ipmb1@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c3 {
+	//Host2 IPMB bus
+	status = "okay";
+	multi-master;
+	ipmb3@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c5 {
+	//Host3 IPMB bus
+	status = "okay";
+	multi-master;
+	ipmb5@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c7 {
+	//Host4 IPMB bus
+	status = "okay";
+	multi-master;
+	ipmb7@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c8 {
+	status = "okay";
+	//FRU EEPROM
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+	tmp421@4e {
+	//INLET TEMP
+		compatible = "ti,tmp421";
+		reg = <0x4e>;
+	};
+	//OUTLET TEMP
+	tmp421@4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+	//HSC
+	adm1278@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c11 {
+	status = "okay";
+	//MEZZ_TEMP_SENSOR
+	tmp421@1f {
+		compatible = "ti,tmp421";
+		reg = <0x1f>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+	//MEZZ_FRU
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+};
+
+&pwm_tacho {
+	status = "okay";
+	//FSC
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+	fan@1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
+	};
+};
-- 
2.7.4


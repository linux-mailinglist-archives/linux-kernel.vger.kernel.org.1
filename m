Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2288827BF8D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgI2Icz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgI2Icx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:32:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEBEC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:32:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t7so2268111pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UiWcYyOhRC7RXRis+nbhpk3PtdnMz2h/sPkr6CWec0w=;
        b=IiCVmzvedVRtlcLDAz4DyjJL6JSfglyyCYsDIPmWfhrE9kOmedp5D1PU7VYqul2p1y
         9AoC75EDsk6HT1bTSIEY4IQrm4ON7uVdo4qfKNS7EcM1fxmOy/DVuzhv44HEvWFR8N65
         U8++8U5lr323awZlm+75dpInzlk+OAqzZ5VlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UiWcYyOhRC7RXRis+nbhpk3PtdnMz2h/sPkr6CWec0w=;
        b=I9fEHdFMhQerheBof70ffdmP5r0DkY8HrLFoidI8rj8TtUZ1xux4LwoiAfcedx5gHq
         +zOeCP2MXxKlIByso8pfg48ay4DCTv1IDQEx132WDCXcJaP+xnss3jxlrFr28b30LH8u
         2kwuwlHJd9kN4odOrgLOcJRmtTOc7mHDUz0M9tdVt6pmsg+3otB+oNdrqJyYneBFzgBH
         PZFbOZcSWMHsgIjMDWtdLW9xwlmTrjwQkkZZhxh/Y9ATOLjhSABUB1aLEad2LnE9i/yt
         KW+jifsNXDFX+vKZ3EebnJ4IHOqqWBS3f8l1RwGgKGajU+cV+0GIeTWRZlVjiv4BhTwE
         UjNg==
X-Gm-Message-State: AOAM533r+Ip4qZGQ0Nps6gcP3ABrToyHlowNGy423Q/HIiLlfAMP15zd
        ycBk7ItZqq/IKusrFTgMjoESJA==
X-Google-Smtp-Source: ABdhPJxcAsQPiHqm7wbJG/lPjiSE6GtzGhAZeSib8ldx2ZKwGXrnxSubt9VtXr8TD420pNW3JXFy4g==
X-Received: by 2002:a17:90a:e697:: with SMTP id s23mr2888036pjy.175.1601368372751;
        Tue, 29 Sep 2020 01:32:52 -0700 (PDT)
Received: from ub-XPS-13-9350.pdxnet.pdxeng.ch ([2405:201:c809:c7d5:b511:310d:8495:d767])
        by smtp.gmail.com with ESMTPSA id 36sm3961241pgl.72.2020.09.29.01.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 01:32:52 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 3/7] arm64: dts: rockchip: Add Engicam PX30.Core SOM
Date:   Tue, 29 Sep 2020 14:02:13 +0530
Message-Id: <20200929083217.25406-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929083217.25406-1-jagan@amarulasolutions.com>
References: <20200929083217.25406-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.

General features:
- Rockchip PX30
- Up to 2GB DDR4
- eMMC 4 GB expandible
- rest of PX30 features

PX30.Core needs to mount on top of Engicam baseboards for creating
complete platform boards.

Possible baseboards are,
- EDIMM2.2
- C.TOUCH 2.0

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
Changes for v4:
- none
Changes for v3:
- sort regulator nodes properties
- add Amarula Solutions copyright
- update the patch author
Changes for v2:
- none

 .../boot/dts/rockchip/px30-px30-core.dtsi     | 232 ++++++++++++++++++
 1 file changed, 232 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/px30-px30-core.dtsi b/arch/arm64/boot/dts/rockchip/px30-px30-core.dtsi
new file mode 100644
index 000000000000..16e6cf28a440
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-px30-core.dtsi
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutons
+ * Copyright (c) 2020 Amarula Solutons(India)
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+
+/ {
+	compatible = "engicam,px30-px30-core", "rockchip,px30";
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&emmc {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	non-removable;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA7 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int>;
+		rockchip,system-power-controller;
+		wakeup-source;
+		#clock-cells = <1>;
+		clock-output-names = "rk808-clkout1", "rk808-clkout2";
+
+		vcc1-supply = <&vcc5v0_sys>;
+		vcc2-supply = <&vcc5v0_sys>;
+		vcc3-supply = <&vcc5v0_sys>;
+		vcc4-supply = <&vcc5v0_sys>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc5v0_sys>;
+
+		regulators {
+			vdd_log: DCDC_REG1 {
+				regulator-name = "vdd_log";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+				};
+			};
+
+			vdd_arm: DCDC_REG2 {
+				regulator-name = "vdd_arm";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_3v3: DCDC_REG4 {
+				regulator-name = "vcc_3v3";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc3v3_sys: DCDC_REG5 {
+				regulator-name = "vcc3v3_sys";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_1v0: LDO_REG1 {
+				regulator-name = "vcc_1v0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vcc_1v8: LDO_REG2 {
+				regulator-name = "vcc_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd_1v0: LDO_REG3 {
+				regulator-name = "vdd_1v0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vcc3v0_pmu: LDO_REG4 {
+				regulator-name = "vcc3v0_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-name = "vccio_sd";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc5v0_host: SWITCH_REG2 {
+				regulator-name = "vcc5v0_host";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
+&io_domains {
+	vccio1-supply = <&vcc_3v3>;
+	vccio2-supply = <&vcc_3v3>;
+	vccio3-supply = <&vcc_3v3>;
+	vccio4-supply = <&vcc_3v3>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&pinctrl {
+	pmic {
+		pmic_int: pmic_int {
+			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	pmuio1-supply = <&vcc_3v3>;
+	pmuio2-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <1>;
+	status = "okay";
+};
-- 
2.25.1


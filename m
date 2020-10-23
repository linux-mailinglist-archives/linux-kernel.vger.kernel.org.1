Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D092976C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750074AbgJWSSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465122AbgJWSSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:18:37 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81622C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:18:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f38so1893935pgm.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TodvX9MTBX7vTykdv70rmek7Lo3V0evCYJjQaUL+VJE=;
        b=pk9cTuw5sWjL9dMKYE/Zfxs3S2rkulRAJrsheIWcrgFP8sZyVF8n+sITafKUJONJr9
         lgdBm3Pr4BRoNjcEasVyfAstxqMSmZBHuE8IJ85+q+He1IihI7qo8yPp9K6n5Ehwc4C6
         DldFcIvPFLQ3qIVmAatrU9ap8S6guuEdQZKnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TodvX9MTBX7vTykdv70rmek7Lo3V0evCYJjQaUL+VJE=;
        b=bBdkjT2TIYlGZy+DVXt5i0df5JJDuoauTyOnssHudGtVmenmEBz14tOm5LkUreRu2d
         RzwQ9fCJQVBzTBuo9gRL/O1BC/xQcUHR+VYik2KVO3RFeYrwuBcEQd5+71cSfAvj8yfc
         paxkj4pc4o7rj0WW+McPmkfjneAk4Q/5NNSLE81Jo1qg56bR5Ta0TqCqg0CSBWTPWAku
         V+JZFL2Vi2B/bLVI3oMah21ixxH+i9MkiqA5mxSCg1ADqC5/TTpT3ZRCi9QebOjgJG80
         g5TqvR+0WJZpFe3z/SOW4kvDvySyWosHW1ce18+9d7kBJoNQELzWR0fsx838JY56e01F
         +WhQ==
X-Gm-Message-State: AOAM5332/5KxCGBL3Ol+rc/VQjIT/np5PW6YuCbTIorJCLh0tb4whNMY
        cM8wLocR9LdUygDtzmNxfaMByg==
X-Google-Smtp-Source: ABdhPJxQW2pUQfxcv7j3aOU6N98NepZVuSxtJOAGI9h+/OdIr68fiDyV4dSGLx4Br4bp3DQaku7nRQ==
X-Received: by 2002:a05:6a00:1742:b029:155:dcd2:9155 with SMTP id j2-20020a056a001742b0290155dcd29155mr3543036pfc.78.1603477116038;
        Fri, 23 Oct 2020 11:18:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7a4:2d08:2249:ad54:d32d])
        by smtp.gmail.com with ESMTPSA id q24sm3271162pfn.72.2020.10.23.11.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:18:35 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Tom Cubie <tom@radxa.com>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/2] ARM: dts: rockchip: Add SDIO0 node for VMARC SOM
Date:   Fri, 23 Oct 2020 23:48:14 +0530
Message-Id: <20201023181814.220974-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023181814.220974-1-jagan@amarulasolutions.com>
References: <20201023181814.220974-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip RK3288 and RK3399Pro based VMARC SOM has sdio0 for
connecting WiFi/BT devices as a pluggable card via M.2 E-Key.

Add associated sdio0 nodes, properties.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-vmarc-som.dtsi       | 40 +++++++++++++++++++
 .../dts/rockchip-radxa-dalang-carrier.dtsi    | 21 ++++++++++
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     | 16 ++++++++
 3 files changed, 77 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-vmarc-som.dtsi b/arch/arm/boot/dts/rk3288-vmarc-som.dtsi
index 4a373f5aa600..353d95b9953b 100644
--- a/arch/arm/boot/dts/rk3288-vmarc-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-vmarc-som.dtsi
@@ -231,6 +231,23 @@ regulator-state-mem {
 	};
 };
 
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	hym8563: hym8563@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "hym8563";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <RK_PC3 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
 &i2c5 {
 	status = "okay";
 };
@@ -241,10 +258,17 @@ &io_domains {
 	gpio1830-supply = <&vcc_18>;
 	gpio30-supply = <&vcc_io>;
 	sdcard-supply = <&vccio_sd>;
+	wifi-supply = <&vcc_wl>;
 	status = "okay";
 };
 
 &pinctrl {
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <5 RK_PC3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	pcfg_pull_none_drv_8ma: pcfg-pull-none-drv-8ma {
 		drive-strength = <8>;
 	};
@@ -260,6 +284,12 @@ pmic_int: pmic-int {
 		};
 	};
 
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	sdmmc {
 		sdmmc_bus4: sdmmc-bus4 {
 			rockchip,pins =
@@ -291,6 +321,16 @@ usb0_en_oc: usb0-en-oc {
 	};
 };
 
+&sdio_pwrseq {
+	/*
+	 * On the module itself this is one of these (depending
+	 * on the actual card populated):
+	 * - SDIO_RESET_L_WL_REG_ON
+	 * - PDN (power down when low)
+	 */
+	reset-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;	/* WIFI_REG_ON */
+};
+
 &usbphy {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
index 26b53eac4706..da1d548b7330 100644
--- a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
+++ b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
@@ -15,6 +15,14 @@ clkin_gmac: external-gmac-clock {
 		#clock-cells = <0>;
 	};
 
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&hym8563>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+	};
+
 	vcc12v_dcin: vcc12v-dcin-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -78,6 +86,19 @@ &pwm2 {
 	status = "okay";
 };
 
+&sdio0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index 5d087be04af8..7257494d2831 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -353,6 +353,12 @@ pmic_int_l: pmic-int-l {
 		};
 	};
 
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	vbus_host {
 		usb1_en_oc: usb1-en-oc {
 			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_up>;
@@ -371,6 +377,16 @@ &pmu_io_domains {
 	pmu1830-supply = <&vcc_1v8>;
 };
 
+&sdio_pwrseq {
+	/*
+	 * On the module itself this is one of these (depending
+	 * on the actual card populated):
+	 * - SDIO_RESET_L_WL_REG_ON
+	 * - PDN (power down when low)
+	 */
+	reset-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_LOW>;
+};
+
 &sdhci {
 	bus-width = <8>;
 	mmc-hs400-1_8v;
-- 
2.25.1


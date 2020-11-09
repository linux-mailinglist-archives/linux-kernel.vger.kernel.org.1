Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B982AC356
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgKISLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730580AbgKISLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:11:04 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D89C0613D4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:11:04 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id z3so8883580pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oy1WSzwflsIVOZ5/8uOOaITBP+5WayH2aQR8Kgtsxu4=;
        b=dtzywe1cxALk0HOLgXYLQHuMEw5wtkpRrCRO1LcqdGzpqPSjpudcguae2oXb17dbk/
         GwUqqWz9f731aSDaicAPQAXJQfmD1F/4rxNNN5d78ecdbyQd5Xd9YCBSSccmqBfXU2XB
         6E8gvPn/7KpyJ06lM0tNavY5VEgpSHiI/6i+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oy1WSzwflsIVOZ5/8uOOaITBP+5WayH2aQR8Kgtsxu4=;
        b=bj8cUcTLI+f+olLeXDUFDc7smULeYSsBQmbQDS0swGtVFdxM85hSJyJK0XXiW07+EX
         S83J1/TYOax0bFSrEFu6rMOiy6OKxdXdyYkOmGCahaiWC8k29MnnBmPBmY3D0bu3+9Oj
         fYfGn8YoyFu5hvrISDItumNSlzkcqCrsOnuUMPaFl+KzG1/UbIVdwA7+4I+PYopTxjgI
         BDcAgcnae8ROe32a5e1m31gswkCJCDmjSmw0XTWCcA+f//O68jPCSPtymmU3BDpiKCes
         W3RDLPBpkOsBRUcWBald33b7YmFM60A+iFbZ12T0X3HLsp9hifoseqhY6NtoSEWvV6iD
         u+WQ==
X-Gm-Message-State: AOAM5337wtS2myv3QZSSLgcD0WlEGlw9RHOdNTg0hcfS5V7pQTwJeGGD
        NEO93y9bBI80pX48tgLOG5LlEA==
X-Google-Smtp-Source: ABdhPJwwjh5/eOsviuhwmOZ4kdqHmmRdEhkA7XeJSn1GUE3T5tptRqYWzbbTsQov7XVLc6W81o+9Fw==
X-Received: by 2002:a63:f611:: with SMTP id m17mr13686101pgh.178.1604945463867;
        Mon, 09 Nov 2020 10:11:03 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7a4:c0f0:b8ab:4687:594d])
        by smtp.gmail.com with ESMTPSA id 136sm12027685pfa.132.2020.11.09.10.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:11:03 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 5/9] arm64: dts: rockchip: px30-engicam: Add WiFi support
Date:   Mon,  9 Nov 2020 23:40:13 +0530
Message-Id: <20201109181017.206834-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109181017.206834-1-jagan@amarulasolutions.com>
References: <20201109181017.206834-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suniel Mahesh <sunil@amarulasolutions.com>

Engicam PX30 carrier boards like EDIMM2.2 and C.TOUCH2.0 have
an onboard Sterling-LWD Wifi/BT chip based on BCM43430 connected
on the SDIO bus.

The SDIO power sequnce is connacted with exteernal 32KHz oscillator
and it require 3V3 regulator input.

This patch adds WiFi enablement nodes for these respective boards.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../dts/rockchip/px30-engicam-common.dtsi     | 45 +++++++++++++++++++
 .../dts/rockchip/px30-engicam-ctouch2.dtsi    | 12 +++++
 .../px30-engicam-px30-core-edimm2.2.dts       | 12 +++++
 3 files changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
index 8fdd7ff2fdf9..92681ccf50f1 100644
--- a/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
@@ -14,6 +14,51 @@ vcc5v0_sys: vcc5v0-sys {
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 	};
+
+	xin32k: xin32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "xin32k";
+	};
+
+	vcc3v3_rf_aux_mod: vcc3v3-rf-aux-mod {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_rf_aux_mod";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&xin32k>;
+		clock-names = "ext_clock";
+		post-power-on-delay-ms = <80>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+	};
+};
+
+&sdio {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	bus-width = <4>;
+	clock-frequency = <50000000>;
+	cap-sdio-irq;
+	cap-sd-highspeed;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	sd-uhs-sdr104;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+	};
 };
 
 &gmac {
diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
index 58425b1e559f..d5708779c285 100644
--- a/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
@@ -6,3 +6,15 @@
  */
 
 #include "px30-engicam-common.dtsi"
+
+&pinctrl {
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&sdio_pwrseq {
+	reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-px30-core-edimm2.2.dts b/arch/arm64/boot/dts/rockchip/px30-engicam-px30-core-edimm2.2.dts
index e54d1e480daa..913444548b59 100644
--- a/arch/arm64/boot/dts/rockchip/px30-engicam-px30-core-edimm2.2.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-px30-core-edimm2.2.dts
@@ -19,3 +19,15 @@ chosen {
 		stdout-path = "serial2:115200n8";
 	};
 };
+
+&pinctrl {
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&sdio_pwrseq {
+	reset-gpios = <&gpio1 RK_PC3 GPIO_ACTIVE_LOW>;
+};
-- 
2.25.1


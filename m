Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4642AC358
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgKISLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbgKISLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:11:08 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A12CC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:11:08 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w14so6282724pfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tIeFiQnLUuCZywXPLVslCtTSylPuUHXE2jKWwkzFbJ0=;
        b=TfEF0NM22W03n74gvA1fowPmhoGvIxqKHADn7anF50EsdtaN3gAuVwEdZ8IOgY7NYL
         ENivVgLx7oCw7vdizPPa4fhaEoiuay2dTVq1Xmzu9ITH97mr6X83SeOuLMPSvR9GL+vE
         h1JFJwd3Pd5mDaDGF+kp7V0aFVamibzl7+0n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tIeFiQnLUuCZywXPLVslCtTSylPuUHXE2jKWwkzFbJ0=;
        b=UFrVrlAwXI6k/0RQvRF0MNFIx9i7LKvyg0OevbnpVpSbZ4gjXtbHS0f5Y2Sb+KKDJ2
         CkSBuI5OQvP7mr6MgJhFBsRcYS4wcBiB+kjOGAvZvBZC8VGaboMr0fCQgwDQwEMbY2re
         85ITEwV6B/wDRYtsjzxzS5dtX0AzqnRfZxc9DyGrn/41fiVbFRrxU+I5qAADCeibPypD
         1Ux3rQ8K2XkO8gjWm5zspi42Y7jHOBl5/PWyyxyn99Y9TH5wKv2mdbEe77cmJHQLN3Zi
         +aXpZ881KQOomQDnCw5Je2UASKoKhAw12cfaXjvuOsTR4uJDDOt/fNgC8gqTce55d5ww
         rbuw==
X-Gm-Message-State: AOAM5313k82jaOn7lOwANsWP+2AJCkr5yDK+jMKqYMKzwI6gOY1aQVqj
        dfCElFXtH1sRWF4uKh7WpYSWmA==
X-Google-Smtp-Source: ABdhPJyE0V488QzrR1u+TMMxKwl6j3KSr7TaKRyWlI9fvEUjFDQpdEnszqr/B9XslV9/Ef/CFmxL8g==
X-Received: by 2002:a63:7a51:: with SMTP id j17mr13437221pgn.186.1604945467899;
        Mon, 09 Nov 2020 10:11:07 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7a4:c0f0:b8ab:4687:594d])
        by smtp.gmail.com with ESMTPSA id 136sm12027685pfa.132.2020.11.09.10.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:11:07 -0800 (PST)
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
Subject: [PATCH 6/9] arm64: dts: rockchip: px30-engicam: Add BT support
Date:   Mon,  9 Nov 2020 23:40:14 +0530
Message-Id: <20201109181017.206834-7-jagan@amarulasolutions.com>
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
on the UART bus.

UART bus on the design routed via USB to UART CP20x bridge. This
bridge powered from 3V3 regualtor gpio.

This patch adds BT enablement nodes for these respective boards.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../arm64/boot/dts/rockchip/px30-engicam-common.dtsi | 12 ++++++++++++
 .../boot/dts/rockchip/px30-engicam-ctouch2.dtsi      | 10 ++++++++++
 .../dts/rockchip/px30-engicam-px30-core-edimm2.2.dts | 10 ++++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
index 92681ccf50f1..eb2be7893863 100644
--- a/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
@@ -40,6 +40,18 @@ sdio_pwrseq: sdio-pwrseq {
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_enable_h>;
 	};
+
+	vcc3v3_btreg: vcc3v3-btreg {
+		compatible = "regulator-gpio";
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_enable_h>;
+		regulator-name = "btreg-gpio-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		states = <3300000 0x0>;
+	};
 };
 
 &sdio {
diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
index d5708779c285..bf10a3d29fca 100644
--- a/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
@@ -8,6 +8,12 @@
 #include "px30-engicam-common.dtsi"
 
 &pinctrl {
+	bt {
+		bt_enable_h: bt-enable-h {
+			rockchip,pins = <1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	sdio-pwrseq {
 		wifi_enable_h: wifi-enable-h {
 			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -18,3 +24,7 @@ wifi_enable_h: wifi-enable-h {
 &sdio_pwrseq {
 	reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
 };
+
+&vcc3v3_btreg {
+	enable-gpio = <&gpio1 RK_PC3 GPIO_ACTIVE_HIGH>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-px30-core-edimm2.2.dts b/arch/arm64/boot/dts/rockchip/px30-engicam-px30-core-edimm2.2.dts
index 913444548b59..d759478e1c84 100644
--- a/arch/arm64/boot/dts/rockchip/px30-engicam-px30-core-edimm2.2.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-px30-core-edimm2.2.dts
@@ -21,6 +21,12 @@ chosen {
 };
 
 &pinctrl {
+	bt {
+		bt_enable_h: bt-enable-h {
+			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	sdio-pwrseq {
 		wifi_enable_h: wifi-enable-h {
 			rockchip,pins = <1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -31,3 +37,7 @@ wifi_enable_h: wifi-enable-h {
 &sdio_pwrseq {
 	reset-gpios = <&gpio1 RK_PC3 GPIO_ACTIVE_LOW>;
 };
+
+&vcc3v3_btreg {
+	enable-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
+};
-- 
2.25.1


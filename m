Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529692CCEF4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgLCGBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgLCGBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:01:54 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745E2C061A55;
        Wed,  2 Dec 2020 22:00:44 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id g25so1906474wmh.1;
        Wed, 02 Dec 2020 22:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Q2LsdTBYpLDoB7Cj1Qbdhjz0kWaNgxAFVnGw/sfz1U=;
        b=QtXO3tiAI6/rE9SWRU/ZhO0OVFw6FzMAkpmBXmsCns8KNURciKJ4bYtJsEsqUC3Cro
         Wd1LBED6m2sT9lJZrxnfElSD7CU7LbQqc7TPP67G8I0YoaYVR9XqX230+H4vKuCkOyfJ
         Mbjtf8+A61w845BLTaDvW7xuvLbQxcGu3effd8HSNUxw7IImVDN+CQcb7xAEKiVZ7rnO
         6REB/gdTXZgN/OEwLM5bW/2wHzRFx7Qrcu98TPguIr+PkrNfEWKlHkHcwy+wH2EWrg5C
         Fc0+k5/TjK/Uyhlne6zKpm820Qk1B/Hl+mrtydx+DPNzV51C+RmJTkN6U0H/wAeJfR5d
         5dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Q2LsdTBYpLDoB7Cj1Qbdhjz0kWaNgxAFVnGw/sfz1U=;
        b=T+yASL/BUTNu4+MH39NRblKT/3mtKEtV/FNEsMdtTcD1bGHXuQCqEoZUvu42etsanw
         AJAtiqB547xwbxHR8wmXJvuGS0D6L9mshHz3nFOCO7zQgQquw2KPJAi+JzPlkPnuy3s1
         8mDmUZpcxHyn+a0VxfbzJZj1s1uD8u1VO5Fa1dsZZIlq4ZQfMsWROAP1qlizVnhMK2U2
         zDO4Pmg16OsmiJMEg/cl4SCo1avUD4jI/wV/MDwdwO0xFQ1h0jblaYlSmkAfALbTRIIe
         6BNJ5pL6f9qM24MQ8939OTK8JSgH2qd88+IxvU7DyO2xRBFDaF4pu0jy+/IGGZGDKy1t
         Ta5A==
X-Gm-Message-State: AOAM533QQa6vJRL3Wre8S0CLJm9oJWQTjvUgEK8L8lee2TVPXqHAT2Tr
        7T0dBRB9NKW70uD7l6A66Ro=
X-Google-Smtp-Source: ABdhPJwP/TLaHfs0bgnYof8vTgsePTEkN0CTCkbhP4/YlhSskA2ZUPaMbHH7CW/yL59HpuMxxw7zpQ==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr1367107wml.11.1606975243190;
        Wed, 02 Dec 2020 22:00:43 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i11sm218439wro.85.2020.12.02.22.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:00:42 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v4 7/7] arm64: dts: meson: add audio playback to wetek-play2
Date:   Thu,  3 Dec 2020 06:00:23 +0000
Message-Id: <20201203060023.9454-8-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203060023.9454-1-christianshewitt@gmail.com>
References: <20201203060023.9454-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support limited to HDMI i2s and SPDIF (LPCM).

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../dts/amlogic/meson-gxbb-wetek-play2.dts    | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
index 2ab8a3d10079..f2562c7de67c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
@@ -8,11 +8,19 @@
 
 #include "meson-gxbb-wetek.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "wetek,play2", "amlogic,meson-gxbb";
 	model = "WeTek Play 2";
 
+	spdif_dit: audio-codec-0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
 	leds {
 		led-wifi {
 			label = "wetek-play:wifi-status";
@@ -39,6 +47,59 @@
 			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-WETEK-PLAY2";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_FIFO>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+		};
+
+		dai-link-3 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
+
+			codec-0 {
+				sound-dai = <&spdif_dit>;
+			};
+		};
+
+		dai-link-4 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&aiu {
+	status = "okay";
+	pinctrl-0 = <&spdif_out_y_pins>;
+	pinctrl-names = "default";
 };
 
 &i2c_A {
-- 
2.17.1


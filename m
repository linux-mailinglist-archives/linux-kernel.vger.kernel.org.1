Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429432B3CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgKPGUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgKPGUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:20:51 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519B1C0613CF;
        Sun, 15 Nov 2020 22:20:51 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id d12so17340551wrr.13;
        Sun, 15 Nov 2020 22:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1gIivsKhrs5B4E2eM/SXdSVH3UTq3Ox3b3pPitMs8zM=;
        b=Mj00KA0a7s4QpdkqkPSUoIVCe5VfTiL38H3A13Q1CwiP6l6gZBjrN3DfiIYzehSVeR
         f1mtaedQdInmz3m+Ia+ZCoWGtDYtbk7ilngUhVrgqE92Xo9a+eX2HYlfaYSc6lwesVvK
         zeY21EZy2lhcd9txYzzgKj5KI2sdIi6279Evj4GTs+iQfiCXGPaCxn5RNDjbXhoWaMXg
         HRO8OoYoJuUiX9S7DCZ1Bs7cEc5l8sMTNb0kNSLJnPnI0EUU+uEYb3Yf8zsRkMbmgw22
         mYIb47ZhxzetB5ykPRGbaRsH+c58y4VeE9LAmvxOv8VLeOKXwKdtaf84STQRVJVqKOTM
         w+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1gIivsKhrs5B4E2eM/SXdSVH3UTq3Ox3b3pPitMs8zM=;
        b=C8FnvG9KnyP/VpS+8Sfls2awxbsXM7k+VzYk7/CnKh6+nEzGSLmTJYB+yJjSZWkR4U
         uWMJiiwb1luh79vijrekpgHh4QTHaQueWcB2HuRCb1OoeepXqmnx8mGW8XTFIAFeKCRc
         YTeS5bLD8wmIuPHKezWBq9Qx4bBW/RnjXRuc5m0aEDAFINzrAgLuvUuLuKxu2vH81yMU
         fA3UqdGIl3nnZrUqEcbJlvY9lEAPWlPHgvymurNmAcgALSYY3IrFNa4IYLc8bdKWoqxI
         +jTGPb/mew2vQMKobFWqavahuhzn7K9Buj3OxCU05GDQ1ZGZs0PDN7069bOVzG58XOgR
         YrgQ==
X-Gm-Message-State: AOAM533iUcIjTdlX9W9xEhrInhq3ity7uLTHfbM9Mfbi1nFrJO3KQCm8
        /hwipEs4U5zIfYKPB2hbMHI=
X-Google-Smtp-Source: ABdhPJzX9nR3wvtsqiKz74R6KI/jvBf0xlZXoVn401YSQ4zdG0j+kueNoBq2SybGSrh59EePeSCWtw==
X-Received: by 2002:adf:8028:: with SMTP id 37mr17153751wrk.111.1605507650109;
        Sun, 15 Nov 2020 22:20:50 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m3sm17065985wrv.6.2020.11.15.22.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 22:20:49 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 7/7] arm64: dts: meson: add audio playback to wetek-play2
Date:   Mon, 16 Nov 2020 06:20:31 +0000
Message-Id: <20201116062031.11233-8-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116062031.11233-1-christianshewitt@gmail.com>
References: <20201116062031.11233-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support limited to HDMI i2s and SPDIF (LPCM).

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
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


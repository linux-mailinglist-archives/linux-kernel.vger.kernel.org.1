Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C5E281539
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbgJBOcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388190AbgJBOcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:32:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB3C0613E2;
        Fri,  2 Oct 2020 07:32:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so2049927wrl.12;
        Fri, 02 Oct 2020 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1gIivsKhrs5B4E2eM/SXdSVH3UTq3Ox3b3pPitMs8zM=;
        b=MfBTfakv1DRtuw9LCRw4XUKI/kYSLWvtvMK9+FY9LWPBYKa40UMI4u0TIeCpfNWSyU
         h8v9BKBhEWmYAAVutZzmZGlI9cFjvlgLBKuoVeZjZudhJa9W1uZKQnnHHV4x+cdm8Zc6
         DpuKoW1hlmiQ6Nzuw6CTxk+aTMBmgidolj0Fj+ngitt+nHGa1wyHA/bR2bebyp2CoxVV
         kvn6ZdzqjxjDZXtcGhJ614im0o+M8ANk5EqdxwpyIXNaHwkGFneoX5kNowMHZd4GjBTn
         rdsI5WZxm8dpwai4anLgXgXvUm5W9RLNGkdtGY0xwMkagvbHJj9zf5wOlAcv90jMshdj
         dofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1gIivsKhrs5B4E2eM/SXdSVH3UTq3Ox3b3pPitMs8zM=;
        b=pePb+KioEHEYCNEmSHlDI/tYGhOToX6A+MypH9HbV9MbJ6liRKNDdZAB5X5VPbb17U
         0S7w2g1F0LEXD5xy/P9D0oT4kql8whneDW9l+PGtoU+EChWVdVCStmqLns1eNNRAk+C8
         Zn0suKlkEwF1oglnSovNA/W8HO7jlMYUn0PvXWSIBdcAVZ3bCUiZ9uw9TFBz4ocJDZic
         QDG7FWqAPKF3yIHpRC6WUCkGLYRWuzZHXJiqVm0qJkw91VeNjPcZXwzcnfHHx5uIlOmI
         lHdlFoeKZngkrGuYR/RcxYmor3bSETTUZn4Yi0XK4Ja0B86FmMX1PMB1hTfVwRBjxdZx
         T97w==
X-Gm-Message-State: AOAM532AH4qtGlYBAtPjP6Ak6/XH58q8XhZ/3C9em1ig9dQFi+vcKdAU
        +nVIwwikU2hS8PRLGKDyhw9EpBS/cEY=
X-Google-Smtp-Source: ABdhPJxAsMJBFt1mDap8JdZGwOlH4Qktsgmqvksw+2k8HBZUYiiD/BrMPdckAeioJ12tY1m0Iy9+tw==
X-Received: by 2002:adf:a18c:: with SMTP id u12mr3591224wru.90.1601649129282;
        Fri, 02 Oct 2020 07:32:09 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id w7sm1907392wrm.92.2020.10.02.07.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:32:08 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 10/10] arm64: dts: meson: add audio playback to wetek-play2
Date:   Fri,  2 Oct 2020 14:31:41 +0000
Message-Id: <20201002143141.14870-11-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002143141.14870-1-christianshewitt@gmail.com>
References: <20201002143141.14870-1-christianshewitt@gmail.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C2F2B3D01
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgKPGUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPGUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:20:44 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBDBC0613D1;
        Sun, 15 Nov 2020 22:20:42 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k2so17419187wrx.2;
        Sun, 15 Nov 2020 22:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d988cBXnFVQ/GWsV54ibiM2GROtIFfDIzMG48hK8mIw=;
        b=dyS4m4VPWFRukkjQ39dZz3y6F+S5CWL50MrRNVrAaPWuqOlbfdTc3MYw+ztts8F80W
         CwgUaFxC2F2ysgDeR+ZGn2cQZWSmARarf5CX5+wsdTvD/IyINLxYUncSIfMKZfWnPfz5
         jlHpAPgAth+zavg39MQt2dVx7vvdWY1S/NLel760g7ZkGeuSbUGk55KLDE8QfIkyBy6g
         5rTIek1jS1H4ALjv8OjWKcSfgA5SQdH40HgYdX3M22jqX5yVkBigFm3IQqGGlIyVuGzn
         wo4jTFfxdoqOID97txcb7sV6Vzp9kgkPt2Edb/r6eDANu34MJJHQag0JxfyJ6o+PYIQK
         mAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d988cBXnFVQ/GWsV54ibiM2GROtIFfDIzMG48hK8mIw=;
        b=Vir7kPUrGaC5XU5FCSm1yMaYyzOO1vabaGuUK0FLuCTX6Vq5ricYOtwKM/DSF4RrIx
         vSDDp7QXL0jkB1/MLNCUClst7uOykvQ+27faNXbRKy+3scQSYi9e5wZtd+jgx3RolfYg
         rbUATRPSkReCG61mNI2RGosSxLPDmbXZO2bRj6TCnDv3P7bdGs1n+B/OBwphNqtI7r0Y
         wBOV9CjvL6HF9B+vHhVioUXFoDxOJZTtwDgPIoZcgntW28xRk8NpxvUJD0djlhMQ/AFy
         ab/FiaF5ekej3z5Y5H37LBQu6d8/+1i3iCwgPGSE3zrxn0zMf19PQedVh4sXf2RQzhE0
         PLxA==
X-Gm-Message-State: AOAM533GHYEInb3/CZ1UHsNPvQ+VGNwDpvzvRXF5p1zh/BH+gSw0AsHe
        U5d19wad2tK3zb10BfQ9c53cXslOS7c=
X-Google-Smtp-Source: ABdhPJwRn41L6QLmNecPltMeJiSirI8tr63H8VRB4YLtWAHaygJz0KkkIcHVv3yZNHxsv2Ful0aR9Q==
X-Received: by 2002:a5d:514f:: with SMTP id u15mr16666218wrt.385.1605507641663;
        Sun, 15 Nov 2020 22:20:41 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m3sm17065985wrv.6.2020.11.15.22.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 22:20:41 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 3/7] arm64: dts: meson: add audio playback to khadas-vim2
Date:   Mon, 16 Nov 2020 06:20:27 +0000
Message-Id: <20201116062031.11233-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116062031.11233-1-christianshewitt@gmail.com>
References: <20201116062031.11233-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 44 +++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index bff8ec2c1c70..d4734220443c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -7,9 +7,9 @@
 
 /dts-v1/;
 
-#include <dt-bindings/input/input.h>
-
 #include "meson-gxm.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "khadas,vim2", "amlogic,s912", "amlogic,meson-gxm";
@@ -145,6 +145,45 @@
 		clock-frequency = <32768>;
 		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXM-KHADAS-VIM2";
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
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+		};
+
+		dai-link-2 {
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
 };
 
 &cec_AO {
@@ -154,7 +193,6 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
-
 &cpu_cooling_maps {
 	map0 {
 		cooling-device = <&gpio_fan THERMAL_NO_LIMIT 1>;
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A9B281531
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbgJBOcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388176AbgJBOcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:32:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788F4C0613D0;
        Fri,  2 Oct 2020 07:32:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so1908633wmj.2;
        Fri, 02 Oct 2020 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lDvI8JDwLjhA5jkV3AvGA6unyQL/mwAeBeK74iYRYOY=;
        b=IBzt1wXLRAP5OXl1AVCho6pGVibOE4hdXKs+io0/xIaGLM8ouAJxX2HfBFPzyOnALI
         uV71BLTVIZkhGOCDej5kv8RFqvhMCjXmuyxCRo2EQDytxPPlnXThty9dMjXTgzkx6ZJm
         grYbvcssaH883w0f3h23V2nqI9Omzm1xEA8OmIJCdg5CvfJhllKSwha+5rnraJq7kk+5
         SXZQjRHm/tAd6szw4fV45KCwmJ1yVxYx5m6dYIu3HBXmSRoAGrobzpKyBhU4e9oSEQ4m
         A7N/T9HVHIm6i77XzBgPaEYr1LrKRhRJLX8mc+RCnhjIOa5TusI95bOOzC1vTRib9LkO
         Ye2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lDvI8JDwLjhA5jkV3AvGA6unyQL/mwAeBeK74iYRYOY=;
        b=LISoIFK80ZrB1mMWiZV0PfZbR/Nuq3lqBqe1LARm8fYaYEakldGZuonfUxdskpZ9gB
         zsINHY7WdgJ9wJSinUxnz8fYdfEnxJnpYWxDfMI7oai6sT0DdQ4u/q+b3mC/1uS/iUZK
         DmP5P3QlGR1XTT8IdXEFN7EWvc8oCCEDbNMX21siWi/Gh+sz73Z+rJOdf8f+1lBZLM9H
         jJYI8W0UAjIgYkdR8xs7R8XArwZr1tfOdGzeLICJDrD2AZ+lDJJgEfOY5xo7dbwH+jCq
         l0ztJ1tCgskEgzzyFCG9WvfRgNMLlE+VpwH5PsEs3qm9P6eceSiQcwMdZ3WJGpw3VW/e
         9i5Q==
X-Gm-Message-State: AOAM531XxQywNIQzg4hiw5J7PLC0kZZH5JD3hJKN2dM+/tJZrSoaRvvp
        pdTw2yIp2djEzPi1TJ+VWlw=
X-Google-Smtp-Source: ABdhPJzY7XCXqlnxJ+uSLghfT7uu4+brizDVTK/yBPMA7+xAj8nlahY1gcv4AuHhISIxlo1gDyoRaA==
X-Received: by 2002:a05:600c:21d4:: with SMTP id x20mr3182114wmj.26.1601649124151;
        Fri, 02 Oct 2020 07:32:04 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id w7sm1907392wrm.92.2020.10.02.07.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:32:03 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 08/10] arm64: dts: meson: add audio playback to vega-s95 dtsi
Date:   Fri,  2 Oct 2020 14:31:39 +0000
Message-Id: <20201002143141.14870-9-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002143141.14870-1-christianshewitt@gmail.com>
References: <20201002143141.14870-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support limited to HDMI i2s and SPDIF (LPCM).

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 222ee8069cfa..1300585a1ec7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "meson-gxbb.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "tronsmart,vega-s95", "amlogic,meson-gxbb";
@@ -17,6 +18,13 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	spdif_dit: audio-codec-0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -97,6 +105,59 @@
 		clocks = <&wifi32k>;
 		clock-names = "ext_clock";
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-VEGA-S95";
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
 
 &cec_AO {
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108E8281532
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbgJBOcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388158AbgJBOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:32:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0158AC0613D0;
        Fri,  2 Oct 2020 07:32:01 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e2so1988343wme.1;
        Fri, 02 Oct 2020 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3IIVS7MhfURH0UVnp76zcUfKlv8hfdezuu29h1qTO9Q=;
        b=MT/dm23dknknl82NUiKS5toDjY8Dspqh3oVRx6cYbQvsHxdLfjJWVbNgZzypwLeabf
         oOuITmGGf4OYIRwKH6bwjLX8GVWNVI82hCm3QfoWk9V4xqg/umNEFtMAwgIfoHjRsSbo
         tTYa7XrKRAjYEErslFHmdRDeEw5vBtJFQtM1/isIpN96Qg0SIag8z/uucfCQF7nTP8tO
         jYjyxZKUsi0xe4qBduKgRIvHY1iPEFZZXEMvetBySN28M/VkCUIILbVJlimPoyRvtSTE
         uZBvvpBqRIlNDcziMG4eYGHW36sDNIp1fkgPvWRQeBIRbSvKtS42ReFg0AyURmVFLr7I
         gVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3IIVS7MhfURH0UVnp76zcUfKlv8hfdezuu29h1qTO9Q=;
        b=MBZRjZ6yER6konXcVdneO2AcwQ6+IZiNh3W6zAhx7OIeWTYMiqJKMyprF3eGHAj8KT
         Vu+8qIlMUXzcMa4PoFnMzz131cCIKrnt4NMY/+43G6jJaFJdNfuY35d+K6N31RcibPvC
         jJZqJBseRm2OJ+L4Dcf3EQLJGjTwTeRRUZojx0AC115fuWPMaOMeHPtmiWq8wcta61O2
         gZHjL8m6vBU3rjh3dByfqu3wDhZgJNUqZFJgcV6VJe2/gfIGImA3lFCQdvZKNcgnydKK
         Bw0rDcyIi6nQ2Qgeon1G644S4269IOfNrPVnPF/nYaiq8/gnL2XoY8JiFzbO85o/RT4G
         qxww==
X-Gm-Message-State: AOAM530erk3wo1L5OTjutNCKy6XzivXTzxZ/HBDfdH8V1wvl6tv73gNf
        9kaHpciGd6+wLuctmrM+pGo=
X-Google-Smtp-Source: ABdhPJxv1FFukIDOsjMvcoPqLpB+sbG6b0+XAnD0u2gDzADjf1Rjnv7//yRTGH7MKvpfzkEGMlv0NQ==
X-Received: by 2002:a7b:cc02:: with SMTP id f2mr3137007wmh.1.1601649119669;
        Fri, 02 Oct 2020 07:31:59 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id w7sm1907392wrm.92.2020.10.02.07.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:31:59 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 06/10] arm64: dts: meson: add audio playback to p200
Date:   Fri,  2 Oct 2020 14:31:37 +0000
Message-Id: <20201002143141.14870-7-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002143141.14870-1-christianshewitt@gmail.com>
References: <20201002143141.14870-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support limited to HDMI i2s and SPDIF (LPCM).

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-p200.dts      | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
index 3c93d1898b40..a16dac72600d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
@@ -9,11 +9,19 @@
 
 #include "meson-gxbb-p20x.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "amlogic,p200", "amlogic,meson-gxbb";
 	model = "Amlogic Meson GXBB P200 Development Board";
 
+	spdif_dit: audio-codec-0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
 	avdd18_usb_adc: regulator-avdd18_usb_adc {
 		compatible = "regulator-fixed";
 		regulator-name = "AVDD18_USB_ADC";
@@ -57,6 +65,59 @@
 			press-threshold-microvolt = <0>; /* 0% */
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-P200";
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
 
 &ethmac {
-- 
2.17.1


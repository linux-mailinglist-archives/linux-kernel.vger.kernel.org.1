Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65DE281529
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbgJBObw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbgJBObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:31:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930D3C0613D0;
        Fri,  2 Oct 2020 07:31:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s12so2056421wrw.11;
        Fri, 02 Oct 2020 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UrTzQqJfmOE3wc4LgtWfzvjavE1CxqA487snNOvdDF4=;
        b=HzKtPkn9lPvk9zekQGxzBIYhDFNmhiIH2IVZUA+5GBMe8/a7f/oD87qbUjd8TsEX8L
         UfoFMPFmFb/kcEijFUgXnBuySA4y0wW203Ck5X5rkAxkIm3xI8dl+OS1ZWO4/wJ6Xvue
         KpThXqWs50Q5OyciJu8wYfitbRzkMaz5RVMrsw90jn5d1Jo2709FafQmjG63al/ak9wC
         2hZydOSZH+RZ7xnF5U6GvoDEKOSCzPNejVzm+APlbm4ufNTICeFPN5cARj4BQOTYYcrR
         +wGcFF1WFx66MqyixJl7WvGlWAP11AJRwZWVQUKfBJhRvYugXJFTONBlPO9DI4mNUvWa
         zBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UrTzQqJfmOE3wc4LgtWfzvjavE1CxqA487snNOvdDF4=;
        b=AeE0Z10RrRcRwmn1km6QQ32hwGXYtlQXy37EDp5Y3aLz+wUUuHGG6HCbA2k79esqub
         Ksafkh//1LKWSszcN/peVW7zX4AjgkGTt9S4/d+tPC9hngAJTd0meUGr8xaVehL6QSIa
         8jomrvaQCvgP/TWbRHZl0L8jo9IZtE5ELUJWBxIXGgs3z0/+BbMek9xSMtSF6ROC4h6I
         OPS3t2SbeYRPeqEeQH9L4amsUBgfyCC3BaC3jhyPSbkzSpbf2p9q9RpayQV8qPwEjiP/
         RsQSQNdiAUXsA7UiOAXvMNQFyAOpyp4RvoJGkIwH/UcNN5Tpn+ypHmgLOz0vC5gYgQo6
         fBCA==
X-Gm-Message-State: AOAM531ebwsqMa1wv8xA/HzQ28dLZusZYDmQzc66u2GiKTKjy1l4lCwz
        HjnMQm1v4CkNcD9bTU4YetQ=
X-Google-Smtp-Source: ABdhPJytmUAYV37QaWavgwlpzOpwki1PMc3p+mJ1MwKtsGs63D+2RGUUGDMrlc9koWdviIlzszwzzQ==
X-Received: by 2002:a05:6000:108a:: with SMTP id y10mr3640936wrw.41.1601649108246;
        Fri, 02 Oct 2020 07:31:48 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id w7sm1907392wrm.92.2020.10.02.07.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:31:47 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 01/10] arm64: dts: meson: add audio playback to a95x
Date:   Fri,  2 Oct 2020 14:31:32 +0000
Message-Id: <20201002143141.14870-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002143141.14870-1-christianshewitt@gmail.com>
References: <20201002143141.14870-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index 67d901ed2fa3..b5b11cb9f393 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -10,6 +10,7 @@
 #include "meson-gxbb.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "nexbox,a95x", "amlogic,meson-gxbb";
@@ -139,6 +140,45 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-NEXBOX-A95X";
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
 
 &cvbs_vdac_port {
-- 
2.17.1


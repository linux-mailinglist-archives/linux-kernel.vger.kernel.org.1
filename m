Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7D62DFF76
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgLUSOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgLUSOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:14:22 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCCEC061282
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:13:41 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 3so11822834wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+KwutHWyzn9PxtO0N7Iinmf9zYdkryZ816NS71BKk8=;
        b=ldqnx1j7Ks6lRYx/UBvTxWvpVOMc1MSs4mTUo2PPiSCjT6jKuSWNo1JatbusOuJ5d+
         G0pp1XqnL/0Jk3u8aJdk3wBIvWX3b+0Bq4Z0xUbSUntDV1j05E9OA8bZOYVOnwmqoVv7
         HtgUOw/+DshQZ70V/JebtPpcyiW7frdWWj4ggztpLzJkemtTCsMn4YL39kX1M9cClw7+
         8SBiSZuPWEBUAfvjRtGebyBQLpVkhX7OyL76V8gygAyaw/JYinZesGpBnKxh4aBFk3iP
         R/jL7T3NmSuQhPlWt3mvIEHG19LUwN6VJI+ngNC7Iw4KkcRs9Cav4T8xa7sH9KYrSpGB
         E67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+KwutHWyzn9PxtO0N7Iinmf9zYdkryZ816NS71BKk8=;
        b=lL7Ij5p20bcqKru9tbVk6T2MvfmFF0B2LGeVIUkjBRnujrcuDNRPKgAvlaV0EA6Fa7
         D8eOEy44RpEab1CJe9Hnje7EJuOrGMyXxl8gb6qReNXxHdYTWMvVRjxN0tIx4hbEvjDR
         KUnPc+v/ywF19htzMxhdtTXwmlbBAh2kb9pZYNL+lIzAsw5i8e99uP9jN1qg6ZsL+fpv
         wWkv3EFfha4G3hW96PTW3ihxUQaH4b3hbnii4aDS0l4na1BLBVKbnB9ULlYKJRErrUEr
         9JgD58M1Atzimkth6xOL87N8Ez1tsXcV4yznpNYMzNxQudXD53lkFYW3ebayGXi5lBqH
         B6bg==
X-Gm-Message-State: AOAM530p271c8thAopvpcXB5Cbx9geC94Wv+FidusVBh9uw7U7fK+5QF
        KqHiYZV30kI1ohs5NkjE3w4=
X-Google-Smtp-Source: ABdhPJwf8vXQx3eHs+teSa2YTnl5HqIFCWKxtP2N2IDsGLEMXb60Hsx2tBX///tGDY966BvVeROyIQ==
X-Received: by 2002:a1c:2b46:: with SMTP id r67mr17753384wmr.162.1608574420525;
        Mon, 21 Dec 2020 10:13:40 -0800 (PST)
Received: from localhost.localdomain (p200300f137019000428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3701:9000:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id m11sm23434936wmi.16.2020.12.21.10.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:13:39 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/5] ARM: dts: meson8: add the thermal-zones with cooling configuration
Date:   Mon, 21 Dec 2020 19:13:04 +0100
Message-Id: <20201221181306.904272-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221181306.904272-1-martin.blumenstingl@googlemail.com>
References: <20201221181306.904272-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor kernel uses the following thermal-zone settings:
<= 70°C:
- CPU frequency limited to 1.608GHz
- GPU limited to 511MHz and 5 cores (pixel processors)

<= 80°C:
- CPU frequency limited to 1.2GHz
- GPU limited to 435MHz and 4 cores (pixel processors)

<= 90°C:
- CPU frequency limited to 0.804GHz
- GPU limited to 328MHz and 3 cores (pixel processors)

Add simplified thermal configuration which is taken from the
GXBB/GXL/GXM SoC family (which uses the same manufacturing process and
has the same maximum junction temperature of 125°C). With this the
thermal framework will try to keep the SoC temperature at or below 80°C
which is identical to the vendor kernel (with the exception of one GPU
pixel processor).

The number of GPU cores are not taken into account as this is not
supported.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 54 +++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 04688e8abce2..420324ea2ad7 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/power/meson8-power.h>
 #include <dt-bindings/reset/amlogic,meson8b-clkc-reset.h>
 #include <dt-bindings/reset/amlogic,meson8b-reset.h>
+#include <dt-bindings/thermal/thermal.h>
 #include "meson.dtsi"
 
 / {
@@ -28,6 +29,7 @@ cpu0: cpu@200 {
 			resets = <&clkc CLKC_RESET_CPU0_SOFT_RESET>;
 			operating-points-v2 = <&cpu_opp_table>;
 			clocks = <&clkc CLKID_CPUCLK>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu1: cpu@201 {
@@ -39,6 +41,7 @@ cpu1: cpu@201 {
 			resets = <&clkc CLKC_RESET_CPU1_SOFT_RESET>;
 			operating-points-v2 = <&cpu_opp_table>;
 			clocks = <&clkc CLKID_CPUCLK>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu2: cpu@202 {
@@ -50,6 +53,7 @@ cpu2: cpu@202 {
 			resets = <&clkc CLKC_RESET_CPU2_SOFT_RESET>;
 			operating-points-v2 = <&cpu_opp_table>;
 			clocks = <&clkc CLKID_CPUCLK>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu3: cpu@203 {
@@ -61,6 +65,7 @@ cpu3: cpu@203 {
 			resets = <&clkc CLKC_RESET_CPU3_SOFT_RESET>;
 			operating-points-v2 = <&cpu_opp_table>;
 			clocks = <&clkc CLKID_CPUCLK>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 
@@ -190,6 +195,54 @@ power-firmware@4f00000 {
 		};
 	};
 
+	thermal-zones {
+		soc {
+			polling-delay-passive = <250>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+			thermal-sensors = <&thermal_sensor>;
+
+			cooling-maps {
+				map0 {
+					trip = <&soc_passive>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&soc_hot>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
+			trips {
+				soc_passive: soc-passive {
+					temperature = <80000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+
+				soc_hot: soc-hot {
+					temperature = <90000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "hot";
+				};
+
+				soc_critical: soc-critical {
+					temperature = <110000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	mmcbus: bus@c8000000 {
 		compatible = "simple-bus";
 		reg = <0xc8000000 0x8000>;
@@ -254,6 +307,7 @@ mali: gpu@c0000 {
 			clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_MALI>;
 			clock-names = "bus", "core";
 			operating-points-v2 = <&gpu_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 }; /* end of / */
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104EE2DFF75
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgLUSO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgLUSOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:14:23 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD291C061248
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:13:42 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id y23so11831641wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=htWpp3iKagAp/qem+WLHc63LEn5Nif+eGu8hyXoZAoY=;
        b=MOnQAKHEImD9X64/gcEyDfGlMI84eE0HnR8ZqMOb8Zp39e38nDGCaaj32uQumTrqjX
         iuMJSVwSHRPDweKbfjcmnwAcVdYxY9q4seeWG5F/91coHSMpXGN7c/CTNAoLe2ZYjR03
         Pi8BPVqqqtHRsI2p2KeEjyFoY7SXOWMrINXyoZq/djUxtjBalzh8lMVhs/5V4zf7FPxB
         jsZbUtG3WVrAPGJ828je10I4L74XOuvB64tmffslqgNxiF2SR+jKXr/p9RsuMwbefB9q
         i1LuX3/49qv0M5SPNItpIVnOoAjhH+93RpUklJggFhCIep0BuHJYsitFUSldmkgOgl4H
         6pCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=htWpp3iKagAp/qem+WLHc63LEn5Nif+eGu8hyXoZAoY=;
        b=DCQGTOvGbUH+E3NZRnXNZCtEeDWpFikr58/TgQmciEXr88HDVljGNYRfR3oUekvptP
         NqfhTiq4tUqk1YHtUwi7wMQEKbtHO1bZT9R/RdgAy+6FPA8rczfkSzrWlxwCgm+HWHFi
         vWVkxreXvfA0yxqE1aw4y+Bv5CknRN3rizsFGnBG2tX0NMQzPel2wRi2R74CQZhumiql
         aNKOXz4ziU4VZGtGbvb9CyS6VILVrL3VBoAplsCxdTJcKcv+OC43E6WYb+196DnCDbSY
         n+V8Bq92+ndFumJwwrQEZqDDZKvvzg4qjIElT8UYLAvolrQT4T5oIWheX9kvJXqvHvLZ
         wh1w==
X-Gm-Message-State: AOAM532/ol2j8N12tQXaX0h54uRCBK7r0aZHRGhSrNlpQamT7PySyrqb
        UdDGBmMiV4Ca20G+tC+43+U=
X-Google-Smtp-Source: ABdhPJwPVeC/S2fOq4AHcgYMmdO6siU97r4ZLGePCER4Vy3o/0t1Sshm+A23OGyh+e1krTVohsuGLA==
X-Received: by 2002:a1c:8085:: with SMTP id b127mr17547256wmd.16.1608574421478;
        Mon, 21 Dec 2020 10:13:41 -0800 (PST)
Received: from localhost.localdomain (p200300f137019000428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3701:9000:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id m11sm23434936wmi.16.2020.12.21.10.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:13:40 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 4/5] ARM: dts: meson8b: add the thermal-zones with cooling configuration
Date:   Mon, 21 Dec 2020 19:13:05 +0100
Message-Id: <20201221181306.904272-5-martin.blumenstingl@googlemail.com>
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
- CPU frequency limited to 1.488GHz
- GPU limited to 511MHz and 2 cores (pixel processors)

<= 80°C:
- CPU frequency limited to 1.2GHz
- GPU limited to 435MHz and 2 cores (pixel processors)

<= 90°C:
- CPU frequency limited to 0.804GHz
- GPU limited to 328MHz and 1 core (pixel processor)

Add simplified thermal configuration which is taken from the
GXBB/GXL/GXM SoC family (which uses the same manufacturing process and
has the same maximum junction temperature of 125°C). With this the
thermal framework will try to keep the SoC temperature at or below 80°C
which is identical to the vendor kernel (with the exception of one CPU
frequency step from 1.488GHz to 1.536GHz).

The number of GPU cores are not taken into account as this is not
supported.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 2401cdf5f751..dbf7963b6c87 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/power/meson8-power.h>
 #include <dt-bindings/reset/amlogic,meson8b-reset.h>
 #include <dt-bindings/reset/amlogic,meson8b-clkc-reset.h>
+#include <dt-bindings/thermal/thermal.h>
 #include "meson.dtsi"
 
 / {
@@ -26,6 +27,7 @@ cpu0: cpu@200 {
 			resets = <&clkc CLKC_RESET_CPU0_SOFT_RESET>;
 			operating-points-v2 = <&cpu_opp_table>;
 			clocks = <&clkc CLKID_CPUCLK>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu1: cpu@201 {
@@ -37,6 +39,7 @@ cpu1: cpu@201 {
 			resets = <&clkc CLKC_RESET_CPU1_SOFT_RESET>;
 			operating-points-v2 = <&cpu_opp_table>;
 			clocks = <&clkc CLKID_CPUCLK>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu2: cpu@202 {
@@ -48,6 +51,7 @@ cpu2: cpu@202 {
 			resets = <&clkc CLKC_RESET_CPU2_SOFT_RESET>;
 			operating-points-v2 = <&cpu_opp_table>;
 			clocks = <&clkc CLKID_CPUCLK>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu3: cpu@203 {
@@ -59,6 +63,7 @@ cpu3: cpu@203 {
 			resets = <&clkc CLKC_RESET_CPU3_SOFT_RESET>;
 			operating-points-v2 = <&cpu_opp_table>;
 			clocks = <&clkc CLKID_CPUCLK>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 
@@ -167,6 +172,54 @@ hwrom@0 {
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
@@ -221,6 +274,7 @@ mali: gpu@c0000 {
 			clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_MALI>;
 			clock-names = "bus", "core";
 			operating-points-v2 = <&gpu_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 }; /* end of / */
-- 
2.29.2


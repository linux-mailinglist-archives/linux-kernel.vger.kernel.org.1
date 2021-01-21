Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685802FF329
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbhAUS2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbhAUSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:24:05 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05922C0613ED;
        Thu, 21 Jan 2021 10:23:24 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u11so3558877ljo.13;
        Thu, 21 Jan 2021 10:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5maEnFY9Zpzvtrt4gFbzNHegl8kGjroQ7s0Tf+aY64=;
        b=IokDQnJqE5cWZ9OFF3cTPE4T0vZ/6Ay8800T5GPu+jhwCGZKFun6gWwZEz+XilaTHh
         jx55BS1PJm79rlM0g5UW5vZ5EVQJgNyLMj52Ya8PvRk5UwdZOx64ylr8BT4y7E23vCWK
         IpR5opDxoRNMZLes09Jl6favSsQgjTtko/sWji4vc7Z/+WdUpMG+Ob+ttC9UzrTqIZkc
         /sKPkphst9mXFTv3Xn+J52w3SMl6N00zpcb9ANsV5RXG8lzFhmdijOy1ef0Ktl+NwdYd
         KJffAqRGz3G10fz//MNjSFC7J7S4zhY9WKSUn1zknZsiGdZA0oRLiPkWq52+y21V6WBf
         tpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5maEnFY9Zpzvtrt4gFbzNHegl8kGjroQ7s0Tf+aY64=;
        b=eB6Gb/ci1Eq0HbcyFEXpINSiprTznc4Jd33qAMFlmq886fduwkLz2hxHdpmhEyOreE
         gWH0F9mGu81RLZO1BS3CcnD8gJkMtZBXB9BAyfK1JVgS5eG0/EF1qyLiTohWh8YdKbWg
         3taezfqejRVdVlkuft0I2rX61CtTAmUdZflZicEUJ5T/uFkpKD5JfyKPEL0QBszOeCYH
         kvBTreffr8cYQRvpqjmCPznw2wpgx1ytU5P/Ds9Su4yy6oycDFY5J+8+4e2AL4ZQJ1sn
         WgT/lMMMigZyHF8R4sThKZQnZadzy/30dQ8DINYs5kG/Jkpv94wF+9Kw5J6vHNmWo6hV
         9n/g==
X-Gm-Message-State: AOAM533PjeBqlEdnFNGOMhfXT9T1aBuAsq1AvVOjm8vSyL5RAYB52EiA
        kAUz4cYYOsTqTG1yr4vhLb3QQbzvJ+Q=
X-Google-Smtp-Source: ABdhPJy2VIPcHOVJv6Lk5HUrxb7kEBoJGHlsHWmPFqo2Ecm9Mu1umPqk8xiu7NFyqacSy65z74yeug==
X-Received: by 2002:a2e:b54d:: with SMTP id a13mr305737ljn.438.1611253403443;
        Thu, 21 Jan 2021 10:23:23 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id f186sm600537lfd.289.2021.01.21.10.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 10:23:22 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/13] ARM: tegra: ventana: Support CPU thermal throttling
Date:   Thu, 21 Jan 2021 21:22:57 +0300
Message-Id: <20210121182308.16080-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121182308.16080-1-digetx@gmail.com>
References: <20210121182308.16080-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPU thermal throttling on Tegra20 Ventana board.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-ventana.dts | 41 +++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 02b94ed722d0..99a356c1ccec 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -2,6 +2,7 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/thermal/thermal.h>
 #include "tegra20.dtsi"
 #include "tegra20-cpu-opp.dtsi"
 #include "tegra20-cpu-opp-microvolt.dtsi"
@@ -528,9 +529,10 @@ ldo_rtc {
 			};
 		};
 
-		temperature-sensor@4c {
+		nct1008: temperature-sensor@4c {
 			compatible = "onnn,nct1008";
 			reg = <0x4c>;
+			#thermal-sensor-cells = <1>;
 		};
 	};
 
@@ -614,11 +616,13 @@ cpus {
 		cpu0: cpu@0 {
 			cpu-supply = <&vdd_cpu>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			cpu-supply = <&vdd_cpu>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 	};
 
@@ -716,4 +720,37 @@ sound {
 			 <&tegra_car TEGRA20_CLK_CDEV1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <1000>; /* milliseconds */
+			polling-delay = <5000>; /* milliseconds */
+
+			thermal-sensors = <&nct1008 1>;
+
+			trips {
+				trip0: cpu-alert0 {
+					/* start throttling at 50C */
+					temperature = <50000>;
+					hysteresis = <200>;
+					type = "passive";
+				};
+
+				trip1: cpu-crit {
+					/* shut down at 60C */
+					temperature = <60000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&trip0>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
 };
-- 
2.29.2


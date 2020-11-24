Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABE12C2581
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbgKXMRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733194AbgKXMRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:17:48 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5868DC0613D6;
        Tue, 24 Nov 2020 04:17:46 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id g14so6902735wrm.13;
        Tue, 24 Nov 2020 04:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2ze0FxjajqB9xsntXc3VBzUcaN4KJqWiZjSyHlQppPA=;
        b=LYglDP4Go4I1gx4f0SE8o1rFgXGJwISGeVThoyl+0T6t9Z0sFC2RUXzqeE6hKI7NdU
         AgQ/W13W8623wHeZLEWm9n9x5y7jv0/UAZHDIRJBzxarzpdd7SDVm2V/uONDHCO3sWT6
         nlzEflhPch9A5r4eJ2OU5DqWrILBW1SrVetNTV5KF9if2XQaR7/nHfuuhat0JK0EJo4o
         Mi77k5Asb/t9VrA2Ks4D+y4iTIM0R5pbuxXL81Le/ITrHrE7zovhb3U5G4/xUIOuRj1s
         gUPvVO97FYPiSR1rLJ48YA5UKz+1FFykF0CeLpuowMBO2D4Rnv6MAPgP6hcB9fPNn2Ud
         KDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2ze0FxjajqB9xsntXc3VBzUcaN4KJqWiZjSyHlQppPA=;
        b=oXFfE5hMbOKyrBYvcT5tvtoQ2PJK5JI9F3z/yHx/ZWnn8RahuV6gfLMC8bLfS2GUvW
         scVTjqvG4Y/loERckRQTwtxZKDjOSb5YQZOelX6hkjBdGZ2palH4Vs0EpxSbwo6DXxeT
         uGhpBGb0vcgMo3PMOy6cAylt2f0KP5QDqpNVbWHN23Ecu2cUYwY0okseBc1ue56p+6/1
         OibRnkuQR2Hn+4GVckKjydL1fDZ4s1TM2UsVQajQHjmQI2fYPPsNoOex/q+R5wa1p6oP
         iiiQyXAp6ax/iFQ1eyR1Qx3C3s43kuHreKOEY5W4G/az72nsJAytivdeX92pI/sSVNl1
         9O2Q==
X-Gm-Message-State: AOAM532NznIOpfbkw7XdMySytyYzPayTLfmlsPWGWFdNnaD8cuq2Juai
        ZgY0nwa0M7fD/hZmj4RqH7w=
X-Google-Smtp-Source: ABdhPJyT5ODyn5nQtch+qDirLFfOJdv9xEUlNm14hIaS36eTvBVPVunz3OQgV58Kag+47+gNcgPoXQ==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr5072246wrn.114.1606220265112;
        Tue, 24 Nov 2020 04:17:45 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id p21sm5141572wma.41.2020.11.24.04.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 04:17:44 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: Add capacity-dmips-mhz attributes to GXM
Date:   Tue, 24 Nov 2020 12:17:40 +0000
Message-Id: <20201124121740.25704-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GXM (S912) is a big-little design with CPUs 0-3 clocked at 1.5GHz
and CPUs 4-7 at 1.0GHz. Adding capacity-dmips-mhz attributes allows
the scheduler to factor the different clock speeds into capacity
calculations and prefer the higher-clocked cluster to improve
overall performance.

This was inspired by the similar change for G12B [0] boards. The
diference here is that all cores are A53's so the same dmips-mhz
value is used.

VIM2:~ # cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
1512000
1512000
1512000
1512000
1000000
1000000
1000000
1000000

before:

VIM2:~ # cat /sys/devices/system/cpu/cpu*/cpu_capacity
1024
1024
1024
1024
1024
1024
1024
1024

after:

VIM2:~ # cat /sys/devices/system/cpu/cpu*/cpu_capacity
1024
1024
1024
1024
677
677
677
677

The after value matches my table-napkin calculation:

(1000000 / 1512000 = 0.661) * 1024 = 677

[0] https://github.com/torvalds/linux/commit/6eeaf4d2452ec8b1ece58776812140734fc2e088

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index fe4145112295..411cc312fc62 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -42,11 +42,28 @@
 			};
 		};
 
+		cpu0: cpu@0 {
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu1: cpu@1 {
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu2: cpu@2 {
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu3: cpu@3 {
+			capacity-dmips-mhz = <1024>;
+		};
+
 		cpu4: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
 			#cooling-cells = <2>;
@@ -57,6 +74,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
 			#cooling-cells = <2>;
@@ -67,6 +85,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x102>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
 			#cooling-cells = <2>;
@@ -77,6 +96,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x103>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
 			#cooling-cells = <2>;
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C322FA65B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393463AbhARQgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406822AbhARQdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:33:55 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6469EC061573;
        Mon, 18 Jan 2021 08:33:15 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id l9so18815893ejx.3;
        Mon, 18 Jan 2021 08:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hF6QZO2ui8M4e5iVZafQO9TdqdKvztuXf/OtqBjaiiE=;
        b=Kmu32BZcMB80NvCufU/jOaCBV3VpUM6Zx0IEKYT3A4jOWYijJN7+QKkIAc+bl4PaOh
         NHnCfEa9YU5c/e8BakRtLoMDO+5NqNzohMb3js0HAjh+7yfKF3aZOwjuiXjKpINdiNIu
         F8MdM7UMLixqWZJyx/nY2EFhaafkMHv0xEE2P4r8l8LUdJXS64OeUwGTGDaUk8JyrKls
         3/wSW7WE/pjDaQMKvdHrHz+46HSjQMwsZXYzvIzgGUd1LwYpNQocn9Kjvf9ddLmrk9FB
         L9lCfup+hSui9a/wtS9UzMfDhLrIrPPXwqflyY8mBAPuqI2FkgdjNiQV+x+IDARPlGcl
         3mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hF6QZO2ui8M4e5iVZafQO9TdqdKvztuXf/OtqBjaiiE=;
        b=t76JzIMHDWvaEYlWeKjvajnCjYPOPgpuQjBU81g6cmetoHRgvW1N4KcvDAgMYhP7cJ
         73XQ8cowGlxk1c+U7OrZnxrBMuqxCOOmU7E+HodOpOhbqR8tfSgptAfb3jDV3hvi0DGr
         0XyjQqn8ycDy+hlL3KoVtcaRvm989G0Twh7zOF+7MOFJM6fxoKEiGFq/E2wowpsMlJoG
         ENQghmudQh5plB6bG0wK/hcarsAKDiNBZdsbfIMp9msbvS4yxwEFfuGekIE9KCvEhp2S
         LDjU0FFkJiHi+sQ5SWP8+ffUq3Y0Ow+xXhYy3y0CSXk/8bV3gU/Q2THqWQGmep7EZfAD
         hbbg==
X-Gm-Message-State: AOAM530p/rZL59Dgwj+UkQ0YhYolHCwxZYgP+XKD43YBphdw5YcUJlPM
        1h6VyLgBlHyvDsG73GSL4lI=
X-Google-Smtp-Source: ABdhPJw/YWlrg1475xeiVGz/HO9C+4j9GqprcoUAiRma6zdp+NDRNVRzrgg6b+6tBp8TBRCY+ULnBA==
X-Received: by 2002:a17:906:65a:: with SMTP id t26mr336681ejb.394.1610987594201;
        Mon, 18 Jan 2021 08:33:14 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r13sm8409806ejy.36.2021.01.18.08.33.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 08:33:13 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: cleanup cpu_thermal node of rk3399-rock960.dts
Date:   Mon, 18 Jan 2021 17:33:06 +0100
Message-Id: <20210118163306.8693-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu_thermal node in the rk3399-rock960.dts file does not
reference &cpu_thermal directly to add the board-specific parts,
but also repeats all the SoC default properties.
Clean the whole thing up and fix alignment.
Place node in the correct alphabetical order.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts | 75 ++++++++++++-------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
index b20774081..bff8a73d9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -63,6 +63,42 @@
 
 };
 
+&cpu_thermal {
+	polling-delay-passive = <100>;
+	polling-delay = <1000>;
+	thermal-sensors = <&tsadc 0>;
+	sustainable-power = <1550>;
+
+	trips {
+		cpu_alert0: cpu_alert0 {
+			temperature = <65000>;
+			hysteresis = <2000>;
+			type = "passive";
+		};
+
+		cpu_alert1: cpu_alert1 {
+			temperature = <75000>;
+			hysteresis = <2000>;
+			type = "passive";
+		};
+
+		cpu_crit: cpu_crit {
+			temperature = <95000>;
+			hysteresis = <2000>;
+			type = "critical";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&cpu_alert1>;
+			cooling-device =
+				<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &pcie0 {
 	ep-gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
 };
@@ -125,45 +161,6 @@
 	status = "okay";
 };
 
-&thermal_zones {
-	cpu_thermal: cpu-thermal {
-		polling-delay-passive = <100>;
-		polling-delay = <1000>;
-		thermal-sensors = <&tsadc 0>;
-		sustainable-power = <1550>;
-
-		trips {
-			cpu_alert0: cpu_alert0 {
-				    temperature = <65000>;
-				    hysteresis = <2000>;
-				    type = "passive";
-			};
-
-			cpu_alert1: cpu_alert1 {
-				    temperature = <75000>;
-				    hysteresis = <2000>;
-				    type = "passive";
-			};
-
-			cpu_crit: cpu_crit {
-				  temperature = <95000>;
-				  hysteresis = <2000>;
-				  type = "critical";
-			};
-		};
-
-		cooling-maps {
-			     map0 {
-
-			     trip = <&cpu_alert1>;
-			     cooling-device =
-					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-					<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-			};
-		};
-	};
-};
-
 &usbdrd_dwc3_0 {
 	dr_mode = "otg";
 };
-- 
2.11.0


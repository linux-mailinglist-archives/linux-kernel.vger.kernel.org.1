Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1902589B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 09:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgIAHzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 03:55:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgIAHy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:54:57 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0A0C2071B;
        Tue,  1 Sep 2020 07:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598946896;
        bh=Ua+50hdF9+rjMJBfgI09c5GJMaMmQQGD08GbtEOnOkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZoaOLHYtWMoulJgzZr1LUQe+j9MC+n2WtywnTkYNfqQ/9UN4Mun7s5s5tNxLjH7+
         Cq+XEngeW9Mb2AoJobTCorLMuS8BTaTtPr0tgwWv0pYnXqxeSGosKXCrNxV3bxwFrQ
         HV3qfoZuI6sy2AqeZ2+maEDQBae7JDL984mMn0Vk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 07/13] ARM: dts: exynos: Override thermal by label in Exynos5250
Date:   Tue,  1 Sep 2020 09:54:11 +0200
Message-Id: <20200901075417.22481-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901075417.22481-1-krzk@kernel.org>
References: <20200901075417.22481-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using full paths to extend or override a device tree node is error prone
since if there was a typo error, a new node will be created instead of
extending the node as it was desired.  This will lead to run-time errors
that could be hard to detect.

A mistyped label on the other hand, will cause a dtc compile error
(during build time).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5250.dtsi | 38 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 0249d16e187f..488d3f9fab59 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -1085,26 +1085,6 @@
 		};
 	};
 
-	thermal-zones {
-		cpu_thermal: cpu-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-			thermal-sensors = <&tmu 0>;
-
-			cooling-maps {
-				map0 {
-				     /* Corresponds to 800MHz at freq_table */
-				     cooling-device = <&cpu0 9 9>, <&cpu1 9 9>;
-				};
-				map1 {
-				     /* Corresponds to 200MHz at freq_table */
-				     cooling-device = <&cpu0 15 15>,
-						      <&cpu1 15 15>;
-			       };
-		       };
-		};
-	};
-
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
@@ -1120,6 +1100,24 @@
 	};
 };
 
+&cpu_thermal {
+	polling-delay-passive = <0>;
+	polling-delay = <0>;
+	thermal-sensors = <&tmu 0>;
+
+	cooling-maps {
+		map0 {
+			/* Corresponds to 800MHz at freq_table */
+			cooling-device = <&cpu0 9 9>, <&cpu1 9 9>;
+		};
+		map1 {
+			/* Corresponds to 200MHz at freq_table */
+			cooling-device = <&cpu0 15 15>,
+					 <&cpu1 15 15>;
+		};
+	};
+};
+
 &dp {
 	power-domains = <&pd_disp1>;
 	clocks = <&clock CLK_DP>;
-- 
2.17.1


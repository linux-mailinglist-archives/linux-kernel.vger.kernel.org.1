Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A6625EE20
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 16:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgIFOXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 10:23:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728891AbgIFOV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 10:21:57 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED2CB2080A;
        Sun,  6 Sep 2020 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599402117;
        bh=Yfm4K/YBgu9cciVqK5uLID5d3xhCSI8ollTmhI7pFOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bi+GHytMd1KAyNF80myj0dpn168NNyPU8sk1iAlHJhNIOS//+KpCcnTFQvQR5YnPH
         3ZoPfRZbw3LCwRGnafjse3+GKHVszekkY5w88u1QRzRuY2g4kXGn0WY2Uauxn8EP54
         VGyWuDLfkFsDksELqv8jY/tiXzoBjuee+q7RReGQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH v3 3/3] ARM: dts: exynos: Add clocks sound node in Exynos5422 Odroid XU4
Date:   Sun,  6 Sep 2020 16:21:46 +0200
Message-Id: <20200906142146.21266-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200906142146.21266-1-krzk@kernel.org>
References: <20200906142146.21266-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dtschema expects "clocks" property if "assigned-clocks" are used.
Add reference to all parent clocks to silence the dtbs_check warnings.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Move clock properties to i2s, just like Sylwester Nawrocki did for
   Odroid XU3.
---
 arch/arm/boot/dts/exynos5422-odroidxu4.dts | 60 ++++++++++------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index 892d389d6d09..ddd55d3bcadd 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -35,30 +35,6 @@
 
 		samsung,audio-routing = "I2S Playback", "Mixer DAI TX";
 
-		assigned-clocks = <&clock CLK_MOUT_EPLL>,
-				<&clock CLK_MOUT_MAU_EPLL>,
-				<&clock CLK_MOUT_USER_MAU_EPLL>,
-				<&clock_audss EXYNOS_MOUT_AUDSS>,
-				<&clock_audss EXYNOS_MOUT_I2S>,
-				<&clock_audss EXYNOS_DOUT_SRP>,
-				<&clock_audss EXYNOS_DOUT_AUD_BUS>,
-				<&clock_audss EXYNOS_DOUT_I2S>;
-
-		assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
-				<&clock CLK_MOUT_EPLL>,
-				<&clock CLK_MOUT_MAU_EPLL>,
-				<&clock CLK_MAU_EPLL>,
-				<&clock_audss EXYNOS_MOUT_AUDSS>;
-
-		assigned-clock-rates = <0>,
-				<0>,
-				<0>,
-				<0>,
-				<0>,
-				<196608001>,
-				<(196608002 / 2)>,
-				<196608000>;
-
 		cpu {
 			sound-dai = <&i2s0 0>, <&i2s0 1>;
 		};
@@ -69,17 +45,35 @@
 	};
 };
 
-&clock_audss {
-	assigned-clocks = <&clock_audss EXYNOS_DOUT_SRP>,
-			  <&clock CLK_FOUT_EPLL>;
-	assigned-clock-rates = <(196608000 / 256)>,
-			       <196608000>;
-};
-
 &i2s0 {
 	status = "okay";
-	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
-	assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>;
+
+	assigned-clocks = <&clock CLK_MOUT_EPLL>,
+			  <&clock CLK_MOUT_MAU_EPLL>,
+			  <&clock CLK_MOUT_USER_MAU_EPLL>,
+			  <&clock_audss EXYNOS_MOUT_AUDSS>,
+			  <&clock_audss EXYNOS_MOUT_I2S>,
+			  <&i2s0 CLK_I2S_RCLK_SRC>,
+			  <&clock_audss EXYNOS_DOUT_SRP>,
+			  <&clock_audss EXYNOS_DOUT_AUD_BUS>,
+			  <&clock_audss EXYNOS_DOUT_I2S>;
+
+	assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
+				 <&clock CLK_MOUT_EPLL>,
+				 <&clock CLK_MOUT_MAU_EPLL>,
+				 <&clock CLK_MAU_EPLL>,
+				 <&clock_audss EXYNOS_MOUT_AUDSS>,
+				 <&clock_audss EXYNOS_SCLK_I2S>;
+
+	assigned-clock-rates = <0>,
+			       <0>,
+			       <0>,
+			       <0>,
+			       <0>,
+			       <0>,
+			       <196608001>,
+			       <(196608002 / 2)>,
+			       <196608000>;
 };
 
 &pwm {
-- 
2.17.1


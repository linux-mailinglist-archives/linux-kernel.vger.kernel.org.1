Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B17256962
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 19:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgH2RZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 13:25:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728335AbgH2RZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 13:25:50 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B75252074A;
        Sat, 29 Aug 2020 17:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598721949;
        bh=nRhkqYcTGAk69BeB3yEs3mP59lvOEI+VgG69O0TBHeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNEO2opzvqmgxsWGfLRLM80Zk2/ifz5ocHMwSdfHOTK0kW+dNh5fL7GajsQI9PoJ+
         ZOhNTsGiDS8OqkmehvUuZsLPGYslV/++iDwt6fM1TeSTTzzRVRcZI8SwQvypYM+YM9
         OGU3t23CIp8fWeT+eqM0ca8hynmdyhuMGHdRQfY8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [RFT 3/4] ARM: dts: exynos: Move CMU assigned ISP clocks to buses in Exynos3250
Date:   Sat, 29 Aug 2020 19:25:31 +0200
Message-Id: <20200829172532.29358-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829172532.29358-1-krzk@kernel.org>
References: <20200829172532.29358-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 52005dece527 ("ARM: dts: Add assigned clock parents to CMU node
for exynos3250") added assigned clocks under Clock Management Unit to
fix hangs when accessing ISP registers.

This is not the place for it as CMU does not have a required "clocks"
property:

  arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml: clock-controller@10030000: 'clocks' is a dependency of 'assigned-clocks'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested and I wonder whether actually correct. For example, what will
happen if devfreq (exynos-bus) is not built in?

Could someone verify it?
---
 arch/arm/boot/dts/exynos3250.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index c67c70e46794..6d467022d929 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -214,10 +214,6 @@
 			compatible = "samsung,exynos3250-cmu";
 			reg = <0x10030000 0x20000>;
 			#clock-cells = <1>;
-			assigned-clocks = <&cmu CLK_MOUT_ACLK_400_MCUISP_SUB>,
-					  <&cmu CLK_MOUT_ACLK_266_SUB>;
-			assigned-clock-parents = <&cmu CLK_FIN_PLL>,
-						 <&cmu CLK_FIN_PLL>;
 		};
 
 		cmu_dmc: clock-controller@105c0000 {
@@ -835,6 +831,8 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&cmu CLK_DIV_ACLK_400_MCUISP>;
 			clock-names = "bus";
+			assigned-clocks = <&cmu CLK_MOUT_ACLK_400_MCUISP_SUB>;
+			assigned-clock-parents = <&cmu CLK_FIN_PLL>;
 			operating-points-v2 = <&bus_mcuisp_opp_table>;
 			status = "disabled";
 		};
@@ -843,6 +841,8 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&cmu CLK_DIV_ACLK_266>;
 			clock-names = "bus";
+			assigned-clocks =  <&cmu CLK_MOUT_ACLK_266_SUB>;
+			assigned-clock-parents = <&cmu CLK_FIN_PLL>;
 			operating-points-v2 = <&bus_isp_opp_table>;
 			status = "disabled";
 		};
-- 
2.17.1


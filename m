Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7391F2D69EA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 22:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405058AbgLJVa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 16:30:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404853AbgLJVaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:30:35 -0500
From:   Krzysztof Kozlowski <krzk@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 6/9] ARM: dts: exynos: correct PMIC interrupt trigger level on Odroid XU3 family
Date:   Thu, 10 Dec 2020 22:29:00 +0100
Message-Id: <20201210212903.216728-6-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210212903.216728-1-krzk@kernel.org>
References: <20201210212903.216728-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung PMIC datasheets describe the interrupt line as active low
with a requirement of acknowledge from the CPU.  The falling edge
interrupt will mostly work but it's not correct.

Fixes: aac4e0615341 ("ARM: dts: odroidxu3: Enable wake alarm of S2MPS11 RTC")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index d0df560eb0db..6d690b1db099 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -509,7 +509,7 @@ pmic@66 {
 		samsung,s2mps11-acokb-ground;
 
 		interrupt-parent = <&gpx0>;
-		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&s2mps11_irq>;
 
-- 
2.25.1


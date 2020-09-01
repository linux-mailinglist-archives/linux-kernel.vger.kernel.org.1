Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3587E2589C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 09:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgIAHzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 03:55:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbgIAHzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:55:20 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D9062083B;
        Tue,  1 Sep 2020 07:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598946920;
        bh=zApmnDF9Ii9NjM8St9RUBDwhe2Focy2FrYiga7i/r7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5LPiGw/g9O4Z77CpiahKBkbcMz3DQQMBXlcVnwOfFUlk8v4mf+kg1YQoNGD1iwb/
         kymBEr6EFE1HnBAKP/pSuH3/vR7Yla/0RVAzsgKQ9ys0vxg/RWW/7U4eIG43aitJ48
         xvkpVSMFpZMuIZqzUR/Su+NyDWaI3oYyA8W36mYE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 13/13] ARM: dts: exynos: Use S2MPS11 clock in S3C RTC in SMDK5420
Date:   Tue,  1 Sep 2020 09:54:17 +0200
Message-Id: <20200901075417.22481-14-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901075417.22481-1-krzk@kernel.org>
References: <20200901075417.22481-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the 32 kHz clock from S2MPS11 PMIC in the S3C RTC node. Except
making the S3C RTC working, this also fixes dtbs_check warnings:

  arch/arm/boot/dts/exynos5420-smdk5420.dt.yaml: rtc@101e0000: clocks: [[2, 317]] is too short
  arch/arm/boot/dts/exynos5420-smdk5420.dt.yaml: rtc@101e0000: clock-names: ['rtc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 83fa800fa1eb..4e49d8095b29 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 #include "exynos5420.dtsi"
 #include "exynos5420-cpus.dtsi"
+#include <dt-bindings/clock/samsung,s2mps11.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -401,6 +402,8 @@
 
 &rtc {
 	status = "okay";
+	clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
+	clock-names = "rtc", "rtc_src";
 };
 
 &usbdrd_phy0 {
-- 
2.17.1


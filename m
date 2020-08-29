Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A6D256834
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 16:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgH2O0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 10:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbgH2O0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:26:04 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69282206C0;
        Sat, 29 Aug 2020 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598711164;
        bh=y1v3WRBl4MbrDweIobQQZydmN+yvc1LWyMEcpKKt2S0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5w7LxE8HNSicErTpW8YDPTUUtPUsRWL7SQc/QbDSiDVxqoVASBqrg0+jxIZS4ALy
         tayAMnlVVsztFempHudHlZ41F71RVa90Nvek6O+r21yXFwjuuw1ogWzkUU28jXC/Hk
         Iyz8IABk+dYmIfBRH3GAHMC+bliFq0mp4oPruUyQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [RFT 10/10] arm64: dts: exynos: Enable Arizona interrupt controller in Exynos5433 TM2
Date:   Sat, 29 Aug 2020 16:25:01 +0200
Message-Id: <20200829142501.31478-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829142501.31478-1-krzk@kernel.org>
References: <20200829142501.31478-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Wolfson Arizona codec is interrupt controller which is required by
bindings.  This fixes dtbs_check warnings like:

  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dt.yaml: wm5110-codec@0: 'interrupt-controller' is a required property
  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dt.yaml: wm5110-codec@0: '#interrupt-cells' is a required property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on HQ. Please kindly review and test.

Best regards,
Krzysztof
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index bab6c1addd5f..49cd55d6891c 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -1242,6 +1242,8 @@
 
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		wlf,micd-detect-debounce = <300>;
 		wlf,micd-bias-start-time = <0x1>;
-- 
2.17.1


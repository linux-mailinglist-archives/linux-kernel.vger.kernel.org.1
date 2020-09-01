Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328B42589AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 09:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgIAHyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 03:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgIAHyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:54:49 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ACB82083B;
        Tue,  1 Sep 2020 07:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598946888;
        bh=tWAPTPHyQVyPj43cqt3RNEMPzS8ONrtp+vcsWMDU69U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tnYOoPoj2xbvgY+JX3F+Wdrs9xmr8tg+IK8s5G3NjjVM6YNbWOvTVNST+5gcRVyFO
         dhdWBA8Tg4WIVAMuIjc5N1mw8836TGGGQRp02R0FP4L/8nT8OlMek1jhqm/V8LVgif
         PEdsdofu+yYGGBBIVZU7rRi3E50eLpttnfCxB6dA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 05/13] ARM: dts: exynos: Silence i2c-gpio dtschema warning in Exynos5250 Arndale
Date:   Tue,  1 Sep 2020 09:54:09 +0200
Message-Id: <20200901075417.22481-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901075417.22481-1-krzk@kernel.org>
References: <20200901075417.22481-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of I2C controller over GPIO lines node ends with '-gpio' which
confuses dtschema:

  arch/arm/boot/dts/exynos5250-arndale.dt.yaml: soc: i2c-gpio:
    {'pinctrl-names': ['default'], ... 'phandle': [[65]]} is not of type 'array'
    From schema: lib/python3.6/site-packages/dtschema/schemas/gpio/gpio-consumer.yaml

Add a '-10' (there are already 0-9 I2C controllers on the SoC) suffix to
silence it.  This pattern on naming i2c-gpio is already present in many
other dts.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 59872d83da6e..ec94af640cd5 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -624,7 +624,7 @@
 	 * For unknown reasons HDMI-DDC does not work with Exynos I2C
 	 * controllers. Lets use software I2C over GPIO pins as a workaround.
 	 */
-	i2c_ddc: i2c-gpio {
+	i2c_ddc: i2c-10 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c2_gpio_bus>;
 		status = "okay";
-- 
2.17.1


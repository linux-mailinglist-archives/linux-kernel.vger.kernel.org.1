Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAD425DC72
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 16:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgIDOyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 10:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730849AbgIDOyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:54:31 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ABC620722;
        Fri,  4 Sep 2020 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599231271;
        bh=QOJLGecW1qxz6ZNlLifYa3oKhiDzUyvvKI7pYuzuHRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MIaC+jSu5K5Ul1I+hd40MUvRZUlCxrX3f809s3TEnNjprGSdRQROcWey19AD11pmp
         rNnrLLXLjWuznWa5iLoYcNm9Pklcbv5VdJ06qeBB/uqh9wDr7sdvRI3xD6HUPPtJgH
         LJlaXSdlXFcy/CbOvNSeld92RdgUUw+jXBoqcLkk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Li Yang <leoyang.li@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 12/13] arm64: dts: imx8mq-librem5: Drop interrupt-names in PMIC
Date:   Fri,  4 Sep 2020 16:53:11 +0200
Message-Id: <20200904145312.10960-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904145312.10960-1-krzk@kernel.org>
References: <20200904145312.10960-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'interrupt-names' property is not described in dtschema, not used by
the driver and does not really make sense as its value is simple 'irq'.
Drop it to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dt.yaml:
    pmic@4b: 'interrupt-names' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 1 -
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 10f30ff85fd3..cce1b595e2d6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -289,7 +289,6 @@
 		clock-output-names = "pmic_clk";
 		interrupt-parent = <&gpio1>;
 		interrupts = <3 GPIO_ACTIVE_LOW>;
-		interrupt-names = "irq";
 		rohm,reset-snvs-powered;
 
 		regulators {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 4e50cb62654d..a78584086fa9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -640,7 +640,6 @@
 		clock-output-names = "pmic_clk";
 		interrupt-parent = <&gpio1>;
 		interrupts = <7 GPIO_ACTIVE_LOW>;
-		interrupt-names = "irq";
 		rohm,reset-snvs-powered;
 
 		regulators {
-- 
2.17.1


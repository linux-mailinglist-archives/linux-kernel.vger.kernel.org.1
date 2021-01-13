Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B913A2F5806
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbhANCMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:12:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38858 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbhAMV6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 16:58:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id CBF1C1F45763
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: mt8183: Add missing power-domain for pwm0 node
Date:   Wed, 13 Jan 2021 22:57:23 +0100
Message-Id: <20210113215723.71966-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT8183 display PWM device will not work until the associated
power-domain is enabled. Add the power-domain reference to the node
allows the display PWM driver to operate and the backlight turn on.

Fixes: f15722c0fef0 ("arm64: dts: mt8183: Add pwm and backlight node")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index bda283fa9245..8471c973dfd5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -661,6 +661,7 @@ pwm0: pwm@1100e000 {
 			compatible = "mediatek,mt8183-disp-pwm";
 			reg = <0 0x1100e000 0 0x1000>;
 			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
 			#pwm-cells = <2>;
 			clocks = <&topckgen CLK_TOP_MUX_DISP_PWM>,
 					<&infracfg CLK_INFRA_DISP_PWM>;
-- 
2.29.2


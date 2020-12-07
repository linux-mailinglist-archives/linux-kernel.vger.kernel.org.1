Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C340D2D1803
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgLGR64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLGR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:58:55 -0500
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4798EC061749;
        Mon,  7 Dec 2020 09:58:15 -0800 (PST)
Received: from allenwind.lan (unknown [IPv6:2a02:169:3df5:0:6d9:f5ff:fe22:28bf])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D10A55C26E3;
        Mon,  7 Dec 2020 18:58:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1607363893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=QgiXC+yQQL2nekfa8OvfrMNMROrqRj4G+Xqa0/Q1Jrc=;
        b=SdSk54xoBtJt2wA7D+FyMl1gy8j99vqSlTwDnx/ptWFpLwzh5Jjsdjf1AXe7NW4YxbCA1h
        +9GcjZoy3ymlImYNAmwFphfZ3q5pCsFvFsH5xpL4AuJ/fLyRuuWCddfz/hpLT4W71eTs7/
        dzGIiznrZ2e3LRQnRMCNcVDFLxjw2Fg=
From:   Stefan Agner <stefan@agner.ch>
To:     khilman@baylibre.com
Cc:     robh+dt@kernel.org, narmstrong@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, christianshewitt@gmail.com,
        jian.hu@amlogic.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v3 1/5] arm64: dts: meson: g12b: odroid-n2: fix PHY deassert timing requirements
Date:   Mon,  7 Dec 2020 18:57:59 +0100
Message-Id: <df3f5c4fc6e43c55429fd3662a636036a21eed49.1607363522.git.stefan@agner.ch>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet (Rev. 1.9) the RTL8211F requires at least
72ms "for internal circuits settling time" before accessing the PHY
registers. This fixes an issue where the Ethernet link doesn't come up
when using ip link set down/up:
  [   29.360965] meson8b-dwmac ff3f0000.ethernet eth0: Link is Down
  [   34.569012] meson8b-dwmac ff3f0000.ethernet eth0: PHY [0.0:00] driver [RTL8211F Gigabit Ethernet] (irq=31)
  [   34.676732] meson8b-dwmac ff3f0000.ethernet: Failed to reset the dma
  [   34.678874] meson8b-dwmac ff3f0000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
  [   34.687850] meson8b-dwmac ff3f0000.ethernet eth0: stmmac_open: Hw setup failed

Fixes: 658e4129bb81 ("arm64: dts: meson: g12b: odroid-n2: add the Ethernet PHY reset line")
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 6982632ae646..39a09661c5f6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -413,7 +413,7 @@ external_phy: ethernet-phy@0 {
 		max-speed = <1000>;
 
 		reset-assert-us = <10000>;
-		reset-deassert-us = <30000>;
+		reset-deassert-us = <80000>;
 		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
 
 		interrupt-parent = <&gpio_intc>;
-- 
2.29.2


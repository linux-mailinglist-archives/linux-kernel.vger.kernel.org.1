Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C32297D6C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762253AbgJXQ0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 12:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762239AbgJXQ0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 12:26:11 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A17EA2226B;
        Sat, 24 Oct 2020 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603556770;
        bh=H279X0AxzPH1W9ziRhSoDhGJV5nVuqEtyBHwqaF/Wd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zWKrT6R3iyfeS+IfjkalIiUYp0vLbBNh+vqz+Edt4YsERPJqZ4B6bbcqX8v13Yizn
         xAQtDbblGYQWYejaLegQ/uFsNR6j8tc9SxZ8aiHAq39Dz9Axw0ZqJ3Ft/pI5wFjvrr
         +a/8I7q99y9qvqJwa6lQ60vBvZ0i4S8IQ7xXpw7A=
Received: by wens.tw (Postfix, from userid 1000)
        id 03596602ED; Sun, 25 Oct 2020 00:25:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] ARM: dts: sunxi: bananapi-m2-plus: Enable RGMII RX/TX delay on Ethernet PHY
Date:   Sun, 25 Oct 2020 00:25:13 +0800
Message-Id: <20201024162515.30032-8-wens@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201024162515.30032-1-wens@kernel.org>
References: <20201024162515.30032-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The Ethernet PHY on the Bananapi M2+ has the RX and TX delays
enabled on the PHY, using pull-ups on the RXDLY and TXDLY pins.

Fix the phy-mode description to correct reflect this so that the
implementation doesn't reconfigure the delays incorrectly. This
happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
rx/tx delay config").

Fixes: 8c7ba536e709 ("ARM: sun8i: bananapi-m2-plus: Enable dwmac-sun8i")
Fixes: 4904337fe34f ("ARM: dts: sunxi: Restore EMAC changes (boards)")
Fixes: aa8fee415f46 ("ARM: dts: sun8i: h3: Split out non-SoC-specific parts of Bananapi M2 Plus")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
index 39263e74fbb5..8e5cb3b3fd68 100644
--- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
@@ -126,7 +126,7 @@ &emac {
 	pinctrl-0 = <&emac_rgmii_pins>;
 	phy-supply = <&reg_gmac_3v3>;
 	phy-handle = <&ext_rgmii_phy>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 
 	status = "okay";
 };
-- 
2.28.0


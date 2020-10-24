Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D054B297D63
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762223AbgJXQ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 12:26:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760182AbgJXQZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 12:25:59 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE102225F;
        Sat, 24 Oct 2020 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603556758;
        bh=VGOq5hjYah4TRO7kF3h5ip33hBAACBFqbRqzRWwBjWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2oNXXg64EVBeQiiD7/lUclSzpODCOwB2mn9gijGF+kW73UQ/jl5VX8dxtzIq6xKY+
         nAe/eGEelBsjtVApQP+485HHPDix5czv6kjhPg5b0dwGIG+q7S8YHags42k4y96KK/
         idTKp3R2Xjdz8qiF8++0npBlIjc+HGMINSLsJ/xQ=
Received: by wens.tw (Postfix, from userid 1000)
        id A8C0B5FDC0; Sun, 25 Oct 2020 00:25:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] ARM: dts: sun7i: bananapi-m1-plus: Enable RGMII RX/TX delay on Ethernet PHY
Date:   Sun, 25 Oct 2020 00:25:09 +0800
Message-Id: <20201024162515.30032-4-wens@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201024162515.30032-1-wens@kernel.org>
References: <20201024162515.30032-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The Ethernet PHY on the Bananapi M1+ has the RX and TX delays
enabled on the PHY, using pull-ups on the RXDLY and TXDLY pins.

Fix the phy-mode description to correct reflect this so that the
implementation doesn't reconfigure the delays incorrectly. This
happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
rx/tx delay config").

Fixes: 04c85ecad32a ("ARM: dts: sun7i: Add dts file for Bananapi M1 Plus board")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index 32d5d45a35c0..8945dbb114a2 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -130,7 +130,7 @@ &gmac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy-handle = <&phy1>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-supply = <&reg_gmac_3v3>;
 	status = "okay";
 };
-- 
2.28.0


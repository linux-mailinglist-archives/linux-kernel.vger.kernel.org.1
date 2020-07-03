Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128EB21401C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 21:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgGCTsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 15:48:50 -0400
Received: from vps.xff.cz ([195.181.215.36]:47770 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgGCTsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593805725; bh=bIYOaQy4bpcqZdipw5TvtipwYQ+4P11t0efNzRjRNdM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CMPMnHspiUrG3aWVb9q7MdiQ8iekRSnBLoJC8rI3I41ZAO3NDq7J+HO85aRF0T9N5
         J3klpwi0mNW42koI23eFm+7XxGvMbTjlVgxLskUfmcBQ6a6hoSpR+VGBCLXrC/6kCS
         rXlrHSe+bWyXCVIJGT90nqsoQ2xydooqlbpbe4zc=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: sun50i-pinephone: dldo4 must not be >= 1.8V
Date:   Fri,  3 Jul 2020 21:48:42 +0200
Message-Id: <20200703194842.111845-4-megous@megous.com>
In-Reply-To: <20200703194842.111845-1-megous@megous.com>
References: <20200703194842.111845-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some outputs from the RTL8723CS are connected to the PL port (BT_WAKE_AP),
which runs at 1.8V. When BT_WAKE_AP is high, the PL pin this signal is
connected to is overdriven, and the whole PL port's voltage rises
somewhat. This results in changing voltage on the R_PWM pin (PL10),
which is the cause for backlight flickering very noticeably when typing
on a Bluetooth keyboard, because backlight intensity is highly sensitive
to the voltage of the R_PWM pin.

Limit the maximum WiFi/BT I/O voltage to 1.8V to avoid overdriving
the PL port pins via BT and WiFi IO port signals. WiFi and BT
functionality is unaffected by this change.

This completely stops the backlight flicker when using bluetooth.

Fixes: 91f480d40942 ("arm64: dts: allwinner: Add initial support for Pine64 PinePhone")
Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 904122711a89..25150aba749d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -329,7 +329,7 @@ &reg_dldo3 {
 
 &reg_dldo4 {
 	regulator-min-microvolt = <1800000>;
-	regulator-max-microvolt = <3300000>;
+	regulator-max-microvolt = <1800000>;
 	regulator-name = "vcc-wifi-io";
 };
 
-- 
2.27.0


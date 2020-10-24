Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB94297D6B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 18:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762261AbgJXQ0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 12:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760989AbgJXQ0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 12:26:11 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9820222BA;
        Sat, 24 Oct 2020 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603556770;
        bh=b33mSnzA5/E4PKY2LtTydWNfdZgZQ2kOjj46gwVlpUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2rAd+2dgtHFmRk95dg4p1pCHnBfEHPb5ZFOLnaGqtzdAGEj2PKcpqcdqPETQdOfG
         aeCiEIoEfuPEFBksfdfCA4oTUxG6BhRgSIpIdvQpJcuN4LLIsA6+yargN1AZKC1NKz
         3QbChcHh+EVpbXDKkSvtY79bqlC+KO6AHrpPVLko=
Received: by wens.tw (Postfix, from userid 1000)
        id E10BD60223; Sun, 25 Oct 2020 00:25:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] ARM: dts: sun8i: a83t: Enable both RGMII RX/TX delay on Ethernet PHY
Date:   Sun, 25 Oct 2020 00:25:11 +0800
Message-Id: <20201024162515.30032-6-wens@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201024162515.30032-1-wens@kernel.org>
References: <20201024162515.30032-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The Ethernet PHY on the Bananapi M3 and Cubietruck Plus have the RX
and TX delays enabled on the PHY, using pull-ups on the RXDLY and
TXDLY pins.

Fix the phy-mode description to correct reflect this so that the
implementation doesn't reconfigure the delays incorrectly. This
happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
rx/tx delay config").

Fixes: 039359948a4b ("ARM: dts: sun8i: a83t: Enable Ethernet on two boards")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts     | 2 +-
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 9d34eabba121..431f70234d36 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -131,7 +131,7 @@ &emac {
 	pinctrl-0 = <&emac_rgmii_pins>;
 	phy-supply = <&reg_sw>;
 	phy-handle = <&rgmii_phy>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	allwinner,rx-delay-ps = <700>;
 	allwinner,tx-delay-ps = <700>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index d9be511f054f..d8326a5c681d 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -183,7 +183,7 @@ &emac {
 	pinctrl-0 = <&emac_rgmii_pins>;
 	phy-supply = <&reg_dldo4>;
 	phy-handle = <&rgmii_phy>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
 
-- 
2.28.0


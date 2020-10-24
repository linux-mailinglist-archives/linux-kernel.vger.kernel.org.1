Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018B5297D71
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 18:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762272AbgJXQ02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 12:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762241AbgJXQ0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 12:26:11 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3C29223EA;
        Sat, 24 Oct 2020 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603556770;
        bh=exlq22lB2jCN3FykJN2ZZhvgbFVlODxJ/nUS036IGvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMectys8lMcr8lO7+LYN/jg3t0/dOuIP6FtU0Xq8/6Wb+mVe37optZzUOG8nd5gyM
         CP7cyt91jBKMTdHnRIYYe44lVm6Yqi82Urnxu3yLY7vzyGOAU5npPLnAP+rY+IzSjL
         WGlfYEbIbvGnOyODPCTdYvIfRjPzQK7dRSSSlH2g=
Received: by wens.tw (Postfix, from userid 1000)
        id EC637602B0; Sun, 25 Oct 2020 00:25:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] ARM: dts: sun9i: Enable both RGMII RX/TX delay on Ethernet PHY
Date:   Sun, 25 Oct 2020 00:25:12 +0800
Message-Id: <20201024162515.30032-7-wens@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201024162515.30032-1-wens@kernel.org>
References: <20201024162515.30032-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The Ethernet PHY on the Cubieboard 4 and A80 Optimus have the RX
and TX delays enabled on the PHY, using pull-ups on the RXDLY and
TXDLY pins.

Fix the phy-mode description to correct reflect this so that the
implementation doesn't reconfigure the delays incorrectly. This
happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
rx/tx delay config").

Fixes: 98048143b7f8 ("ARM: dts: sun9i: cubieboard4: Enable GMAC")
Fixes: bc9bd03a44f9 ("ARM: dts: sun9i: a80-optimus: Enable GMAC")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 2 +-
 arch/arm/boot/dts/sun9i-a80-optimus.dts     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index d3b337b043a1..484b93df20cb 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -129,7 +129,7 @@ &gmac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy-handle = <&phy1>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-supply = <&reg_cldo1>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index bbc6335e5631..5c3580d712e4 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -124,7 +124,7 @@ &gmac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy-handle = <&phy1>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-supply = <&reg_cldo1>;
 	status = "okay";
 };
-- 
2.28.0


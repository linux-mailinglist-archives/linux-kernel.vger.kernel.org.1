Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9FE2A2C97
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgKBOU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:20:27 -0500
Received: from mail2.sp2max.com.br ([138.185.4.9]:45282 "EHLO
        mail2.sp2max.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgKBOT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:19:27 -0500
Received: from pgsop.sopnet.com.ar (unknown [179.40.38.12])
        (Authenticated sender: pablo@fliagreco.com.ar)
        by mail2.sp2max.com.br (Postfix) with ESMTPSA id 4356E7B04AC;
        Mon,  2 Nov 2020 11:19:20 -0300 (-03)
From:   Pablo Greco <pgreco@centosproject.org>
To:     linux-sunxi@googlegroups.com
Cc:     Pablo Greco <pgreco@centosproject.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sun8i: r40: bananapi-m2-berry: Fix dcdc1 regulator
Date:   Mon,  2 Nov 2020 11:19:14 -0300
Message-Id: <1604326755-39742-1-git-send-email-pgreco@centosproject.org>
X-Mailer: git-send-email 1.8.3.1
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: 4356E7B04AC.A3BF5
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
        escore=-2.9, requerido 6, autolearn=not spam, ALL_TRUSTED -1.00,
        BAYES_00 -1.90)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DCDC1 regulator powers many different subsystems. While some of them can
work at 3.0 V, some of them can not. For example, VCC-HDMI can only work
between 3.24 V and 3.36 V. According to OS images provided by the board
manufacturer this regulator should be set to 3.3 V.

Set DCDC1 and DCDC1SW to 3.3 V in order to fix this.

Fixes: 23edc168bd98 ("ARM: dts: sun8i: Add board dts file for Banana Pi M2 Berry")
Fixes: 27e81e1970a8 ("ARM: dts: sun8i: v40: bananapi-m2-berry: Enable GMAC ethernet controller")
Signed-off-by: Pablo Greco <pgreco@centosproject.org>
---
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
index 3ab6f47cea4f..47954551f573 100644
--- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
@@ -198,16 +198,16 @@
 };
 
 &reg_dc1sw {
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
 	regulator-name = "vcc-gmac-phy";
 };
 
 &reg_dcdc1 {
 	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "vcc-3v0";
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3";
 };
 
 &reg_dcdc2 {
-- 
2.18.4


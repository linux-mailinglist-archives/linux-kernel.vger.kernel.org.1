Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5FF23D0D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 21:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgHETx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 15:53:27 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45384 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbgHEQuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:50:20 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 434B1201463;
        Wed,  5 Aug 2020 12:43:57 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 680AF200431;
        Wed,  5 Aug 2020 12:43:53 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5282A402D0;
        Wed,  5 Aug 2020 12:43:35 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Support headphone and microphone detection
Date:   Wed,  5 Aug 2020 18:39:04 +0800
Message-Id: <1596623944-3104-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "DMIC" rounting, headphone and microphone detect gpio for sound
card, then output sound can switch between headphone and speaker.
input sound can switch between DMIC and AMIC.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 28b35ccb3757..d933b5384a96 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -105,9 +105,13 @@ sound {
 			"Ext Spk", "SPKOUTL",
 			"Ext Spk", "SPKOUTR",
 			"AMIC", "MICBIAS",
-			"IN3R", "AMIC";
+			"IN3R", "AMIC",
+			"DMIC", "MICBIAS",
+			"DMICDAT", "DMIC";
 		mux-int-port = <2>;
 		mux-ext-port = <3>;
+		hp-det-gpio = <&gpio7 8 GPIO_ACTIVE_LOW>;
+		mic-det-gpio = <&gpio1 9 GPIO_ACTIVE_LOW>;
 	};
 
 	backlight_lvds: backlight-lvds {
-- 
2.27.0


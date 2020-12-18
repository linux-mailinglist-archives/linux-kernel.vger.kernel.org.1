Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F01F2DE9EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 20:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733304AbgLRTv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 14:51:29 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:42842 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbgLRTv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 14:51:28 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 3D4F1BFD9A;
        Fri, 18 Dec 2020 20:50:47 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id B1EC3C1D4A; Fri, 18 Dec 2020 20:50:46 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 8C268C1D31;
        Fri, 18 Dec 2020 20:50:35 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH] ARM: dts: sun8i-v3s: Add CSI0 MCLK pin definition
Date:   Fri, 18 Dec 2020 20:50:33 +0100
Message-Id: <20201218195033.2301127-1-contact@paulk.fr>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a device-tree definition for the CSI0 MCLK pin,
which can be used for feeding MIPI CSI-2 sensors.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index a9f5795d4e57..bff822b9fa01 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -337,6 +337,12 @@ pio: pinctrl@1c20800 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			/omit-if-no-ref/
+			csi0_mclk_pin: csi0-mclk-pin {
+				pins = "PE20";
+				function = "csi_mipi";
+			};
+
 			/omit-if-no-ref/
 			csi1_8bit_pins: csi1-8bit-pins {
 				pins = "PE0", "PE2", "PE3", "PE8", "PE9",
-- 
2.29.2


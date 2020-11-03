Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D162A57AD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732238AbgKCUxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 15:53:21 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:57380 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732388AbgKCUxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:53:14 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 26D89BFBC2;
        Tue,  3 Nov 2020 21:53:12 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 651DDC1D4A; Tue,  3 Nov 2020 21:53:11 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 93D2BC1D4C;
        Tue,  3 Nov 2020 21:51:01 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Paul Kocialkowski <contact@paulk.fr>,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v2 4/6] ARM: dts: sun8i: Cleanup the Pinecube AXP209 node
Date:   Tue,  3 Nov 2020 21:50:56 +0100
Message-Id: <20201103205058.435207-5-contact@paulk.fr>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201103205058.435207-1-contact@paulk.fr>
References: <20201103205058.435207-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a few things with the Pinecube AXP209 node:
- No compatible is required since it is using an AXP209 (not AXP203)
  according to the schematics and this is what the included axp209.dtsi
  already has;
- The interrupt-controller and #interrupt-cells properties are already
  described in the included axp209.dtsi;
- The interrupt comes through the NMI controller, not directly through
  the GIC.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/sun8i-s3-pinecube.dts | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-s3-pinecube.dts b/arch/arm/boot/dts/sun8i-s3-pinecube.dts
index 9bab6b7f4014..ed6b4e94088d 100644
--- a/arch/arm/boot/dts/sun8i-s3-pinecube.dts
+++ b/arch/arm/boot/dts/sun8i-s3-pinecube.dts
@@ -88,13 +88,9 @@ &i2c0 {
 	status = "okay";
 
 	axp209: pmic@34 {
-		compatible = "x-powers,axp203",
-			     "x-powers,axp209";
 		reg = <0x34>;
-		interrupt-parent = <&gic>;
-		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
-- 
2.29.1


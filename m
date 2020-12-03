Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADF12CDD00
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbgLCSCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:02:15 -0500
Received: from gw.c-home.cz ([89.24.150.100]:34746 "EHLO dmz.c-home.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbgLCSCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:02:13 -0500
Received: from ubuntu2004.c-home.cz (unifi.c-home.cz [192.168.1.227])
        by dmz.c-home.cz (8.14.4+Sun/8.14.4) with ESMTP id 0B3I11ap011430;
        Thu, 3 Dec 2020 19:01:06 +0100 (CET)
From:   Martin Cerveny <m.cerveny@computer.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Martin Cerveny <m.cerveny@computer.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] ARM: dts: sun8i: v3s: SRAM_C real mapping
Date:   Thu,  3 Dec 2020 19:00:40 +0100
Message-Id: <20201203180040.3284-1-m.cerveny@computer.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VideoEngine (cedrus) needs assign dedicated SRAM for decoding.
SRAM_C1 is usually used for Allwinner platforms.
Allwinner V3s scale down chip has not SRAM_C1 but only small SRAM_C (44kB).

Result of additional testing:

SRAM_C is mapped in two regions 0x0000_4000 (primary location, by Datasheet)
(size is 0xb000, probably exact size is 0xb0c0 and it is mapped to 4k boundary
(to 0x0000_ffff)) and to 0x01d0_4000 (traditional SRAM_C1 region from 0x01d0_0000).

Rest of 0x01d0_0000 are discontinuously filled with R/W register sets
(probably some internals registers from VE) that I thought to be SRAM too.

Programming register SRAM_CTRL_REG0 (0x01c00_0000) with value 0x7fff_ffff
switch out whole region 0x01d0_0000-0x01df_ffff and 0x0000_4000-0x0000_ffff
(dedicate access to VE).

VE/cedrus code use this SRAM region indirectly
(VE_AVC_SRAM_PORT_OFFSET/VE_AVC_SRAM_PORT_DATA...)
and it is not influenced by "real" SRAM mapping or size
so it is working even without this patch.

Signed-off-by: Martin Cerveny <m.cerveny@computer.org>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index e8f304125e2d..90d703e5b73b 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -162,17 +162,17 @@ syscon: system-control@1c00000 {
 			#size-cells = <1>;
 			ranges;
 
-			sram_c: sram@1d00000 {
+			sram_c: sram@4000 {
 				compatible = "mmio-sram";
-				reg = <0x01d00000 0x80000>;
+				reg = <0x4000 0xb000>;
 				#address-cells = <1>;
 				#size-cells = <1>;
-				ranges = <0 0x01d00000 0x80000>;
+				ranges = <0 0 0x4000 0xb000>;
 
 				ve_sram: sram-section@0 {
 					compatible = "allwinner,sun8i-v3s-sram-c1",
 						     "allwinner,sun4i-a10-sram-c1";
-					reg = <0x000000 0x80000>;
+					reg = <0x0 0xb000>;
 				};
 			};
 		};
-- 
2.25.1


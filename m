Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38122F9C88
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389129AbhARJoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 04:44:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388886AbhARJck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:32:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EE0520780;
        Mon, 18 Jan 2021 09:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610962320;
        bh=7UlzqAXgQrFeU5H5PfgXOffeF2ee2L2uNmDpETFzuko=;
        h=From:To:Cc:Subject:Date:From;
        b=uIT9Osv4DcbyvIqyLKAQqyzmMgUoL1yPHJwOlJ2Jwzy84CbPkpuI7/x+GBAT8X3aA
         FVbvD9s/yTghq/ZLAWNP8nfMjnyxCdFc1/csF5/zzZfcOhD0mmdILdYBtk78dfWPVG
         juj0f9adMi4JHzqAsMo00RlMXRa10eKNq3btbcpi2ZLZRHwqJcbyaj5NndOT9M6H7E
         GjHruR+YoTfTkd+5SPY5TZS4l/8lMC0cUFYDDsBthBl42WV6GYPgq/Tw4s0C7jAvKW
         DyKv4Uk4mtwr7cuLG8BrVlK5C7Rd0htHMJyD9thfijiFN/WeNBWaiEX8RtSMMlmKDq
         WkuDHaxfk7JWA==
Received: by pali.im (Postfix)
        id 2B093889; Mon, 18 Jan 2021 10:31:58 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: marvell: armada-37xx: Add SATA comphy into main armada-37xx.dtsi file
Date:   Mon, 18 Jan 2021 10:31:39 +0100
Message-Id: <20210118093139.8441-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SATA on A3720 SOC can use only comphy2, so move this definition from board
specific DTS file armada-3720-espressobin.dtsi into main A3720 SOC file
armada-37xx.dtsi.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 2 --
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi             | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index daffe136c523..5fc613d24151 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -67,8 +67,6 @@
 /* J6 */
 &sata {
 	status = "okay";
-	phys = <&comphy2 0>;
-	phy-names = "sata-phy";
 };
 
 /* U11 */
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index b1209ccd258e..005463935ffa 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -459,6 +459,8 @@
 				reg = <0xe0000 0x178>;
 				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&nb_periph_clk 1>;
+				phys = <&comphy2 0>;
+				phy-names = "sata-phy";
 				status = "disabled";
 			};
 
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E1F1AFC98
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 19:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgDSRM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 13:12:59 -0400
Received: from v6.sk ([167.172.42.174]:44164 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgDSRM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:12:57 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id D2E66610B9;
        Sun, 19 Apr 2020 17:12:25 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     soc@kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 10/15] ARM: dts: mmp3: Fix USB & USB PHY node names
Date:   Sun, 19 Apr 2020 19:11:52 +0200
Message-Id: <20200419171157.672999-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419171157.672999-1-lkundrak@v3.sk>
References: <20200419171157.672999-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are better generic ones and the validation is going to complain:

  mmp3-dell-ariel.dt.yaml: hsic@f0001000: $nodename:0: 'hsic@f0001000'
      does not match '^usb(@.*)?'
  mmp3-dell-ariel.dt.yaml: hsic@f0002000: $nodename:0: 'hsic@f0002000'
      does not match '^usb(@.*)?'
  ...

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/mmp3.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
index 531e1d85d5fa6..a4d8d846f81af 100644
--- a/arch/arm/boot/dts/mmp3.dtsi
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -183,14 +183,14 @@ hsi0_mux: interrupt-controller@d42821d0 {
 				mrvl,intc-nr-irqs = <5>;
 			};
 
-			usb_otg_phy0: usb-otg-phy@d4207000 {
+			usb_otg_phy0: usb-phy@d4207000 {
 				compatible = "marvell,mmp3-usb-phy";
 				reg = <0xd4207000 0x40>;
 				#phy-cells = <0>;
 				status = "disabled";
 			};
 
-			usb_otg0: usb-otg@d4208000 {
+			usb_otg0: usb@d4208000 {
 				compatible = "marvell,pxau2o-ehci";
 				reg = <0xd4208000 0x200>;
 				interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
@@ -201,7 +201,7 @@ usb_otg0: usb-otg@d4208000 {
 				status = "disabled";
 			};
 
-			hsic_phy0: hsic-phy@f0001800 {
+			hsic_phy0: usb-phy@f0001800 {
 				compatible = "marvell,mmp3-hsic-phy",
 					     "usb-nop-xceiv";
 				reg = <0xf0001800 0x40>;
@@ -209,7 +209,7 @@ hsic_phy0: hsic-phy@f0001800 {
 				status = "disabled";
 			};
 
-			hsic0: hsic@f0001000 {
+			hsic0: usb@f0001000 {
 				compatible = "marvell,pxau2o-ehci";
 				reg = <0xf0001000 0x200>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
@@ -223,7 +223,7 @@ hsic0: hsic@f0001000 {
 				status = "disabled";
 			};
 
-			hsic_phy1: hsic-phy@f0002800 {
+			hsic_phy1: usb-phy@f0002800 {
 				compatible = "marvell,mmp3-hsic-phy",
 					     "usb-nop-xceiv";
 				reg = <0xf0002800 0x40>;
@@ -231,7 +231,7 @@ hsic_phy1: hsic-phy@f0002800 {
 				status = "disabled";
 			};
 
-			hsic1: hsic@f0002000 {
+			hsic1: usb@f0002000 {
 				compatible = "marvell,pxau2o-ehci";
 				reg = <0xf0002000 0x200>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.26.0


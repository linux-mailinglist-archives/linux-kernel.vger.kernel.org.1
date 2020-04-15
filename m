Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B440E1A9951
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 11:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895854AbgDOJtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 05:49:14 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:40881 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895826AbgDOJsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:48:52 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 99CDEFF818;
        Wed, 15 Apr 2020 09:48:49 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kamel.bouhara@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 3/9] ARM: dts: at91: sama5d2: add TCB GCLK
Date:   Wed, 15 Apr 2020 11:48:20 +0200
Message-Id: <20200415094826.132562-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200415094826.132562-1-alexandre.belloni@bootlin.com>
References: <20200415094826.132562-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sama5d2 tcbs take an extra input clock, their gclk.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index ab550d69db91..996143e966d8 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -499,23 +499,23 @@ macb0: ethernet@f8008000 {
 			};
 
 			tcb0: timer@f800c000 {
-				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				compatible = "atmel,sama5d2-tcb", "simple-mfd", "syscon";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0xf800c000 0x100>;
 				interrupts = <35 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&pmc PMC_TYPE_PERIPHERAL 35>, <&clk32k>;
-				clock-names = "t0_clk", "slow_clk";
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 35>, <&pmc PMC_TYPE_GCK 35>, <&clk32k>;
+				clock-names = "t0_clk", "gclk", "slow_clk";
 			};
 
 			tcb1: timer@f8010000 {
-				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				compatible = "atmel,sama5d2-tcb", "simple-mfd", "syscon";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0xf8010000 0x100>;
 				interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&pmc PMC_TYPE_PERIPHERAL 36>, <&clk32k>;
-				clock-names = "t0_clk", "slow_clk";
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 36>, <&pmc PMC_TYPE_GCK 36>, <&clk32k>;
+				clock-names = "t0_clk", "gclk", "slow_clk";
 			};
 
 			hsmc: hsmc@f8014000 {
-- 
2.25.2


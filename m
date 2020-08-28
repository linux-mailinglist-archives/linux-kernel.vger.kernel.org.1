Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2772255C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 16:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgH1OU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 10:20:59 -0400
Received: from foss.arm.com ([217.140.110.172]:50410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbgH1OUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:20:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C95F81396;
        Fri, 28 Aug 2020 07:20:36 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B059C3F71F;
        Fri, 28 Aug 2020 07:20:35 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] ARM: dts: nspire: Fix SP804 users
Date:   Fri, 28 Aug 2020 15:20:17 +0100
Message-Id: <20200828142018.43298-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828142018.43298-1-andre.przywara@arm.com>
References: <20200828142018.43298-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though the SP804 binding allows to specify only one clock, the
primecell driver requires a named clock to activate the bus clock.

Specify the one clock three times and provide some clock-names, to
make the DT match the SP804 and primecell binding.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/nspire.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
index d9a0fd7524dc..90e033d9141f 100644
--- a/arch/arm/boot/dts/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire.dtsi
@@ -145,15 +145,19 @@
 
 			timer0: timer@900C0000 {
 				reg = <0x900C0000 0x1000>;
-
-				clocks = <&timer_clk>;
+				clocks = <&timer_clk>, <&timer_clk>,
+					 <&timer_clk>;
+				clock-names = "timer0clk", "timer1clk",
+					      "apb_pclk";
 			};
 
 			timer1: timer@900D0000 {
 				reg = <0x900D0000 0x1000>;
 				interrupts = <19>;
-
-				clocks = <&timer_clk>;
+				clocks = <&timer_clk>, <&timer_clk>,
+					 <&timer_clk>;
+				clock-names = "timer0clk", "timer1clk",
+					      "apb_pclk";
 			};
 
 			watchdog: watchdog@90060000 {
-- 
2.17.1


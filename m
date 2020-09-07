Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8262425FA73
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 14:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgIGMZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 08:25:13 -0400
Received: from foss.arm.com ([217.140.110.172]:34360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbgIGMSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:18:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EC1F13D5;
        Mon,  7 Sep 2020 05:18:42 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 756BA3F66E;
        Mon,  7 Sep 2020 05:18:41 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     soc@kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Wei Xu <xuwei5@hisilicon.com>, Chanho Min <chanho.min@lge.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] arm64: dts: lg: Fix SP804 users
Date:   Mon,  7 Sep 2020 13:18:28 +0100
Message-Id: <20200907121831.242281-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907121831.242281-1-andre.przywara@arm.com>
References: <20200907121831.242281-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though the SP804 binding allows to specify only one clock, the
primecell driver requires a named clock to activate the bus clock.

Specify the one clock three times and provide some clock-names, to
make the DT match the SP804 and primecell binding.
Also add the missing arm,primecell compatible string.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/lg/lg1312.dtsi | 6 +++---
 arch/arm64/boot/dts/lg/lg1313.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi b/arch/arm64/boot/dts/lg/lg1312.dtsi
index 64f3b135068d..e2a1564597c8 100644
--- a/arch/arm64/boot/dts/lg/lg1312.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
@@ -131,11 +131,11 @@
 		ranges;
 
 		timers: timer@fd100000 {
-			compatible = "arm,sp804";
+			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x0 0xfd100000 0x1000>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>, <&clk_bus>;
+			clock-names = "timer0clk", "timer1clk", "apb_pclk";
 		};
 		wdog: watchdog@fd200000 {
 			compatible = "arm,sp805", "arm,primecell";
diff --git a/arch/arm64/boot/dts/lg/lg1313.dtsi b/arch/arm64/boot/dts/lg/lg1313.dtsi
index ac23592ab011..a54d14d7ae6f 100644
--- a/arch/arm64/boot/dts/lg/lg1313.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1313.dtsi
@@ -131,11 +131,11 @@
 		ranges;
 
 		timers: timer@fd100000 {
-			compatible = "arm,sp804";
+			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x0 0xfd100000 0x1000>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>, <&clk_bus>;
+			clock-names = "timer0clk", "timer1clk", "apb_pclk";
 		};
 		wdog: watchdog@fd200000 {
 			compatible = "arm,sp805", "arm,primecell";
-- 
2.17.1


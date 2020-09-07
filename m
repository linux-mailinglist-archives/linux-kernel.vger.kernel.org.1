Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326C325FA69
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 14:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgIGMWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 08:22:42 -0400
Received: from foss.arm.com ([217.140.110.172]:34410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729250AbgIGMSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:18:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 335A01435;
        Mon,  7 Sep 2020 05:18:45 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A4423F66E;
        Mon,  7 Sep 2020 05:18:43 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     soc@kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Wei Xu <xuwei5@hisilicon.com>, Chanho Min <chanho.min@lge.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] arm64: dts: lg: Fix SP805 clocks
Date:   Mon,  7 Sep 2020 13:18:30 +0100
Message-Id: <20200907121831.242281-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907121831.242281-1-andre.przywara@arm.com>
References: <20200907121831.242281-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SP805 DT binding requires two clocks to be specified, but the two
LG platform DTs currently only specify one clock.

In practice, Linux would pick a clock named "apb_pclk" for the bus
clock, and the Linux (and U-Boot) SP805 driver would use the first clock
to derive the actual watchdog counter frequency.

Since currently both are the very same clock, we can just double the
clock reference, and add the correct clock-names, to match the binding.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Chanho Min <chanho.min@lge.com>
---
 arch/arm64/boot/dts/lg/lg1312.dtsi | 4 ++--
 arch/arm64/boot/dts/lg/lg1313.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi b/arch/arm64/boot/dts/lg/lg1312.dtsi
index e2a1564597c8..081fe7a9f605 100644
--- a/arch/arm64/boot/dts/lg/lg1312.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
@@ -141,8 +141,8 @@
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xfd200000 0x1000>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>;
+			clock-names = "wdog_clk", "apb_pclk";
 		};
 		uart0: serial@fe000000 {
 			compatible = "arm,pl011", "arm,primecell";
diff --git a/arch/arm64/boot/dts/lg/lg1313.dtsi b/arch/arm64/boot/dts/lg/lg1313.dtsi
index a54d14d7ae6f..604bb6975337 100644
--- a/arch/arm64/boot/dts/lg/lg1313.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1313.dtsi
@@ -141,8 +141,8 @@
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xfd200000 0x1000>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>;
+			clock-names = "wdog_clk", "apb_pclk";
 		};
 		uart0: serial@fe000000 {
 			compatible = "arm,pl011", "arm,primecell";
-- 
2.17.1


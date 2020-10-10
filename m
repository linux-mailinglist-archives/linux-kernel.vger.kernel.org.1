Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094C328A05B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 14:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgJJMTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 08:19:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15256 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726664AbgJJKQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 06:16:13 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8DB59F3B91C7CD585522;
        Sat, 10 Oct 2020 17:57:41 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 10 Oct 2020 17:57:34 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 01/10] ARM: dts: hisilicon: fix errors detected by snps-dw-apb-uart.yaml
Date:   Sat, 10 Oct 2020 17:57:00 +0800
Message-ID: <20201010095709.1340-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201010095709.1340-1-thunder.leizhen@huawei.com>
References: <20201010095709.1340-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Change node name to match '^serial(@[0-9a-f,]+)*$'
2. Change clock-names to "baudclk", "apb_pclk". Both of them use the same
   clock.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/boot/dts/hip01.dtsi    | 24 ++++++++++++------------
 arch/arm/boot/dts/hip04-d01.dts |  2 +-
 arch/arm/boot/dts/hip04.dtsi    |  6 +++---
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/hip01.dtsi b/arch/arm/boot/dts/hip01.dtsi
index 975d39828405f0b..fd09e6d9309c755 100644
--- a/arch/arm/boot/dts/hip01.dtsi
+++ b/arch/arm/boot/dts/hip01.dtsi
@@ -41,41 +41,41 @@
 			compatible = "simple-bus";
 			ranges;
 
-			uart0: uart@10001000 {
+			uart0: serial@10001000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x10001000 0x1000>;
-				clocks = <&hisi_refclk144mhz>;
-				clock-names = "apb_pclk";
+				clocks = <&hisi_refclk144mhz>, <&hisi_refclk144mhz>;
+				clock-names = "baudclk", "apb_pclk";
 				reg-shift = <2>;
 				interrupts = <0 32 4>;
 				status = "disabled";
 			};
 
-			uart1: uart@10002000 {
+			uart1: serial@10002000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x10002000 0x1000>;
-				clocks = <&hisi_refclk144mhz>;
-				clock-names = "apb_pclk";
+				clocks = <&hisi_refclk144mhz>, <&hisi_refclk144mhz>;
+				clock-names = "baudclk", "apb_pclk";
 				reg-shift = <2>;
 				interrupts = <0 33 4>;
 				status = "disabled";
 			};
 
-			uart2: uart@10003000 {
+			uart2: serial@10003000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x10003000 0x1000>;
-				clocks = <&hisi_refclk144mhz>;
-				clock-names = "apb_pclk";
+				clocks = <&hisi_refclk144mhz>, <&hisi_refclk144mhz>;
+				clock-names = "baudclk", "apb_pclk";
 				reg-shift = <2>;
 				interrupts = <0 34 4>;
 				status = "disabled";
 			};
 
-			uart3: uart@10006000 {
+			uart3: serial@10006000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x10006000 0x1000>;
-				clocks = <&hisi_refclk144mhz>;
-				clock-names = "apb_pclk";
+				clocks = <&hisi_refclk144mhz>, <&hisi_refclk144mhz>;
+				clock-names = "baudclk", "apb_pclk";
 				reg-shift = <2>;
 				interrupts = <0 4 4>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/hip04-d01.dts b/arch/arm/boot/dts/hip04-d01.dts
index 9019e0d2ef60b67..f5691dbc26d2419 100644
--- a/arch/arm/boot/dts/hip04-d01.dts
+++ b/arch/arm/boot/dts/hip04-d01.dts
@@ -22,7 +22,7 @@
 	};
 
 	soc {
-		uart0: uart@4007000 {
+		uart0: serial@4007000 {
 			status = "ok";
 		};
 	};
diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
index 555bc6b6720fc94..bccf5ba3d8553c2 100644
--- a/arch/arm/boot/dts/hip04.dtsi
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -250,12 +250,12 @@
 				     <0 79 4>;
 		};
 
-		uart0: uart@4007000 {
+		uart0: serial@4007000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x4007000 0x1000>;
 			interrupts = <0 381 4>;
-			clocks = <&clk_168m>;
-			clock-names = "uartclk";
+			clocks = <&clk_168m>, <&clk_168m>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			status = "disabled";
 		};
-- 
1.8.3



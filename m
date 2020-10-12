Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD35A28AE27
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgJLGNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:13:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33580 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727241AbgJLGMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:12:49 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D1793321CB20E1F84D70;
        Mon, 12 Oct 2020 14:12:45 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 14:12:39 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 07/10] ARM: dts: hisilicon: fix errors detected by spi-pl022.yaml
Date:   Mon, 12 Oct 2020 14:12:22 +0800
Message-ID: <20201012061225.1597-8-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201012061225.1597-1-thunder.leizhen@huawei.com>
References: <20201012061225.1597-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Change clock-names to "sspclk", "apb_pclk". Both of them use the same
   clock.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/boot/dts/hi3519.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/hi3519.dtsi b/arch/arm/boot/dts/hi3519.dtsi
index 630753c0d704427..c524c854d319243 100644
--- a/arch/arm/boot/dts/hi3519.dtsi
+++ b/arch/arm/boot/dts/hi3519.dtsi
@@ -127,8 +127,8 @@
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x12120000 0x1000>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg HI3519_SPI0_CLK>;
-			clock-names = "apb_pclk";
+			clocks = <&crg HI3519_SPI0_CLK>, <&crg HI3519_SPI0_CLK>;
+			clock-names = "sspclk", "apb_pclk";
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -139,8 +139,8 @@
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x12121000 0x1000>;
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg HI3519_SPI1_CLK>;
-			clock-names = "apb_pclk";
+			clocks = <&crg HI3519_SPI1_CLK>, <&crg HI3519_SPI1_CLK>;
+			clock-names = "sspclk", "apb_pclk";
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -151,8 +151,8 @@
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x12122000 0x1000>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg HI3519_SPI2_CLK>;
-			clock-names = "apb_pclk";
+			clocks = <&crg HI3519_SPI2_CLK>, <&crg HI3519_SPI2_CLK>;
+			clock-names = "sspclk", "apb_pclk";
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.8.3



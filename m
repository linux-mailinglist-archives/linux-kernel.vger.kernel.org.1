Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED09528B603
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388968AbgJLNT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:19:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56900 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388956AbgJLNTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:19:54 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A06F4E63F6AAF79F48A2;
        Mon, 12 Oct 2020 21:19:35 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 21:19:28 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 09/11] arm64: dts: hisilicon: list all clocks required by spi-pl022.yaml
Date:   Mon, 12 Oct 2020 21:17:37 +0800
Message-ID: <20201012131739.1655-10-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201012131739.1655-1-thunder.leizhen@huawei.com>
References: <20201012131739.1655-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm,pl022 binding need to specify two clocks: "sspclk", "apb_pclk".
But only "apb_pclk" is specified now. Because the driver preferentially
matches the first clock. Otherwise, it matches the second clock instead
of both clocks. So both of them use the same clock don't change the
function.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi      | 8 ++++----
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 4 ++--
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 3f6b1715835af06..edb80abf45b327b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -971,8 +971,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg_ctrl HI3660_CLK_GATE_SPI2>;
-			clock-names = "apb_pclk";
+			clocks = <&crg_ctrl HI3660_CLK_GATE_SPI2>, <&crg_ctrl HI3660_CLK_GATE_SPI2>;
+			clock-names = "sspclk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi2_pmx_func &spi2_cfg_func>;
 			num-cs = <1>;
@@ -986,8 +986,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg_ctrl HI3660_CLK_GATE_SPI3>;
-			clock-names = "apb_pclk";
+			clocks = <&crg_ctrl HI3660_CLK_GATE_SPI3>, <&crg_ctrl HI3660_CLK_GATE_SPI3>;
+			clock-names = "sspclk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi3_pmx_func &spi3_cfg_func>;
 			num-cs = <1>;
diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index 11a72891e2a3a65..1c7dda972c92856 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -291,8 +291,8 @@
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			num-cs = <1>;
 			cs-gpios = <&gpio7 1 0>;
-			clocks = <&crg HISTB_SPI0_CLK>;
-			clock-names = "apb_pclk";
+			clocks = <&crg HISTB_SPI0_CLK>, <&crg HISTB_SPI0_CLK>;
+			clock-names = "sspclk", "apb_pclk";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 014735a9bc7312d..c6580c9f068ebf7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -725,8 +725,8 @@
 			interrupts = <0 50 4>;
 			bus-id = <0>;
 			enable-dma = <0>;
-			clocks = <&sys_ctrl HI6220_SPI_CLK>;
-			clock-names = "apb_pclk";
+			clocks = <&sys_ctrl HI6220_SPI_CLK>, <&sys_ctrl HI6220_SPI_CLK>;
+			clock-names = "sspclk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi0_pmx_func &spi0_cfg_func>;
 			num-cs = <1>;
-- 
1.8.3



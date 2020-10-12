Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A496728B609
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388997AbgJLNUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:20:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388891AbgJLNTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:19:37 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C55411CB2D0619CA4B7E;
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
Subject: [PATCH 10/11] arm64: dts: hisilicon: list all clocks required by pl011.yaml
Date:   Mon, 12 Oct 2020 21:17:38 +0800
Message-ID: <20201012131739.1655-11-thunder.leizhen@huawei.com>
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

The arm,pl011 binding need to specify two clocks: "uartclk", "apb_pclk".
But only "apb_pclk" is specified now. Because the driver preferentially
matches the first clock. Otherwise, it matches the second clock instead
of both clocks. So both of them use the same clock don't change the
function.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index 1c7dda972c92856..81d09434c5c610d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -216,8 +216,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x8b00000 0x1000>;
 			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sysctrl HISTB_UART0_CLK>;
-			clock-names = "apb_pclk";
+			clocks = <&sysctrl HISTB_UART0_CLK>, <&sysctrl HISTB_UART0_CLK>;
+			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
 
@@ -225,8 +225,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x8b02000 0x1000>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg HISTB_UART2_CLK>;
-			clock-names = "apb_pclk";
+			clocks = <&crg HISTB_UART2_CLK>, <&crg HISTB_UART2_CLK>;
+			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
 
-- 
1.8.3



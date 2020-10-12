Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E2128B608
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbgJLNUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:20:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56884 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387930AbgJLNTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:19:44 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9C3D8C0B8A6EB6466787;
        Mon, 12 Oct 2020 21:19:35 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 21:19:27 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 08/11] arm64: dts: hisilicon: normalize the node name of the UART devices
Date:   Mon, 12 Oct 2020 21:17:36 +0800
Message-ID: <20201012131739.1655-9-thunder.leizhen@huawei.com>
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

Change the node name of the UART devices to match
"^serial(@[0-9a-f,]+)*$".

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip05.dtsi | 4 ++--
 arch/arm64/boot/dts/hisilicon/hip06.dtsi | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index f7e3a7af4634233..26caf09e9511b3c 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -296,7 +296,7 @@
 			clock-frequency = <200000000>;
 		};
 
-		uart0: uart@80300000 {
+		uart0: serial@80300000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x80300000 0x0 0x10000>;
 			interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
@@ -307,7 +307,7 @@
 			status = "disabled";
 		};
 
-		uart1: uart@80310000 {
+		uart1: serial@80310000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x80310000 0x0 0x10000>;
 			interrupts = <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index 2d401d74a01f8b9..7980709e21ff020 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -359,7 +359,7 @@
 				status = "disabled";
 			};
 
-			uart0: lpc-uart@2f8 {
+			uart0: serial@2f8 {
 				compatible = "ns16550a";
 				clock-frequency = <1843200>;
 				reg = <0x01 0x2f8 0x08>;
-- 
1.8.3



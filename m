Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD6028B60B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389006AbgJLNUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:20:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388883AbgJLNTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:19:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 82C53D499816D365E587;
        Mon, 12 Oct 2020 21:19:30 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 21:19:23 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 01/11] arm64: dts: hisilicon: normalize the node name of the ITS devices
Date:   Mon, 12 Oct 2020 21:17:29 +0800
Message-ID: <20201012131739.1655-2-thunder.leizhen@huawei.com>
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

Change the node name of the ITS devices to match
"^(msi-controller|gic-its|interrupt-controller)@[0-9a-f]+$". Although
"interrupt-controller" is allowed, but "msi-controller" is preferred.
Otherwise, "interrupt-controller@b7000000: False schema does not allow"
will be reported by arm,gic-v3.yaml.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip05.dtsi |  8 ++++----
 arch/arm64/boot/dts/hisilicon/hip06.dtsi |  2 +-
 arch/arm64/boot/dts/hisilicon/hip07.dtsi | 16 ++++++++--------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index bc49955360db754..f7e3a7af4634233 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -242,28 +242,28 @@
 		      <0x0 0xfe020000 0 0x10000>;       /* GICV */
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
-		its_peri: interrupt-controller@8c000000 {
+		its_peri: msi-controller@8c000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
 			reg = <0x0 0x8c000000 0x0 0x40000>;
 		};
 
-		its_m3: interrupt-controller@a3000000 {
+		its_m3: msi-controller@a3000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
 			reg = <0x0 0xa3000000 0x0 0x40000>;
 		};
 
-		its_pcie: interrupt-controller@b7000000 {
+		its_pcie: msi-controller@b7000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
 			reg = <0x0 0xb7000000 0x0 0x40000>;
 		};
 
-		its_dsa: interrupt-controller@c6000000 {
+		its_dsa: msi-controller@c6000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index 50ceaa959bdc016..a2fba458e047fd7 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -242,7 +242,7 @@
 		      <0x0 0xfe020000 0 0x10000>;       /* GICV */
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
-		its_dsa: interrupt-controller@c6000000 {
+		its_dsa: msi-controller@c6000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 4773a533fce589d..892691bb2adb446 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -924,56 +924,56 @@
 		      <0x0 0xfe020000 0x0 0x10000>;	/* GICV */
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
-		p0_its_peri_a: interrupt-controller@4c000000 {
+		p0_its_peri_a: msi-controller@4c000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
 			reg = <0x0 0x4c000000 0x0 0x40000>;
 		};
 
-		p0_its_peri_b: interrupt-controller@6c000000 {
+		p0_its_peri_b: msi-controller@6c000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
 			reg = <0x0 0x6c000000 0x0 0x40000>;
 		};
 
-		p0_its_dsa_a: interrupt-controller@c6000000 {
+		p0_its_dsa_a: msi-controller@c6000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
 			reg = <0x0 0xc6000000 0x0 0x40000>;
 		};
 
-		p0_its_dsa_b: interrupt-controller@8,c6000000 {
+		p0_its_dsa_b: msi-controller@8c6000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
 			reg = <0x8 0xc6000000 0x0 0x40000>;
 		};
 
-		p1_its_peri_a: interrupt-controller@400,4c000000 {
+		p1_its_peri_a: msi-controller@4004c000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
 			reg = <0x400 0x4c000000 0x0 0x40000>;
 		};
 
-		p1_its_peri_b: interrupt-controller@400,6c000000 {
+		p1_its_peri_b: msi-controller@4006c000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
 			reg = <0x400 0x6c000000 0x0 0x40000>;
 		};
 
-		p1_its_dsa_a: interrupt-controller@400,c6000000 {
+		p1_its_dsa_a: msi-controller@400c6000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
 			reg = <0x400 0xc6000000 0x0 0x40000>;
 		};
 
-		p1_its_dsa_b: interrupt-controller@408,c6000000 {
+		p1_its_dsa_b: msi-controller@408c6000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
-- 
1.8.3



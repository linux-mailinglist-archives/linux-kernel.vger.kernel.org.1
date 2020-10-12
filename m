Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A8C28B607
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388979AbgJLNUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:20:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56860 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388889AbgJLNTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:19:37 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 97A3DBEA199870C5118F;
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
Subject: [PATCH 07/11] arm64: dts: hisilicon: normalize the node name of the usb devices
Date:   Mon, 12 Oct 2020 21:17:35 +0800
Message-ID: <20201012131739.1655-8-thunder.leizhen@huawei.com>
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

Change the node name of the usb devices to match "^usb(@.*)?". These errors
are detected by generic-ehci.yaml and generic-ohci.yaml.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 4 ++--
 arch/arm64/boot/dts/hisilicon/hip06.dtsi       | 4 ++--
 arch/arm64/boot/dts/hisilicon/hip07.dtsi       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index e24969d53c8fed0..11a72891e2a3a65 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -584,7 +584,7 @@
 			status = "disabled";
 		};
 
-		ohci: ohci@9880000 {
+		ohci: usb@9880000 {
 			compatible = "generic-ohci";
 			reg = <0x9880000 0x10000>;
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
@@ -599,7 +599,7 @@
 			status = "disabled";
 		};
 
-		ehci: ehci@9890000 {
+		ehci: usb@9890000 {
 			compatible = "generic-ehci";
 			reg = <0x9890000 0x10000>;
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index 2f1930d4457fe1b..2d401d74a01f8b9 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -373,7 +373,7 @@
 			#clock-cells = <0>;
 		};
 
-		usb_ohci: ohci@a7030000 {
+		usb_ohci: usb@a7030000 {
 			compatible = "generic-ohci";
 			reg = <0x0 0xa7030000 0x0 0x10000>;
 			interrupt-parent = <&mbigen_usb>;
@@ -382,7 +382,7 @@
 			status = "disabled";
 		};
 
-		usb_ehci: ehci@a7020000 {
+		usb_ehci: usb@a7020000 {
 			compatible = "generic-ehci";
 			reg = <0x0 0xa7020000 0x0 0x10000>;
 			interrupt-parent = <&mbigen_usb>;
diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index ba90b25853555b7..7832d9cdec21c93 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1253,7 +1253,7 @@
 			status = "disabled";
 		};
 
-		usb_ohci: ohci@a7030000 {
+		usb_ohci: usb@a7030000 {
 			compatible = "generic-ohci";
 			reg = <0x0 0xa7030000 0x0 0x10000>;
 			interrupt-parent = <&mbigen_usb>;
@@ -1262,7 +1262,7 @@
 			status = "disabled";
 		};
 
-		usb_ehci: ehci@a7020000 {
+		usb_ehci: usb@a7020000 {
 			compatible = "generic-ehci";
 			reg = <0x0 0xa7020000 0x0 0x10000>;
 			interrupt-parent = <&mbigen_usb>;
-- 
1.8.3



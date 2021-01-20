Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9B02FD902
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392405AbhATTCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:02:52 -0500
Received: from saphodev.broadcom.com ([192.19.232.172]:56962 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392272AbhATSwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:52:43 -0500
Received: from lbrmn-lnxub113.broadcom.net (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8A70180DA;
        Wed, 20 Jan 2021 10:51:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8A70180DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611168704;
        bh=yWn2lZmIdUJiqHhTCwVkDPJNGcmB2uqIm0gs3uMXCxc=;
        h=From:To:Cc:Subject:Date:From;
        b=h84nxHw+edEvAc2ielnkpGCwMucDnuzOju/yKYQ4KJgWFDhsa/aWW205Orp2zlhap
         sfx00wnD60mLF9OpWBNci5NERDUauST2rWDVCnhD0WP1wg89UcDBGg8qzxEqh4A1ZO
         eXpNG5UnczJJYfqItXSsAhbPYm8Yqx0CmjbQaylw=
From:   Scott Branden <scott.branden@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] arm64: dts: stingray: remove sata
Date:   Wed, 20 Jan 2021 10:51:40 -0800
Message-Id: <20210120185140.16929-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove sata from stingray as it is unsupported.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 .../dts/broadcom/stingray/bcm958742-base.dtsi |  64 ----
 .../dts/broadcom/stingray/stingray-sata.dtsi  | 278 ------------------
 .../boot/dts/broadcom/stingray/stingray.dtsi  |   7 -
 3 files changed, 349 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
index 43aa5e9c0020..8fe7325cfbb2 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
@@ -56,70 +56,6 @@
 	};
 };
 
-&sata0 {
-	status = "okay";
-};
-
-&sata_phy0{
-	status = "okay";
-};
-
-&sata1 {
-	status = "okay";
-};
-
-&sata_phy1{
-	status = "okay";
-};
-
-&sata2 {
-	status = "okay";
-};
-
-&sata_phy2{
-	status = "okay";
-};
-
-&sata3 {
-	status = "okay";
-};
-
-&sata_phy3{
-	status = "okay";
-};
-
-&sata4 {
-	status = "okay";
-};
-
-&sata_phy4{
-	status = "okay";
-};
-
-&sata5 {
-	status = "okay";
-};
-
-&sata_phy5{
-	status = "okay";
-};
-
-&sata6 {
-	status = "okay";
-};
-
-&sata_phy6{
-	status = "okay";
-};
-
-&sata7 {
-	status = "okay";
-};
-
-&sata_phy7{
-	status = "okay";
-};
-
 &pwm {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
deleted file mode 100644
index 8c68e0c26f1b..000000000000
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
+++ /dev/null
@@ -1,278 +0,0 @@
-/*
- *  BSD LICENSE
- *
- *  Copyright(c) 2016-2017 Broadcom.  All rights reserved.
- *
- *  Redistribution and use in source and binary forms, with or without
- *  modification, are permitted provided that the following conditions
- *  are met:
- *
- *    * Redistributions of source code must retain the above copyright
- *      notice, this list of conditions and the following disclaimer.
- *    * Redistributions in binary form must reproduce the above copyright
- *      notice, this list of conditions and the following disclaimer in
- *      the documentation and/or other materials provided with the
- *      distribution.
- *    * Neither the name of Broadcom nor the names of its
- *      contributors may be used to endorse or promote products derived
- *      from this software without specific prior written permission.
- *
- *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-	sata {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x67d00000 0x00800000>;
-
-		sata0: ahci@0 {
-			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00000000 0x1000>;
-			reg-names = "ahci";
-			interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata0_port0: sata-port@0 {
-				reg = <0>;
-				phys = <&sata0_phy0>;
-				phy-names = "sata-phy";
-			};
-		};
-
-		sata_phy0: sata_phy@2100 {
-			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00002100 0x1000>;
-			reg-names = "phy";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata0_phy0: sata-phy@0 {
-				reg = <0>;
-				#phy-cells = <0>;
-			};
-		};
-
-		sata1: ahci@10000 {
-			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00010000 0x1000>;
-			reg-names = "ahci";
-			interrupts = <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata1_port0: sata-port@0 {
-				reg = <0>;
-				phys = <&sata1_phy0>;
-				phy-names = "sata-phy";
-			};
-		};
-
-		sata_phy1: sata_phy@12100 {
-			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00012100 0x1000>;
-			reg-names = "phy";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata1_phy0: sata-phy@0 {
-				reg = <0>;
-				#phy-cells = <0>;
-			};
-		};
-
-		sata2: ahci@20000 {
-			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00020000 0x1000>;
-			reg-names = "ahci";
-			interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata2_port0: sata-port@0 {
-				reg = <0>;
-				phys = <&sata2_phy0>;
-				phy-names = "sata-phy";
-			};
-		};
-
-		sata_phy2: sata_phy@22100 {
-			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00022100 0x1000>;
-			reg-names = "phy";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata2_phy0: sata-phy@0 {
-				reg = <0>;
-				#phy-cells = <0>;
-			};
-		};
-
-		sata3: ahci@30000 {
-			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00030000 0x1000>;
-			reg-names = "ahci";
-			interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata3_port0: sata-port@0 {
-				reg = <0>;
-				phys = <&sata3_phy0>;
-				phy-names = "sata-phy";
-			};
-		};
-
-		sata_phy3: sata_phy@32100 {
-			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00032100 0x1000>;
-			reg-names = "phy";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata3_phy0: sata-phy@0 {
-				reg = <0>;
-				#phy-cells = <0>;
-			};
-		};
-
-		sata4: ahci@100000 {
-			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00100000 0x1000>;
-			reg-names = "ahci";
-			interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata4_port0: sata-port@0 {
-				reg = <0>;
-				phys = <&sata4_phy0>;
-				phy-names = "sata-phy";
-			};
-		};
-
-		sata_phy4: sata_phy@102100 {
-			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00102100 0x1000>;
-			reg-names = "phy";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata4_phy0: sata-phy@0 {
-				reg = <0>;
-				#phy-cells = <0>;
-			};
-		};
-
-		sata5: ahci@110000 {
-			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00110000 0x1000>;
-			reg-names = "ahci";
-			interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata5_port0: sata-port@0 {
-				reg = <0>;
-				phys = <&sata5_phy0>;
-				phy-names = "sata-phy";
-			};
-		};
-
-		sata_phy5: sata_phy@112100 {
-			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00112100 0x1000>;
-			reg-names = "phy";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata5_phy0: sata-phy@0 {
-				reg = <0>;
-				#phy-cells = <0>;
-			};
-		};
-
-		sata6: ahci@120000 {
-			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00120000 0x1000>;
-			reg-names = "ahci";
-			interrupts = <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata6_port0: sata-port@0 {
-				reg = <0>;
-				phys = <&sata6_phy0>;
-				phy-names = "sata-phy";
-			};
-		};
-
-		sata_phy6: sata_phy@122100 {
-			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00122100 0x1000>;
-			reg-names = "phy";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata6_phy0: sata-phy@0 {
-				reg = <0>;
-				#phy-cells = <0>;
-			};
-		};
-
-		sata7: ahci@130000 {
-			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00130000 0x1000>;
-			reg-names = "ahci";
-			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata7_port0: sata-port@0 {
-				reg = <0>;
-				phys = <&sata7_phy0>;
-				phy-names = "sata-phy";
-			};
-		};
-
-		sata_phy7: sata_phy@132100 {
-			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00132100 0x1000>;
-			reg-names = "phy";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-
-			sata7_phy0: sata-phy@0 {
-				reg = <0>;
-				#phy-cells = <0>;
-			};
-		};
-	};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index b425b12c3ed2..2ffb2c92182a 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -285,7 +285,6 @@
 	};
 
 	#include "stingray-fs4.dtsi"
-	#include "stingray-sata.dtsi"
 	#include "stingray-pcie.dtsi"
 	#include "stingray-usb.dtsi"
 
@@ -309,12 +308,6 @@
 				#size-cells = <0>;
 			};
 
-			mdio@2 { /* SATA */
-				reg = <0x2>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
-
 			mdio@3 { /* USB */
 				reg = <0x3>;
 				#address-cells = <1>;
-- 
2.17.1


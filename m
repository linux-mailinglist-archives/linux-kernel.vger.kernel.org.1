Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C67E25C1BB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 15:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgICNhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 09:37:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37664 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbgICNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:01:57 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 083D0Oth043878;
        Thu, 3 Sep 2020 08:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599138024;
        bh=hC8MGnrzcwOc/jOvEUis8iOVo4RaDpVeqzpk8KjNJPI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Of7z7xh6wlyFOXFCVaHXMrPM1dhh1fruQWkmcp4kXEeuNspuy31am2A0gBrWF9Yyh
         DTneAEXxmtWB1TJ+2u1gQYJWfY/E2N++WgQWAayI5R3j5SO+C617vyTamzUmBaM+ze
         bY0GPzDCVRuKhbvXzzTJsgWxJ5g/egNK/FHU4nT8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 083D0OXu027918
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Sep 2020 08:00:24 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 08:00:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 08:00:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083D0McA105505;
        Thu, 3 Sep 2020 08:00:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 5/8] arm64: dts: ti: k3-*: Use generic pinctrl for node names
Date:   Thu, 3 Sep 2020 08:00:12 -0500
Message-ID: <20200903130015.21361-6-nm@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901223059.14801-1-nm@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pinctrl@ naming for nodes following standard conventions of device
tree (section 2.2.2 Generic Names recommendation in [1]).

[1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3

Suggested-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Suman Anna <s-anna@ti.com>
---
Changes:
v2: None (picked acks/reviews)
v1: https://lore.kernel.org/linux-arm-kernel/20200901223059.14801-4-nm@ti.com/

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi        | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 63a1299cb0b2..1dd488cb15c6 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -134,7 +134,7 @@
 		};
 	};
 
-	main_pmx0: pinmux@11c000 {
+	main_pmx0: pinctrl@11c000 {
 		compatible = "pinctrl-single";
 		reg = <0x0 0x11c000 0x0 0x2e4>;
 		#pinctrl-cells = <1>;
@@ -142,7 +142,7 @@
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
-	main_pmx1: pinmux@11c2e8 {
+	main_pmx1: pinctrl@11c2e8 {
 		compatible = "pinctrl-single";
 		reg = <0x0 0x11c2e8 0x0 0x24>;
 		#pinctrl-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 0765700a8ba8..bb498be2f0a4 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -39,7 +39,7 @@
 		reg = <0x43000014 0x4>;
 	};
 
-	wkup_pmx0: pinmux@4301c000 {
+	wkup_pmx0: pinctrl@4301c000 {
 		compatible = "pinctrl-single";
 		reg = <0x4301c000 0x118>;
 		#pinctrl-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 00a36a14efe7..1d2a7c05b6f3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -327,7 +327,7 @@
 		};
 	};
 
-	main_pmx0: pinmux@11c000 {
+	main_pmx0: pinctrl@11c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
 		reg = <0x0 0x11c000 0x0 0x2b4>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index c4a48e8d420a..9ad0266598ad 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -53,7 +53,7 @@
 		reg = <0x0 0x43000014 0x0 0x4>;
 	};
 
-	wkup_pmx0: pinmux@4301c000 {
+	wkup_pmx0: pinctrl@4301c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
 		reg = <0x00 0x4301c000 0x00 0x178>;
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960A22B0CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgKLSgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:36:05 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34220 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgKLSfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:35:50 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACIZg41071628;
        Thu, 12 Nov 2020 12:35:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605206142;
        bh=EPFf43p9JdPmOBYNZNUkNug5qkbm1IvZxjKbE6zIjFo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xxZdX1WlC/4x6Ljj8EA8U0qT3yIMMsIbJp/N/EODrnRmEbeEI3UtDR6XpX3GDgrLl
         wnLYbcX3oXdTGLZOPGenhvsEOd3jariTOGhEuHKzYDVF3Z/9txhd7xsypmWvctoSF9
         4QtEjwu780PCpr9rS9h1/zEHy+/vYos+0fOffX7I=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACIZgMg121075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 12:35:42 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 12:35:41 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 12:35:42 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACIZfZq042709;
        Thu, 12 Nov 2020 12:35:41 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 1/5] arm64: dts: ti: k3-am65*: Cleanup disabled nodes at SoC dtsi level
Date:   Thu, 12 Nov 2020 12:35:34 -0600
Message-ID: <20201112183538.6805-2-nm@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112183538.6805-1-nm@ti.com>
References: <20201112183538.6805-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree standard states that when the status property is
not present under a node, the okay value is assumed. There are many
reasons for doing the same, the number of strings in the device
tree, default power management functionality, etc. are a few of the
reasons.

In general, after a few rounds of discussions [1] there are few
options one could take when dealing with SoC dtsi and board dts

a. SoC dtsi provide nodes as a super-set default (aka enabled) state and
   to prevent messy board files, when more boards are added per SoC, we
   optimize and disable commonly un-used nodes in board-common.dtsi
b. SoC dtsi disables all hardware dependent nodes by default and board
   dts files enable nodes based on a need basis.
c. Subjectively pick and choose which nodes we will disable by default
   in SoC dtsi and over the years we can optimize things and change
   default state depending on the need.

While there are pros and cons on each of these approaches, the right
thing to do will be to stick with device tree default standards and
work within those established rules. So, we choose to go with option
(a).

Lets cleanup defaults of am654 SoC dtsi before this gets more harder
to cleanup later on and new SoCs are added.

The dtb generated is identical with the patch and it is just cleanup to
ensure we have a clean usage model

NOTE: There is a known risk of omission that new board dts developers
might miss reviewing both the board schematics in addition to all the
DT nodes of the SoC when setting appropriate nodes status to disable
or reserved in the board dts. This can expose issues in drivers that
may not anticipate an incomplete node (example: missing appropriate
board properties) being in an "okay" state. These cases are considered
bugs and need to be fixed in the drivers as and when identified.

[1] https://lore.kernel.org/linux-arm-kernel/20201027130701.GE5639@atomide.com/

Fixes: 9bcb631e9953 ("arm64: dts: ti: k3-am654-main: Add McASP nodes")
Fixes: fc539b90eda2 ("arm64: dts: ti: am654: Add DSS node")
Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
Changes since v2:
- rebase to resolve dss conflict.
- no functional change, just reviewed-by picked up

V2: https://lore.kernel.org/linux-arm-kernel/20201112014929.25227-2-nm@ti.com/
V1: https://lore.kernel.org/linux-arm-kernel/20201104224356.18040-2-nm@ti.com/

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       |  8 --------
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index a664c91675de..c842b9803f2d 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -769,8 +769,6 @@ mcasp0: mcasp@2b00000 {
 		clocks = <&k3_clks 104 0>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
-
-		status = "disabled";
 	};
 
 	mcasp1: mcasp@2b10000 {
@@ -788,8 +786,6 @@ mcasp1: mcasp@2b10000 {
 		clocks = <&k3_clks 105 0>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
-
-		status = "disabled";
 	};
 
 	mcasp2: mcasp@2b20000 {
@@ -807,8 +803,6 @@ mcasp2: mcasp@2b20000 {
 		clocks = <&k3_clks 106 0>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
-
-		status = "disabled";
 	};
 
 	cal: cal@6f03000 {
@@ -864,8 +858,6 @@ dss: dss@4a00000 {
 
 		interrupts = <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>;
 
-		status = "disabled";
-
 		dma-coherent;
 
 		dss_ports: ports {
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 17f3a85360e6..0dec781982b1 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -529,3 +529,19 @@ &cpsw_port1 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&phy0>;
 };
+
+&mcasp0 {
+	status = "disabled";
+};
+
+&mcasp1 {
+	status = "disabled";
+};
+
+&mcasp2 {
+	status = "disabled";
+};
+
+&dss {
+	status = "disabled";
+};
-- 
2.29.2


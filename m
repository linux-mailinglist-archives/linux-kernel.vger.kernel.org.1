Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997122A705C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 23:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgKDW0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 17:26:04 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60106 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgKDW0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:26:04 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A4MPQf2116398;
        Wed, 4 Nov 2020 16:25:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604528726;
        bh=eUT5OSNde+/PqvdrL2v47qP1jdie99a86iyDJLOC/yY=;
        h=From:To:CC:Subject:Date;
        b=CuKlEL6NxXauCU2x7YihxrW9X5kWSE320tXHkvf1mo4LQpqQTFBn09awGvtGz9N2s
         C+tfs/dqWZXKEIkvSoltrkREjXJPEYeqdw7Iw9wshLoL+EDHyXu1GAy/6zGyPErRCd
         SwZTyyw0qQOkBix05kG8kvB6hH40+dS7OI3XhqmI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A4MPQnk085176
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Nov 2020 16:25:26 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 4 Nov
 2020 16:25:26 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 4 Nov 2020 16:25:26 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A4MPQeA119258;
        Wed, 4 Nov 2020 16:25:26 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am65*/j721e*: Fix unit address format error for dss node
Date:   Wed, 4 Nov 2020 16:25:19 -0600
Message-ID: <20201104222519.12308-1-nm@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the node address to follow the device tree convention.

This fixes the dtc warning:
<stdout>: Warning (simple_bus_reg): /bus@100000/dss@04a00000: simple-bus
unit address format error, expected "4a00000"

Fixes: 76921f15acc0 ("arm64: dts: ti: k3-j721e-main: Add DSS node")
Fixes: fc539b90eda2 ("arm64: dts: ti: am654: Add DSS node")
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi  | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 533525229a8d..27f6fd9eaa0a 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -834,7 +834,7 @@ csi2_0: port@0 {
 		};
 	};
 
-	dss: dss@04a00000 {
+	dss: dss@4a00000 {
 		compatible = "ti,am65x-dss";
 		reg =	<0x0 0x04a00000 0x0 0x1000>, /* common */
 			<0x0 0x04a02000 0x0 0x1000>, /* vidl1 */
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index e2a96b2c423c..c66ded9079be 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1278,7 +1278,7 @@ ufs@4e84000 {
 		};
 	};
 
-	dss: dss@04a00000 {
+	dss: dss@4a00000 {
 		compatible = "ti,j721e-dss";
 		reg =
 			<0x00 0x04a00000 0x00 0x10000>, /* common_m */
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9BD2E2625
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgLXLRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:17:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37730 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLXLRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:17:42 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBGtHP041757;
        Thu, 24 Dec 2020 05:16:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608808615;
        bh=ejqVodygEsgAslfKzhoklm22eEg4+DvOyLToSf8bIJ0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rXW67rXRnHaMt4WjB1qg4HF46eqsx7B9/GRjg6AsCqFRjjDjOYg455aUauB1cguhn
         LdGhhWna+8ygASCEF4324DTetGjR4qP2+cDW2+J/3syo0qMJyZR63d9WA+DI6oy2x1
         IHDvinpNqyMBS6PMogyqRe+ubKbhcpr7xCJOqd0Q=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBGtkx059768
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:16:55 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:16:55 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:16:55 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBGWG9116630;
        Thu, 24 Dec 2020 05:16:51 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 03/15] dt-bindings: phy: cadence-sierra: Add bindings for the PLLs within SERDES
Date:   Thu, 24 Dec 2020 16:46:15 +0530
Message-ID: <20201224111627.32590-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224111627.32590-1-kishon@ti.com>
References: <20201224111627.32590-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the PLLs within SERDES.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/phy/phy-cadence-sierra.yaml      | 89 ++++++++++++++++++-
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
index d210843863df..f574b8ed358c 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
@@ -49,12 +49,14 @@ properties:
     const: serdes
 
   clocks:
-    maxItems: 2
+    maxItems: 4
 
   clock-names:
     items:
       - const: cmn_refclk_dig_div
       - const: cmn_refclk1_dig_div
+      - const: pll_cmnlc
+      - const: pll_cmnlc1
 
   cdns,autoconf:
     type: boolean
@@ -107,6 +109,58 @@ patternProperties:
 
     additionalProperties: false
 
+  "^refrcv1?$":
+    type: object
+    description: |
+      Reference receivers that enables routing external clocks to the alternate
+      PLLCMNLC.
+    properties:
+      clocks:
+        maxItems: 1
+        description: Phandle to clock nodes representing the input to the
+          reference receiver.
+
+      clock-names:
+        items:
+          - const: pll_refclk
+
+      "#clock-cells":
+        const: 0
+
+    required:
+      - clocks
+      - "#clock-cells"
+
+  "^pll_cmnlc1?$":
+    type: object
+    description: |
+      SERDES node should have subnodes for each of the PLLs present in
+      the SERDES.
+    properties:
+      clocks:
+        maxItems: 2
+        description: Phandle to clock nodes representing the two inputs to PLL.
+
+      clock-names:
+        items:
+          - const: pll_refclk
+          - const: refrcv
+
+      "#clock-cells":
+        const: 0
+
+      assigned-clocks:
+        maxItems: 1
+
+      assigned-clock-parents:
+        maxItems: 1
+
+    required:
+      - clocks
+      - "#clock-cells"
+      - assigned-clocks
+      - assigned-clock-parents
+
 required:
   - compatible
   - "#address-cells"
@@ -130,10 +184,39 @@ examples:
             reg = <0x0 0xfd240000 0x0 0x40000>;
             resets = <&phyrst 0>, <&phyrst 1>;
             reset-names = "sierra_reset", "sierra_apb";
-            clocks = <&cmn_refclk_dig_div>, <&cmn_refclk1_dig_div>;
-            clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
+            clocks = <&cmn_refclk_dig_div>, <&cmn_refclk1_dig_div>, <&serdes_pll_cmnlc>, <&serdes_pll_cmnlc1>;
+            clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div", "pll_cmnlc", "pll_cmnlc1";
             #address-cells = <1>;
             #size-cells = <0>;
+
+            serdes_refrcv: refrcv {
+                    clocks = <&pll0_refclk>;
+                    clock-names = "pll_refclk";
+                    #clock-cells = <0>;
+            };
+
+            serdes_refrcv1: refrcv1 {
+                    clocks = <&pll1_refclk>;
+                    clock-names = "pll_refclk";
+                    #clock-cells = <0>;
+            };
+
+            serdes_pll_cmnlc: pll_cmnlc {
+                    clocks = <&pll0_refclk>, <&serdes_refrcv1>;
+                    clock-names = "pll_refclk", "refrcv";
+                    #clock-cells = <0>;
+                    assigned-clocks = <&serdes_pll_cmnlc>;
+                    assigned-clock-parents = <&pll0_refclk>;
+            };
+
+            serdes_pll_cmnlc1: pll_cmnlc1 {
+                    clocks = <&pll1_refclk>, <&serdes_refrcv>;
+                    clock-names = "pll_refclk", "refrcv";
+                    #clock-cells = <0>;
+                    assigned-clocks = <&serdes_pll_cmnlc1>;
+                    assigned-clock-parents = <&pll1_refclk>;
+            };
+
             pcie0_phy0: phy@0 {
                 reg = <0>;
                 resets = <&phyrst 2>;
-- 
2.17.1


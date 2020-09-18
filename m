Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D092926F87B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgIRIh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:37:57 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44288 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgIRIhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:37:53 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08I8boJR048568;
        Fri, 18 Sep 2020 03:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600418270;
        bh=DMsl67xK5NX7DtbdJD5aclNCh7kwQUztauT0LlKtQyw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sOxYsAFwJXzyq/icRnEz6L/E+juWLlY/HIPKZLyqVVTlxi8IidQu2gc+2gFk1cpEr
         P+ZPSoRHGqzQGjY5bEhrUe+XzZXx+gDePiRtSXli4HSJ14weNUZowOeOOyWI4vQIVm
         lFICmJQEQ+gejerj//H1gwObnD0ku44Jr0TT5oTc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08I8bojw091020;
        Fri, 18 Sep 2020 03:37:50 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 03:37:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 03:37:49 -0500
Received: from deskari.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08I8bjT1109595;
        Fri, 18 Sep 2020 03:37:48 -0500
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH v2 2/2] dt-bindings: phy: ti,phy-j721e-wiz: fix bindings for torrent phy
Date:   Fri, 18 Sep 2020 11:37:43 +0300
Message-ID: <20200918083743.213874-2-tomi.valkeinen@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918083743.213874-1-tomi.valkeinen@ti.com>
References: <20200918083743.213874-1-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When WIZ wraps a Cadence Torrent PHY (instead of Cadence Sierra PHY)
there is a difference in the refclk-dig node: Torrent only has two
clocks instead of Sierra's four clocks. Add minItems: 2 to solve this.

Additionally, in our use case we only need to use assigned-clock for a
single clock, but the current binding requires either no assigned-clocks
or two. Fix this by adding minItems: 1 to all the assigned-clock
properties.

There was also an extra trailing whitespace, which this patch removes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---

Changes in v2:

* Base on phy-next

 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml   | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index 5ffc95c62909..c33e9bc79521 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -45,9 +45,15 @@ properties:
   ranges: true
 
   assigned-clocks:
+    minItems: 1
     maxItems: 2
 
   assigned-clock-parents:
+    minItems: 1
+    maxItems: 2
+
+  assigned-clock-rates:
+    minItems: 1
     maxItems: 2
 
   typec-dir-gpios:
@@ -119,9 +125,10 @@ patternProperties:
       logic.
     properties:
       clocks:
+        minItems: 2
         maxItems: 4
-        description: Phandle to four clock nodes representing the inputs to
-          refclk_dig
+        description: Phandle to two (Torrent) or four (Sierra) clock nodes representing
+          the inputs to refclk_dig
 
       "#clock-cells":
         const: 0
@@ -203,7 +210,7 @@ examples:
            };
 
            refclk-dig {
-                  clocks = <&k3_clks 292 11>, <&k3_clks 292 0>, 
+                  clocks = <&k3_clks 292 11>, <&k3_clks 292 0>,
                           <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
                   #clock-cells = <0>;
                   assigned-clocks = <&wiz0_refclk_dig>;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


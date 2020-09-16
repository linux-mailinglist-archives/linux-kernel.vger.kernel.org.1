Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CA126CB69
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgIPU06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:26:58 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58446 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgIPRZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:25:38 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08GClLqX043458;
        Wed, 16 Sep 2020 07:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600260441;
        bh=BoLji1jDPhuJCxrV8+eJr3d2Zu6IFzNElVtPtmkib9Q=;
        h=From:To:CC:Subject:Date;
        b=kwZA42v45JxKnrxNk1inRxTz8tXL73G/oiO4Vihi8gJSJt2U5Hz456o1JglrDU/7U
         sgviUdpAvKnSL0LOm6+/5SVReYURyUD/xDthCupxBoJtavg7WOHfIXPr3RgS3FXhty
         iGI3Ma44Rqduy9y0pt2QeajLJEDTF2d0GBx6l+WA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08GClLQQ106494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 07:47:21 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 07:47:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 07:47:20 -0500
Received: from deskari.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GClIou027623;
        Wed, 16 Sep 2020 07:47:18 -0500
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/2] dt-bindings: phy: ti,phy-j721e-wiz: fix bindings for torrent phy
Date:   Wed, 16 Sep 2020 15:47:10 +0300
Message-ID: <20200916124711.166643-1-tomi.valkeinen@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
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


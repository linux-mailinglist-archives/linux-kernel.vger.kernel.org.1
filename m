Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C8726F879
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIRIhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:37:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44282 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgIRIhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:37:52 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08I8bmAn048562;
        Fri, 18 Sep 2020 03:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600418268;
        bh=0t56EaP80PzJeDFaOK+P0Ax7QIKwm/7eg9l9TlrAEB8=;
        h=From:To:CC:Subject:Date;
        b=XEGKCsQgAwg7udabE7AuTyHfUj+M/e758rU7zCTtjtLX6jYCTDMm550o2Dm4oWLL0
         ME5FwXu2ANixxdbOpQm0ZVtj4/DrHG5s19KFucPBvsHPd2vPY5jFeNXPIhgcQPiL7t
         5oTfe+QJifCbr9dBfDLoJI2yQNWbFsUuHVrOejWc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08I8bmsj006233
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 03:37:48 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 03:37:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 03:37:47 -0500
Received: from deskari.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08I8bjT0109595;
        Fri, 18 Sep 2020 03:37:45 -0500
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: cdns,torrent-phy: add reset-names
Date:   Fri, 18 Sep 2020 11:37:42 +0300
Message-ID: <20200918083743.213874-1-tomi.valkeinen@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset-names as a required property.

There are no dts files using torrent phy yet, so it is safe to add a new
required property.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---

Changes in v2:

* Base on phy-next
* Update example
* Add torrent_apb

 .../devicetree/bindings/phy/phy-cadence-torrent.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 26480f89627d..e266ade53d87 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -57,6 +57,13 @@ properties:
       - description: Torrent PHY reset.
       - description: Torrent APB reset. This is optional.
 
+  reset-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: torrent_reset
+      - const: torrent_apb
+
 patternProperties:
   '^phy@[0-3]$':
     type: object
@@ -127,6 +134,7 @@ required:
   - reg
   - reg-names
   - resets
+  - reset-names
 
 additionalProperties: false
 
@@ -144,6 +152,7 @@ examples:
                   <0xf0 0xfb030a00 0x0 0x00000040>;
             reg-names = "torrent_phy", "dptx_phy";
             resets = <&phyrst 0>;
+            reset-names = "torrent_reset";
             clocks = <&ref_clk>;
             clock-names = "refclk";
             #address-cells = <1>;
@@ -172,6 +181,7 @@ examples:
             reg = <0xf0 0xfb500000 0x0 0x00100000>;
             reg-names = "torrent_phy";
             resets = <&phyrst 0>, <&phyrst 1>;
+            reset-names = "torrent_reset", "torrent_apb";
             clocks = <&ref_clk>;
             clock-names = "refclk";
             #address-cells = <1>;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


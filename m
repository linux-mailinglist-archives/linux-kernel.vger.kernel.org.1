Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF7C2E2672
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgLXLoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:44:05 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41422 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgLXLoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:44:04 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBhGIM048674;
        Thu, 24 Dec 2020 05:43:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608810196;
        bh=ovMxIAcf6Y9YiGb7+AcUSIA6TimQiEmhgqrwck2ZN7c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=V941GK/mI2vmaMrEwitGERPd0l0Y1N8LBcpi5lCKWuzNbWiAEEcsbaJC9l2zgAYpE
         wgYjUnFmZAhn9oRgwDmp+05vIrqofFDJb7y7uMu/vuwJoA3+yAxu4sIlK1yW/xs0Nj
         1Quuw7Hn6vpZIaDuNvF98BH3wyLkzws8ReLX6l3Q=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBhG6X089826
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:43:16 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:43:15 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:43:15 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBgtwW026267;
        Thu, 24 Dec 2020 05:43:11 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Peter Rosin <peda@axentia.se>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/7] dt-bindings: phy: cadence-torrent: Add binding for refclk driver
Date:   Thu, 24 Dec 2020 17:12:46 +0530
Message-ID: <20201224114250.1083-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224114250.1083-1-kishon@ti.com>
References: <20201224114250.1083-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for refclk driver used to route the refclk out of the
SERDES.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/phy/phy-cadence-torrent.yaml       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index e266ade53d87..d3b96afd514c 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -125,6 +125,23 @@ patternProperties:
 
     additionalProperties: false
 
+  "^refclk-driver":
+    type: object
+    description: |
+      Driver to route the reference clock out of the SERDES.
+    properties:
+      clocks:
+        maxItems: 1
+        description: Phandle to clock nodes representing the input to the
+          refclk driver.
+
+      "#clock-cells":
+        const: 0
+
+    required:
+      - clocks
+      - "#clock-cells"
+
 required:
   - compatible
   - "#address-cells"
-- 
2.17.1


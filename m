Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1002E267B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgLXLox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:44:53 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39656 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgLXLox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:44:53 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBhAXf083357;
        Thu, 24 Dec 2020 05:43:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608810190;
        bh=94E65ixmOJZFX7TRdsWv8gU0jihL6XoZszoQCsm3YLE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=veF4Uir3GKY963R+jqrnfnZypAmNRBusxwCaZtWqrqamZbyaKXmqaooxY0QFopB7e
         LmsgZQzwDdKDoVpT84l83ATHj0+6tXNWKgC2dJVM0XDlOS25f32za9sOT6pMj6/omr
         PMH/rqJ9LrEJm80obCRUGyB9VHMgkzkUMu/4bg9I=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBhAen089791
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:43:10 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:43:10 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:43:10 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBgtwV026267;
        Thu, 24 Dec 2020 05:43:06 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Peter Rosin <peda@axentia.se>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/7] dt-bindings: phy: ti,phy-j721e-wiz: Add binding for phy_en_refclk
Date:   Thu, 24 Dec 2020 17:12:45 +0530
Message-ID: <20201224114250.1083-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224114250.1083-1-kishon@ti.com>
References: <20201224114250.1083-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding for phy_en_refclk used to route the refclk out of the
SERDES.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index 4a1f9c27b5f0..14823588bc94 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -149,6 +149,19 @@ patternProperties:
       - assigned-clocks
       - assigned-clock-parents
 
+  "^phy-en-refclk$":
+    type: object
+    description: |
+      In order to drive the refclk out from the SERDES (Cadence Torrent),
+      PHY_EN_REFCLK should be set in SERDES_RST of WIZ. Model phy-en-refclk
+      as a clock so that it can be enabled directly or as a parent clock.
+    properties:
+      "#clock-cells":
+        const: 0
+
+    required:
+      - "#clock-cells"
+
   "^serdes@[0-9a-f]+$":
     type: object
     description: |
-- 
2.17.1


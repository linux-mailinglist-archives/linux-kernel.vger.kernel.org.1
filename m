Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B822EA6F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbhAEJGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:06:44 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:9940 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727679AbhAEJGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:06:30 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10593IVg000856;
        Tue, 5 Jan 2021 10:05:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=yUM6UDXk4052Snui9PdYxyhjgeVqwrZ/q86U4XwqofM=;
 b=qLW6o0VSAAbpgn1avOzQYKPPBJa8OHcTLHlVrMmRVj7UiAnzMk+B4bKmJKIHyyAnHCfG
 GvX7y6ppAheOlW1ZSPKNxyAuzRsdjaBy8PjmZG12C2z5NveCI4VLZpFCSzZtkB6K/Djc
 XYm3cro4H9FbuTDzm58pPl3DiU0c2rUhF+c5iQOTxuE1aKgt/Ougww1dbGrLWa8rVoC/
 8k3lGJdheY03FIikt3XmM2CfZK4ZzxomCPqKLzXzybGQGgfhXJu7mFZXrXDyZTNGEj8q
 CIN4chc3CKVYtRjC6IQNoLpbpEJxja46hhxfAlHxoajSBrhE0Uz7VJ90t5enK0/t19pT yA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35tf66uy52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 10:05:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4C57910002A;
        Tue,  5 Jan 2021 10:05:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 371DD22AA5B;
        Tue,  5 Jan 2021 10:05:34 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Jan 2021 10:05:33
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 1/6] dt-bindings: phy: phy-stm32-usbphyc: move PLL supplies to parent node
Date:   Tue, 5 Jan 2021 10:05:20 +0100
Message-ID: <20210105090525.23164-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105090525.23164-1-amelie.delaunay@foss.st.com>
References: <20210105090525.23164-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PLL block requires to be powered with 1v1 and 1v8 supplies to catch ENABLE
signal.
Currently, supplies are managed through phy_ops .power_on/off, and PLL
activation/deactivation is managed through phy_ops .init/exit.
The sequence of phy_ops .power_on/.phy_init, .power_off/.exit is USB
drivers dependent.
To ensure a good behavior of the PLL, supplies have to be managed at PLL
activation/deactivation. That means the supplies need to be put in usbphyc
parent node and not in phy children nodes.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Note that even with bindings change, it doesn't break the backward
compatibility: old device trees are still compatible, USB is still
functional. Device trees will be updated with this new bindings
when approved.
---
 .../bindings/phy/phy-stm32-usbphyc.yaml       | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
index 0ba61979b970..46df6786727a 100644
--- a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
@@ -45,6 +45,12 @@ properties:
   "#size-cells":
     const: 0
 
+  vdda1v1-supply:
+    description: regulator providing 1V1 power supply to the PLL block
+
+  vdda1v8-supply:
+    description: regulator providing 1V8 power supply to the PLL block
+
 #Required child nodes:
 
 patternProperties:
@@ -61,12 +67,6 @@ patternProperties:
       phy-supply:
         description: regulator providing 3V3 power supply to the PHY.
 
-      vdda1v1-supply:
-        description: regulator providing 1V1 power supply to the PLL block
-
-      vdda1v8-supply:
-        description: regulator providing 1V8 power supply to the PLL block
-
       "#phy-cells":
         enum: [ 0x0, 0x1 ]
 
@@ -90,8 +90,6 @@ patternProperties:
     required:
       - reg
       - phy-supply
-      - vdda1v1-supply
-      - vdda1v8-supply
       - "#phy-cells"
 
     additionalProperties: false
@@ -102,6 +100,8 @@ required:
   - clocks
   - "#address-cells"
   - "#size-cells"
+  - vdda1v1-supply
+  - vdda1v8-supply
   - usb-phy@0
   - usb-phy@1
 
@@ -116,22 +116,20 @@ examples:
         reg = <0x5a006000 0x1000>;
         clocks = <&rcc USBPHY_K>;
         resets = <&rcc USBPHY_R>;
+        vdda1v1-supply = <&reg11>;
+        vdda1v8-supply = <&reg18>;
         #address-cells = <1>;
         #size-cells = <0>;
 
         usbphyc_port0: usb-phy@0 {
             reg = <0>;
             phy-supply = <&vdd_usb>;
-            vdda1v1-supply = <&reg11>;
-            vdda1v8-supply = <&reg18>;
             #phy-cells = <0>;
         };
 
         usbphyc_port1: usb-phy@1 {
             reg = <1>;
             phy-supply = <&vdd_usb>;
-            vdda1v1-supply = <&reg11>;
-            vdda1v8-supply = <&reg18>;
             #phy-cells = <1>;
         };
     };
-- 
2.17.1


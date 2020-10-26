Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B70B2991F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785078AbgJZQLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:11:42 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45786 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442303AbgJZQKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:10:45 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C69721A0C97;
        Mon, 26 Oct 2020 17:10:43 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B95971A0052;
        Mon, 26 Oct 2020 17:10:43 +0100 (CET)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 72DE02030E;
        Mon, 26 Oct 2020 17:10:43 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v4 01/11] dt-bindings: net: add the DPAA2 MAC DTS definition
Date:   Mon, 26 Oct 2020 18:09:55 +0200
Message-Id: <20201026161005.5421-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026161005.5421-1-ioana.ciornei@nxp.com>
References: <20201026161005.5421-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a documentation entry for the DTS bindings needed and supported by
the dpaa2-mac driver.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
 - new patch
Changes in v3:
 - renamed dpmac@x into ethernet@x
 - renamed the new documentation file to use the same name as the
   compatible
 - marked additionalProperties as false
 - added a reference to ethernet-controller.yaml
Changes in v4:
 - none


 .../bindings/net/fsl,qoriq-mc-dpmac.yaml      | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml

diff --git a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
new file mode 100644
index 000000000000..2159b7d1f537
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DPAA2 MAC bindings
+
+maintainers:
+  - Ioana Ciornei <ioana.ciornei@nxp.com>
+
+description:
+  This binding represents the DPAA2 MAC objects found on the fsl-mc bus and
+  located under the 'dpmacs' node for the fsl-mc bus DTS node.
+
+allOf:
+  - $ref: "ethernet-controller.yaml#"
+
+properties:
+  compatible:
+    const: fsl,qoriq-mc-dpmac
+
+  reg:
+    maxItems: 1
+    description: The DPMAC number
+
+  phy-handle: true
+
+  phy-connection-type: true
+
+  phy-mode: true
+
+  pcs-handle:
+    $ref: /schemas/types.yaml#definitions/phandle
+    description:
+      A reference to a node representing a PCS PHY device found on
+      the internal MDIO bus.
+
+  managed: true
+
+required:
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    dpmacs {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ethernet@4 {
+        compatible = "fsl,qoriq-mc-dpmac";
+        reg = <0x4>;
+        phy-handle = <&mdio1_phy6>;
+        phy-connection-type = "qsgmii";
+        managed = "in-band-status";
+        pcs-handle = <&pcs3_1>;
+      };
+    };
-- 
2.28.0


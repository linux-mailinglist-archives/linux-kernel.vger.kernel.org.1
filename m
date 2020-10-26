Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5568E299472
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788717AbgJZRzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:55:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33806 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788705AbgJZRzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:55:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 91E611F44FC9
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 01/16] dt-bindings: power: Add bindings for the Mediatek SCPSYS power domains controller
Date:   Mon, 26 Oct 2020 18:55:10 +0100
Message-Id: <20201026175526.2915399-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026175526.2915399-1-enric.balletbo@collabora.com>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The System Control Processor System (SCPSYS) has several power management
related tasks in the system. Add the bindings to define the power
domains for the SCPSYS power controller.

Co-developed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3:
- Use hex for unit-addresses.
- Define child nodes for nested power domains even are duplicated, but
  more clear than adding a regex scaped to be a valid URI.

Changes in v2:
- Use generic node names (power-domain).
- Define valid values for common properties like #power-domain-cells.

 .../power/mediatek,power-controller.yaml      | 289 ++++++++++++++++++
 1 file changed, 289 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mediatek,power-controller.yaml

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
new file mode 100644
index 000000000000..62524f03f64f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -0,0 +1,289 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Power Domains Controller
+
+maintainers:
+  - Weiyi Lu <weiyi.lu@mediatek.com>
+  - Matthias Brugger <mbrugger@suse.com>
+
+description: |
+  Mediatek processors include support for multiple power domains which can be
+  powered up/down by software based on different application scenes to save power.
+
+  IP cores belonging to a power domain should contain a 'power-domains'
+  property that is a phandle for SCPSYS node representing the domain.
+
+properties:
+  $nodename:
+    const: power-controller
+
+  compatible:
+    enum:
+      - mediatek,mt8173-power-controller
+
+  '#power-domain-cells':
+    const: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^power-domain@[0-9a-f]+$":
+    type: object
+    description: |
+      Represents the power domains within the power controller node as documented
+      in Documentation/devicetree/bindings/power/power-domain.yaml.
+
+    properties:
+
+      '#power-domain-cells':
+        description:
+            Must be 0 for nodes representing a single PM domain and 1 for nodes
+            providing multiple PM domains.
+
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+      reg:
+        description: |
+          Power domain index. Valid values are defined in:
+              "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
+        maxItems: 1
+
+      clocks:
+        description: |
+          A number of phandles to clocks that need to be enabled during domain
+          power-up sequencing.
+
+      clock-names:
+        description: |
+          List of names of clocks, in order to match the power-up sequencing
+          for each power domain we need to group the clocks by name. BASIC
+          clocks need to be enabled before enabling the corresponding power
+          domain, and should not have a '-' in their name (i.e mm, mfg, venc).
+          SUSBYS clocks need to be enabled before releasing the bus protection,
+          and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
+
+          In order to follow properly the power-up sequencing, the clocks must
+          be specified by order, adding first the BASIC clocks followed by the
+          SUSBSYS clocks.
+
+      mediatek,infracfg:
+        $ref: /schemas/types.yaml#definitions/phandle
+        description: phandle to the device containing the INFRACFG register range.
+
+      mediatek,smi:
+        $ref: /schemas/types.yaml#definitions/phandle
+        description: phandle to the device containing the SMI register range.
+
+    patternProperties:
+      "^power-domain@[0-9a-f]+$":
+        type: object
+        description: |
+          Represents a power domain child within a power domain parent node.
+
+        properties:
+
+          '#power-domain-cells':
+            description:
+                Must be 0 for nodes representing a single PM domain and 1 for nodes
+                providing multiple PM domains.
+
+          '#address-cells':
+            const: 1
+
+          '#size-cells':
+            const: 0
+
+          reg:
+             maxItems: 1
+
+          clocks:
+            description: |
+              A number of phandles to clocks that need to be enabled during domain
+              power-up sequencing.
+
+          clock-names:
+            description: |
+              List of names of clocks, in order to match the power-up sequencing
+              for each power domain we need to group the clocks by name. BASIC
+              clocks need to be enabled before enabling the corresponding power
+              domain, and should not have a '-' in their name (i.e mm, mfg, venc).
+              SUSBYS clocks need to be enabled before releasing the bus protection,
+              and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
+
+              In order to follow properly the power-up sequencing, the clocks must
+              be specified by order, adding first the BASIC clocks followed by the
+              SUSBSYS clocks.
+
+          mediatek,infracfg:
+            $ref: /schemas/types.yaml#definitions/phandle
+            description: phandle to the device containing the INFRACFG register range.
+
+          mediatek,smi:
+            $ref: /schemas/types.yaml#definitions/phandle
+            description: phandle to the device containing the SMI register range.
+
+        patternProperties:
+          "^power-domain@[0-9a-f]+$":
+            type: object
+            description: |
+              Represents a power domain child within a power domain parent node.
+
+            properties:
+
+              '#power-domain-cells':
+                description:
+                    Must be 0 for nodes representing a single PM domain and 1 for nodes
+                    providing multiple PM domains.
+
+              '#address-cells':
+                const: 1
+
+              '#size-cells':
+                const: 0
+
+              reg:
+                 maxItems: 1
+
+              clocks:
+                description: |
+                  A number of phandles to clocks that need to be enabled during domain
+                  power-up sequencing.
+
+              clock-names:
+                description: |
+                  List of names of clocks, in order to match the power-up sequencing
+                  for each power domain we need to group the clocks by name. BASIC
+                  clocks need to be enabled before enabling the corresponding power
+                  domain, and should not have a '-' in their name (i.e mm, mfg, venc).
+                  SUSBYS clocks need to be enabled before releasing the bus protection,
+                  and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
+
+                  In order to follow properly the power-up sequencing, the clocks must
+                  be specified by order, adding first the BASIC clocks followed by the
+                  SUSBSYS clocks.
+
+              mediatek,infracfg:
+                $ref: /schemas/types.yaml#definitions/phandle
+                description: phandle to the device containing the INFRACFG register range.
+
+              mediatek,smi:
+                $ref: /schemas/types.yaml#definitions/phandle
+                description: phandle to the device containing the SMI register range.
+
+            required:
+              - reg
+
+            additionalProperties: false
+
+        required:
+          - reg
+
+        additionalProperties: false
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/power/mt8173-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        scpsys: syscon@10006000 {
+            compatible = "syscon", "simple-mfd";
+            reg = <0 0x10006000 0 0x1000>;
+
+            spm: power-controller {
+                compatible = "mediatek,mt8173-power-controller";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                #power-domain-cells = <1>;
+
+                /* power domains of the SoC */
+                power-domain@MT8173_POWER_DOMAIN_VDEC {
+                    reg = <MT8173_POWER_DOMAIN_VDEC>;
+                    clocks = <&topckgen CLK_TOP_MM_SEL>;
+                    clock-names = "mm";
+                    #power-domain-cells = <0>;
+                };
+                power-domain@MT8173_POWER_DOMAIN_VENC {
+                    reg = <MT8173_POWER_DOMAIN_VENC>;
+                    clocks = <&topckgen CLK_TOP_MM_SEL>,
+                             <&topckgen CLK_TOP_VENC_SEL>;
+                    clock-names = "mm", "venc";
+                    #power-domain-cells = <0>;
+                };
+                power-domain@MT8173_POWER_DOMAIN_ISP {
+                    reg = <MT8173_POWER_DOMAIN_ISP>;
+                    clocks = <&topckgen CLK_TOP_MM_SEL>;
+                    clock-names = "mm";
+                    #power-domain-cells = <0>;
+                };
+                power-domain@MT8173_POWER_DOMAIN_MM {
+                    reg = <MT8173_POWER_DOMAIN_MM>;
+                    clocks = <&topckgen CLK_TOP_MM_SEL>;
+                    clock-names = "mm";
+                    #power-domain-cells = <0>;
+                    mediatek,infracfg = <&infracfg>;
+                };
+                power-domain@MT8173_POWER_DOMAIN_VENC_LT {
+                    reg = <MT8173_POWER_DOMAIN_VENC_LT>;
+                    clocks = <&topckgen CLK_TOP_MM_SEL>,
+                             <&topckgen CLK_TOP_VENC_LT_SEL>;
+                    clock-names = "mm", "venclt";
+                    #power-domain-cells = <0>;
+                };
+                power-domain@MT8173_POWER_DOMAIN_AUDIO {
+                    reg = <MT8173_POWER_DOMAIN_AUDIO>;
+                    #power-domain-cells = <0>;
+                };
+                power-domain@MT8173_POWER_DOMAIN_USB {
+                    reg = <MT8173_POWER_DOMAIN_USB>;
+                    #power-domain-cells = <0>;
+                };
+                power-domain@MT8173_POWER_DOMAIN_MFG_ASYNC {
+                    reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
+                    clocks = <&clk26m>;
+                    clock-names = "mfg";
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    #power-domain-cells = <1>;
+
+                    power-domain@MT8173_POWER_DOMAIN_MFG_2D {
+                        reg = <MT8173_POWER_DOMAIN_MFG_2D>;
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+                        #power-domain-cells = <1>;
+
+                        power-domain@MT8173_POWER_DOMAIN_MFG {
+                            reg = <MT8173_POWER_DOMAIN_MFG>;
+                            #power-domain-cells = <0>;
+                            mediatek,infracfg = <&infracfg>;
+                        };
+                    };
+                };
+            };
+        };
+    };
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FC72F684A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbhANRvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:51:08 -0500
Received: from m-r2.th.seeweb.it ([5.144.164.171]:33611 "EHLO
        m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbhANRvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:51:08 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 9790B3EA59;
        Thu, 14 Jan 2021 18:50:25 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     thierry.reding@gmail.com
Cc:     sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 2/2] dt-bindings: display: Document BOE BF060Y8M-AJ0 panel compatible
Date:   Thu, 14 Jan 2021 18:50:24 +0100
Message-Id: <20210114175024.399756-2-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114175024.399756-1-angelogioacchino.delregno@somainline.org>
References: <20210114175024.399756-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the boe,bf060y8m-aj0 panel.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 .../display/panel/boe,bf060y8m-aj0.yaml       | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,bf060y8m-aj0.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/boe,bf060y8m-aj0.yaml b/Documentation/devicetree/bindings/display/panel/boe,bf060y8m-aj0.yaml
new file mode 100644
index 000000000000..0fba09ddb6a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/boe,bf060y8m-aj0.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/boe,bf060y8m-aj0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BOE BF060Y8M-AJ0 5.99" 1080x2160 AMOLED Panel
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
+
+description: |
+  This is a 5.99" 1080x2160 16.7M Color active matrix AMOLED
+  video mode panel module on MIPI-DSI 4-Lane interface, GGRB
+  pixel arrangement, 63 micrometers pitch, with an active
+  area of 68.04 x 136.08 millimeters.
+  Each pixel is divided into red and green dots, or blue and
+  green dots, and two pixels share red or blue dots which are
+  arranged in vertical stripe.
+  The DriverIC for this panel module is SW43404.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: boe,bf060y8m-aj0
+  reg: true
+  reset-gpios: true
+  vcc-supply:
+    description: Core (TSP) voltage supply (2.70-3.60V)
+  vddio-supply:
+    description: I/O voltage supply (1.62-1.98V)
+  vci-supply:
+    description: DriverIC Operation supply (2.60-3.60V)
+  elvdd-supply:
+    description: EL Driving positive (VDD) supply (4.40-4.80V)
+  elvss-supply:
+    description: EL Driving negative (VSS) supply (-5.00V to -1.40V)
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            panel@0 {
+                    compatible = "boe,bf060y8m,aj0";
+                    reg = <0>;
+
+                    vcc-supply = <&disp_vcc_vreg>;
+                    vddio-supply = <&disp_vddio_vreg>;
+                    vci-supply = <&disp_vci_vreg>;
+                    elvdd-supply = <&disp_elvdd_vreg>;
+                    elvss-supply = <&disp_elvss_vreg>;
+
+                    reset-gpios = <&tlmm 94 GPIO_ACTIVE_HIGH>;
+            };
+    };
-- 
2.29.2


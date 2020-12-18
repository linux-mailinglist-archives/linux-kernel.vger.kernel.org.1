Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350462DE6E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 16:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgLRPoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 10:44:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:43026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgLRPoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 10:44:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 42DE4AD60;
        Fri, 18 Dec 2020 15:43:36 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        robh+dt@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        tim.gover@raspberrypi.com, phil@raspberrypi.com
Subject: [PATCH v2 1/5] dt-bindings: nvmem: Add bindings for rmem driver
Date:   Fri, 18 Dec 2020 16:43:16 +0100
Message-Id: <20201218154320.28368-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218154320.28368-1-nsaenzjulienne@suse.de>
References: <20201218154320.28368-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware/co-processors might use reserved memory areas in order to pass
data stemming from an nvmem device otherwise non accessible to Linux.
For example an EEPROM memory only physically accessible to firmware, or
data only accessible early at boot time.

Introduce the dt-bindings to nvmem's rmem.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Changes since v1:
 - Update schema to new driver design

 .../devicetree/bindings/nvmem/rmem.yaml       | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/rmem.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/rmem.yaml b/Documentation/devicetree/bindings/nvmem/rmem.yaml
new file mode 100644
index 000000000000..29b53871aa02
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/rmem.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/rmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Reserved Memory Based nvmem Device
+
+maintainers:
+  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - raspberrypi,bootloader-config
+      - const: nvmem-rmem
+
+  no-map:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Avoid creating a virtual mapping of the region as part of the OS'
+      standard mapping of system memory.
+
+required:
+  - compatible
+  - no-map
+
+unevaluatedProperties: false
+
+examples:
+  - |
+        reserved-memory {
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                blconfig: nvram@10000000 {
+                        compatible = "raspberrypi,bootloader-config", "nvmem-rmem";
+                        #address-cells = <1>;
+                        #size-cells = <1>;
+                        reg = <0x10000000 0x1000>;
+                        no-map;
+                };
+        };
+
+...
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E68C2DB0E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbgLOQDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:03:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:60806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730659AbgLOP5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:57:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 352ECACF9;
        Tue, 15 Dec 2020 15:56:41 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     srinivas.kandagatla@linaro.org,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, robh+dt@kernel.org,
        tim.gover@raspberrypi.com, phil@raspberrypi.com
Subject: [PATCH 1/6] dt-bindings: nvmem: Add bindings for rmem driver
Date:   Tue, 15 Dec 2020 16:56:21 +0100
Message-Id: <20201215155627.2513-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215155627.2513-1-nsaenzjulienne@suse.de>
References: <20201215155627.2513-1-nsaenzjulienne@suse.de>
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
 .../devicetree/bindings/nvmem/rmem.yaml       | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/rmem.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/rmem.yaml b/Documentation/devicetree/bindings/nvmem/rmem.yaml
new file mode 100644
index 000000000000..3037ebc4634d
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/rmem.yaml
@@ -0,0 +1,35 @@
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
+properties:
+  compatible:
+    enum:
+      - nvmem-rmem
+
+  memory-region:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the reserved memory region
+
+required:
+  - compatible
+  - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+        fw-config {
+                compatible = "nvmem-rmem";
+                memory-region = <&mem>;
+        };
+
+...
-- 
2.29.2


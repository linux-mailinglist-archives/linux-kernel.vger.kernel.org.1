Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866742850B6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJFRX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:23:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39732 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFRX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:23:59 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 096HNmac124305;
        Tue, 6 Oct 2020 12:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602005028;
        bh=irQFGBfcmEyAfUvvL/TexTT802hbDdNn/2QtblPPM+c=;
        h=From:To:CC:Subject:Date;
        b=QygmtDV1oRj+4rNGtevcVxWI/wKzijMjcQnUGyPj+Nji99F7BCP+Cltk1agdSYp6G
         3T2ySJkuyxXqgL006OloRs0wA11uiArUQq4w8frIpbsUTeevTbvOYn4y+fftXUjqcO
         Qem3dH5mN7qrIBNK+6UgkHZGcrPxJ5iQ3+yHNHb4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 096HNmu1066923
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Oct 2020 12:23:48 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 6 Oct
 2020 12:23:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 6 Oct 2020 12:23:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 096HNmnJ096384;
        Tue, 6 Oct 2020 12:23:48 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: tas2764: Add the TAS2764 binding doc
Date:   Tue, 6 Oct 2020 12:23:40 -0500
Message-ID: <20201006172341.16423-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding for the TAS2764 Smart Amplifier.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/sound/tas2764.yaml    | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas2764.yaml

diff --git a/Documentation/devicetree/bindings/sound/tas2764.yaml b/Documentation/devicetree/bindings/sound/tas2764.yaml
new file mode 100644
index 000000000000..d2c90c82b13f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas2764.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/sound/tas2764.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Texas Instruments TAS2764 Smart PA
+
+maintainers:
+  - Dan Murphy <dmurphy@ti.com>
+
+description: |
+  The TAS2764 is a mono, digital input Class-D audio amplifier optimized for
+  efficiently driving high peak power into small loudspeakers.
+  Integrated speaker voltage and current sense provides for
+  real time monitoring of loudspeaker behavior.
+
+properties:
+  compatible:
+    enum:
+      - ti,tas2764
+
+  reg:
+    maxItems: 1
+    description: |
+       I2C address of the device can be between 0x38 to 0x45.
+
+  reset-gpios:
+    description: GPIO used to reset the device.
+
+  shutdown-gpios:
+    description: GPIO used to control the state of the device.
+
+  interrupts:
+    maxItems: 1
+
+  ti,imon-slot-no:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: TDM TX current sense time slot.
+
+  ti,vmon-slot-no:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: TDM TX voltage sense time slot.
+
+  '#sound-dai-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/gpio/gpio.h>
+   i2c0 {
+     #address-cells = <1>;
+     #size-cells = <0>;
+     codec: codec@38 {
+       compatible = "ti,tas2764";
+       reg = <0x38>;
+       #sound-dai-cells = <1>;
+       interrupt-parent = <&gpio1>;
+       interrupts = <14>;
+       reset-gpio = <&gpio1 15 0>;
+       shutdown-gpios = <&gpio1 15 0>;
+       ti,imon-slot-no = <0>;
+       ti,vmon-slot-no = <2>;
+     };
+   };
+
+...
-- 
2.28.0.585.ge1cfff676549


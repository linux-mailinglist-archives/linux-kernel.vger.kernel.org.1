Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1AE2C8323
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgK3LYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbgK3LYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:24:31 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3A2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:23:50 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id b12so1176299pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5KQEYcp6l6dBFn1raevTr29TeoPJz8nJ6f6yY9EnMeE=;
        b=c3Y5DGTqRSegKH/Wo4ABWzvfq7RxsnyYIx8B7v8xobbvKb66SB8rBO0w8hXYuKkItB
         muDZA+nshAnhkHJmWg44802W6iE8REMKvEIC4SzIquVSP6nR+9jMPm+iRMuP2hAiXIEe
         uPD/iILXOc3Ey5btuRWXZr9WjbVrhisMoUp3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5KQEYcp6l6dBFn1raevTr29TeoPJz8nJ6f6yY9EnMeE=;
        b=UUyirCpNV/lcuYUG3bKuTS5Fa45QlP4uJLHccGxLFRYE+ajqSrzKsjR1g6/mJJHqWA
         pX7jWHXZaBiLXD8slkFuIOReyxQNqD7hbgg7JyK+S9Z+tggG+i57vv0H+hFS7s9Onzsy
         KdMqi22lUHAU8xWf66N36ScSzkcyOu2L2ij60EF/6YI/FSDrHUureq6d2tQU+5xjubny
         xVFM2LeUp8K3RdPoj1I41aD5L+WsZ/g8fq6Udo77SW3Qs6e4zXZwFhKGkp6Zy4UERGUn
         QfnDXQeOUQuCndisT9B19Cdm8lOcHb/1VlRRtXr5v8DCfWOa6hVQnGkTz4V83R2Pc0LD
         W0MA==
X-Gm-Message-State: AOAM533IYUTRB31PNgVG7WQY/9a/klAaXTbrHsqWCDBkDIV9I8gTGf7G
        2JIacRwek9ywF1M5aj22z+86PWcskZj11BOk
X-Google-Smtp-Source: ABdhPJzgaq+7GVK8vXDvTehlFsfhsh/zRT+j1VOIpCOeuDHv3wSCATz00rLvomKzjQP3aybSXjjEBA==
X-Received: by 2002:a17:902:a5c1:b029:d8:d387:3c23 with SMTP id t1-20020a170902a5c1b02900d8d3873c23mr18245054plq.22.1606735430157;
        Mon, 30 Nov 2020 03:23:50 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:741b:45e2:5211:48e3])
        by smtp.gmail.com with ESMTPSA id d19sm22438326pjs.0.2020.11.30.03.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 03:23:49 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Troy Kisky <troy.kisky@boundarydevices.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/2] dt-bindings: regulator: Add pf8x00 regulator bindings
Date:   Mon, 30 Nov 2020 16:53:28 +0530
Message-Id: <20201130112329.104614-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NXP PF8100/PF8121A/PF8200 regulators bindings.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../regulator/nxp,pf8x00-regulator.yaml       | 211 ++++++++++++++++++
 1 file changed, 211 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
new file mode 100644
index 000000000000..a6c259ce9785
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -0,0 +1,211 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/nxp,pf8x00-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PF8100/PF8121A/PF8200 PMIC regulators
+
+maintainers:
+  - Jagan Teki <jagan@amarulasolutions.com>
+  - Troy Kisky <troy.kisky@boundarydevices.com>
+
+description: |
+  PF8100/PF8121A/PF8200 is a PMIC designed for highperformance consumer
+  applications. It features seven high efficiency buck converters, four
+  linear and one vsnvs regulators. It has built-in one time programmable
+  fuse bank for device configurations.
+
+properties:
+  compatible:
+    enum:
+      - nxp,pf8x00
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: |
+      list of regulators provided by this controller
+
+    patternProperties:
+      "^ldo[1-4]$":
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single LDO regulator.
+
+        properties:
+          regulator-name:
+            pattern: "^ldo[1-4]$"
+            description:
+              should be "ldo1", ..., "ldo4"
+
+        unevaluatedProperties: false
+
+      "^buck[1-7]$":
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single BUCK regulator.
+
+        properties:
+          regulator-name:
+            pattern: "^buck[1-7]$"
+            description:
+              should be "buck1", ..., "buck7"
+
+          nxp,ilim-ma:
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            minimum: 2100
+            maximum: 4500
+            description:
+              BUCK regulators current limit in mA.
+
+              Listed current limits in mA are,
+              2100 (default)
+              2600
+              3000
+              4500
+
+          nxp,phase-shift:
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            minimum: 45
+            maximum: 0
+            description:
+              BUCK regulators phase shift control in degrees.
+
+              Listed phase shift control values in degrees are,
+              45
+              90
+              135
+              180
+              225
+              270
+              315
+              0 (default)
+
+        unevaluatedProperties: false
+
+      "^vsnvs$":
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single VSNVS regulator.
+
+        properties:
+          regulator-name:
+            pattern: "^vsnvs$"
+            description:
+              should be "vsnvs"
+
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@8 {
+            compatible = "nxp,pf8x00";
+            reg = <0x08>;
+
+            regulators {
+                reg_ldo1: ldo1 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-max-microvolt = <5000000>;
+                    regulator-min-microvolt = <1500000>;
+                };
+
+                reg_ldo2: ldo2 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-max-microvolt = <5000000>;
+                    regulator-min-microvolt = <1500000>;
+                };
+
+                reg_ldo3: ldo3 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-max-microvolt = <5000000>;
+                    regulator-min-microvolt = <1500000>;
+                };
+
+                reg_ldo4: ldo4 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-max-microvolt = <5000000>;
+                    regulator-min-microvolt = <1500000>;
+                };
+
+                reg_buck1: buck1 {
+                    nxp,ilim-ma = <4500>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-min-microvolt =  <400000>;
+                };
+
+                reg_buck2: buck2 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-min-microvolt =  <400000>;
+                };
+
+                reg_buck3: buck3 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-min-microvolt =  <400000>;
+                };
+
+                reg_buck4: buck4 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-min-microvolt =  <400000>;
+                };
+
+                reg_buck5: buck5 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-min-microvolt =  <400000>;
+                };
+
+                reg_buck6: buck6 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-min-microvolt =  <400000>;
+                };
+
+                reg_buck7: buck7 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-min-microvolt = <3300000>;
+                };
+
+                reg_vsnvs: vsnvs {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-min-microvolt = <1800000>;
+                };
+            };
+        };
+    };
-- 
2.25.1


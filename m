Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675D724B127
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 10:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHTIgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 04:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHTIgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:36:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C698EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 01:36:17 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t11so713899plr.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 01:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mrDhicMEzi6ypjXQ+lHgViYNy1XmglXxxOBXI3pmGZg=;
        b=XlW911ZV7fx3iRAfW45F7OJJj47Ts4kuM75hG+XUQ8h7WgejYPhagyKwmpz9Op8KLW
         /4mozTBX9+gRK+/C/Gif7OsJZ8hfcMsNUtRcCS6nFUnxZaE03sb9Ir+cjzR0uuxnrUhR
         OZd9lLtNKIJnz1Dcv79w7fWSdjonYsEjWersOx8W7MsDABuOJiZwRN5NLZ638fEKDcoT
         Ng4LrT4kZbJP1ECuBOLb8VIejLKAXdhsLy4SkWfqbDp4C5a/aV/284a87Bk7qd15yRHq
         KIKffmVPXA8CC57QZX3+LiI4auvlwEK9AHcVUlQHmysuVCASd/+AopIzXVSlgz9Borkg
         HaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mrDhicMEzi6ypjXQ+lHgViYNy1XmglXxxOBXI3pmGZg=;
        b=qsvePUzZaB9TXw38HwdQVg3NG+n6+6ogC5yfto8bq8/92afsSc+HRBn70ftPx/zm5P
         V7X3/D5BRDIwuXVQBJ4yUMyk3cS2C8DVDKXyTGm8Oc1SvU6dtE9R8txGuDlw4UzdvN6h
         kf0t46EOC8H5Clp0WggsmxPQJKbSC1iuYzb1GahIbzDzsk1FbMCRUwtfPJKPJeKQNamu
         9uLFy/Lb0gxXgxSQUWEREaJhgeIjsgfF5RecytSqnUOrMFkbEXPvG6RAM/Zp4hH7cxIi
         qQ6QRqUAYEtSryN0/vvV/DV5W8AWhqArGarcySY0RIuHC6Kf+45sW0DIO/ffa5ppGtD5
         99cw==
X-Gm-Message-State: AOAM531odte5UqOMwc2fMLyfizRa2AnL6qblT0EDq+jnoPhIyjKTUpmZ
        GmxkpFKw+1unJ77zQ08bkPg=
X-Google-Smtp-Source: ABdhPJzYa0qNWcybovZD6zvwZkMtD3wDMkD2dvdTNELV61zeYzKi5ndT9d47ZiO2WLg8lSB3NJI1jA==
X-Received: by 2002:a17:90a:c201:: with SMTP id e1mr1684156pjt.142.1597912577051;
        Thu, 20 Aug 2020 01:36:17 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:41e:201d:7f1a:5526:baf8:a1ae])
        by smtp.gmail.com with ESMTPSA id f13sm1762760pfd.215.2020.08.20.01.36.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 01:36:16 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH] dt-bindings: mfd: mediatek: Add bindings for MT6360 PMIC
Date:   Thu, 20 Aug 2020 16:35:30 +0800
Message-Id: <1597912530-5374-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add bindings for MT6360 PMIC

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 Documentation/devicetree/bindings/mfd/mt6360.yaml | 142 ++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.yaml

diff --git a/Documentation/devicetree/bindings/mfd/mt6360.yaml b/Documentation/devicetree/bindings/mfd/mt6360.yaml
new file mode 100644
index 0000000..5ad1afd
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mt6360.yaml
@@ -0,0 +1,142 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/mt6360.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MT6360 PMIC from MediaTek Integrated
+
+maintainers:
+  - Gene Chen <gene_chen@richtek.com>
+
+description: |
+  MT6360 is a PMIC device with the following sub modules.
+  It is interfaced to host controller using I2C interface.
+
+  This document describes the binding for PMIC device and its sub module.
+
+properties:
+  compatible:
+    const: mediatek,mt6360
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+      enum:
+        - IRQB
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+    description:
+      The first cell is the IRQ number.
+
+  regulator:
+    $ref: ../regulator/mt6360-regulator.yaml
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mt6360@34 {
+            compatible = "mediatek,mt6360";
+            reg = <0x34>;
+            wakeup-source;
+            interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-names = "IRQB";
+            interrupt-controller;
+            #interrupt-cells = <1>;
+            regulator {
+                compatible = "mediatek,mt6360-regulator";
+                LDO_VIN3-supply = <&BUCK2>;
+                buck1 {
+                    regulator-compatible = "BUCK1";
+                    regulator-name = "mt6360,buck1";
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <1300000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                                               MT6360_OPMODE_LP
+                                               MT6360_OPMODE_ULP>;
+                };
+                BUCK2: buck2 {
+                regulator-compatible = "BUCK2";
+                    regulator-name = "mt6360,buck2";
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <1300000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                                               MT6360_OPMODE_LP
+                                               MT6360_OPMODE_ULP>;
+                };
+                ldo6 {
+                    regulator-compatible = "LDO6";
+                    regulator-name = "mt6360,ldo6";
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <2100000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                                               MT6360_OPMODE_LP>;
+                };
+                ldo7 {
+                    regulator-compatible = "LDO7";
+                    regulator-name = "mt6360,ldo7";
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <2100000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                                               MT6360_OPMODE_LP>;
+                };
+                ldo1 {
+                    regulator-compatible = "LDO1";
+                    regulator-name = "mt6360,ldo1";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <3600000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                                               MT6360_OPMODE_LP>;
+                };
+                ldo2 {
+                    regulator-compatible = "LDO2";
+                    regulator-name = "mt6360,ldo2";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <3600000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                                               MT6360_OPMODE_LP>;
+                };
+                ldo3 {
+                    regulator-compatible = "LDO3";
+                    regulator-name = "mt6360,ldo3";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <3600000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                                               MT6360_OPMODE_LP>;
+                };
+                ldo5 {
+                    regulator-compatible = "LDO5";
+                    regulator-name = "mt6360,ldo5";
+                    regulator-min-microvolt = <2700000>;
+                    regulator-max-microvolt = <3600000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                                               MT6360_OPMODE_LP>;
+                };
+            };
+        };
+    };
-- 
2.7.4


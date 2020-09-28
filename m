Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A5727A872
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgI1HT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgI1HT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:19:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84464C0613CE;
        Mon, 28 Sep 2020 00:19:56 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b124so98658pfg.13;
        Mon, 28 Sep 2020 00:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kte6gHSNCG6v2OVGxS3d7I/+DBmoB+e4pk9r9Jb/QP8=;
        b=u55pMWOO6eU+LYykvbpU15GlXBNUgyhWLu+l4YNZfKEDuzU2izGhXR2Bc2g1ns5MMh
         FbUV7ddABP/oWhieqxCUunwrduW6+IX29NnVRPBsD4AtF2qmbI4s6LD4R//wRDnEPzsJ
         cXbaL6FdWjpZsd1Kg+eR6Iuj+LMe++rVuUe3kooG6HmTNuURKhr2+6DBGGrOGCgDVOEC
         MOSUgz0YOXoAdpIZo6bHE8R5MY/mwSIQmLg7XtvJPIyLgHLicgImpAhKlSyRjf8Oy+Mu
         SXquwbWsIBVo+aS9S9uAn15BiRsxISf3cQjDtdHDVBXX5ExCcyblXzlTbLljlGc+lALp
         NhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kte6gHSNCG6v2OVGxS3d7I/+DBmoB+e4pk9r9Jb/QP8=;
        b=kAnOtET4GaKUaTYIIkuinh0RiIgNAU7JFVGXyohkgaK8M5iCluuzzzeT3aqbuA8gUq
         o+DaGYJqoTB68lMwBOXlFCryXAOHOyzu7cjY7k/b/yEcLTxoQLKijcye9De1piZzSOBn
         Po+SIH5wVAjGfxYS5VFX8KEgLu2rBpm/OkkaHnTDaPUufQXHCSSU0Hu0owz2gbQZVNne
         7lswFOp1Co9F+SS780pPOG5c3y3OQn4p3kuawT0LBuAg2MHX1vNynbqE9JWGDUAYDfdX
         4aaxzdwKcUsITYzEOP9mjqMEwD3/bNOoe3IZifp2ENAueh6kPOc4eY9xE9uXR3aAeZeZ
         dApA==
X-Gm-Message-State: AOAM531qSwxqXqf+NKVPOg9OtWvE81fhocY90/QHGmSVP+2labKfdwd1
        GyOQvcDiscmkBZbqHZ2/NPI=
X-Google-Smtp-Source: ABdhPJzPsCHjmFUdNlibb2Og9HWOdZd5lXQBhc7m2IPkw/WZ4o65l70avc8DWJSV2GnazaYhke/4Mg==
X-Received: by 2002:a63:e111:: with SMTP id z17mr201584pgh.267.1601277596032;
        Mon, 28 Sep 2020 00:19:56 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:579:ab5d:e84b:6994:41f0:ce96])
        by smtp.gmail.com with ESMTPSA id gj16sm148556pjb.13.2020.09.28.00.19.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 00:19:55 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] regulator: rtmv20: Add DT-binding document for Richtek RTMV20
Date:   Mon, 28 Sep 2020 15:19:44 +0800
Message-Id: <1601277584-5526-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601277584-5526-1-git-send-email-u0084500@gmail.com>
References: <1601277584-5526-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add DT-binding document for Richtek RTMV20

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../regulator/richtek,rtmv20-regulator.yaml        | 168 +++++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
new file mode 100644
index 00000000..4cb4b68
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
@@ -0,0 +1,168 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rtmv20-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RTMV20 laser diode regulator
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  Richtek RTMV20 is a load switch current regulator that can supply up to 6A.
+  It is used to drive laser diode. There're two signals for chip controls
+  (Enable/Fail), Enable pin to turn chip on, and Fail pin as fault indication.
+  There're still four pins for camera control, two inputs (strobe and vsync),
+  the others for outputs (fsin1 and fsin2). Strobe input to start the current
+  supply, vsync input from IR camera, and fsin1/fsin2 output for the optional.
+
+properties:
+  compatible:
+    const: richtek,rtmv20
+
+  reg:
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts-extend:
+    maxItems: 1
+
+  enable-gpios:
+    description: A connection of the 'enable' gpio line.
+    maxItems: 1
+
+  ld-pulse-delay-us:
+    description: |
+      load current pulse delay in microsecond after strobe pin pulse high.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 100000
+    default: 0
+
+  ld-pulse-width-us:
+    description: |
+      Load current pulse width in microsecond after strobe pin pulse high.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 10000
+    default: 1200
+
+  fsin1-delay-us:
+    description: |
+      Fsin1 pulse high delay in microsecond after vsync signal pulse high.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 100000
+    default: 23000
+
+  fsin1-width-us:
+    description: |
+      Fsin1 pulse high width in microsecond after vsync signal pulse high.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 40
+    maximum: 10000
+    default: 160
+
+  fsin2-delay-us:
+    description: |
+      Fsin2 pulse high delay in microsecond after vsync signal pulse high.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 100000
+    default: 23000
+
+  fsin2-width-us:
+    description: |
+      Fsin2 pulse high width in microsecond after vsync signal pulse high.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 40
+    maximum: 10000
+    default: 160
+
+  es-pulse-width-us:
+    description: Eye safety function pulse width limit in microsecond.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 10000
+    default: 1200
+
+  es-ld-current-microamp:
+    description: Eye safety function load current limit in microamp.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 6000000
+    default: 3000000
+
+  lbp-level-microvolt:
+    description: Low battery protection level in microvolt.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 2400000
+    maximum: 3700000
+    default: 2700000
+
+  lbp-enable:
+    description: Low battery protection function enable control.
+    type: boolean
+
+  strobe-polarity-high:
+    description: Strobe pin active polarity control.
+    type: boolean
+
+  vsync-polarity-high:
+    description: Vsync pin active polarity control.
+    type: boolean
+
+  fsin-enable:
+    description: Fsin function enable control.
+    type: boolean
+
+  fsin-output:
+    description: Fsin function output control.
+    type: boolean
+
+  es-enable:
+    description: Eye safety function enable control.
+    type: boolean
+
+patternProperties:
+  "lsw":
+    type: object
+    $ref: "regulator.yaml#"
+
+required:
+  - compatible
+  - reg
+  - wakeup-source
+  - interrupts-extend
+  - enable-gpios
+  - lsw
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rtmv20@34 {
+        compatible = "richtek,rtmv20";
+        reg = <0x34>;
+        wakeup-source;
+        interrupts-extend = <&gpio26 2 IRQ_TYPE_LEVEL_LOW>;
+        enable-gpios = <&gpio26 3 0>;
+
+        strobe-polarity-high;
+        vsync-polarity-high;
+
+        lsw {
+                regulator-name = "rtmv20,lsw";
+                regulator-min-microamp = <0>;
+                regulator-max-microamp = <6000000>;
+        };
+      };
+    };
+...
-- 
2.7.4


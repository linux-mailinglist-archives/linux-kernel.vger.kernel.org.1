Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198D52774C9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgIXPFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgIXPFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:05:03 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D4CC0613CE;
        Thu, 24 Sep 2020 08:05:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id z19so2063655pfn.8;
        Thu, 24 Sep 2020 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m+rwhbMbOkhwHZS7MVNwyAdTQvHyVvU7pAv4TyqFRkM=;
        b=VfKwWQ+G2wENqfpRBAFvNmiGxL8iAKh8GUN2EuSmaqo7Fqpt31GmfpzxGmtM5Bgp69
         3A1wN/NyRTcjl+WGs2jFQmq19aWw2xkNQwYjrglGfXmRjbR8Hmev6TcIfjpjITJ5VQ7j
         cItorCVKI5KS6Ta4KZwrtsSjofHFLtynwz3E7Z7kqA0yRrUKQExAHvWQaYBio38GFFG4
         nrOgUO4XS7dGxDJH5Y2H885gVPHF+NJ+rw1i6hRU7MisfPKjZC9Mye8C7t1JLj4FSucx
         rF9W/F7rP0G9rXd4p7HxJUE3gQEelJIobqH5+g2aVh4C0K9uRheBzbpgAPwTQrt1756J
         Tbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m+rwhbMbOkhwHZS7MVNwyAdTQvHyVvU7pAv4TyqFRkM=;
        b=f0bW6YEz7nKKgmby6pTxcuWs39BnB/A+RQOizQ77GxDz9iTlBra3Qqb/YoH/uZgFFU
         n76rq82Zb8vxTvovUjOsCAlGHycLKIbK+uCcdpfjh16KGA7JqU6NJqR8tHylpOFFnE+A
         91hd5dL5sup3u2XrZKfA47eGpD28GmkjXDCsd73QuG3FeMrdDAiJTjNa2qJu6cMsfSRq
         WQqCeXnIk/a7RJ6Me878YxLNuBWL9GMorOX85cp371m53FggYajZNIy9xQcQP8Hcnjcb
         a77vV6RTCSxBRXp0O6xq3ziXwq930wOw3aF1oOdew1dAhiRJPUXiIaVrjjRkHMwYRCZw
         wpUg==
X-Gm-Message-State: AOAM532coMxoAWnsC+VAzf4k3qESWVnpiBlV4l+3Ned/QjgO1TCIQlG1
        B9Q09XppL5+xuF0qBAsUAhI=
X-Google-Smtp-Source: ABdhPJzsmLyvOLFsXw6ci+HQWTLqWr663gRWppVZQhKbJplhLkXnxaJ7KkE+K09YpBdKPLecyIWU8A==
X-Received: by 2002:a65:624e:: with SMTP id q14mr41911pgv.307.1600959902862;
        Thu, 24 Sep 2020 08:05:02 -0700 (PDT)
Received: from localhost.localdomain ([123.110.152.116])
        by smtp.gmail.com with ESMTPSA id w203sm3747251pff.0.2020.09.24.08.05.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 08:05:02 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
Subject: [PATCH v1 2/2] regulator: rtmv20: Add DT-binding document for Richtek RTMV20
Date:   Thu, 24 Sep 2020 23:04:51 +0800
Message-Id: <1600959891-16606-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600959891-16606-1-git-send-email-u0084500@gmail.com>
References: <1600959891-16606-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add DT-binding document for Richtek RTMV20

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../regulator/richtek,rtmv20-regulator.yaml        | 183 +++++++++++++++++++++
 1 file changed, 183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
new file mode 100644
index 00000000..0e906af
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
@@ -0,0 +1,183 @@
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
+  enable-gpio:
+    description: A connection of the 'enable' gpio line.
+    maxItems: 1
+
+  ld_pulse_delay:
+    description: |
+      load current pulse delay in microsecond after strobe pin pulse high.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 100000
+    default: 0
+
+  ld_pulse_width:
+    description: |
+      Load current pulse width in microsecond after strobe pin pulse high.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 10000
+    default: 1200
+
+  fsin1_delay:
+    description: |
+      Fsin1 pulse high delay in microsecond after vsync signal pulse high.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 100000
+    default: 23000
+
+  fsin1_width:
+    description: |
+      Fsin1 pulse high width in microsecond after vsync signal pulse high.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 40
+    maximum: 10000
+    default: 160
+
+  fsin2_delay:
+    description: |
+      Fsin2 pulse high delay in microsecond after vsync signal pulse high.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 100000
+    default: 23000
+
+  fsin2_width:
+    description: |
+      Fsin2 pulse high width in microsecond after vsync signal pulse high.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 40
+    maximum: 10000
+    default: 160
+
+  es_pulse_width:
+    description: Eye safety function pulse width limit in microsecond.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 10000
+    default: 1200
+
+  es_ld_current:
+    description: Eye safety function load current limit in microamp.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 6000000
+    default: 3000000
+
+  lbp_level:
+    description: Low battery protection level in microvolt.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 2400000
+    maximum: 3700000
+    default: 2700000
+
+  lbp_enable:
+    description: Low battery protection function enable control.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 1
+    default: 0
+
+  strobe_polarity:
+    description: Strobe pin active polarity control.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 1
+    default: 1
+
+  vsync_polarity:
+    description: Vsync pin active polarity control.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 1
+    default: 1
+
+  fsin_enable:
+    description: Fsin function enable control.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 1
+    default: 0
+
+  fsin_output:
+    description: Fsin function output control.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 1
+    default: 0
+
+  es_enable:
+    description: Eye safety function enable control.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 1
+    default: 0
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
+  - enable-gpio
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
+        enable-gpio = <&gpio26 3 0>;
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


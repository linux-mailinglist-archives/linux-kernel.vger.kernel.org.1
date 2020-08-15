Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20AE2452B5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Aug 2020 23:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgHOVy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 17:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgHOVwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:35 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC00C06136D;
        Fri, 14 Aug 2020 20:14:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id m8so5474848pfh.3;
        Fri, 14 Aug 2020 20:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H3Sj2RA4VzKEVF5wDfAwtb0zeDgeFHLqIYqBkdSYJfs=;
        b=Ir6oqEZmnhfVikiaoGxUdicwSjlJCfEhYVtwKnK6KgBn+RuuHHWhbbgd6T7QbJplaR
         h4E7nhaALfuNnlQJN8hhuYGYBLiF48VXcOMdMVUG5TNCmB3DteEgIiFuwwzBpMMNvEHh
         gNUXFeE8YhmK9wdBwLdacRcWG/UwGM4KUiqU5lnpF2IRiUUugnlrUOFIf5vzQkHduzlx
         6Io5Q18k0HwjWT29Pno161AkUm6G6YMu510yeB+NoJOk7uhIIskIkMqiUo/36TSGwb3C
         Tz4iMX5XCD8f1Dh5XvlU3sb0DhPjsjBGm+9NupmK2cwcOKj++hFQOblciGN5YRKGMvON
         qmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H3Sj2RA4VzKEVF5wDfAwtb0zeDgeFHLqIYqBkdSYJfs=;
        b=tNtW1kZdJwDeJkRW2Ph24/x5NjZSZtRwyqKk1kNbFIC4QD5TfB0DHKj378DEfcKUgV
         0lmDSRuoCukq1TBl+eNYc2GIFLVA5BYZ1LV6EQqzaNLqErjv/89K9F39WgZVVJQKQbL8
         zfjsfDBkyA1fhl+otll0K9jxgJfAvelhDWr7J/aHY2sUZU3WoPNugmLjtmLvqEqMRkoz
         SvjD2PHPFnxDb80NTJedIaZXSlfYVB6Qltf9Y7TtrGbNf8tktXbXLk7a8KbD7POPW8RH
         jhKlQE50Gb0OGyLRWmu5mlxDbucLoxvHhglqQ3aDzTnTz0QPqmWjWhJVjRzh9q3+qYnD
         y/6A==
X-Gm-Message-State: AOAM532zcYqx0D6fA9s1CchdrSJz+0aY638zmDO/ZFVFn5pyftXOiJ1J
        Ny20lsiL/s6qfYaw3ES/VyE=
X-Google-Smtp-Source: ABdhPJzBjd6pazJkdJ3/rjyy8EUV9uWsZT5JGvEuoh7T3zbM6egssAPtqnlhMF206sE4DJF5eifJig==
X-Received: by 2002:aa7:9344:: with SMTP id 4mr3987520pfn.30.1597461278245;
        Fri, 14 Aug 2020 20:14:38 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.91])
        by smtp.gmail.com with ESMTPSA id 196sm10981534pfc.178.2020.08.14.20.14.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2020 20:14:37 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/3] regulator: rt4801: Add DT binding documentation
Date:   Sat, 15 Aug 2020 11:14:21 +0800
Message-Id: <1597461262-25878-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597461262-25878-1-git-send-email-u0084500@gmail.com>
References: <1597461262-25878-1-git-send-email-u0084500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add a devicetree binding documentation for the rt4801 regulator driver.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../regulator/richtek,rt4801-regulator.yaml        | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
new file mode 100644
index 00000000..28d30e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt4801-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT4801 Display Bias regulators
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  Regulator nodes should be named to DSVP and DSVN. The
+  definition for each of these nodes is defined using the standard
+  binding for regulators at
+  Documentation/devicetree/bindings/regulator/regulator.txt.
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT4801H/DS4801H-00.pdf
+
+#The valid names for RT4801 regulator nodes are:
+#DSVP, DSVN
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt4801
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIOs to use to enable DSVP/DSVN regulator.
+      The first one is ENP to enable DSVP, and second one is ENM to enable DSVN.
+      Number of GPIO in the array list could be 1 or 2.
+      If only one gpio is specified, only one gpio used to control ENP/ENM.
+      Else both are spefied, DSVP/DSVN could be controlled individually.
+      Othersie, this property not specified. treat both as always-on regulator.
+    minItems: 1
+    maxItems: 2
+
+patternProperties:
+  "^DSV(P|N)$":
+    type: object
+    $ref: regulator.yaml#
+    description:
+      Properties for single display bias regulator.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties:
+  - enable-gpios
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rt4801@73 {
+            compatible = "richtek,rt4801";
+            reg = <0x73>;
+            enable-gpios = <&gpio26 2 0>, <&gpio26 3 0>;
+
+            dsvp: DSVP {
+                regulator-name = "rt4801,dsvp";
+                regulator-min-microvolt = <4000000>;
+                regulator-max-microvolt = <6000000>;
+                regulator-boot-on;
+            };
+            dsvn: DSVN {
+                regulator-name = "rt4801,dsvn";
+                regulator-min-microvolt = <4000000>;
+                regulator-max-microvolt = <6000000>;
+                regulator-boot-on;
+            };
+
+        };
+    };
-- 
2.7.4


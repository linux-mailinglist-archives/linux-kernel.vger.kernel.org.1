Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3B42B3DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgKPHrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgKPHrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:47:17 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9187FC0613CF;
        Sun, 15 Nov 2020 23:47:15 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id l11so11736726lfg.0;
        Sun, 15 Nov 2020 23:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x5A+vBa0PDYR6xu5vb3kp+/gHOn8DSYF46/5RWQLHvg=;
        b=MoVPX4eR/x59r8XwxijCvlg3FZ3J5wDdIm+VpKjHs8yCoo2TQxmz1KXKv1Vj2NbFpI
         HlrkES5W6DC4z6ROteowrczHXueQ+mN8qEWBWayLUo6BAbvlkApSZ+d72z43BC2qIKdw
         jO23hMaj//qUG111kp5M2OndBkN2OQV4UB+5wRoThdi5EB8K+dyOvXdu/OwNtaasSvM5
         5GStCJ/WNKWjaPL5IxGtQ+Eezu3h5/rmxYN3he76C3NvxMxUnUny2zywi3IivUCYrjtR
         mt6ZIZvSkDXOh/ZDeQeV139NMVNEvpp3MWcJWX68kdvPxtCRJPdfQpWBmUsUfvHr+NUt
         WP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x5A+vBa0PDYR6xu5vb3kp+/gHOn8DSYF46/5RWQLHvg=;
        b=CF46s/0Uj2Kk1Qkyt+l2FD77O11OnWddvfjydmfKGwMk0I3k6XzOYGFc23VwqgHEUm
         cF1fdSaxdDraB3gHxQoLNhszRA+jyO2ewXg7IaMEPuNh/5xonbzIc2gbQqns7LJSpYu6
         iu8VUPcphavyfXQS0XEZ2RX6rMxxz0ylqfVnHyiOaI6R2eur4e6bQL7Txc+wSiqoxUyu
         ewmK1Eskljtaok1LD/At0iQFFVZQ+m0ayw7r7Gjhyk/+AJaYzSQR1zhEqLmJYzI7N7yq
         RgB0oR5fGME3vnulUB67J0HeLXfVQzCOmBTND2RhzrKwXDLvcs0qAzmByUTKLAp/DO6C
         rCbw==
X-Gm-Message-State: AOAM532qtqlmG8/9o1taabvuV5OTl6D/5OU/lcZss2Ob37skWy5WOodb
        r+ebxQYKiFR5SMwPzaNwGBc=
X-Google-Smtp-Source: ABdhPJyzjNtogpk1e1xza+hlYROcuWZy+N0bDaEQBe5XLeFnZs8L3hsXvO3xFwQHzrZxGDTEtOfgGA==
X-Received: by 2002:a05:6512:2115:: with SMTP id q21mr4700837lfr.14.1605512834017;
        Sun, 15 Nov 2020 23:47:14 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id v20sm2612441ljh.19.2020.11.15.23.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 23:47:13 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: phy: bcm-ns-usb3-phy: convert to yaml
Date:   Mon, 16 Nov 2020 08:46:49 +0100
Message-Id: <20201116074650.16070-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

1. Change syntax from txt to yaml
2. Drop "Driver for" from the title
3. Drop "reg = <0x0>;" from example (noticed by dt_binding_check)
4. Specify license

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
I think this should go through linux-phy tree. Kishon, Vinod, can you
take this patch?

This patch generates a false positive checkpatch.pl warning [0].
Please ignore:
WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

[0] https://lkml.org/lkml/2020/2/18/1084
---
 .../bindings/phy/bcm-ns-usb3-phy.txt          | 34 ----------
 .../bindings/phy/bcm-ns-usb3-phy.yaml         | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt b/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt
deleted file mode 100644
index 32f057260351..000000000000
--- a/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Driver for Broadcom Northstar USB 3.0 PHY
-
-Required properties:
-
-- compatible: one of: "brcm,ns-ax-usb3-phy", "brcm,ns-bx-usb3-phy".
-- reg: address of MDIO bus device
-- usb3-dmp-syscon: phandle to syscon with DMP (Device Management Plugin)
-		   registers
-- #phy-cells: must be 0
-
-Initialization of USB 3.0 PHY depends on Northstar version. There are currently
-three known series: Ax, Bx and Cx.
-Known A0: BCM4707 rev 0
-Known B0: BCM4707 rev 4, BCM53573 rev 2
-Known B1: BCM4707 rev 6
-Known C0: BCM47094 rev 0
-
-Example:
-	mdio: mdio@0 {
-		reg = <0x0>;
-		#size-cells = <1>;
-		#address-cells = <0>;
-
-		usb3-phy@10 {
-			compatible = "brcm,ns-ax-usb3-phy";
-			reg = <0x10>;
-			usb3-dmp-syscon = <&usb3_dmp>;
-			#phy-cells = <0>;
-		};
-	};
-
-	usb3_dmp: syscon@18105000 {
-		reg = <0x18105000 0x1000>;
-	};
diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.yaml
new file mode 100644
index 000000000000..7fd419db45d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/bcm-ns-usb3-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Northstar USB 3.0 PHY
+
+description: |
+  Initialization of USB 3.0 PHY depends on Northstar version. There are currently
+  three known series: Ax, Bx and Cx.
+  Known A0: BCM4707 rev 0
+  Known B0: BCM4707 rev 4, BCM53573 rev 2
+  Known B1: BCM4707 rev 6
+  Known C0: BCM47094 rev 0
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  compatible:
+    enum:
+      - brcm,ns-ax-usb3-phy
+      - brcm,ns-bx-usb3-phy
+
+  reg:
+    description: address of MDIO bus device
+    maxItems: 1
+
+  usb3-dmp-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the DMP (Device Management Plugin) syscon
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - usb3-dmp-syscon
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        usb3-phy@10 {
+            compatible = "brcm,ns-ax-usb3-phy";
+            reg = <0x10>;
+            usb3-dmp-syscon = <&usb3_dmp>;
+            #phy-cells = <0>;
+        };
+    };
+
+    usb3_dmp: syscon@18105000 {
+        reg = <0x18105000 0x1000>;
+    };
-- 
2.27.0


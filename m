Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0AD2CF4D9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 20:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgLDTgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 14:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLDTgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 14:36:20 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D07C0613D1;
        Fri,  4 Dec 2020 11:35:40 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c79so4453360pfc.2;
        Fri, 04 Dec 2020 11:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQEOGFYSu5gjZsZIFeFaQQwURzAW5gco/80H8pDScYI=;
        b=eL680N7zTc3Kw+uUKHH5IwSFqsVQ+aYCV4gega01LckzYQzxIg6eK6TUov4Y1qtG4G
         HSBYywuNLX+fEunc2O6DMfNg0Sorr/twQDeVwczvCr3Ohlv03eqmlZdUIuU5z1GWKYS9
         AnFOFpdXn/dIG29NnV+b1HhZT5CI+jxMfjG2cuNXVPkDeSdXtDGIg34e6wfqZG/7wGaO
         gC5V09FyIc9VGaqRgYRS+XHTNYH3cSyqUoJTwyrhhCymjCT9s2AZDPFKQMg1KkEhGiQF
         bqE3YsDEjfKdEBPwI5aOHvcjTzYus3SAQS++84Jitj5Tof/BUe2UxRFBwY4+p6jS9LLe
         yvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQEOGFYSu5gjZsZIFeFaQQwURzAW5gco/80H8pDScYI=;
        b=teBQY4eA7uT2vxyPnAYRQQHmOx5qM6dBdNJ3kKsW01jsSR9yNlj9KJnn8EyC8L+uhh
         WR/PolWW/YV9DA/G/jXTgn8JFoMSibP0UasBvNWlYeN7CGi7lwADcyPia8zl8xlB293g
         gyeEc/CYLEPX/8aQpFvJm+NdXsQ1HDe4CSgRT+XHxGkvTvLS8lqQIlPrOYliBIiEPQ15
         NLxjzy8Hjd5OA+HA8AGHPdiK3hOdE5BlOjEkWcbhGOQPB0GXKzqqJEuSoQkhhmVw9xvM
         uopbftgCz3EAvH2wtCwBzjqO1IlIM7F45YpA+b1nK9lcpe7eZ+v6sXZrSiWSA3KNyaUE
         olnQ==
X-Gm-Message-State: AOAM5310kTNzgfZ2zDQWILSxvco/xES/65rmdkUxtC0Yz4cRu8yDiRY4
        LLbB5L68dGbJPEzgeZgwhfSMm77pQFQ=
X-Google-Smtp-Source: ABdhPJxOqw1l9gRm2+pgTXbV8DBas+qjV687u0mtSWY6ZaM+UJOcLdGrdnQjeNvM2fWrxKK44FOdTw==
X-Received: by 2002:aa7:9341:0:b029:18b:b43:6c7 with SMTP id 1-20020aa793410000b029018b0b4306c7mr5355827pfn.7.1607110539136;
        Fri, 04 Dec 2020 11:35:39 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j9sm5425942pfi.116.2020.12.04.11.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 11:35:38 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v2] dt-bindings: phy: Convert Broadcom SATA PHY to YAML
Date:   Fri,  4 Dec 2020 11:35:31 -0800
Message-Id: <20201204193532.1934108-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom SATA PHY Device Tree binding to a YAML format.

Suggested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- fixed #phy-cells warning
- fixed yamlling warnings

 .../bindings/phy/brcm,sata-phy.yaml           | 148 ++++++++++++++++++
 .../devicetree/bindings/phy/brcm-sata-phy.txt |  61 --------
 2 files changed, 148 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm-sata-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
new file mode 100644
index 000000000000..58c3ef8004ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
@@ -0,0 +1,148 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/brcm,sata-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Broadcom SATA3 PHY
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  $nodename:
+    pattern: "^sata[-|_]phy(@.*)?$"
+
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,bcm7216-sata-phy
+              - brcm,bcm7425-sata-phy
+              - brcm,bcm7445-sata-phy
+              - brcm,bcm63138-sata-phy
+          - const: brcm,phy-sata3
+      - items:
+          - const: brcm,iproc-nsp-sata-phy
+      - items:
+          - const: brcm,iproc-ns2-sata-phy
+      - items:
+          - const: brcm,iproc-sr-sata-phy
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  reg-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: phy
+      - const: phy-ctrl
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^sata-phy@[0-9]+$":
+    type: object
+    description: |
+      Each port's PHY should be represented as a sub-node.
+
+    properties:
+      reg:
+        description: The SATA PHY port number
+        maxItems: 1
+
+      "#phy-cells":
+        const: 0
+
+      "brcm,enable-ssc":
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: |
+          Use spread spectrum clocking (SSC) on this port
+          This property is not applicable for "brcm,iproc-ns2-sata-phy",
+          "brcm,iproc-nsp-sata-phy" and "brcm,iproc-sr-sata-phy".
+
+      "brcm,rxaeq-mode":
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          String that indicates the desired RX equalizer mode.
+        enum:
+          - off
+          - auto
+          - manual
+
+      "brcm,rxaeq-value":
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+            When 'brcm,rxaeq-mode' is set to "manual", provides the RX
+            equalizer value that should be used.
+        minimum: 0
+        maximum: 63
+
+      "brcm,tx-amplitude-millivolt":
+        description: |
+            Transmit amplitude voltage in millivolt.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [400, 500, 600, 800]
+
+    required:
+      - reg
+      - "#phy-cells"
+
+    additionalProperties: false
+
+if:
+  properties:
+    compatible:
+      items:
+        const: brcm,iproc-ns2-sata-phy
+then:
+  properties:
+    reg:
+      maxItems: 2
+    reg-names:
+      items:
+        - const: "phy"
+        - const: "phy-ctrl"
+else:
+  properties:
+    reg:
+      maxItems: 1
+    reg-names:
+      maxItems: 1
+      items:
+        - const: "phy"
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+examples:
+  - |
+    sata_phy@f0458100 {
+        compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
+        reg = <0xf0458100 0x1e00>;
+        reg-names = "phy";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sata-phy@0 {
+                reg = <0>;
+                #phy-cells = <0>;
+        };
+
+        sata-phy@1 {
+                reg = <1>;
+                #phy-cells = <0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt b/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
deleted file mode 100644
index e5abbace93a3..000000000000
--- a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-* Broadcom SATA3 PHY
-
-Required properties:
-- compatible: should be one or more of
-     "brcm,bcm7216-sata-phy"
-     "brcm,bcm7425-sata-phy"
-     "brcm,bcm7445-sata-phy"
-     "brcm,iproc-ns2-sata-phy"
-     "brcm,iproc-nsp-sata-phy"
-     "brcm,phy-sata3"
-     "brcm,iproc-sr-sata-phy"
-     "brcm,bcm63138-sata-phy"
-- address-cells: should be 1
-- size-cells: should be 0
-- reg: register ranges for the PHY PCB interface
-- reg-names: should be "phy" and "phy-ctrl"
-     The "phy-ctrl" registers are only required for
-     "brcm,iproc-ns2-sata-phy" and "brcm,iproc-sr-sata-phy".
-
-Sub-nodes:
-  Each port's PHY should be represented as a sub-node.
-
-Sub-nodes required properties:
-- reg: the PHY number
-- phy-cells: generic PHY binding; must be 0
-
-Sub-nodes optional properties:
-- brcm,enable-ssc: use spread spectrum clocking (SSC) on this port
-     This property is not applicable for "brcm,iproc-ns2-sata-phy",
-     "brcm,iproc-nsp-sata-phy" and "brcm,iproc-sr-sata-phy".
-
-- brcm,rxaeq-mode: string that indicates the desired RX equalizer
-  mode, possible values are:
-	"off" (equivalent to not specifying the property)
-	"auto"
-	"manual" (brcm,rxaeq-value is used in that case)
-
-- brcm,rxaeq-value: when 'rxaeq-mode' is set to "manual", provides the RX
-  equalizer value that should be used. Allowed range is 0..63.
-
-- brcm,tx-amplitude-millivolt: transmit amplitude voltage in millivolt.
-  Possible values are 400, 500, 600 or 800 mV.
-
-Example
-	sata-phy@f0458100 {
-		compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
-		reg = <0xf0458100 0x1e00>, <0xf045804c 0x10>;
-		reg-names = "phy";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		sata-phy@0 {
-			reg = <0>;
-			#phy-cells = <0>;
-		};
-
-		sata-phy@1 {
-			reg = <1>;
-			#phy-cells = <0>;
-		};
-	};
-- 
2.25.1


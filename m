Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A382BC369
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 04:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgKVD3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 22:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgKVD3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 22:29:39 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFC1C0613CF;
        Sat, 21 Nov 2020 19:29:39 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id t8so11686805pfg.8;
        Sat, 21 Nov 2020 19:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qsxZje6DSxpGZp8hqGoiFVe66DWZ3OIPRcPhCbAxg/c=;
        b=cdjtOdBKKBl2TgNtJe0otkgI37kZp37C1ouzKILB6ED7ArK+RggYEfNZOTf20wt6yh
         UJCzctYOjr2u7+gmxHuUN/61auU1CbQ4yA8MbwJioyuQbOAlnghC7TgFNKYgi1q87gsA
         QuqH+OHL6EhbKGtwSQykofU2dEQ/iZVMbN/IMfGK2N6P63Az1vVo0iQTkpjzRTPq+0eB
         28gSU7a5LanyCK6uVprjWD7ua8AN75qpwdttPxXeR+fD10/34p2vT4d8Yd0zfh31CNDp
         7APQzmQ3qF5Jd5Vb6sKY0qDaLiE7T0cXosCKJRM/oLpqavVx8uKCYRJ1Bnx7ohuiIFLV
         +G9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qsxZje6DSxpGZp8hqGoiFVe66DWZ3OIPRcPhCbAxg/c=;
        b=DoLCXvqWEyok7I3RipWvPXXDnLaaomvI9L8di9cnt1tAYhzcMqx8U3riSg1h5G6vZ0
         gzjCr1z26n2fUa/2OIda4ku2h7134eHowyvwD0X08ehFGBjESXVMxUtRY8xooOFc6zfb
         AZp3ScykCj6PuX47uEYpoElRiRecOtyM37EmhQalZkYsuxjkgkiaQC0/uwhDazmQXHhA
         wydetRIE219Jm7rhafB4eLftVEmCQmZndLBXb4Fd74YusJE7eRnqHCvDRRhE5TB6+Udd
         R7JDmIsk1BC97FXM94ep9utfeqeKCtTb4lHRmKrAvk8Fe8Qmr5FbvCL/mPxvJ3bGxRhd
         6TAg==
X-Gm-Message-State: AOAM5334CYadtUJDFIcLer4fkdnl3eMbIe9+K3JNASPF6npYQUux48uN
        PGQjUUvA9dFiNX3F9n68Wgx/OqNRUHo=
X-Google-Smtp-Source: ABdhPJyejA4eoth2fmV9d62+wq9PrhT3PcCZG6YCtHSD/cXQG+rXBusWRi2KJAHHgxWF1PirfZgT5Q==
X-Received: by 2002:a62:1b0e:0:b029:164:228b:f063 with SMTP id b14-20020a621b0e0000b0290164228bf063mr20158377pfb.75.1606015778789;
        Sat, 21 Nov 2020 19:29:38 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s5sm1451466pgc.15.2020.11.21.19.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 19:29:38 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH] dt-bindings: phy: Convert Broadcom SATA PHY to YAML
Date:   Sat, 21 Nov 2020 19:29:24 -0800
Message-Id: <20201122032926.2185026-1-f.fainelli@gmail.com>
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
This is based on phy/next and it depends on the following commit:

https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/commit/?h=next&id=6d3b3f88423e4edc0fad5853c10558b42e1a91dd

it would make sense to have Vinod apply this change.

 .../bindings/phy/brcm,sata-phy.yaml           | 148 ++++++++++++++++++
 .../devicetree/bindings/phy/brcm-sata-phy.txt |  61 --------
 2 files changed, 148 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm-sata-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
new file mode 100644
index 000000000000..979b7419dc69
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
+        - enum:
+           - brcm,bcm7216-sata-phy
+           - brcm,bcm7425-sata-phy
+           - brcm,bcm7445-sata-phy
+           - brcm,bcm63138-sata-phy
+        - const: brcm,phy-sata3
+      - items:
+        - const: brcm,iproc-nsp-sata-phy
+      - items:
+        - const: brcm,iproc-ns2-sata-phy
+      - items:
+        - const: brcm,iproc-sr-sata-phy
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
+     type: object
+     description: |
+       Each port's PHY should be represented as a sub-node.
+
+     properties:
+       reg:
+         description: The SATA PHY port number
+         maxItems: 1
+
+       "#phy-cells":
+         const: 0
+
+       "brcm,enable-ssc":
+         $ref: /schemas/types.yaml#/definitions/flag
+         description: |
+           Use spread spectrum clocking (SSC) on this port
+           This property is not applicable for "brcm,iproc-ns2-sata-phy",
+           "brcm,iproc-nsp-sata-phy" and "brcm,iproc-sr-sata-phy".
+
+       "brcm,rxaeq-mode":
+          $ref: /schemas/types.yaml#/definitions/string
+          description:
+            String that indicates the desired RX equalizer mode.
+          enum:
+            - off
+            - auto
+            - manual
+
+       "brcm,rxaeq-value":
+          $ref: /schemas/types.yaml#/definitions/uint32
+          description: |
+            When 'brcm,rxaeq-mode' is set to "manual", provides the RX
+            equalizer value that should be used.
+          minimum: 0
+          maximum: 63
+
+       "brcm,tx-amplitude-millivolt":
+          description: |
+            Transmit amplitude voltage in millivolt.
+          $ref: /schemas/types.yaml#/definitions/uint32
+          enum: [400, 500, 600, 800]
+
+     required:
+       - reg
+       - "#phy-cells"
+
+     additionalProperties: false
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
+    sata-phy@f0458100 {
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


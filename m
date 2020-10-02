Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FFD281EC3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 00:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgJBW72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 18:59:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47081 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBW71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 18:59:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id a13so2975126otl.13;
        Fri, 02 Oct 2020 15:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cm1FASKC/6qLmqDGJznIVEYyfcRxXEvKrBVthaDAX/A=;
        b=WqoJTVZ44DK2ccGgR3093KWqu7PkZb2vmuiTTpTUv1WYUTyGWLY6LTEASVj9sSGwbg
         NyOaoT1LTYOdImSAJ2cDwTaz8d5vVlbT3L+SmXS7zhLDO0vrqtEKCdGMtkN9vHSho0Yv
         MrBDez8/QyffKGm8/35D1JwpB3Xnrunv4e3KW4/Xykc45xZcTQN4FuMx1R0XW9SHQCUx
         9goXYDwc2IE55gzLw0mYud5gVEV2kXqgU3Nx4qignWbt/yYGyx5302W+4t0FHQQQZq6C
         xUTIcMcTLtgRzQYJ8bJCrXzvEISVxOnbubdi6It2RfPtwVYa7M9wcPhzMj42yKYaG1xB
         Wvww==
X-Gm-Message-State: AOAM531l6K7SUqBgnAr4QHtqHsfL/tmLEDlib3K5k55YQctlKFUp/Dfv
        A+ZRI/I2X+P4jS9lnc3YDElLnMmwoDTm
X-Google-Smtp-Source: ABdhPJyljpSwhWeoftw53nYQUlYuv1ZIcmgJ2iqol1GkWX/pDx6J5CLTdQuFFwIPqI7OhUh64e4SgA==
X-Received: by 2002:a9d:5545:: with SMTP id h5mr3150095oti.269.1601679565979;
        Fri, 02 Oct 2020 15:59:25 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u7sm732278ote.37.2020.10.02.15.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 15:59:25 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        =?UTF-8?q?Guido=20G=C3=BAnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Yannick Fertre <yannick.fertre@st.com>
Subject: [PATCH] dt-bindings: display: Add dsi-controller.yaml in DSI controller schemas
Date:   Fri,  2 Oct 2020 17:59:24 -0500
Message-Id: <20201002225924.3513700-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some DSI controllers are missing a reference to the recently added
dsi-controller.yaml schema. Add it and we can drop the duplicate parts.

Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: "Guido Gúnther" <agx@sigxcpu.org>
Cc: Robert Chiras <robert.chiras@nxp.com>
Cc: Philippe Cornu <philippe.cornu@st.com>
Cc: Yannick Fertre <yannick.fertre@st.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 11 ++-------
 .../bindings/display/brcm,bcm2835-dsi0.yaml   |  3 +++
 .../bindings/display/bridge/nwl-dsi.yaml      | 11 ++++-----
 .../bindings/display/st,stm32-dsi.yaml        | 23 ++++---------------
 4 files changed, 14 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
index 63f948175239..7aa330dabc44 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
@@ -11,9 +11,6 @@ maintainers:
   - Maxime Ripard <mripard@kernel.org>
 
 properties:
-  "#address-cells": true
-  "#size-cells": true
-
   compatible:
     enum:
       - allwinner,sun6i-a31-mipi-dsi
@@ -57,12 +54,7 @@ properties:
       port should be the input endpoint, usually coming from the
       associated TCON.
 
-patternProperties:
-  "^panel@[0-9]+$": true
-
 required:
-  - "#address-cells"
-  - "#size-cells"
   - compatible
   - reg
   - interrupts
@@ -74,6 +66,7 @@ required:
   - port
 
 allOf:
+  - $ref: dsi-controller.yaml#
   - if:
       properties:
         compatible:
@@ -99,7 +92,7 @@ allOf:
         clocks:
           minItems: 1
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
index 3c643b227a70..eb44e072b6e5 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
@@ -9,6 +9,9 @@ title: Broadcom VC4 (VideoCore4) DSI Controller
 maintainers:
   - Eric Anholt <eric@anholt.net>
 
+allOf:
+  - $ref: dsi-controller.yaml#
+
 properties:
   "#clock-cells":
     const: 1
diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
index b8ba6eb482a1..a125b2dd3a2f 100644
--- a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
@@ -14,6 +14,9 @@ description: |
   NWL MIPI-DSI host controller found on i.MX8 platforms. This is a dsi bridge for
   the SOCs NWL MIPI-DSI host controller.
 
+allOf:
+  - $ref: ../dsi-controller.yaml#
+
 properties:
   compatible:
     const: fsl,imx8mq-nwl-dsi
@@ -144,10 +147,6 @@ properties:
 
     additionalProperties: false
 
-patternProperties:
-  "^panel@[0-9]+$":
-    type: object
-
 required:
   - '#address-cells'
   - '#size-cells'
@@ -163,7 +162,7 @@ required:
   - reset-names
   - resets
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -172,7 +171,7 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/reset/imx8mq-reset.h>
 
-    mipi_dsi: mipi_dsi@30a00000 {
+    dsi@30a00000 {
               #address-cells = <1>;
               #size-cells = <0>;
               compatible = "fsl,imx8mq-nwl-dsi";
diff --git a/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml b/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
index 69cc7e8bf15a..327a14d85df8 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
@@ -13,6 +13,9 @@ maintainers:
 description:
   The STMicroelectronics STM32 DSI controller uses the Synopsys DesignWare MIPI-DSI host controller.
 
+allOf:
+  - $ref: dsi-controller.yaml#
+
 properties:
   compatible:
     const: st,stm32-dsi
@@ -65,24 +68,6 @@ properties:
         description:
           DSI output port node, connected to a panel or a bridge input port"
 
-patternProperties:
-  "^(panel|panel-dsi)@[0-9]$":
-    type: object
-    description:
-      A node containing the panel or bridge description as documented in
-      Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
-    properties:
-      port:
-        type: object
-        description:
-          Panel or bridge port node, connected to the DSI output port (port@1)
-
-  "#address-cells":
-    const: 1
-
-  "#size-cells":
-    const: 0
-
 required:
   - "#address-cells"
   - "#size-cells"
@@ -92,7 +77,7 @@ required:
   - clock-names
   - ports
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.25.1


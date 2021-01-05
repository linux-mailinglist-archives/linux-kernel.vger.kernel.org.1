Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E579A2EAC4A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbhAENrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbhAENrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:47:33 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CD7C06179E;
        Tue,  5 Jan 2021 05:46:48 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id m6so18385159pfm.6;
        Tue, 05 Jan 2021 05:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ITGq5XXvbi+yNr7BSlbWRzQTm7bqZ80outw2BLEk37E=;
        b=RZ01zhUXYyioHMu3b9cHDVAAtIEoHXrcsQqbkGE5LaMLfcyl18oHwZ5BljJLQPbdGN
         AAyfzFe4j+pTp6on5XZSN6nIPSs7M/J7wciC4AqMhyX4I/q+kxkcMUorqxNQ87IMT1A3
         B160TRS7Fl5aboQsGfo77FL8RI2Ch4ujkUZCok9tfHl5jLasIu7o8Nm4Do8O2f/gimfF
         cZFIlw5GzQKwMbsoABvCDLztcnItxBuDBJ+J7Lnpo3D+G4WwOOuKMgqyG9A3UHA1W35B
         EdDwJ2k6l3EvO4tUAVz8w9ktjVVqa/Rd4J5x3UNXjTXO9HUAMCroIk90EkFEIEMj7Coy
         XiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ITGq5XXvbi+yNr7BSlbWRzQTm7bqZ80outw2BLEk37E=;
        b=NCsO83/J0Qw6xX4k4kTxDCvDNLCyic8g4wFmV/NxwZyH6rnao4cVb8POeGGx2ngXdk
         bClXJzsgAeIfY+qzwFtbR4d1VaxZssBMNML5ABRbxXf+US6RZ+b4DRReCMCuxhQX7RvX
         ZFQHNuklGiD5jXhtHfA47lpHAtD1Inoz4NocuTrDmVhohby/rVVQGl3e0C164lP4/v7n
         yLWwLCi5hZg6Kbnv3tBs87U7SDYq8Qe04jo4vResX+Y/5LeoRZ/1pfTx9BLZoLJ2UTsd
         gTX5N7Tcop9AbtoTctJIeyD3oEPWBkr8lyI3xblZ651T/+6xSXn7C9FlISYSONzY4DfO
         aMkg==
X-Gm-Message-State: AOAM531+y9iLXxFXQU8vDlOrkMqFJpmHtGTdENDL1Ggxcd5vJqx1vET6
        HZvPxPCpNyQf32w3okwhQrg=
X-Google-Smtp-Source: ABdhPJxUcKIH5i4vIbC/bBQ3cvnVqC/L48yXPdZ4iWPBpBJ6W700melX2u/WmUJxId20lXSXP2M2cw==
X-Received: by 2002:a63:c5e:: with SMTP id 30mr61485858pgm.57.1609854407827;
        Tue, 05 Jan 2021 05:46:47 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w63sm57582284pfc.20.2021.01.05.05.46.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 05:46:47 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 5/6] dt-bindings: display: add Unisoc's mipi dsi controller bindings
Date:   Tue,  5 Jan 2021 21:46:06 +0800
Message-Id: <1609854367-2720-6-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609854367-2720-1-git-send-email-kevin3.tang@gmail.com>
References: <1609854367-2720-1-git-send-email-kevin3.tang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

Adds MIPI DSI Controller
support for Unisoc's display subsystem.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/sprd/sprd,sharkl3-dsi-host.yaml        | 102 +++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
new file mode 100644
index 0000000..d439f68
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/sprd,sharkl3-dsi-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc MIPI DSI Controller
+
+maintainers:
+  - Kevin Tang <kevin.tang@unisoc.com>
+
+properties:
+  compatible:
+    const: sprd,sharkl3-dsi-host
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  clocks:
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: clk_src_96m
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    type: object
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      port@0:
+        type: object
+        description:
+          A port node with endpoint definitions as defined in
+          Documentation/devicetree/bindings/media/video-interfaces.txt.
+          That port should be the input endpoint, usually coming from
+          the associated DPU.
+      port@1:
+        type: object
+        description:
+          A port node with endpoint definitions as defined in
+          Documentation/devicetree/bindings/media/video-interfaces.txt.
+          That port should be the output endpoint, usually output to
+          the associated panel.
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+      - port@0
+      - port@1
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sprd,sc9860-clk.h>
+    dsi: dsi@63100000 {
+        compatible = "sprd,sharkl3-dsi-host";
+        reg = <0x63100000 0x1000>;
+        interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+          <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+        clock-names = "clk_src_96m";
+        clocks = <&pll CLK_TWPLL_96M>;
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port@0 {
+                reg = <0>;
+                dsi_in: endpoint {
+                    remote-endpoint = <&dpu_out>;
+                };
+            };
+            port@1 {
+                reg = <1>;
+                dsi_out: endpoint {
+                    remote-endpoint = <&panel_in>;
+                };
+            };
+        };
+    };
-- 
2.7.4


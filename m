Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6544D2D1415
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgLGOvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGOvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:51:49 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E151DC0612AB;
        Mon,  7 Dec 2020 06:50:53 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id m9so9074751pgb.4;
        Mon, 07 Dec 2020 06:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y4Yf/zppkktM8cnTiZUCQlAYgq8mTIxwfKXhAD+iUPQ=;
        b=FVYgChdQ+ZghVAnu49CRn9dwxAqn19kJ722RC81D1HiK0DqBTpj+RzAn80KevB4qVX
         DFO1h2U419+79kEvD2RtngJ8SKFXFhanms7JtzShhAMnUNm1zXBTNMNO2/li+5r5ybkY
         sH2Ccsp1mjetJj/yw9dwrXhwYKu+xLkERodr6KpNSYLhxW2ioC4IQlidVrICfilVtgkk
         cZYJQMYvNbHSXCrPbymho4nkwPmL5/bBi/gvYDMSSFe6Sn9x15DgzohuRfTl4iM9ygj6
         2CjilhFIxnU+GVK0yduZpJyw542BasNhZKpnx7jJWlhq4TCSo5cz8KJZ0tlm4WKG7yao
         am/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y4Yf/zppkktM8cnTiZUCQlAYgq8mTIxwfKXhAD+iUPQ=;
        b=NgezYkfO11xe1Gu6omB7mWJFZBBueAFnCuxThybzbdN9OQOXblT2tBIPqiNQXfH6vm
         xccjBhaweAvfGaTPPLE3iLoy/kkJRwsLl2bVVTStq5S/piSaB25Fhla6bwsooksaaR6f
         D8LtouSvcYYkDV3jNZt60kkSB2szgCkjZRCyD/BDI8HTgRFz4TmzPdpcYNM1lORstlSM
         h5+eflqe6ACPy8C2+QO+Wh/B/BiKl7FdFx6rIxOquJLw1Wr+gpbNQwaIQr/ZGaDZJpPY
         TKPfGC3L87/Id6ZXaSA5CXOx/MSl7sG7y6FI8KHj/O4Yk4T8PRaLNRAbXmHpNABPfKIO
         EPnQ==
X-Gm-Message-State: AOAM533wF35KsEQ74TrQlH05ASguOD9LIODk4bLFHKeEA5nLA75vAKec
        4kcz5/qesr3n1sAbK5hZ+cs=
X-Google-Smtp-Source: ABdhPJxq2D16/pq/CJQ8sTcaJ4p+SmhSJJF6uQ8nEKGX6Be4VAdG1BTwj9GAXWr2RJOMFQShiggThw==
X-Received: by 2002:aa7:8205:0:b029:18b:3691:e447 with SMTP id k5-20020aa782050000b029018b3691e447mr16061164pfi.69.1607352653515;
        Mon, 07 Dec 2020 06:50:53 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u25sm10360249pgl.68.2020.12.07.06.50.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 06:50:52 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 5/6] dt-bindings: display: add Unisoc's mipi dsi controller bindings
Date:   Mon,  7 Dec 2020 22:50:25 +0800
Message-Id: <1607352626-26088-6-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607352626-26088-1-git-send-email-kevin3.tang@gmail.com>
References: <1607352626-26088-1-git-send-email-kevin3.tang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

Adds MIPI DSI Controller
support for Unisoc's display subsystem.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 .../display/sprd/sprd,sharkl3-dsi-host.yaml        | 107 +++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
new file mode 100644
index 0000000..f7ee6b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
@@ -0,0 +1,107 @@
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
+    description:
+      Physical base address and length of the registers set for the device.
+
+  interrupts:
+    maxItems: 2
+    description:
+      Should contain DSI interrupt.
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
+    description: A phandle to DSIM power domain node
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


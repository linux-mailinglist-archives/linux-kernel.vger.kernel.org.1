Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B923A2C86C1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbgK3O3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgK3O3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:29:38 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF2DC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:28:51 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w187so10510447pfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q+XDWKoV9MHFRTeqn/T5sJtop0zObfyxbDEIDUOub8M=;
        b=ehIkPDvR3VgtMgIKZL8RVxU9U8jNyx0krGMxMEJacUsEuNgJcWjLwH1yRcDOU+KqaL
         zHf0BwBuJhgmEHjrJESBvMRLxxMAOUu9nqlwqEkftxDK0CxAkEaPbktpjK78vehIy+51
         AOisfeJD1zgIkFuphvbmuGkRZBAJ2E1sKHBuZc9xaHg0UQN6uTNhjku5kRJFIeMrvgqx
         EhC3oq5bYz0hdB9AZyiQgn0JF+rBnKPC90Ed/uCIkn9QJt+8sqzHzJ+HwGKET4jT2jkb
         nHFwrBwdX3XG2gUmGTpdbjWnxdNI+02RmqGsq1yVdkVCanto2fHouoGTh4C9E0xW1Xs8
         Na4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q+XDWKoV9MHFRTeqn/T5sJtop0zObfyxbDEIDUOub8M=;
        b=Q5Qt+53hCgQbv/qloPGNjkXCHUpd/u4bexX6GYwazgd0Xlhoza3G3lcpTElXtU6QfJ
         hegOIeB2GY/+49B5dEh0rgWzB/3ghKEL8qdPa+OjGCP5StGsNzidhXpb1clyMN7MHSIm
         LNELCa782U9Ym3ydwauTPnolk1JFz3Odr4gYxlSY735RdiUoY3Vnk1A7eb/qenevBBSA
         dL8ZqY9krdnFE17ej9dQf58qGEnc2z95YOmAb9sOE4z8DuVllF7G4waDLrP2i7EpeyXD
         5xEagHmy3yRamLXbzbDixo6JHyGkXoi77o/GZavBccbaSJSXFHVsq3jxvDzEDKY56VHp
         V6mQ==
X-Gm-Message-State: AOAM530+0f5j+cQ4KTepd+W2ZcpsaSC6eaTyN5iXSzLXG3PSaDU+R9IP
        K4O9O9Cnm6BwQDDuPqANDc8=
X-Google-Smtp-Source: ABdhPJzNEFG3Z5LTCpEJFYTrjXyIJr3N5JnpCJG8vPCncSukIAMX4+GdH5Ki05Dl1aj+mI/xqyX8ug==
X-Received: by 2002:a63:5656:: with SMTP id g22mr17811454pgm.262.1606746531075;
        Mon, 30 Nov 2020 06:28:51 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 17sm15580479pfh.173.2020.11.30.06.28.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 06:28:50 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 3/6] dt-bindings: display: add Unisoc's dpu bindings
Date:   Mon, 30 Nov 2020 22:28:30 +0800
Message-Id: <1606746513-30909-4-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606746513-30909-1-git-send-email-kevin3.tang@gmail.com>
References: <1606746513-30909-1-git-send-email-kevin3.tang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
which transfers the image data from a video memory buffer to an internal
LCD interface.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 .../bindings/display/sprd/sprd,sharkl3-dpu.yaml    | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
new file mode 100644
index 0000000..a9052e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/sprd,sharkl3-dpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc Sharkl3 Display Processor Unit (DPU)
+
+maintainers:
+  - Kevin Tang <kevin.tang@unisoc.com>
+
+description: |
+  DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
+  which transfers the image data from a video memory buffer to an internal
+  LCD interface.
+
+properties:
+  compatible:
+    const: sprd,sharkl3-dpu
+
+  reg:
+    maxItems: 1
+    description:
+      Physical base address and length of the DPU registers set
+
+  interrupts:
+    maxItems: 1
+    description:
+      The interrupt signal from DPU
+
+  clocks:
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: clk_src_128m
+      - const: clk_src_384m
+
+  power-domains:
+    maxItems: 1
+    description: A phandle to DPU power domain node.
+
+  iommus:
+    maxItems: 1
+    description: A phandle to DPU iommu node.
+
+  port:
+    type: object
+    description:
+      A port node with endpoint definitions as defined in
+      Documentation/devicetree/bindings/media/video-interfaces.txt.
+      That port should be the output endpoint, usually output to
+      the associated DSI.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sprd,sc9860-clk.h>
+    dpu: dpu@63000000 {
+        compatible = "sprd,sharkl3-dpu";
+        reg = <0x63000000 0x1000>;
+        interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+        clock-names = "clk_src_128m", "clk_src_384m";
+
+        clocks = <&pll CLK_TWPLL_128M>,
+          <&pll CLK_TWPLL_384M>;
+
+        dpu_port: port {
+            dpu_out: endpoint {
+                remote-endpoint = <&dsi_in>;
+            };
+        };
+    };
-- 
2.7.4


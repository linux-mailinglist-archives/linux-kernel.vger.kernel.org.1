Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9992E35A5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 11:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgL1KCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 05:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgL1KCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 05:02:52 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29514C061798;
        Mon, 28 Dec 2020 02:02:12 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y8so5405855plp.8;
        Mon, 28 Dec 2020 02:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vv0Tt7wUhLrWCRhDSflLKD0bX0DOHnjLkBF71kuu380=;
        b=vCTTnj7+GzOvNpAKrMVp2zDe4HA4xPfrZFuIio2ouwLZxOo6rLpSMbinORbG9ZBEUP
         cdeJWKiSVj9siXQ9tOpWstpC90V4I2viYeoYw6YANB2apV0Hpz8FGZcAVdS5xnTMyoEf
         LUOwykxJHhEtOAVT/KGSi+Ui3RjsXcxTsnpfBQbgw8j9NO6jC4TSw4BpDQAZkTw2/g6a
         qBzsW7xTYMHF0LcB+GT1HF4oV7FIQRFS+iGmXS7YklajLThkCGbK9WFGLd/NhB6MC4fR
         tsi7vJOloi0wVlELTJ3QFZsA2/NPSXdsen31F60+NYuy4lOixpiHH7JXEvxEeScG+G3C
         8sOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vv0Tt7wUhLrWCRhDSflLKD0bX0DOHnjLkBF71kuu380=;
        b=O4QmIrGFPpTBwqNaY7UmxmklrOf1K/XyCJMlWm0LAIAkIYuuZ3He15HXMfPqqSPj0g
         kbPDpHdr/94Lrz1EBPzNqyAW9i5wr8nvDKDmtEi9dlZ6Nn3s+1PUhCKNsJRO1rTroL1o
         ps1xH5KItJlaD80Wte/Hf1j3Nfvqo/EHsdkciccwFtLLwH3VdQ0rOX7Xo5GH7wmFddOW
         ov9S/S7EfHHgX4MZs+keHjm4cHjoEZwy7TfuqkFUOHvI/V7mx1rNWUpAMDIY+D4gw7r4
         ts/kZwxsDNoTD7yy07SxNp/kX1gF5N6dB2v3uqsJB6GQQmgxKpTA+EJ+ld8ScNSOwVHY
         JuIA==
X-Gm-Message-State: AOAM533IKzWjN7N2748aibcV3uO0Ke/4f3z3ZmIkHkRkTYjFPw9vYLsK
        q5Ft+JoncKxyydzMz2m0gZ4=
X-Google-Smtp-Source: ABdhPJyyhLUIkAER5gLVdEXNUusmZUYOGsbveXGxvMUfapz4nXPGbqCn5VWjPq1NEDkUiCNDhj28uw==
X-Received: by 2002:a17:90a:4:: with SMTP id 4mr20557128pja.19.1609149731767;
        Mon, 28 Dec 2020 02:02:11 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s1sm33775240pjk.1.2020.12.28.02.02.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Dec 2020 02:02:11 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/6] dt-bindings: display: add Unisoc's dpu bindings
Date:   Mon, 28 Dec 2020 18:01:44 +0800
Message-Id: <1609149707-21411-4-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609149707-21411-1-git-send-email-kevin3.tang@gmail.com>
References: <1609149707-21411-1-git-send-email-kevin3.tang@gmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/sprd/sprd,sharkl3-dpu.yaml    | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
new file mode 100644
index 0000000..4ebea60
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
@@ -0,0 +1,77 @@
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
+
+  interrupts:
+    maxItems: 1
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
+
+  iommus:
+    maxItems: 1
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


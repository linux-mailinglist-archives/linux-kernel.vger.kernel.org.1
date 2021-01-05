Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CAF2EAC46
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbhAENrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbhAENrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:47:16 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC401C061574;
        Tue,  5 Jan 2021 05:46:36 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n10so21288658pgl.10;
        Tue, 05 Jan 2021 05:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vv0Tt7wUhLrWCRhDSflLKD0bX0DOHnjLkBF71kuu380=;
        b=gcmmjoGgf0wUNaGuMNdnZ6CcjRO7AI0t0OuJqof7JjbvAQ4Yr8JSFD/UB4s0LvjdxG
         +n4vQoxat/GI8ntEbjl/+18TMs/wb+wn0YsChDkCDIolQeidJqkZp9ew8hy9P11GH8uo
         xils6KlYKHMAUditqbDpqW1t55MeFg7Jo4q4wVPexwnbuK1/ENUG4dlMht8Q8gV9/KbN
         +UnvnVAp9D9dyGWTu9EH0+fa7jlK+1d3PGIQxlelP+TD0V2Yd+YCmReSFTI9AuCj9u6B
         1FbLONtJI3LcL66jruR950UbVMUbeBu8ln5pg5MNnwKHHr/P4OS97AWlTOaLhrs1jpvT
         meXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vv0Tt7wUhLrWCRhDSflLKD0bX0DOHnjLkBF71kuu380=;
        b=XvIEAONXcysluN6BkUGGqUxMpNbXFZU7yJiT5Enma9A0whB93tjyuy+KKRKuhRiEn1
         Hwusdnr76B4l+7L8Tc3qwZUdRDsP9KKZWfDqckKJ3g2Op2xQ6xjg28NXmJvbrPVtyX4G
         V74r7iw9G2jucLChMFwr5ZnPXSxFAtwr51XLGrfxWvztmLiYcF1DIm3yKng73eA7y1Ug
         5QbbevZDyfIcXHP3lH794bnB3DJ8i9KfSCzoPLrLudFcGwzEZTAQfPK96K2wzOLlc5d2
         7dcAOOyngOluJiOCZzfCklLklhkqdMaCc9xoUGc5nS37ndxNgCQZiusCKQdfaKY21EmX
         8HUg==
X-Gm-Message-State: AOAM533crjzlvzx1xQQyONPYW4ktQfF+2AshAC1zSk18vOQxNZVvUVkR
        uoTBxW/5V4DeVKG3A/u4iaQ=
X-Google-Smtp-Source: ABdhPJxavjvNbANe/Xh1U+R40m0rOMGxRnpABb5EjpMdLbys/JSNDaBklI23JQiIUgdtdoeRefmnWg==
X-Received: by 2002:aa7:9f1d:0:b029:1ad:2aaa:c1e3 with SMTP id g29-20020aa79f1d0000b02901ad2aaac1e3mr62546200pfr.75.1609854396309;
        Tue, 05 Jan 2021 05:46:36 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w63sm57582284pfc.20.2021.01.05.05.46.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 05:46:35 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 3/6] dt-bindings: display: add Unisoc's dpu bindings
Date:   Tue,  5 Jan 2021 21:46:04 +0800
Message-Id: <1609854367-2720-4-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609854367-2720-1-git-send-email-kevin3.tang@gmail.com>
References: <1609854367-2720-1-git-send-email-kevin3.tang@gmail.com>
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


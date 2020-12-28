Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0A92E35AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 11:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgL1KDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 05:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgL1KDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 05:03:18 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBCFC06179A;
        Mon, 28 Dec 2020 02:02:19 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n3so4633134pjm.1;
        Mon, 28 Dec 2020 02:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oVRIl4Sz0MTda1/P8GVqU6JTUOlSJ4wE70cCNd4CfXk=;
        b=YnyTV4vyw9pVpGdEoVqKLl47nTsq5e0f8vjcw9tJZS8FL7Q6O3Ae7EzB9CGTfnVNnR
         Y0SaxeeH9beuaI7SuHGunidfi2kixdeXK+dPxaAzF7TSIBUUiLaB/abT5RfqxEWqvfIW
         IVzV+IHNqnekl7GDdrOHtVB6PlZy3nrL3G46jdk+rg0oMxlLZsFoR5T2xdz5pLkFC8Iw
         JXJ6lYwDwKfe+wuLIoN5Ow2nzm3FuVy56a1kXDPeqfIY00xFMntKE2fyFm1uJSgdPWc3
         38DRbKaCtC7YhbNNUM72NHHa430V3ZLsNOyub5GdEwCYv5e9H9Oo79wYWNYz/7+OMIGv
         80mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oVRIl4Sz0MTda1/P8GVqU6JTUOlSJ4wE70cCNd4CfXk=;
        b=aXgmsB7ZW/RxAjPuWlHXlUDxmodWmRM16fr17XODF0xtKyH4/DDXWN8saM+McnBPgT
         B+ld0YqIn+Kg/P5ZAbUPat1KctaN8NXwxG+3hA7xLXTZwpnFKEiniNLfwek3PoUDLYzj
         I2JwLxzrysysXY0vFYH7Gls/YaTFGT2xKLpqX36X1MwGM220QMAB7WtG1ecsXNoFVjwS
         MG/DLo0P2nih6kpQpW2kzOG8n6uBukPZ2oLCfovLdoJMzoIMswE3hbjyQRy/ExI2V0mY
         jVhP+wvKHfrjpk5jnfbjvHBRRdeI/mMLZn/0Iv3lgTvPM4zvCHizC1TlQDzsScega7DQ
         q1Kw==
X-Gm-Message-State: AOAM5319ovnqCq0xgH4TD0nAaR6unqf9DFxLrsJ2U+E0ViT8CwCPxmMR
        tyaeQI7htdUrlMdH3EjfSJE=
X-Google-Smtp-Source: ABdhPJxd27P0DV2n5nVvW4sWQLcddokEN0tmiJK0+RruD7GQvOCaWq4cUZEAPb+SjxWUzX41JPqeDA==
X-Received: by 2002:a17:902:fe91:b029:da:6bf3:7ba0 with SMTP id x17-20020a170902fe91b02900da6bf37ba0mr44270797plm.2.1609149739451;
        Mon, 28 Dec 2020 02:02:19 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s1sm33775240pjk.1.2020.12.28.02.02.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Dec 2020 02:02:18 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 5/6] dt-bindings: display: add Unisoc's mipi dsi controller bindings
Date:   Mon, 28 Dec 2020 18:01:46 +0800
Message-Id: <1609149707-21411-6-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609149707-21411-1-git-send-email-kevin3.tang@gmail.com>
References: <1609149707-21411-1-git-send-email-kevin3.tang@gmail.com>
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


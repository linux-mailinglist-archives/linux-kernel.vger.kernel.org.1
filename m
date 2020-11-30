Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986E72C86BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgK3O3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgK3O3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:29:21 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ED2C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:28:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h7so12331pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EpEME209mz5k6FTxbvqck9duuxyhczoNP4apmpkRY5E=;
        b=VU91h9AImpvhGCnnvsr49JxL8FfrvBsLs4EcTzjNT2/qySaAiuf4EHYapUGDUEXjou
         YsfPEY9c+Mmgxx+LE2R0rILoGGJ/VS5DV8N5cx994q9NV6vDA+lipaYzuk/oeQuVqIQW
         ZPrfOEGvqVFHb8TIh2T/8b1k4ReclWHG3pRafgk+PhpQuP8yg6Oz1bktqE1tptLlP+l6
         USLeArSp0z6uhtQrDYZEBrxpD1d0EN1OgsAM4oPQaSU/CK1XowdADCyPg6za2QpDKM8v
         DcTx1rdH2PaWSLvzY2kOkuRNw5Jms5uuk4wucqATgBCRr/sLJInXL2Y15v4dgMiqWCsH
         ZNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EpEME209mz5k6FTxbvqck9duuxyhczoNP4apmpkRY5E=;
        b=dOT5n2ElBhPTAZhNiOAo6esDMK72aDKWXRLUVXXd8oYSySRSOUTecnPMKuREV9AfEC
         k2//3RZsuAvrH/E7g9cR1FYDijvht2VxkfqaNG8lG6VPQfzlgtIt8BiVcnZtbeyhZlAH
         T+Ex2zOfiTKoGzzWRS4N6JrYFo4loorIhEBqM3xRexUySOB8QwEM2ZupUJc+/zEqTkp1
         BL8iTK6K0qaJ5Zu+KTNcN+QGMbE3GOzTwe+4MEGA9acNnGTFXos5AdaI54HubKo3irhY
         64IR2bdNHO42A1I2GM3fDApTF8xlVcVR6P6jCrFcKtWz/wOgvshvr145U2jpcES631CG
         0zUw==
X-Gm-Message-State: AOAM533BgqqEG0mdsuHaZ58Qw2mU+K6GIPSVzR2KBkxzdlYr2VUcdg0V
        Zi1mqQkGpt4916sPfog3Yc0=
X-Google-Smtp-Source: ABdhPJz/EO917ORFpZWL819ftPBlTYHNLLh0U42PTMgJ7dxVEIJapgjsKIHHSMwpafin6vtFvbWWOQ==
X-Received: by 2002:a17:902:8309:b029:da:3239:db54 with SMTP id bd9-20020a1709028309b02900da3239db54mr19222324plb.31.1606746538307;
        Mon, 30 Nov 2020 06:28:58 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 17sm15580479pfh.173.2020.11.30.06.28.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 06:28:57 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 5/6] dt-bindings: display: add Unisoc's mipi dsi&dphy bindings
Date:   Mon, 30 Nov 2020 22:28:32 +0800
Message-Id: <1606746513-30909-6-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606746513-30909-1-git-send-email-kevin3.tang@gmail.com>
References: <1606746513-30909-1-git-send-email-kevin3.tang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

Adds MIPI DSI Master and MIPI DSI-PHY (D-PHY)
support for Unisoc's display subsystem.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 .../display/sprd/sprd,sharkl3-dsi-host.yaml        | 107 +++++++++++++++++++++
 .../display/sprd/sprd,sharkl3-dsi-phy.yaml         |  84 ++++++++++++++++
 2 files changed, 191 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-phy.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
new file mode 100644
index 0000000..fe0e89d
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
+          the associated DPHY.
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
+                    remote-endpoint = <&dphy_in>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-phy.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-phy.yaml
new file mode 100644
index 0000000..b4715d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-phy.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/sprd,sharkl3-dsi-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc MIPI DSI-PHY (D-PHY)
+
+maintainers:
+  - Kevin Tang <kevin.tang@unisoc.com>
+
+properties:
+  compatible:
+    const: sprd,sharkl3-dsi-phy
+
+  reg:
+    maxItems: 1
+    description:
+      Must be the dsi controller base address.
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
+          That port should be the output endpoint, usually output to
+          the associated panel.
+      port@1:
+        type: object
+        description:
+          A port node with endpoint definitions as defined in
+          Documentation/devicetree/bindings/media/video-interfaces.txt.
+          That port should be the input endpoint, usually coming from
+          the associated DSI controller.
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
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    dphy: dphy@63100000 {
+        compatible = "sprd,sharkl3-dsi-phy";
+        reg = <0x63100000 0x1000>;
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            /* input port*/
+            port@1 {
+                reg = <1>;
+                dphy_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+            /* output port */
+            port@0 {
+                reg = <0>;
+                dphy_out: endpoint {
+                    remote-endpoint = <&panel_in>;
+                };
+            };
+        };
+    };
-- 
2.7.4


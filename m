Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A8E19D8FA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 16:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391081AbgDCOWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 10:22:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37066 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390812AbgDCOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:22:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id j19so7919511wmi.2;
        Fri, 03 Apr 2020 07:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FnjjXTS2tsUqaCMaL0+MNmh8auRiJkLrY6HybNJpx+A=;
        b=WUXbhUtDuCCX+mwh0lK951yZfAZfXRYIO0QlQERr12I5nb1nrhtizedRX0mIcKlkCk
         +AxrfWxqUqWBTGRzn/yto9ZkY6yY4/qSJgiA8O81CHAfVu+cOrWg2Jw+TwzA1oZy7jwv
         Q6vGIAKnj69JKQSbkzRhWWT7HxGZxuthjJFRcRcFtXlEnV/ge9yjeUwsDQb7YKxLZzul
         D6QbY6pE2fCh18Qxs5i8aY7kcHMNjcdQNlB+xxrv1eLzT5l6UO/oPL8kTdQtbrYLp+5q
         wSW9xwEFgqlW+gNc2jt3oNQmJ38yyj1vlJKoEE98xswoWRqYFO9AOY0uZB88tO1bGVNd
         5Xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FnjjXTS2tsUqaCMaL0+MNmh8auRiJkLrY6HybNJpx+A=;
        b=orFZn4cdb9AI4+buqKBfkirCvlnaU280rjwhzCUXsucnJEH4+jXX+fNk4+ygUISn7L
         HAP3/d3WMNy0C+y9lYJdLfeZluk3dKWa425JP+hNiSp1fZIYQrQYSegfrwGWFwNKxwcn
         3Q5WBMtyqbukMzL7R5+kCn5R3+YFFw8xwQHjSKjyeqkcqPKMFGHlfyY9QdG217SuGcVd
         XFOoRBbJ0Dd4mdYKOo6ntzVMqBtpMNKnuIBQCSKYimLWWvcA1gs+GFx4QvIl20iDX/UE
         DzomlROhEH0SNdX/Oo2PgudoPuBxc0J6r7pB4CuP12ujLcIOkz4k3s13D4YCvtIDSFPZ
         oVfQ==
X-Gm-Message-State: AGi0PuZ7Vg1rCUsUNKURZvvpkPeL3piLoSU+uqFdxqqGOoafj50pnyPE
        1CDj7By2jzTd9A7aV0VLNgo=
X-Google-Smtp-Source: APiQypLjkxiSIiSVBM2f6/971sNVX/AwIwkwZ+MDXn3Jc6d57+MOIC7i53w6iYG8L7VzmVg7i6SIrA==
X-Received: by 2002:a7b:c445:: with SMTP id l5mr6162878wmi.61.1585923764058;
        Fri, 03 Apr 2020 07:22:44 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u16sm12132223wro.23.2020.04.03.07.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 07:22:43 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: display: convert rockchip vop bindings to yaml
Date:   Fri,  3 Apr 2020 16:22:34 +0200
Message-Id: <20200403142235.8870-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'vop' nodes are manually verified.
In order to automate this process rockchip-vop.txt
has to be converted to yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes v5:
  Add reviewed by
  Fix irq.h already included in arm-gic.h

Changes v4:
  Change description
  Replace compatible oneOf by enum
  Change interrupts description
  Remove resets minItems

Changes v3:
  Change description

Changes v2:
  No new properties
---
 .../bindings/display/rockchip/rockchip-vop.txt     |  74 -------------
 .../bindings/display/rockchip/rockchip-vop.yaml    | 123 +++++++++++++++++++++
 2 files changed, 123 insertions(+), 74 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
deleted file mode 100644
index 8b3a5f514..000000000
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
+++ /dev/null
@@ -1,74 +0,0 @@
-device-tree bindings for rockchip soc display controller (vop)
-
-VOP (Visual Output Processor) is the Display Controller for the Rockchip
-series of SoCs which transfers the image data from a video memory
-buffer to an external LCD interface.
-
-Required properties:
-- compatible: value should be one of the following
-		"rockchip,rk3036-vop";
-		"rockchip,rk3126-vop";
-		"rockchip,px30-vop-lit";
-		"rockchip,px30-vop-big";
-		"rockchip,rk3066-vop";
-		"rockchip,rk3188-vop";
-		"rockchip,rk3288-vop";
-		"rockchip,rk3368-vop";
-		"rockchip,rk3366-vop";
-		"rockchip,rk3399-vop-big";
-		"rockchip,rk3399-vop-lit";
-		"rockchip,rk3228-vop";
-		"rockchip,rk3328-vop";
-
-- reg: Must contain one entry corresponding to the base address and length
-	of the register space. Can optionally contain a second entry
-	corresponding to the CRTC gamma LUT address.
-
-- interrupts: should contain a list of all VOP IP block interrupts in the
-		 order: VSYNC, LCD_SYSTEM. The interrupt specifier
-		 format depends on the interrupt controller used.
-
-- clocks: must include clock specifiers corresponding to entries in the
-		clock-names property.
-
-- clock-names: Must contain
-		aclk_vop: for ddr buffer transfer.
-		hclk_vop: for ahb bus to R/W the phy regs.
-		dclk_vop: pixel clock.
-
-- resets: Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names: Must include the following entries:
-  - axi
-  - ahb
-  - dclk
-
-- iommus: required a iommu node
-
-- port: A port node with endpoint definitions as defined in
-  Documentation/devicetree/bindings/media/video-interfaces.txt.
-
-Example:
-SoC specific DT entry:
-	vopb: vopb@ff930000 {
-		compatible = "rockchip,rk3288-vop";
-		reg = <0x0 0xff930000 0x0 0x19c>, <0x0 0xff931000 0x0 0x1000>;
-		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
-		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
-		resets = <&cru SRST_LCDC1_AXI>, <&cru SRST_LCDC1_AHB>, <&cru SRST_LCDC1_DCLK>;
-		reset-names = "axi", "ahb", "dclk";
-		iommus = <&vopb_mmu>;
-		vopb_out: port {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			vopb_out_edp: endpoint@0 {
-				reg = <0>;
-				remote-endpoint=<&edp_in_vopb>;
-			};
-			vopb_out_hdmi: endpoint@1 {
-				reg = <1>;
-				remote-endpoint=<&hdmi_in_vopb>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
new file mode 100644
index 000000000..42ee2b5c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/rockchip/rockchip-vop.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SoC display controller (VOP)
+
+description:
+  VOP (Video Output Processor) is the display controller for the Rockchip
+  series of SoCs which transfers the image data from a video memory
+  buffer to an external LCD interface.
+
+maintainers:
+  - Sandy Huang <hjc@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,px30-vop-big
+      - rockchip,px30-vop-lit
+      - rockchip,rk3036-vop
+      - rockchip,rk3066-vop
+      - rockchip,rk3126-vop
+      - rockchip,rk3188-vop
+      - rockchip,rk3228-vop
+      - rockchip,rk3288-vop
+      - rockchip,rk3328-vop
+      - rockchip,rk3366-vop
+      - rockchip,rk3368-vop
+      - rockchip,rk3399-vop-big
+      - rockchip,rk3399-vop-lit
+
+  reg:
+    minItems: 1
+    items:
+      - description:
+          Must contain one entry corresponding to the base address and length
+          of the register space.
+      - description:
+          Can optionally contain a second entry corresponding to
+          the CRTC gamma LUT address.
+
+  interrupts:
+    maxItems: 1
+    description:
+      The VOP interrupt is shared by several interrupt sources, such as
+      frame start (VSYNC), line flag and other status interrupts.
+
+  clocks:
+    items:
+      - description: Clock for ddr buffer transfer.
+      - description: Pixel clock.
+      - description: Clock for the ahb bus to R/W the phy regs.
+
+  clock-names:
+    items:
+      - const: aclk_vop
+      - const: dclk_vop
+      - const: hclk_vop
+
+  resets:
+    maxItems: 3
+
+  reset-names:
+    items:
+      - const: axi
+      - const: ahb
+      - const: dclk
+
+  port:
+    type: object
+    description:
+      A port node with endpoint definitions as defined in
+      Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+  iommus:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3288-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    vopb: vopb@ff930000 {
+      compatible = "rockchip,rk3288-vop";
+      reg = <0x0 0xff930000 0x0 0x19c>,
+            <0x0 0xff931000 0x0 0x1000>;
+      interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru ACLK_VOP0>,
+               <&cru DCLK_VOP0>,
+               <&cru HCLK_VOP0>;
+      clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+      resets = <&cru SRST_LCDC1_AXI>,
+               <&cru SRST_LCDC1_AHB>,
+               <&cru SRST_LCDC1_DCLK>;
+      reset-names = "axi", "ahb", "dclk";
+      iommus = <&vopb_mmu>;
+      vopb_out: port {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        vopb_out_edp: endpoint@0 {
+          reg = <0>;
+          remote-endpoint=<&edp_in_vopb>;
+        };
+        vopb_out_hdmi: endpoint@1 {
+          reg = <1>;
+          remote-endpoint=<&hdmi_in_vopb>;
+        };
+      };
+    };
-- 
2.11.0


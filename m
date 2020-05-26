Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9B11BC09F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 16:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgD1OGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 10:06:54 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:61561 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728008AbgD1OGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:06:52 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 Apr 2020 19:36:44 +0530
Received: from c-sanm-linux.qualcomm.com ([10.206.25.31])
  by ironmsg02-blr.qualcomm.com with ESMTP; 28 Apr 2020 19:36:27 +0530
Received: by c-sanm-linux.qualcomm.com (Postfix, from userid 2343233)
        id C936528DA; Tue, 28 Apr 2020 19:36:26 +0530 (IST)
From:   Sandeep Maheswaram <sanm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: [PATCH v6 2/4] dt-bindings: phy: qcom,qmp-usb3-dp: Add dt bindings for USB3 DP PHY
Date:   Tue, 28 Apr 2020 19:36:13 +0530
Message-Id: <1588082775-19959-3-git-send-email-sanm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588082775-19959-1-git-send-email-sanm@codeaurora.org>
References: <1588082775-19959-1-git-send-email-sanm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split out the dt bindings for USB3 DP PHY from qcom,qmp bindings
for modularity.

Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
---
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         | 135 +++++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
new file mode 100644
index 0000000..6055786
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/qcom,qmp-usb3-dp-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm QMP USB3 DP PHY controller
+
+maintainers:
+  - Manu Gautam <mgautam@codeaurora.org>
+
+properties:
+  compatible:
+    const:
+      qcom,sdm845-qmp-usb3-phy
+  reg:
+    items:
+      - description: Address and length of PHY's common serdes block.
+      - description: Address and length of the DP_COM control block.
+
+  reg-names:
+    items:
+      - const: reg-base
+      - const: dp_com
+
+  "#clock-cells":
+     enum: [ 1, 2 ]
+
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+  clocks:
+    items:
+      - description: Phy aux clock.
+      - description: Phy config clock.
+      - description: 19.2 MHz ref clk.
+      - description: Phy common block aux clock.
+
+  clock-names:
+    items:
+      - const: aux
+      - const: cfg_ahb
+      - const: ref
+      - const: com_aux
+
+  resets:
+    items:
+      - description: reset of phy block.
+      - description: phy common block reset.
+
+  reset-names:
+    items:
+      - const: phy
+      - const: common
+
+  vdda-phy-supply:
+    description:
+        Phandle to a regulator supply to PHY core block.
+
+  vdda-pll-supply:
+    description:
+        Phandle to 1.8V regulator supply to PHY refclk pll block.
+
+  vddp-ref-clk-supply:
+    description:
+        Phandle to a regulator supply to any specific refclk
+        pll block.
+
+#Required nodes:
+patternProperties:
+  "^phy@[0-9a-f]+$":
+    type: object
+    description:
+      Each device node of QMP phy is required to have as many child nodes as
+      the number of lanes the PHY has.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#clock-cells"
+  - "#address-cells"
+  - "#size-cells"
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - vdda-phy-supply
+  - vdda-pll-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+    usb_1_qmpphy: phy-wrapper@88e9000 {
+        compatible = "qcom,sdm845-qmp-usb3-phy";
+        reg = <0 0x088e9000 0 0x18c>,
+              <0 0x088e8000 0 0x10>;
+        reg-names = "reg-base", "dp_com";
+        #clock-cells = <1>;
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+                 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+                 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+                 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
+        clock-names = "aux", "cfg_ahb", "ref", "com_aux";
+
+        resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
+                 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
+        reset-names = "phy", "common";
+
+        vdda-phy-supply = <&vdda_usb2_ss_1p2>;
+        vdda-pll-supply = <&vdda_usb2_ss_core>;
+
+        usb_1_ssphy: phy@88e9200 {
+                reg = <0 0x088e9200 0 0x128>,
+                      <0 0x088e9400 0 0x200>,
+                      <0 0x088e9c00 0 0x218>,
+                      <0 0x088e9600 0 0x128>,
+                      <0 0x088e9800 0 0x200>,
+                      <0 0x088e9a00 0 0x100>;
+                #clock-cells = <0>;
+                #phy-cells = <0>;
+                clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+                clock-names = "pipe0";
+                clock-output-names = "usb3_phy_pipe_clk_src";
+            };
+        };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


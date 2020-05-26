Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F971CFD11
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgELSSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 14:18:51 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:5156 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730922AbgELSSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:18:48 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 May 2020 23:48:43 +0530
Received: from c-rbokka-linux.qualcomm.com ([10.206.232.238])
  by ironmsg02-blr.qualcomm.com with ESMTP; 12 May 2020 23:48:24 +0530
Received: by c-rbokka-linux.qualcomm.com (Postfix, from userid 203305)
        id 9E1B82B7C; Tue, 12 May 2020 23:48:23 +0530 (IST)
From:   Ravi Kumar Bokka <rbokka@codeaurora.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org, Ravi Kumar Bokka <rbokka@codeaurora.org>
Subject: [RFC v1 1/3] dt-bindings: nvmem: Add devicetree bindings for qfprom-efuse
Date:   Tue, 12 May 2020 23:47:58 +0530
Message-Id: <1589307480-27508-2-git-send-email-rbokka@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds dt-bindings document for qfprom-efuse controller.

Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
---
 .../devicetree/bindings/nvmem/qfprom-efuse.yaml    | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml b/Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml
new file mode 100644
index 0000000..d262c99
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/qfprom-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies Inc, QFPROM Efuse bindings
+
+maintainers:
+  - Ravi Kumar Bokka <rbokka@codeaurora.org>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc7180-qfprom-efuse
+
+  reg:
+    maxItems: 3
+
+required:
+   - compatible
+   - reg
+   - clocks
+   - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
+
+    efuse@780000 {
+	compatible = "qcom,sc7180-qfprom-efuse";
+        reg = <0 0x00780000 0 0x100>,
+              <0 0x00780120 0 0x7a0>,
+              <0 0x00782000 0 0x100>;
+        clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
+        clock-names = "secclk";
+    };
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.


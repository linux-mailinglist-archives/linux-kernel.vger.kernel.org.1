Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222CB2BFEDE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 04:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgKWDsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 22:48:36 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55034 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727818AbgKWDsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 22:48:33 -0500
X-UUID: 8341c14b7e36454db53145c5d6c31a8e-20201123
X-UUID: 8341c14b7e36454db53145c5d6c31a8e-20201123
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 484808300; Mon, 23 Nov 2020 11:48:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 Nov 2020 11:48:23 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 Nov 2020 11:48:23 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v3 3/8] dt-bindings: regulator: Add document for MT6359 regulator
Date:   Mon, 23 Nov 2020 11:48:05 +0800
Message-ID: <1606103290-15034-4-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1606103290-15034-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1606103290-15034-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add dt-binding document for MediaTek MT6359 PMIC

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
---
 .../bindings/regulator/mt6359-regulator.yaml  | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml
new file mode 100644
index 000000000000..bc882b93c86a
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mt6359-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MT6359 Regulator from MediaTek Integrated
+
+maintainers:
+  - Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
+
+description: |
+  List of regulators provided by this controller. It is named
+  according to its regulator type, buck_<name> and ldo_<name>.
+  MT6359 regulators node should be sub node of the MT6397 MFD node.
+
+properties:
+  $nodename:
+    pattern: "^pmic$"
+
+  mt6359regulator:
+    type: object
+    description: |
+      list of regulators provided by this controller.
+
+    patternProperties:
+      "^buck_v(s1|gpu11|modem|pu|core|s2|pa|proc2|proc1|core_sshub)$":
+        $ref: "regulator.yaml#"
+
+        properties:
+          regulator-name:
+            pattern: "^v(s1|gpu11|modem|pu|core|s2|pa|proc2|proc1|core_sshub)$"
+
+      "^ldo_v(ibr|rf12|usb|camio|efuse|xo22)$":
+        $ref: "regulator.yaml#"
+
+        properties:
+          regulator-name:
+            pattern: "^v(ibr|rf12|usb|camio|efuse|xo22)$"
+
+      "^ldo_v(rfck|emc|a12|a09|ufs|bbck)$":
+        $ref: "regulator.yaml#"
+
+        properties:
+          regulator-name:
+            pattern: "^v(rfck|emc|a12|a09|ufs|bbck)$"
+
+      "^ldo_vcn(18|13|33_1_bt|13_1_wifi|33_2_bt|33_2_wifi)$":
+        $ref: "regulator.yaml#"
+
+        properties:
+          regulator-name:
+            pattern: "^vcn(18|13|33_1_bt|13_1_wifi|33_2_bt|33_2_wifi)$"
+
+      "^ldo_vsram_(proc2|others|md|proc1|others_sshub)$":
+        $ref: "regulator.yaml#"
+
+        properties:
+          regulator-name:
+            pattern: "^vsram_(proc2|others|md|proc1|others_sshub)$"
+
+      "^ldo_v(fe|bif|io)28$":
+        $ref: "regulator.yaml#"
+
+        properties:
+          regulator-name:
+            pattern: "^v(fe|bif|io)28$"
+
+      "^ldo_v(aud|io|aux|rf|m)18$":
+        $ref: "regulator.yaml#"
+
+        properties:
+          regulator-name:
+            pattern: "^v(aud|io|aux|rf|m)18$"
+
+      "^ldo_vsim[12]$":
+        $ref: "regulator.yaml#"
+
+        properties:
+          regulator-name:
+            pattern: "^vsim[12]$"
+
+    additionalProperties: false
+
+required:
+  - regulator-name
+
+examples:
+  - |
+    pmic {
+      mt6359regulator {
+        mt6359_vgpu11_buck_reg: buck_vgpu11 {
+          regulator-name = "vgpu11";
+          regulator-min-microvolt = <400000>;
+          regulator-max-microvolt = <1193750>;
+          regulator-enable-ramp-delay = <200>;
+          regulator-always-on;
+          regulator-allowed-modes = <0 1 2>;
+        };
+
+        mt6359_vcamio_ldo_reg: ldo_vcamio {
+          regulator-name = "vcamio";
+          regulator-min-microvolt = <1700000>;
+          regulator-max-microvolt = <1900000>;
+        };
+
+        mt6359_vcn18_ldo_reg: ldo_vcn18 {
+          regulator-name = "vcn18";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+          regulator-enable-ramp-delay = <240>;
+        };
+
+        mt6359_vsram_proc2_ldo_reg: ldo_vsram_proc2 {
+          regulator-name = "vsram_proc2";
+          regulator-min-microvolt = <500000>;
+          regulator-max-microvolt = <1293750>;
+          regulator-ramp-delay = <7500>;
+          regulator-enable-ramp-delay = <240>;
+          regulator-always-on;
+        };
+
+        mt6359_vfe28_ldo_reg: ldo_vfe28 {
+          regulator-name = "vfe28";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <2800000>;
+          regulator-enable-ramp-delay = <120>;
+        };
+
+        mt6359_vaud18_ldo_reg: ldo_vaud18 {
+          regulator-name = "vaud18";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+          regulator-enable-ramp-delay = <240>;
+        };
+
+        mt6359_vsim1_ldo_reg: ldo_vsim1 {
+          regulator-name = "vsim1";
+          regulator-min-microvolt = <1700000>;
+          regulator-max-microvolt = <3100000>;
+          regulator-enable-ramp-delay = <480>;
+        };
+      };
+    };
+...
-- 
2.18.0


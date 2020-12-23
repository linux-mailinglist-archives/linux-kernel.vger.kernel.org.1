Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F8F2E1C20
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 13:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgLWMOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 07:14:35 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:37585 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728302AbgLWMOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 07:14:34 -0500
X-UUID: cc1edd256b324e3c815770a14cf24e87-20201223
X-UUID: cc1edd256b324e3c815770a14cf24e87-20201223
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 351899630; Wed, 23 Dec 2020 20:13:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Dec 2020 20:13:46 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 20:13:45 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <drinkcat@chromium.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3 1/3] dt-bindings: regulator: document binding for MT6315 regulator
Date:   Wed, 23 Dec 2020 20:13:42 +0800
Message-ID: <1608725624-30594-2-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1608725624-30594-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1608725624-30594-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding information for MT6315 regulator driver.
Example bindings for MT6315 are added.

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
---
 .../bindings/regulator/mt6315-regulator.yaml  | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
new file mode 100644
index 000000000000..15ce83a36174
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mtk,mt6315-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT6315 Regulator
+
+maintainers:
+  - Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
+
+description: |
+  The MT6315 is a power management IC (PMIC) configurable with SPMI.
+  that contains 4 BUCKs output which can combine with each other
+  by different efuse settings.
+
+properties:
+  compatible:
+    const: mediatek,mt6315-regulator
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: List of regulators and its properties
+
+    patternProperties:
+      "^vbuck[1-4]$":
+        type: object
+        $ref: "regulator.yaml#"
+
+        properties:
+          regulator-name:
+            pattern: "^vbuck[1-4]$"
+            description:
+              should be "vbuck1", ..., "vbuck4"
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic@6 {
+      compatible = "mediatek,mt6315-regulator";
+      reg = <0x6 0 0xb 1>;
+
+      regulators {
+        vbuck1 {
+          regulator-compatible = "vbuck1";
+          regulator-min-microvolt = <300000>;
+          regulator-max-microvolt = <1193750>;
+          regulator-enable-ramp-delay = <256>;
+          regulator-allowed-modes = <0 1 2 4>;
+        };
+
+        vbuck3 {
+          regulator-compatible = "vbuck3";
+          regulator-min-microvolt = <300000>;
+          regulator-max-microvolt = <1193750>;
+          regulator-enable-ramp-delay = <256>;
+          regulator-allowed-modes = <0 1 2 4>;
+        };
+      };
+    };
-- 
2.18.0


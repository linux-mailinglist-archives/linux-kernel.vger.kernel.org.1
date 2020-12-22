Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B812E0A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgLVNLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:11:16 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33847 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727190AbgLVNLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:11:15 -0500
X-UUID: 98bac8f3bbf546ac9240253253935645-20201222
X-UUID: 98bac8f3bbf546ac9240253253935645-20201222
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 743034350; Tue, 22 Dec 2020 21:09:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Dec 2020 21:09:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Dec 2020 21:09:48 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v6 01/22] dt-bindings: ARM: Mediatek: Add new document bindings of imp i2c wrapper controller
Date:   Tue, 22 Dec 2020 21:09:26 +0800
Message-ID: <1608642587-15634-2-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
References: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the new binding documentation of imp i2c wrapper controller
for Mediatek MT8192.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 .../arm/mediatek/mediatek,imp_iic_wrap.yaml        | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml
new file mode 100644
index 0000000..5d0cf37
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,imp_iic_wrap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek IMP I2C Wrapper Controller
+
+maintainers:
+  - Weiyi Lu <weiyi.lu@mediatek.com>
+
+description:
+  The Mediatek imp i2c wrapper controller provides functional configurations and clocks to the system.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8192-imp_iic_wrap_c
+          - mediatek,mt8192-imp_iic_wrap_e
+          - mediatek,mt8192-imp_iic_wrap_s
+          - mediatek,mt8192-imp_iic_wrap_ws
+          - mediatek,mt8192-imp_iic_wrap_w
+          - mediatek,mt8192-imp_iic_wrap_n
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    imp_iic_wrap_c: syscon@11007000 {
+        compatible = "mediatek,mt8192-imp_iic_wrap_c", "syscon";
+        reg = <0 0x11007000 0 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imp_iic_wrap_e: syscon@11cb1000 {
+        compatible = "mediatek,mt8192-imp_iic_wrap_e", "syscon";
+        reg = <0 0x11cb1000 0 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imp_iic_wrap_s: syscon@11d03000 {
+        compatible = "mediatek,mt8192-imp_iic_wrap_s", "syscon";
+        reg = <0 0x11d03000 0 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imp_iic_wrap_ws: syscon@11d23000 {
+        compatible = "mediatek,mt8192-imp_iic_wrap_ws", "syscon";
+        reg = <0 0x11d23000 0 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imp_iic_wrap_w: syscon@11e01000 {
+        compatible = "mediatek,mt8192-imp_iic_wrap_w", "syscon";
+        reg = <0 0x11e01000 0 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imp_iic_wrap_n: syscon@11f02000 {
+        compatible = "mediatek,mt8192-imp_iic_wrap_n", "syscon";
+        reg = <0 0x11f02000 0 0x1000>;
+        #clock-cells = <1>;
+    };
-- 
1.8.1.1.dirty


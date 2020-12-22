Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2702E0A76
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgLVNMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:12:24 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:56699 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727410AbgLVNMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:12:21 -0500
X-UUID: f4b51d127f3a41bcb74e8b822e026776-20201222
X-UUID: f4b51d127f3a41bcb74e8b822e026776-20201222
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 86103010; Tue, 22 Dec 2020 21:10:14 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Dec 2020 21:09:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Dec 2020 21:09:49 +0800
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
Subject: [PATCH v6 02/22] dt-bindings: ARM: Mediatek: Add new document bindings of mdpsys controller
Date:   Tue, 22 Dec 2020 21:09:27 +0800
Message-ID: <1608642587-15634-3-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
References: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the new binding documentation of mdpsys controller
for Mediatek MT8192.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 .../bindings/arm/mediatek/mediatek,mdpsys.yaml     | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mdpsys.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mdpsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mdpsys.yaml
new file mode 100644
index 0000000..831acdc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mdpsys.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mdpsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MDPSYS Controller
+
+maintainers:
+  - Weiyi Lu <weiyi.lu@mediatek.com>
+
+description:
+  The Mediatek mdpsys controller provides functional configurations and clocks to the system.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8192-mdpsys
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
+    mdpsys: syscon@1f000000 {
+        compatible = "mediatek,mt8192-mdpsys", "syscon";
+        reg = <0 0x1f000000 0 0x1000>;
+        #clock-cells = <1>;
+    };
-- 
1.8.1.1.dirty


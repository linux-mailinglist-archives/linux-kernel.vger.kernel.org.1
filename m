Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFB32F7797
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbhAOLYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:24:23 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35736 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725950AbhAOLYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:24:22 -0500
X-UUID: c3d30975417f4d79b5ea791d7ed5920b-20210115
X-UUID: c3d30975417f4d79b5ea791d7ed5920b-20210115
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 785667229; Fri, 15 Jan 2021 19:23:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 15 Jan 2021 19:23:35 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Jan 2021 19:23:34 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <crystal.guo@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <stanley.chu@mediatek.com>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <fan.chen@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <Yingjoe.Chen@mediatek.com>,
        <s-anna@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <Yidi.Lin@mediatek.com>, <ikjn@chromium.org>
Subject: [v7,1/2] dt-binding: reset-controller: mediatek: add YAML schemas
Date:   Fri, 15 Jan 2021 19:23:30 +0800
Message-ID: <20210115112331.27434-2-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210115112331.27434-1-crystal.guo@mediatek.com>
References: <20210115112331.27434-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a YAML documentation for Mediatek, which uses ti reset-controller
driver directly. The TI reset controller provides a common reset
management, and is suitable for Mediatek SoCs.

Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
---
 .../bindings/reset/mediatek-syscon-reset.yaml | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/mediatek-syscon-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/mediatek-syscon-reset.yaml b/Documentation/devicetree/bindings/reset/mediatek-syscon-reset.yaml
new file mode 100644
index 000000000000..85d241cdb0ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/mediatek-syscon-reset.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/mediatek-syscon-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Reset Controller
+
+maintainers:
+  - Crystal Guo <crystal.guo@mediatek.com>
+
+description:
+  The bindings describe the reset-controller for Mediatek SoCs,
+  which is based on TI reset controller. For more detail, please
+  visit Documentation/devicetree/bindings/reset/ti-syscon-reset.txt.
+
+properties:
+  compatible:
+    const: mediatek,syscon-reset
+
+  '#reset-cells':
+    const: 1
+
+  ti,reset-bits:
+    description: >
+      Contains the reset control register information, please refer to
+      Documentation/devicetree/bindings/reset/ti-syscon-reset.txt.
+
+required:
+  - compatible
+  - '#reset-cells'
+  - ti,reset-bits
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/ti-syscon.h>
+    infracfg: infracfg@10001000 {
+        compatible = "mediatek,mt8192-infracfg", "syscon", "simple-mfd";
+        reg = <0 0x10001000>;
+        #clock-cells = <1>;
+
+        infracfg_rst: reset-controller {
+            compatible = "mediatek,syscon-reset";
+            #reset-cells = <1>;
+            ti,reset-bits = <
+               0x140 15 0x144 15 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
+            >;
+        };
+    };
-- 
2.18.0


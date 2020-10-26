Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1423329947C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788798AbgJZRzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:55:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33836 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788753AbgJZRzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:55:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C53191F44FD3
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, weiyi.lu@mediatek.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 14/16] dt-bindings: power: Add MT8192 power domains
Date:   Mon, 26 Oct 2020 18:55:23 +0100
Message-Id: <20201026175526.2915399-15-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026175526.2915399-1-enric.balletbo@collabora.com>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weiyi Lu <weiyi.lu@mediatek.com>

Add power domains dt-bindings for MT8192.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2: None

 .../power/mediatek,power-controller.yaml      |  2 ++
 include/dt-bindings/power/mt8192-power.h      | 32 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/dt-bindings/power/mt8192-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 7126c3c81570..0318ffb1133c 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -25,6 +25,7 @@ properties:
     enum:
       - mediatek,mt8173-power-controller
       - mediatek,mt8183-power-controller
+      - mediatek,mt8192-power-controller
 
   '#power-domain-cells':
     const: 1
@@ -60,6 +61,7 @@ patternProperties:
           Power domain index. Valid values are defined in:
               "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
               "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
+              "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
         maxItems: 1
 
       clocks:
diff --git a/include/dt-bindings/power/mt8192-power.h b/include/dt-bindings/power/mt8192-power.h
new file mode 100644
index 000000000000..4eaa53d7270a
--- /dev/null
+++ b/include/dt-bindings/power/mt8192-power.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2020 MediaTek Inc.
+ * Author: Weiyi Lu <weiyi.lu@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8192_POWER_H
+#define _DT_BINDINGS_POWER_MT8192_POWER_H
+
+#define MT8192_POWER_DOMAIN_AUDIO	0
+#define MT8192_POWER_DOMAIN_CONN	1
+#define MT8192_POWER_DOMAIN_MFG0	2
+#define MT8192_POWER_DOMAIN_MFG1	3
+#define MT8192_POWER_DOMAIN_MFG2	4
+#define MT8192_POWER_DOMAIN_MFG3	5
+#define MT8192_POWER_DOMAIN_MFG4	6
+#define MT8192_POWER_DOMAIN_MFG5	7
+#define MT8192_POWER_DOMAIN_MFG6	8
+#define MT8192_POWER_DOMAIN_DISP	9
+#define MT8192_POWER_DOMAIN_IPE		10
+#define MT8192_POWER_DOMAIN_ISP		11
+#define MT8192_POWER_DOMAIN_ISP2	12
+#define MT8192_POWER_DOMAIN_MDP		13
+#define MT8192_POWER_DOMAIN_VENC	14
+#define MT8192_POWER_DOMAIN_VDEC	15
+#define MT8192_POWER_DOMAIN_VDEC2	16
+#define MT8192_POWER_DOMAIN_CAM		17
+#define MT8192_POWER_DOMAIN_CAM_RAWA	18
+#define MT8192_POWER_DOMAIN_CAM_RAWB	19
+#define MT8192_POWER_DOMAIN_CAM_RAWC	20
+
+#endif /* _DT_BINDINGS_POWER_MT8192_POWER_H */
-- 
2.28.0


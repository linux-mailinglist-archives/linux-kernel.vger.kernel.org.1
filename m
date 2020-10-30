Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A54A2A045B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgJ3LhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:37:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59034 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgJ3Lgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8446C1F45EBF
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        weiyi.lu@mediatek.com, fparent@baylibre.com,
        Matthias Brugger <mbrugger@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 10/16] dt-bindings: power: Add MT8183 power domains
Date:   Fri, 30 Oct 2020 12:36:16 +0100
Message-Id: <20201030113622.201188-11-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030113622.201188-1-enric.balletbo@collabora.com>
References: <20201030113622.201188-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power domains dt-bindings for MT8183.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 .../power/mediatek,power-controller.yaml      |  2 ++
 include/dt-bindings/power/mt8183-power.h      | 26 +++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 include/dt-bindings/power/mt8183-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 73b8988bd063..8cae43412327 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt8173-power-controller
+      - mediatek,mt8183-power-controller
 
   '#power-domain-cells':
     const: 1
@@ -58,6 +59,7 @@ patternProperties:
         description: |
           Power domain index. Valid values are defined in:
               "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
+              "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
         maxItems: 1
 
       clocks:
diff --git a/include/dt-bindings/power/mt8183-power.h b/include/dt-bindings/power/mt8183-power.h
new file mode 100644
index 000000000000..d1ab387ba8c7
--- /dev/null
+++ b/include/dt-bindings/power/mt8183-power.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Author: Weiyi Lu <weiyi.lu@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8183_POWER_H
+#define _DT_BINDINGS_POWER_MT8183_POWER_H
+
+#define MT8183_POWER_DOMAIN_AUDIO	0
+#define MT8183_POWER_DOMAIN_CONN	1
+#define MT8183_POWER_DOMAIN_MFG_ASYNC	2
+#define MT8183_POWER_DOMAIN_MFG		3
+#define MT8183_POWER_DOMAIN_MFG_CORE0	4
+#define MT8183_POWER_DOMAIN_MFG_CORE1	5
+#define MT8183_POWER_DOMAIN_MFG_2D	6
+#define MT8183_POWER_DOMAIN_DISP	7
+#define MT8183_POWER_DOMAIN_CAM		8
+#define MT8183_POWER_DOMAIN_ISP		9
+#define MT8183_POWER_DOMAIN_VDEC	10
+#define MT8183_POWER_DOMAIN_VENC	11
+#define MT8183_POWER_DOMAIN_VPU_TOP	12
+#define MT8183_POWER_DOMAIN_VPU_CORE0	13
+#define MT8183_POWER_DOMAIN_VPU_CORE1	14
+
+#endif /* _DT_BINDINGS_POWER_MT8183_POWER_H */
-- 
2.28.0


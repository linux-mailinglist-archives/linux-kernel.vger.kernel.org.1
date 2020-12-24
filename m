Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3572E2408
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 04:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgLXDUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 22:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgLXDUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 22:20:49 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DAAC061282
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 19:19:56 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g15so775726pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 19:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bY2URhtHpp2ViDApeX+WMIac4xic2Nz10mLXPafWH1I=;
        b=fHyv89jHI3dvjcUjJ5lDVSRFWiq7bg4lXHOZaHco8FGPSzoysvYMsH5QN46IE07wN6
         N1VBz6eO1Z88HabORkNJIAk9uC4BrVvoRvWsb/U+63cEU6c2Q/cKcxKDba//TwXhsZ6c
         RMhfriyb8HXJSZcCJsBrIUo4FZjrsvdIjcuRSWBkCaozQdwJ12I8bswaW+9ZjUzVu/vN
         yGppvjevALg4k/zpy5VLsGqgz3p5vbmAYeNOimNbVFQRBe7JdLIRVwWW2hRLyhK3jPfs
         phURXB7SZtpfgLz4C0AdnGL/kf00r2Jx0WNjNXJ2AG8iujqx/fNGTrlRk/iRX9CpcVrM
         ZdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bY2URhtHpp2ViDApeX+WMIac4xic2Nz10mLXPafWH1I=;
        b=eVD3/MM50736i17pRFxD2l1Vb+bXhDNPtyxyvbI/leEHtKgalTPz1UuaanRxwIDYG7
         EL8NaYU7J7/Tke/didIQzOCh/3mO6iOwzC9kvW+QSFiGW+H3uCorcYFlyrjDxczNeq5d
         5Lfw37S1z9VZ8V7jBUhUYe6bPtbepOyF6h+iYsQUatplvKrYpG0DcPyKZGynRc97VaHx
         YvFqRsBgiYvENLObSml3u0nwOiEa6KMDW+1hjlYiXFqKaMfJbXmZMKXlVLW6cB7iJMOG
         5mcY+UUT8G+X8vH4gb8Rwx6/PlcyoqwLuNRpFNro2pMWaXBq+Ko8x0srpeJg8lI63GZM
         PS2A==
X-Gm-Message-State: AOAM530KyjJq2IfLDZxxHHG8W/p8Zj+Irj+iKdxuV/CKavPVzcWP8KaE
        mgTwS6r1+eedlSMeEmj/kxw=
X-Google-Smtp-Source: ABdhPJzOHu37HvEexERhFvYlu0dNsAb8MQw+8bVf1KJVfFh+HzHPTgXC/j3Bixig7v1Mb5gHdfYpsw==
X-Received: by 2002:a63:480f:: with SMTP id v15mr13457906pga.341.1608779995916;
        Wed, 23 Dec 2020 19:19:55 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:492:86cf:7e4a:b265:b394:eefd])
        by smtp.gmail.com with ESMTPSA id b19sm23842540pfo.24.2020.12.23.19.19.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Dec 2020 19:19:55 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH resend] dt-bindings: mfd: mediatek: Add bindings for MT6360 PMIC
Date:   Thu, 24 Dec 2020 11:19:49 +0800
Message-Id: <1608779989-9641-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add bindings for MT6360 PMIC

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 Documentation/devicetree/bindings/mfd/mt6360.yaml | 69 +++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.yaml

diff --git a/Documentation/devicetree/bindings/mfd/mt6360.yaml b/Documentation/devicetree/bindings/mfd/mt6360.yaml
new file mode 100644
index 0000000..2781c31
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mt6360.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/mt6360.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MT6360 PMIC from MediaTek Integrated
+
+maintainers:
+  - Gene Chen <gene_chen@richtek.com>
+
+description: |
+  MT6360 is a PMIC device with the following sub modules.
+  It is interfaced to host controller using I2C interface.
+
+  This document describes the binding for PMIC device and its sub module.
+
+properties:
+  compatible:
+    const: mediatek,mt6360
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+      enum:
+        - IRQB
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+    description:
+      The first cell is the IRQ number.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mt6360@34 {
+            compatible = "mediatek,mt6360";
+            reg = <0x34>;
+            wakeup-source;
+            interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-names = "IRQB";
+            interrupt-controller;
+            #interrupt-cells = <1>;
+        };
+    };
-- 
2.7.4


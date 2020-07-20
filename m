Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465C9226302
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 17:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgGTPMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 11:12:02 -0400
Received: from out28-197.mail.aliyun.com ([115.124.28.197]:54946 "EHLO
        out28-197.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgGTPMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:12:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1251932|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0245558-0.00059272-0.974851;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03294;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.I4tlHnB_1595257890;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I4tlHnB_1595257890)
          by smtp.aliyun-inc.com(10.147.41.143);
          Mon, 20 Jul 2020 23:11:45 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     daniel.lezcano@linaro.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v9 1/2] dt-bindings: timer: Add Ingenic X1000 OST bindings.
Date:   Mon, 20 Jul 2020 23:11:05 +0800
Message-Id: <20200720151106.112807-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200720151106.112807-1-zhouyanjie@wanyeetech.com>
References: <20200720151106.112807-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the OST bindings for the X10000 SoC from Ingenic.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v1->v2:
    No change.
    
    v2->v3:
    Fix wrong parameters in "clocks".
    
    v3->v4:
    1.Rename "ingenic,ost.yaml" to "ingenic,sysost.yaml".
    2.Rename "ingenic,ost.h" to "ingenic,sysost.h".
    3.Modify the description in "ingenic,sysost.yaml".
    
    v4->v5:
    No change.
    
    v5->v6:
    1.Drop "oneOf" and the blank line.
    2.Add "additionalProperties: false".
    
    v6->v7:
    No change.
    
    v7->v8:
    No change.
    
    v8->v9:
    Fix warning while applying.
    Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>

 .../devicetree/bindings/timer/ingenic,sysost.yaml  | 63 ++++++++++++++++++++++
 include/dt-bindings/clock/ingenic,sysost.h         | 12 +++++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
 create mode 100644 include/dt-bindings/clock/ingenic,sysost.h

diff --git a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
new file mode 100644
index 000000000000..324ea2979e42
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/ingenic,sysost.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for SYSOST in Ingenic XBurst family SoCs
+
+maintainers:
+  - 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
+
+description:
+  The SYSOST in an Ingenic SoC provides one 64bit timer for clocksource
+  and one or more 32bit timers for clockevent.
+
+properties:
+  "#size-cells":
+    const: 1
+
+  compatible:
+    enum:
+      - ingenic,x1000-ost
+      - ingenic,x2000-ost
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ost
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - "#clock-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/x1000-cgu.h>
+
+    ost: timer@12000000 {
+            compatible = "ingenic,x1000-ost";
+            reg = <0x12000000 0x3c>;
+
+            #clock-cells = <1>;
+
+            clocks = <&cgu X1000_CLK_OST>;
+            clock-names = "ost";
+
+            interrupt-parent = <&cpuintc>;
+            interrupts = <3>;
+        };
+...
diff --git a/include/dt-bindings/clock/ingenic,sysost.h b/include/dt-bindings/clock/ingenic,sysost.h
new file mode 100644
index 000000000000..9ac88e90babf
--- /dev/null
+++ b/include/dt-bindings/clock/ingenic,sysost.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides clock numbers for the ingenic,tcu DT binding.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_INGENIC_OST_H__
+#define __DT_BINDINGS_CLOCK_INGENIC_OST_H__
+
+#define OST_CLK_PERCPU_TIMER	0
+#define OST_CLK_GLOBAL_TIMER	1
+
+#endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
-- 
2.11.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4FA2B3DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgKPHtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgKPHtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:49:21 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42953C0613CF;
        Sun, 15 Nov 2020 23:49:21 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id l10so19025494lji.4;
        Sun, 15 Nov 2020 23:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uEgau9nQGqNz6ZXzmaV6+j0vQE+uEXLhXRKT84vgtQc=;
        b=Kpe5fNjJXV2Wqnfrv9u8SvBB7SUE4WTvuVm1KvNqrPw5R17cokq048j0mkndTBNXl/
         zZ0gk9JbVnN4IBBW+7NdaAYVdzGk1qxlUhQ97iFUolKJpPhc4MyKJPowPccp6DMKpnxu
         zS/T79HkmoJ5VOxk3MkV6O+h8677Z3Txt+uwjsEvnOYELmi69f3YBYzVmd6V0t8UZwhL
         ij6ZYiIxHbx0QyWLmWFuZ+0TgRAFOWZZxFedgJlTMpv9EGKS8pI1YzWgMvJ2zIAaHUD3
         /ZaWyOF0xcKFYIH8km31JuL4RMGEWEhqJcxNgXr1vmAenk/6p7ZL0aPdTnUlP6OcMFO2
         bjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEgau9nQGqNz6ZXzmaV6+j0vQE+uEXLhXRKT84vgtQc=;
        b=ea07HPk3lqyxGleYxqqhlfB5eZhOH6Y3hN1HrQkXEZBqoI9sktcJKqaRWyJ+r4/hJ9
         Yn7QS5xtX5S6Mm3Ac3JTgHE7o3R+HMc7L6N7mfMCAYp5VEp9JpCHaCvRvTcPG6mrKnaq
         JG5sQFabt/DXFlB2wEGna0Eziv0joi/vAKHovlSox1SASPWNJGodD8c9cePlz7VvBu8c
         RIw7vkEVyX3Q5C+DdKg4gwKwprccFEb34Fu3mehFA9Q7Kt1kpzNPtrZKil6EKYMEH5rN
         hKva8Nmn3GVmcnfPgCOB6snCluDmDZP4MGdgxTQxpz1xBzSmsgSYky4uYjrMRo5zmper
         xvMA==
X-Gm-Message-State: AOAM530VzFcs45S60gKN1GTcRAdgjfVxOCDzOHF0/qU8YYcRB4O5bNH5
        qPfrQUJPzgTAGv80zgLvt2Q=
X-Google-Smtp-Source: ABdhPJzG+C1YH7nheYHlhFRBT1UeMKElffaRKwR5CB6IEVJB1CSp9+npeBYzfdoAmYiCIpQmaMrdyg==
X-Received: by 2002:a2e:2a86:: with SMTP id q128mr5679600ljq.158.1605512959779;
        Sun, 15 Nov 2020 23:49:19 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id v20sm2612441ljh.19.2020.11.15.23.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 23:49:19 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: phy: bcm-ns-usb2-phy: convert to yaml
Date:   Mon, 16 Nov 2020 08:46:50 +0100
Message-Id: <20201116074650.16070-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201116074650.16070-1-zajec5@gmail.com>
References: <20201116074650.16070-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

1. Convert from txt to yaml
2. Drop "Driver for" from the title
3. Document "#phy-cells"
4. Fix example node name (noticed by dt_binding_check)
5. Add #include to example (noticed by dt_binding_check)
6. Specify license

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
I think this should go through linux-phy tree. Kishon, Vinod, can you
take this patch?

This patch generates a false positive checkpatch.pl warning [0].
Please ignore:
WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

[0] https://lkml.org/lkml/2020/2/18/1084
---
 .../bindings/phy/bcm-ns-usb2-phy.txt          | 21 -------
 .../bindings/phy/bcm-ns-usb2-phy.yaml         | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt b/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
deleted file mode 100644
index a7aee9ea8926..000000000000
--- a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Driver for Broadcom Northstar USB 2.0 PHY
-
-Required properties:
-- compatible: brcm,ns-usb2-phy
-- reg: iomem address range of DMU (Device Management Unit)
-- reg-names: "dmu", the only needed & supported reg right now
-- clocks: USB PHY reference clock
-- clock-names: "phy-ref-clk", the only needed & supported clock right now
-
-To initialize USB 2.0 PHY driver needs to setup PLL correctly. To do this it
-requires passing phandle to the USB PHY reference clock.
-
-Example:
-	usb2-phy {
-		compatible = "brcm,ns-usb2-phy";
-		reg = <0x1800c000 0x1000>;
-		reg-names = "dmu";
-		#phy-cells = <0>;
-		clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
-		clock-names = "phy-ref-clk";
-	};
diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.yaml
new file mode 100644
index 000000000000..05b4dcd80019
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/bcm-ns-usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Northstar USB 2.0 PHY
+
+description: >
+  To initialize USB 2.0 PHY driver needs to setup PLL correctly.
+  To do this it requires passing phandle to the USB PHY reference clock.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  compatible:
+    const: brcm,ns-usb2-phy
+
+  reg:
+    items:
+      - description: iomem address range of DMU (Device Management Unit)
+
+  reg-names:
+    items:
+      - const: dmu
+
+  clocks:
+    items:
+      - description: USB PHY reference clock
+
+  clock-names:
+    items:
+      - const: phy-ref-clk
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/bcm-nsp.h>
+    phy@1800c000 {
+        compatible = "brcm,ns-usb2-phy";
+        reg = <0x1800c000 0x1000>;
+        reg-names = "dmu";
+        clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
+        clock-names = "phy-ref-clk";
+        #phy-cells = <0>;
+    };
-- 
2.27.0


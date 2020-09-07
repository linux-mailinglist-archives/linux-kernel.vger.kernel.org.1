Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754A825F3F1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 09:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgIGH13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 03:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgIGH1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:27:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9ADC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 00:27:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e16so14639218wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 00:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2TPEKZsBaI5ym5zLNPRbwhJVAOFuQ97b5/eUYr0rYDc=;
        b=dfAa5ahKol3nYX5fP99OQv9g8cZuwSDzK9qnmdGDEs4UhWg2EsuzIEILHEyi+3HSU5
         vi0F4k+v6dRExbfz+uRjrnhu2hEkiKEyx58bIMKaUtqz+deWPXWsTlv2taoQnkeSTxrh
         lsfg5NqerMjlWhdaoFeZcPCre1Pyt+jfIFyQY6mgxOi+QrAxD9t7dU6rGl+Bsq0M/k5H
         ChNOh7CEbRBycnHqZkRiWFse28/jViwxWz+F2fQNSiPiqkk2WAxD6WUPEnKunP00eIa3
         KCyKDThMrrS5Zg8iQO21hVuzk5/mqZ1TpGjzPDwQ4IJ4f6K5coQY+mQomK+pjfLbGC8O
         q8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2TPEKZsBaI5ym5zLNPRbwhJVAOFuQ97b5/eUYr0rYDc=;
        b=B7MEHkuA1/ILcH2UoKR6aZelVcrvKKTemQHrFmaSw/Y9/X0lr8X4pEGVB2uXTzdYGV
         XN1Zu0R+HlOf81/InAhGWUg6OW0Wx7VoDHx0v2ILsFSkUGJX494WiWi52iwop1PZX8Dt
         qxMbecZuvvi2voXOMKEKQJyMDuQ4ZtevuRApQeRKxO67nNIcvFG6YEQETLkpvCqJZVLp
         NToSjKNizXGMoyd/Y8bojCfX3IYIryi4Gma8a1Epc1XggMY7LDQNNr4VJS9a0/Xxyxo2
         Ypav4YXZhFnfixD8mut8yIKDdwehMdFHHh/hvhXd9UZB/UVrYLUGHqpOpOXJRVAzjI8q
         dVmg==
X-Gm-Message-State: AOAM531GJHTR6sJIq11bL4xnqrRSk00pvO8JpjEBCczesufCgnc8g2iE
        uQ0e2dCwQxTGzz/B4O6y5JzuPQ==
X-Google-Smtp-Source: ABdhPJzENjeeo6XRiHnOARoz14tPkStdsIiGG1vknGWVVW2afjDs6Ovn3bt++gumxHsXNXnA7IHj3Q==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr20929383wrp.187.1599463636463;
        Mon, 07 Sep 2020 00:27:16 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id x16sm25560500wrq.62.2020.09.07.00.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 00:27:15 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: phy: add Amlogic AXG MIPI D-PHY bindings
Date:   Mon,  7 Sep 2020 09:27:07 +0200
Message-Id: <20200907072708.26043-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200907072708.26043-1-narmstrong@baylibre.com>
References: <20200907072708.26043-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXg SoCs embeds a MIPI D-PHY to communicate with DSI
panels, this adds the bindings.

This D-PHY depends on a separate analog PHY.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/phy/amlogic,axg-mipi-dphy.yaml   | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml
new file mode 100644
index 000000000000..f7ae1135288b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 BayLibre, SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/amlogic,axg-mipi-dphy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic AXG MIPI D-PHY
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+properties:
+  compatible:
+    enum:
+      - amlogic,axg-mipi-dphy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pclk
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: phy
+
+  "#phy-cells":
+    const: 0
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: analog
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - phys
+  - phy-names
+  - "#phy-cells"
+
+examples:
+  - |
+    phy@ff640000 {
+            compatible = "amlogic,axg-mipi-dphy";
+            reg = <0xff640000 0x100>;
+            clocks = <&clk_mipi_dsi_phy>;
+            clock-names = "pclk";
+            resets = <&reset_phy>;
+            reset-names = "phy";
+            phys = <&mipi_pcie_analog_dphy>;
+            phy-names = "analog";
+            #phy-cells = <0>;
+    };
-- 
2.22.0


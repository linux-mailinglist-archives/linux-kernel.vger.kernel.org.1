Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A202B408C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgKPKNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgKPKNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:13:22 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B73C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:13:21 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d12so17994717wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+jktKSyt59M1RlyoUXQDUiIneqQcY7EbqJCiazlG1Y=;
        b=i5E0jmsmNyqdoUSm84mjuIsvNHBhir03FpDaC3SMoi9kLZUyAn5LtMejHw4iI2aD/C
         kJkp37MNw6Il00+yD+5jr2D4No4GLU3VRbioOxxFlTNsT7y39QsT7tJ7Jz1aauH5VO+B
         jizfQ79qJlsFiS+JhJiAZ+v0f5WBBOe74o045qBHQglWGuVPNGYGqHTVwSRZtWSFSWrk
         GWfka0JgYa1hBg5Vf5CKdxFhWg0KB3NPBM6AOmOd+rcGPJz0W8LIv/UCPV/vnf9NILzV
         WxpW5iWo0UTjYl5UbLc2gctXbyI+lYc7yeTcnzQxvm1tgO0KuRcaTrA3+HRwghvmYpzw
         pa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+jktKSyt59M1RlyoUXQDUiIneqQcY7EbqJCiazlG1Y=;
        b=aYjWPBrVJivq6fUvX32SJwjJS2B81c0Me/MI8OURkZj0HdoWSc5gQKjBjspd+ES8vF
         VwxnrEuxa4Vb7hvJWkG/oA7TCjYLtvkqTAbywL593yKY9FNlQVmv8vF7I1F4kFh2UQZT
         Z+T8PlMBuCgt/reTbwHPvOZz7jpAW9qA8krFDFvb3hn7rVMeU+knuLpnjOdUhdgSx21/
         aKCiHxqGrWgvI3bBWZVBBw9WTHTx9xPuJMCTgj0KOXm0Ys434KP4m+rApp+/a8D/KkRv
         +Bwq549rnsyd337F5hUNqM/SUOktJA6HmrrporA8hnDy6SpxyMjCJ/YMxzynYlHL0GcP
         /GeA==
X-Gm-Message-State: AOAM5302mdA1WIWhXSlRl/qpi0ulZ6XCOebuZL923CLfkxUpm1yaR++d
        /LVsvswIjb28kPTdk09QpeOxJ503iHKweLX8
X-Google-Smtp-Source: ABdhPJzzawClAU+KtOLWRR/v6L2Sy0PuBtshrLlL9wKHSAIMeuqAUnlakL7MgC7U+8MHRcgIcEiPrQ==
X-Received: by 2002:adf:9407:: with SMTP id 7mr19583282wrq.182.1605521600399;
        Mon, 16 Nov 2020 02:13:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:edb9:72a:9e35:6eb])
        by smtp.gmail.com with ESMTPSA id g66sm19082228wmg.37.2020.11.16.02.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:13:19 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     devicetree@vger.kernel.org, kishon@ti.com, vkoul@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v3 1/2] dt-bindings: phy: add Amlogic AXG MIPI D-PHY bindings
Date:   Mon, 16 Nov 2020 11:13:14 +0100
Message-Id: <20201116101315.71720-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116101315.71720-1-narmstrong@baylibre.com>
References: <20201116101315.71720-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXg SoCs embeds a MIPI D-PHY to communicate with DSI
panels, this adds the bindings.

This D-PHY depends on a separate analog PHY.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/amlogic,axg-mipi-dphy.yaml   | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml
new file mode 100644
index 000000000000..be485f500887
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml
@@ -0,0 +1,70 @@
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
+additionalProperties: false
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
2.25.1


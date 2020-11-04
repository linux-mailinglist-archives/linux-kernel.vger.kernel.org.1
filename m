Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4482A657F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 14:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgKDNrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 08:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729847AbgKDNri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 08:47:38 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332BAC061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 05:47:37 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w14so22073021wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 05:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+jktKSyt59M1RlyoUXQDUiIneqQcY7EbqJCiazlG1Y=;
        b=jSLbyaxPZKd2BfEHQR+i4qkHFQUDYYmpFXx9Tdpbb6vvPC8oadefWz+kr1x3IG/Sol
         buywHZChF4DsZQBoxnVS/DQevkehD78cB4ATtgFrnTxucRvG6Blre6vq3Qm59B3+TR13
         kAm37d9G9T2frIkEP0MnEo7NnyDMDBIz+N1KeaZon53e/bcE1yL/ZQPBuDlpA9W7uxxB
         u6XNTSAr/zs1Hj84MneZSTDYs18M5AQZD7yKIl1s1WBeWymzqxV9PZgY01Q0IPdldRKf
         8/UIeV+H9Qb1XCs7yln5l1elr9mWLJdG8sGKenoA5MD5hSarooBJqbpZOQctZoNpkyfh
         yiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+jktKSyt59M1RlyoUXQDUiIneqQcY7EbqJCiazlG1Y=;
        b=Q3OGNGpnqWsadC0YTqc3BX0+rah8FEtVR6HAOndgSfFLJ0LXIFedcKc64zJqvds0FY
         oN5ChMzkNKlV9gs3Q2HTBJ8LXwUqVjcs9FZMjcduVSY4pDIUgAAoP54Uj1rW90ALTDq0
         HFQGDPEW/5LM19k7FRh72moANjS4p7/o1x9PrzAMs/uRKLvQ9+3rVy3dApZXLdJGYbBH
         wUAMQ7EH/5UcLifInKMkQIUrA1eb3B0rsghtmo4EJakdkG8yh7S95cFdoIGWqQsanS3z
         3L+9o/h13H1x7xIOShgh4kmEyK94C2zq/J81LQL+93epajV0ALldDI55z13nt/ccef2J
         oQSg==
X-Gm-Message-State: AOAM533Z936mgoI/VtIlYfSdlVj4GuDa5cEN7NGOh5IfoCfOZSbX/pFE
        IcbFqRpP341b2GoMbrwahFg5ag==
X-Google-Smtp-Source: ABdhPJyBiSSrZ7n/5ZV3G5rqUJ4D+BkannbQm+zSCpWf0KcWLXfH8q7e/EMH258OINRXL5jKjXL9dw==
X-Received: by 2002:adf:8562:: with SMTP id 89mr31867445wrh.214.1604497655706;
        Wed, 04 Nov 2020 05:47:35 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:3d8d:fb08:21c9:faa3])
        by smtp.gmail.com with ESMTPSA id 30sm2759586wrs.84.2020.11.04.05.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 05:47:34 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     devicetree@vger.kernel.org, kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: phy: add Amlogic AXG MIPI D-PHY bindings
Date:   Wed,  4 Nov 2020 14:47:29 +0100
Message-Id: <20201104134730.1545875-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104134730.1545875-1-narmstrong@baylibre.com>
References: <20201104134730.1545875-1-narmstrong@baylibre.com>
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


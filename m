Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB7B2A2105
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 20:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgKATVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 14:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgKATVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 14:21:03 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CF6C0617A6;
        Sun,  1 Nov 2020 11:21:02 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A459A22EDE;
        Sun,  1 Nov 2020 20:21:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604258461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3n0cJafRCuIGYxeV0d81yy0bf0nRitVwt0wrJfHCqRQ=;
        b=phzNahdj4fzCf/kvn/UuDdzK0OiYvr6UBbX4Pe48kfka05+iwfk8H6Rw19L1jhUF4ICDLZ
        Sr3mRQyBp/lb6pMAarsmG7e6G/HtsfEzJxOPPRURirngrlmR6E7V0qpzvIkIwMqtGf8ovy
        2y0evgmrIZiY8s6H88tZgMcyYJflDpg=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/4] dt-bindings: clock: document the fsl-flexspi-clk driver
Date:   Sun,  1 Nov 2020 20:20:50 +0100
Message-Id: <20201101192053.18644-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../bindings/clock/fsl,flexspi-clock.yaml     | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,flexspi-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,flexspi-clock.yaml b/Documentation/devicetree/bindings/clock/fsl,flexspi-clock.yaml
new file mode 100644
index 000000000000..1fa390ee7b9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,flexspi-clock.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,flexspi-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale FlexSPI clock driver for Layerscape SoCs
+
+maintainers:
+  - Michael Walle <michael@walle.cc>
+
+description:
+  The Freescale Layerscape SoCs have a special FlexSPI clock which is
+  derived from the platform PLL.
+
+properties:
+  compatible:
+    enum:
+      - fsl,ls1028a-flexspi-clk
+      - fsl,lx2160a-flexspi-clk
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    dcfg {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        fspi_clk: clock-controller@900 {
+            compatible = "fsl,ls1028a-flexspi-clk";
+            reg = <0x900 0x4>;
+            #clock-cells = <0>;
+            clocks = <&parentclk>;
+            clock-output-names = "fspi_clk";
+        };
+    };
-- 
2.20.1


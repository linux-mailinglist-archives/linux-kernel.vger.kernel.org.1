Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABD22A8760
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbgKETfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbgKETfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:35:24 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD0CC0613CF;
        Thu,  5 Nov 2020 11:35:24 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B0E5A23078;
        Thu,  5 Nov 2020 20:35:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604604920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kZmt24h7VqqkzcCxLkXiBSq6HI3bCDHlBnRkD++EPNo=;
        b=l9jTC+s/SBDVPY/BxlcmW4tdYruZEjX9PmZr+dzTxAF/ZmFyfHJzEmVYUOFJAntvbhirOc
        l6I+4Lhvr1iuEYvJIemYdveg9mEm44zm02L3bLaMc5FRCY6E7DOZEzKspNpKe1kiDC1Eut
        abYaCk20QDaIm1J0YKOBWbN67J6jsDM=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/5] dt-bindings: clock: document the fsl-flexspi-clk driver
Date:   Thu,  5 Nov 2020 20:35:09 +0100
Message-Id: <20201105193512.22388-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105193512.22388-1-michael@walle.cc>
References: <20201105193512.22388-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since v1:
 - none

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


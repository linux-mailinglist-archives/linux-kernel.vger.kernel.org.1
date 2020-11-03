Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341472A410B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgKCKAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:00:31 -0500
Received: from smtp2.axis.com ([195.60.68.18]:17889 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgKCKA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1486; q=dns/txt; s=axis-central1;
  t=1604397629; x=1635933629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T27dQA59Sfl70Uu8/TBv9UNuLJQSsRsmmD17RsXzYLw=;
  b=eziz81DSsuhN3qSemdiCEIeaQpFqURw3o//iHa9b0fTDEWSJoYqNd6u+
   wz3lkCu6/yJIDhvnsthMDx7vNgKm3t1w6MkOUCosu/6B/O5cYZvDpQ5qj
   3Qda+fA9e00gkz0CMBoAtkjs/1DAP/d7w4V3o4WEuhFvrMA+0fe7JSi2p
   pL16/3wcBhjbgJHTCJLQOfQboWc26ffUzG5FGHZARB5eLYsa2ot0HoLSH
   gu3/LJ2veml/RRgZCmx7KELJ8yPxEojQ1I+kN/F/wVzN6bs39Sgzl7Bog
   Z+OO3NrXs6vM7s4seA4pwRvSehNRBVm1NMAFwWxGpFCI9xwCdFhzOpLPe
   g==;
IronPort-SDR: eycs8D35KG0/cSh3ZPt4wZZkFpwTzOhIg2vBRDd+/kuriEsf+oem/IxsLIV3hwGSIXXGuxKpyC
 yOa1gtG0XVppzbfg9m9VuHs83kokBBd9vdB0iNBni3PqvTEsc4XbqEGhVevLaOQ3TOQdPUq2IQ
 wkKFDJKhpXEvVyt2x+yeH2fkfiO/1Sl8h1tqtyptEqViR3Q0W6zZeWnQfI43bO5CZj5gDkjffz
 OrdB8uqzCPpeTCiKuQaEzJHtO52lxR05I5TVA/92/22XwstEFfzPCJCvQttLsj/Vqnbrw5x2d4
 MTI=
X-IronPort-AV: E=Sophos;i="5.77,447,1596492000"; 
   d="scan'208";a="14164799"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <support.opensource@diasemi.com>
CC:     <kernel@axis.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 1/2] dt-bindings: regulator: Add DA9121
Date:   Tue, 3 Nov 2020 11:00:20 +0100
Message-ID: <20201103100021.19603-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103100021.19603-1-vincent.whitchurch@axis.com>
References: <20201103100021.19603-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Dialog Semiconductor DA9121 voltage regulator.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 .../bindings/regulator/dlg,da9121.yaml        | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/dlg,da9121.yaml

diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
new file mode 100644
index 000000000000..cde0d82dd201
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/dlg,da9121.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog Semiconductor DA9121 voltage regulator
+
+maintainers:
+  - Vincent Whitchurch <vincent.whitchurch@axis.com>
+
+properties:
+  compatible:
+    const: dlg,da9121
+
+  reg:
+    maxItems: 1
+
+  buck1:
+    description:
+      Initial data for the Buck1 regulator.
+    $ref: "regulator.yaml#"
+    type: object
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      regulator@68 {
+        compatible = "dlg,da9121";
+        reg = <0x68>;
+
+        buck1 {
+          regulator-min-microvolt = <680000>;
+          regulator-max-microvolt = <820000>;
+        };
+      };
+    };
+
+...
-- 
2.28.0


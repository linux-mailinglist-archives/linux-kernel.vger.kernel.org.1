Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930E92CEA62
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgLDJAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:00:52 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41999 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgLDJAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607072463; x=1638608463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=juXAMaoC0LaiudGimn3JVw/cJS6l1iw8NO9uF2NFJUs=;
  b=cT2sSk7YVYMALUY2/g81jw0W7uDDuM6rQVutcX4ZvZNMx9ShCVwOEeRj
   QpZGNPSoeqfaw8fwS4KTz5+Bu81JEwKbYlg+rZfMrj8qzguouSL2/otIm
   YnrdyOSAF1tnrJBGBrnefCpw+EZqqq+OhFL3AvQWYGijbaO4Ts/IlPX44
   yi9IDhBKIV9sMInDry7vW3pT6jQPc+tFI57YqPzZzD4aizEb9WkOPAbHX
   Z0Tw+3XwqqTa4nojiYzwgUlWo2g++mjIHOxop3I+w3S8mdHYszLDGXMd5
   XjB4RlFqZH/cMaJyvjwog686c+VWHUJIY796J4wNpLjcMQzq6tgKfzmme
   Q==;
IronPort-SDR: vyvcLQU0v2j+psJS2jevqIh/gyTFW3yayo2l97RIycAg5TcHB5tefEwAe8r+leyJRLGaWC0biv
 4ME7/vBTCIc7Pzt8WXH2qzEJcGfWlLruHOcFm62/O6QWw/TLzymPXlhdqfvniAdgLMd7TeK9wy
 AEt31ZkMbUHzqRaTWKoi9HaGQnDlSfY/YnECapIbXmI4Mr07bWpTDbpXWB7pgQ/SMKEqHx/jqI
 3XtPP6PpwTiRGs0Y1z19i9Hgf5ZDF1BBKhQYtTf84xP86pmArePFXSiBoBQ354x/975uzNJOSu
 fis=
X-IronPort-AV: E=Sophos;i="5.78,392,1599494400"; 
   d="scan'208";a="258129846"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 17:18:04 +0800
IronPort-SDR: v7W+SoRZdUz7FyfFqyYKmPMJk7j7xAz13mRerbhkdS2gn0APiO8dBU+a6o9dRHeVuEoS0n54Og
 +pWZzCgLUWaf7Fl/JNO9cArjjzq6U6d5A=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 00:44:12 -0800
IronPort-SDR: 8+0WEGg+RGWJLmk6pntYWJW4OHU6PJa0AI68Dwjs2t23s7srBgV2EXcnLi5wtAGR+N5j6xBtoK
 o8yaK7wQpvFA==
WDCIronportException: Internal
Received: from cnf010505.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.200])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2020 00:58:39 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Bin Meng <bin.meng@windriver.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Ivan.Griffin@microchip.com,
        Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor.Dooley@microchip.com
Subject: [PATCH v3 2/5] dt-bindings: riscv: microchip: Add YAML documentation for the PolarFire SoC
Date:   Fri,  4 Dec 2020 00:58:32 -0800
Message-Id: <20201204085835.2406541-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204085835.2406541-1-atish.patra@wdc.com>
References: <20201204085835.2406541-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML DT binding documentation for the Microchip PolarFire SoC.
It is documented at:

https://www.microsemi.com/products/fpga-soc/polarfire-soc-icicle-quick-start-guide

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 .../devicetree/bindings/riscv/microchip.yaml  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/microchip.yaml

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
new file mode 100644
index 000000000000..66e63c2bf359
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/microchip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PolarFire SoC-based boards device tree bindings
+
+maintainers:
+  - Cyril Jean <Cyril.Jean@microchip.com>
+  - Lewis Hanly <lewis.hanly@microchip.com>
+
+description:
+  Microchip PolarFire SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - microchip,mpfs-icicle-kit
+      - const: microchip,polarfire-soc
+      - const: microchip,mpfs
+
+additionalProperties: true
+
+...
-- 
2.25.1


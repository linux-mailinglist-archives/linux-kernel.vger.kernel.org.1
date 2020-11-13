Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9382B2560
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgKMU03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:26:29 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43164 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKMU0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605299173; x=1636835173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4onK1rRbS8jJSGpeiRqURxgT+ayGvncdcCs3sC7rsKc=;
  b=Wyj1KjUTgLyGUUpJAHdFPu3HPCSA2WZaeVaKqq6WiliZ3uaoj3Sx0Btg
   46YlQm4GFXTvJGaA0JMfiQOnyAPubgvJlQzSHxwFaQ7q304jjMs4cn3B0
   ei79q/LiH6f26MTmwNB+LnLdZrSrl85Q7QkoFzH1CMSxfO1ZUBf5Ilg8g
   EAhcMvv1vFYZWPDbEEWXbtHwBAiG1r6qnd4JhJfYrKZM6cCKQaj4KCH//
   pqz2MguUFIPHntv7ZCVvsGhpmcnfOsvAwdSma4OacjKEk7Be6clhekZSV
   AdvwX3USYVCIUBZy22GvUdyEkqzRFLZaJl4a2Wfuj9kSCKOk5NC3M3DzN
   g==;
IronPort-SDR: g5QKIcLsjPVg1zemHN75EQ/d467GRq0VFtfTEzHUMtp/HOCEpzs+Qnm6r1ApQtd2s7sMkynhDX
 i+UEgEDWI1W3fQX/5RgO1vD86bJeWdW5gSOYGDV1bEp96UPigXoszIdQdxPA4swviXlV3/EhSO
 Gf3s6sV9cUR8DpDbiKVQeUVxX61hEttfvhyJYG746jniLHecnekApRhbdKVrFdTH/EKZ9E8Cvn
 mpQE5JK71rNWNUgmDq7nIhPWcczafmJng83dF58aRk6MI5Lp3j9q1sSo/G93Y7/DrONO8qMxqg
 X0Y=
X-IronPort-AV: E=Sophos;i="5.77,476,1596470400"; 
   d="scan'208";a="157074939"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2020 04:26:12 +0800
IronPort-SDR: 0xb7ORN727+QlXTY2uON/A5aCu2N0Rbzzxuc4yoDKM76jZr8MK7edP3X9ruHtf99qjQFaeduWC
 niVFRzKLl7CfkX/KIMMOiiXgcKsdFgF+/+mzprE6djYKKMcgMgExHRRif0ijPOb6lFi3DmKHDq
 Y/v7JQzg/f75RdFeB6b0IPc2bW8+vMtvLAoL7jgi4qr/lX9Vl4porqo1lPk5ydpp0K/bwup5I/
 lAPQ8OERgH/kNkViVsFeG2sPSx9jFax+eNVoYzluBn+6fzkAZTWFEqYRAm/+L3WbsnGKJTU2d9
 0b5MGsRlsEfpc7CJM4iLI3fS
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 12:12:09 -0800
IronPort-SDR: KizZEy6ZdGwiZ0gn0B5MSBrmfHZge3FSxnru7uCGW+otaD46XBcbX5wGVpodqI4061fUHImeVm
 dnkOAEsqbLvDSb0MrfISW5W31h2lmeN06xN9QftAp81Ly7EJstudWJ1J9UXEOLvXs4h/SbHXAl
 I4Xngs2gR3ADZc5x032lIqszDYaQ8y41SkDAwsRHKTiMBpPHJt6jtOSKCG7upyehsVxyAIi2oO
 KN0aRzPluj47OufF/B+MzRQae3CMztPs+OePOizPuIiacYUFRoOJvmmKGIfkBvV4I7Z6yzE3zZ
 V6w=
WDCIronportException: Internal
Received: from usa003372.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.22])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Nov 2020 12:26:13 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril.Jean@microchip.com, Ivan.Griffin@microchip.com,
        Conor.Dooley@microchip.com
Subject: [RFC PATCH v2 2/4] dt-bindings: riscv: microchip: Add YAML documentation for the PolarFire SoC
Date:   Fri, 13 Nov 2020 12:25:48 -0800
Message-Id: <20201113202550.3693323-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113202550.3693323-1-atish.patra@wdc.com>
References: <20201113202550.3693323-1-atish.patra@wdc.com>
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
 .../devicetree/bindings/riscv/microchip.yaml  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/microchip.yaml

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
new file mode 100644
index 000000000000..9c227fee0b9c
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/sifive.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PolarFire SoC-based boards device tree bindings
+
+maintainers:
+  - Cyril Jean <Cyril.Jean@microchip.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427AD2F8AFB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 04:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbhAPDcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 22:32:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11026 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbhAPDcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 22:32:02 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DHk875klQzj7SN;
        Sat, 16 Jan 2021 11:30:15 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 16 Jan 2021 11:31:11 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v5 3/4] dt-bindings: arm: hisilicon: Add binding for Kunpeng L3 cache controller
Date:   Sat, 16 Jan 2021 11:27:39 +0800
Message-ID: <20210116032740.873-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210116032740.873-1-thunder.leizhen@huawei.com>
References: <20210116032740.873-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Hisilicon Kunpeng L3 cache controller.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../arm/hisilicon/kunpeng-l3cache.yaml        | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/kunpeng-l3cache.yaml

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/kunpeng-l3cache.yaml b/Documentation/devicetree/bindings/arm/hisilicon/kunpeng-l3cache.yaml
new file mode 100644
index 000000000000000..5bf33c0e4d14b7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/kunpeng-l3cache.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hisilicon/kunpeng-l3cache.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon Kunpeng L3 cache controller
+
+maintainers:
+  - Wei Xu <xuwei5@hisilicon.com>
+
+description: |
+  The Hisilicon Kunpeng L3 outer cache controller supports a maximum of 36-bit
+  physical addresses. The data cached in the L3 outer cache can be operated
+  based on the physical address range or the entire cache.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - hisilicon,kunpeng506-l3cache
+          - hisilicon,kunpeng509-l3cache
+      - const: hisilicon,kunpeng-l3cache
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    l3cache@f302b000 {
+        compatible = "hisilicon,kunpeng509-l3cache", "hisilicon,kunpeng-l3cache";
+        reg = <0xf302b000 0x1000>;
+    };
+...
-- 
2.26.0.106.g9fadedd



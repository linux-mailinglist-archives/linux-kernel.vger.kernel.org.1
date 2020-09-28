Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D22B27B0C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgI1PR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:17:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726566AbgI1PR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:17:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E11FCAB5BEF7581E3E4D;
        Mon, 28 Sep 2020 23:17:24 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 23:17:18 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 15/20] dt-bindings: arm: hisilicon: convert hisilicon,hip04-bootwrapper bindings to json-schema
Date:   Mon, 28 Sep 2020 23:13:19 +0800
Message-ID: <20200928151324.2134-16-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200928151324.2134-1-thunder.leizhen@huawei.com>
References: <20200928151324.2134-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Hisilicon Bootwrapper boot method binding to DT schema format
using json-schema.

The property boot-method contains two groups of physical address range
information: bootwrapper and relocation. The "uint32-array" type is not
suitable for it, because the field "address" and "size" may occupy one or
two cells respectively. Use "minItems: 1" and "maxItems: 2" to allow it
can be written in "<addr size addr size>" or "<addr size>, <addr size>"
format.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../controller/hisilicon,hip04-bootwrapper.txt     |  9 ------
 .../controller/hisilicon,hip04-bootwrapper.yaml    | 32 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.yaml

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt
deleted file mode 100644
index b0d53333f4fdae1..000000000000000
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt
+++ /dev/null
@@ -1,9 +0,0 @@
-Bootwrapper boot method (software protocol on SMP):
-
-Required Properties:
-- compatible: "hisilicon,hip04-bootwrapper";
-- boot-method: Address and size of boot method.
-  [0]: bootwrapper physical address
-  [1]: bootwrapper size
-  [2]: relocation physical address
-  [3]: relocation size
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.yaml
new file mode 100644
index 000000000000000..d88ef8487879fc1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bootwrapper boot method
+
+maintainers:
+  - Wei Xu <xuwei5@hisilicon.com>
+
+description: Bootwrapper boot method (software protocol on SMP)
+
+properties:
+  compatible:
+    items:
+      - const: hisilicon,hip04-bootwrapper
+
+  boot-method:
+    description: |
+      Address and size of boot method.
+      [0]: bootwrapper physical address
+      [1]: bootwrapper size
+      [2]: relocation physical address
+      [3]: relocation size
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+  - boot-method
+...
-- 
1.8.3



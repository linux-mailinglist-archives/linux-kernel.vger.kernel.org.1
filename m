Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F120279EC4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgI0G1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:27:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14299 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730398AbgI0G1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:27:01 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C014CC958B1746AE4098;
        Sun, 27 Sep 2020 14:26:57 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 27 Sep 2020 14:26:50 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 16/21] dt-bindings: arm: hisilicon: convert hisilicon,hip04-bootwrapper bindings to json-schema
Date:   Sun, 27 Sep 2020 14:21:24 +0800
Message-ID: <20200927062129.4573-17-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200927062129.4573-1-thunder.leizhen@huawei.com>
References: <20200927062129.4573-1-thunder.leizhen@huawei.com>
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
 .../hipxx/hisilicon,hip04-bootwrapper.txt          |  9 ------
 .../hipxx/hisilicon,hip04-bootwrapper.yaml         | 32 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-bootwrapper.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-bootwrapper.yaml

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-bootwrapper.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-bootwrapper.txt
deleted file mode 100644
index baad98ec700e789..000000000000000
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-bootwrapper.txt
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
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-bootwrapper.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-bootwrapper.yaml
new file mode 100644
index 000000000000000..269ea6c45274bb5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-bootwrapper.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hisilicon/controller/hipxx/hisilicon,hip04-bootwrapper.yaml#
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
\ No newline at end of file
-- 
1.8.3



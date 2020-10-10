Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5772928A067
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 14:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgJJM1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 08:27:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726923AbgJJKQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 06:16:12 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A0795FA2F258C4B7956E;
        Sat, 10 Oct 2020 17:57:46 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 10 Oct 2020 17:57:39 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 10/10] dt-bindings: arm: hisilicon: add missing properties into cpuctrl.yaml
Date:   Sat, 10 Oct 2020 17:57:09 +0800
Message-ID: <20201010095709.1340-11-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201010095709.1340-1-thunder.leizhen@huawei.com>
References: <20201010095709.1340-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add properties: #address-cells, #size-cells and ranges. Due to the
Hisilicon CPU controller node may contains child nodes, change the value
of "additionalProperties" from "false" to "type: object".

The corresponding examples are also added.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../bindings/arm/hisilicon/controller/cpuctrl.yaml | 27 +++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
index f6a314db3a59416..528dad4cde3cd19 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
@@ -21,9 +21,34 @@ properties:
   reg:
     maxItems: 1
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
 required:
   - compatible
   - reg
 
-additionalProperties: false
+additionalProperties:
+  type: object
+
+examples:
+  - |
+    cpuctrl@a22000 {
+        compatible = "hisilicon,cpuctrl";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0x00a22000 0x2000>;
+        ranges = <0 0x00a22000 0x2000>;
+
+        clock: clock@0 {
+            compatible = "hisilicon,hix5hd2-clock";
+            reg = <0 0x2000>;
+            #clock-cells = <1>;
+        };
+    };
 ...
-- 
1.8.3



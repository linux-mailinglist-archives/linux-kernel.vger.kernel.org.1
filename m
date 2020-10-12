Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE4328AE1C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgJLGMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:12:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33556 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727214AbgJLGMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:12:48 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C60512300DE390C4CF61;
        Mon, 12 Oct 2020 14:12:45 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 14:12:40 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 09/10] dt-bindings: arm: hisilicon: add missing properties into sysctrl.yaml
Date:   Mon, 12 Oct 2020 14:12:24 +0800
Message-ID: <20201012061225.1597-10-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201012061225.1597-1-thunder.leizhen@huawei.com>
References: <20201012061225.1597-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add properties: #reset-cells, #address-cells, #size-cells and ranges. Due
to the Hisilicon system controller node may contains child nodes, change
the value of "additionalProperties" from "false" to "type: object". The
examples have also been updated.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../bindings/arm/hisilicon/controller/sysctrl.yaml | 28 +++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml
index 449140f89ddbc3b..5a53d433b6f0891 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml
@@ -71,21 +71,43 @@ properties:
   '#clock-cells':
     const: 1
 
+  '#reset-cells':
+    const: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
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
 
 examples:
   - |
     /* Hisilicon system controller */
-    system-controller@fc802000 {
+    system-controller@802000 {
         compatible = "hisilicon,sysctrl", "syscon";
-        reg = <0xfc802000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x802000 0x1000>;
+        reg = <0x802000 0x1000>;
+
         smp-offset = <0x31c>;
         resume-offset = <0x308>;
         reboot-offset = <0x4>;
+
+        clock: clock@0 {
+            compatible = "hisilicon,hi3620-clock";
+            reg = <0 0x10000>;
+            #clock-cells = <1>;
+        };
     };
 
     /* HiP01 system controller */
-- 
1.8.3



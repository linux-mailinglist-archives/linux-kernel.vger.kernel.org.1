Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D0928A001
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 12:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgJJKW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 06:22:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727172AbgJJKQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 06:16:30 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B6F2CEA0387CB9B93677;
        Sat, 10 Oct 2020 17:57:46 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 10 Oct 2020 17:57:38 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 09/10] dt-bindings: arm: hisilicon: add missing properties into sysctrl.yaml
Date:   Sat, 10 Oct 2020 17:57:08 +0800
Message-ID: <20201010095709.1340-10-thunder.leizhen@huawei.com>
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
Hisilicon system controller node may contains child nodes, change the
value of "additionalProperties" from "false" to "type: object". The
examples have also been updated.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../bindings/arm/hisilicon/controller/sysctrl.yaml | 25 +++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml
index 449140f89ddbc3b..a27b79694e9883f 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml
@@ -71,21 +71,40 @@ properties:
   '#clock-cells':
     const: 1
 
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



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB1C270DE6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 14:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgISMpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 08:45:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39996 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbgISMpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 08:45:06 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D81B814E6D6CAD530CEB;
        Sat, 19 Sep 2020 20:45:02 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 20:44:56 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     devicetree <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Haojian Zhuang" <haojian.zhuang@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/1] dt-bindings: sp804: add support for Hisilicon sp804 timer
Date:   Sat, 19 Sep 2020 20:44:12 +0800
Message-ID: <20200919124412.4135-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200919124412.4135-1-thunder.leizhen@huawei.com>
References: <20200919124412.4135-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Hisilicon SoCs, such as Hi1212, use the Hisilicon extended sp804
timer.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/timer/arm,sp804.yaml | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/arm,sp804.yaml b/Documentation/devicetree/bindings/timer/arm,sp804.yaml
index ba0945cf799ee0b..e35d3053250a557 100644
--- a/Documentation/devicetree/bindings/timer/arm,sp804.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,sp804.yaml
@@ -15,19 +15,26 @@ description: |+
   free-running mode. The input clock is shared, but can be gated and prescaled
   independently for each timer.
 
+  There is a viriant of Arm SP804: Hisilicon 64-bit SP804 timer. Some Hisilicon
+  SoCs, such as Hi1212, should use the dedicated compatible: "hisilicon,sp804".
+
 # Need a custom select here or 'arm,primecell' will match on lots of nodes
 select:
   properties:
     compatible:
       contains:
-        const: arm,sp804
+        oneOf:
+          - const: arm,sp804
+          - const: hisilicon,sp804
   required:
     - compatible
 
 properties:
   compatible:
     items:
-      - const: arm,sp804
+      - enum:
+        - arm,sp804
+        - hisilicon,sp804
       - const: arm,primecell
 
   interrupts:
-- 
1.8.3



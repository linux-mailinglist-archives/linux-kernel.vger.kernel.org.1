Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB7626FE47
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIRNXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:23:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59476 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726786AbgIRNXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:23:16 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8C679BFC77A73522B7DA;
        Fri, 18 Sep 2020 21:23:13 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 21:23:04 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: [PATCH v3 9/9] dt-bindings: sp804: add support for Hisilicon sp804 timer
Date:   Fri, 18 Sep 2020 21:22:37 +0800
Message-ID: <20200918132237.3552-10-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200918132237.3552-1-thunder.leizhen@huawei.com>
References: <20200918132237.3552-1-thunder.leizhen@huawei.com>
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
 Documentation/devicetree/bindings/timer/arm,sp804.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/arm,sp804.yaml b/Documentation/devicetree/bindings/timer/arm,sp804.yaml
index ba0945cf799ee0b..06dfcbcc7b24255 100644
--- a/Documentation/devicetree/bindings/timer/arm,sp804.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,sp804.yaml
@@ -15,6 +15,9 @@ description: |+
   free-running mode. The input clock is shared, but can be gated and prescaled
   independently for each timer.
 
+  There is a viriant of Arm SP804: Hisilicon 64-bit SP804 timer. Some Hisilicon
+  SoCs, such as Hi1212, should use the dedicated compatible: "hisilicon,sp804".
+
 # Need a custom select here or 'arm,primecell' will match on lots of nodes
 select:
   properties:
@@ -27,7 +30,9 @@ select:
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



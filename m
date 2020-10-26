Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11472991B9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784657AbgJZQA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:00:27 -0400
Received: from out28-1.mail.aliyun.com ([115.124.28.1]:46712 "EHLO
        out28-1.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784633AbgJZP7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:59:17 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07809633|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00465019-0.000271564-0.995078;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.IohI8W7_1603727944;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IohI8W7_1603727944)
          by smtp.aliyun-inc.com(10.147.40.2);
          Mon, 26 Oct 2020 23:59:11 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        daniel.lezcano@linaro.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH v3 1/1] dt-bindings: timer: Add new OST support for the upcoming new driver.
Date:   Mon, 26 Oct 2020 23:58:42 +0800
Message-Id: <20201026155842.10196-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201026155842.10196-1-zhouyanjie@wanyeetech.com>
References: <20201026155842.10196-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new OST has one global timer and two or four percpu timers, so there
will be three combinations in the upcoming new OST driver: the original
GLOBAL_TIMER + PERCPU_TIMER, the new GLOBAL_TIMER + PERCPU_TIMER0/1 and
GLOBAL_TIMER + PERCPU_TIMER0/1/2/3, For this, add the macro definition
about OST_CLK_PERCPU_TIMER0/1/2/3. And in order to ensure that all the
combinations work normally, the original ABI values of OST_CLK_PERCPU_TIMER
and OST_CLK_GLOBAL_TIMER need to be exchanged to ensure that in any
combinations, the clock can be registered (by calling clk_hw_register())
from index 0.

Before this patch, OST_CLK_PERCPU_TIMER and OST_CLK_GLOBAL_TIMER are only
used in two places, one is when using "assigned-clocks" to configure the
clocks in the DTS file; the other is when registering the clocks in the
sysost driver. When the values of these two ABIs are exchanged, the ABI
value used by sysost driver when registering the clock, and the ABI value
used by DTS when configuring the clock using "assigned-clocks" will also
change accordingly. Therefore, there is no situation that causes the wrong
clock to the configured. Therefore, exchanging ABI values will not cause
errors in the existing codes when registering and configuring the clocks.

Currently, in the mainline, only X1000 and X1830 are using sysost driver,
and the upcoming X2000 will also use sysost driver. This patch has been
tested on all three SoCs and all works fine.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---

Notes:
    v1->v2:
    Rewrite the commit message so that each line is less than 80 characters.
    
    v2->v3:
    Add the description of why the exchange of ABI values will not affect
    the existing driver into the commit message.

 include/dt-bindings/clock/ingenic,sysost.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/clock/ingenic,sysost.h b/include/dt-bindings/clock/ingenic,sysost.h
index 9ac88e90babf..063791b01ab3 100644
--- a/include/dt-bindings/clock/ingenic,sysost.h
+++ b/include/dt-bindings/clock/ingenic,sysost.h
@@ -1,12 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * This header provides clock numbers for the ingenic,tcu DT binding.
+ * This header provides clock numbers for the Ingenic OST DT binding.
  */
 
 #ifndef __DT_BINDINGS_CLOCK_INGENIC_OST_H__
 #define __DT_BINDINGS_CLOCK_INGENIC_OST_H__
 
-#define OST_CLK_PERCPU_TIMER	0
-#define OST_CLK_GLOBAL_TIMER	1
+#define OST_CLK_PERCPU_TIMER	1
+#define OST_CLK_GLOBAL_TIMER	0
+#define OST_CLK_PERCPU_TIMER0	1
+#define OST_CLK_PERCPU_TIMER1	2
+#define OST_CLK_PERCPU_TIMER2	3
+#define OST_CLK_PERCPU_TIMER3	4
 
 #endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
-- 
2.11.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7B82866B3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgJGSPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:15:07 -0400
Received: from out28-169.mail.aliyun.com ([115.124.28.169]:49090 "EHLO
        out28-169.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgJGSOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:14:43 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1553189|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00927651-0.00167429-0.989049;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.IgNey8v_1602094473;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IgNey8v_1602094473)
          by smtp.aliyun-inc.com(10.147.42.135);
          Thu, 08 Oct 2020 02:14:39 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sernia.zhou@foxmail.com
Subject: [PATCH 1/1] dt-bindings: clock: Add new OST support for the upcoming new driver.
Date:   Thu,  8 Oct 2020 02:14:07 +0800
Message-Id: <20201007181407.46889-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201007181407.46889-1-zhouyanjie@wanyeetech.com>
References: <20201007181407.46889-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new OST has one global timer and two or four percpu timers, so there will be three
combinations in the upcoming new OST driver: the original GLOBAL_TIMER + PERCPU_TIMER,
the new GLOBAL_TIMER + PERCPU_TIMER0/1 and GLOBAL_TIMER + PERCPU_TIMER0/1/2/3, For this,
add the macro definition about OST_CLK_PERCPU_TIMER0/1/2/3. And in order to ensure that
all the combinations work normally, the original ABI values of OST_CLK_PERCPU_TIMER and
OST_CLK_GLOBAL_TIMER need to be exchanged to ensure that in any combinations, the clock
can be registered (by calling clk_hw_register()) from index 0.

I'm sure that exchanging the ABI values of OST_CLK_PERCPU_TIMER and OST_CLK_GLOBAL_TIMER
will not affect the existing related drivers and the SoCs whitch using these drivers, so
we should be able to exchange them safely.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
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


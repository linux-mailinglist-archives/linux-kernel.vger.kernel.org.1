Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F064220C79
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 13:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgGOLyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 07:54:32 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:57089 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729356AbgGOLyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:54:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1324965|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0117998-0.000741579-0.987459;FP=0|0|0|0|0|-1|-1|-1;HT=e01l10422;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.I27xjjM_1594814062;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I27xjjM_1594814062)
          by smtp.aliyun-inc.com(10.147.41.121);
          Wed, 15 Jul 2020 19:54:27 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        tiny.windzz@gmail.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH 1/3] =?UTF-8?q?dt-bindings:=20gpio:=20sunxi=EF=BC=9Acreate?= =?UTF-8?q?=20a=20DT=20header=20for=20Allwinner=20pin=20controller?=
Date:   Wed, 15 Jul 2020 19:54:12 +0800
Message-Id: <20200715115412.2544-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

The sunxi gpio binding defines a few custom cells for its gpio specifier.
Provide bank name for those.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>

---
 include/dt-bindings/gpio/sunxi-gpio.h | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 include/dt-bindings/gpio/sunxi-gpio.h

diff --git a/include/dt-bindings/gpio/sunxi-gpio.h b/include/dt-bindings/gpio/sunxi-gpio.h
new file mode 100644
index 000000000000..c692b4360da6
--- /dev/null
+++ b/include/dt-bindings/gpio/sunxi-gpio.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * GPIO definitions for Allwinner SoCs
+ *
+ * Copyright (C) 2020 Yangtao Li <frank@allwinnertech.com>
+ */
+
+#ifndef _DT_BINDINGS_SUNXI_GPIO_H
+#define _DT_BINDINGS_SUNXI_GPIO_H
+
+#include <dt-bindings/gpio/gpio.h>
+
+/* pio */
+#define PA	0
+#define PB	1
+#define PC	2
+#define PD	3
+#define PE	4
+#define PF	5
+#define PG	6
+#define PH	7
+#define PI	8
+
+/* r-pio */
+#define PL	0
+#define PM	1
+#define PN	2
+
+#endif /* _DT_BINDINGS_SUNXI_GPIO_H */
-- 
2.24.0


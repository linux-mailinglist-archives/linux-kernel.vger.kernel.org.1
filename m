Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913F428718B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgJHJbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:31:43 -0400
Received: from out28-221.mail.aliyun.com ([115.124.28.221]:35958 "EHLO
        out28-221.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgJHJbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:31:42 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08136451|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0399064-0.000837473-0.959256;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.IgbT2aG_1602149484;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IgbT2aG_1602149484)
          by smtp.aliyun-inc.com(10.147.40.2);
          Thu, 08 Oct 2020 17:31:39 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: dmaengine: Add X2000 bindings.
Date:   Thu,  8 Oct 2020 17:31:00 +0800
Message-Id: <20201008093100.88405-3-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201008093100.88405-1-zhouyanjie@wanyeetech.com>
References: <20201008093100.88405-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dmaengine bindings for the X2000 SoC from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 include/dt-bindings/dma/x2000-dma.h | 54 +++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 include/dt-bindings/dma/x2000-dma.h

diff --git a/include/dt-bindings/dma/x2000-dma.h b/include/dt-bindings/dma/x2000-dma.h
new file mode 100644
index 000000000000..db2cd4830b00
--- /dev/null
+++ b/include/dt-bindings/dma/x2000-dma.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This header provides macros for X2000 DMA bindings.
+ *
+ * Copyright (c) 2020 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
+ */
+
+#ifndef __DT_BINDINGS_DMA_X2000_DMA_H__
+#define __DT_BINDINGS_DMA_X2000_DMA_H__
+
+/*
+ * Request type numbers for the X2000 DMA controller (written to the DRTn
+ * register for the channel).
+ */
+#define X2000_DMA_AUTO		0x8
+#define X2000_DMA_UART5_TX	0xa
+#define X2000_DMA_UART5_RX	0xb
+#define X2000_DMA_UART4_TX	0xc
+#define X2000_DMA_UART4_RX	0xd
+#define X2000_DMA_UART3_TX	0xe
+#define X2000_DMA_UART3_RX	0xf
+#define X2000_DMA_UART2_TX	0x10
+#define X2000_DMA_UART2_RX	0x11
+#define X2000_DMA_UART1_TX	0x12
+#define X2000_DMA_UART1_RX	0x13
+#define X2000_DMA_UART0_TX	0x14
+#define X2000_DMA_UART0_RX	0x15
+#define X2000_DMA_SSI0_TX	0x16
+#define X2000_DMA_SSI0_RX	0x17
+#define X2000_DMA_SSI1_TX	0x18
+#define X2000_DMA_SSI1_RX	0x19
+#define X2000_DMA_I2C0_TX	0x24
+#define X2000_DMA_I2C0_RX	0x25
+#define X2000_DMA_I2C1_TX	0x26
+#define X2000_DMA_I2C1_RX	0x27
+#define X2000_DMA_I2C2_TX	0x28
+#define X2000_DMA_I2C2_RX	0x29
+#define X2000_DMA_I2C3_TX	0x2a
+#define X2000_DMA_I2C3_RX	0x2b
+#define X2000_DMA_I2C4_TX	0x2c
+#define X2000_DMA_I2C4_RX	0x2d
+#define X2000_DMA_I2C5_TX	0x2e
+#define X2000_DMA_I2C5_RX	0x2f
+#define X2000_DMA_UART6_TX	0x30
+#define X2000_DMA_UART6_RX	0x31
+#define X2000_DMA_UART7_TX	0x32
+#define X2000_DMA_UART7_RX	0x33
+#define X2000_DMA_UART8_TX	0x34
+#define X2000_DMA_UART8_RX	0x35
+#define X2000_DMA_UART9_TX	0x36
+#define X2000_DMA_UART9_RX	0x37
+#define X2000_DMA_SADC_RX	0x38
+
+#endif /* __DT_BINDINGS_DMA_X2000_DMA_H__ */
-- 
2.11.0


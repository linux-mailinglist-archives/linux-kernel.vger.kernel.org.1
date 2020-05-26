Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262281D1463
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 15:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbgEMNRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 09:17:30 -0400
Received: from out28-145.mail.aliyun.com ([115.124.28.145]:38649 "EHLO
        out28-145.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387574AbgEMNR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:17:27 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.286166|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00517094-0.000337524-0.994492;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03311;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HY0oTOn_1589375829;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HY0oTOn_1589375829)
          by smtp.aliyun-inc.com(10.147.41.120);
          Wed, 13 May 2020 21:17:21 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH v8 3/6] dt-bindings: clock: Add X1830 bindings.
Date:   Wed, 13 May 2020 21:16:41 +0800
Message-Id: <1589375804-78423-5-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589375804-78423-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1589375804-78423-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock bindings for the X1830 Soc from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v1->v2:
    Change my Signed-off-by from "Zhou Yanjie <zhouyanjie@zoho.com>"
    to "周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>" because
    the old mailbox is in an unstable state.
    
    v2->v3:
    Adjust order from [3/5] in v2 to [4/5] in v3.
    
    v3->v4:
    Adjust order from [4/5] in v3 to [3/4] in v4.
    
    v4->v5:
    Rebase on top of kernel 5.6-rc1.
    
    v5->v6:
    Add missing part of X1830's CGU.
    
    v6->v7:
    No change.
    
    v7->v8:
    Rebase on top of linux-next.

 .../devicetree/bindings/clock/ingenic,cgu.yaml     |  2 +
 include/dt-bindings/clock/x1830-cgu.h              | 53 ++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 include/dt-bindings/clock/x1830-cgu.h

diff --git a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
index 0281cd1..a952d58 100644
--- a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
+++ b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
@@ -25,6 +25,7 @@ select:
           - ingenic,jz4770-cgu
           - ingenic,jz4780-cgu
           - ingenic,x1000-cgu
+          - ingenic,x1830-cgu
   required:
     - compatible
 
@@ -51,6 +52,7 @@ properties:
         - ingenic,jz4770-cgu
         - ingenic,jz4780-cgu
         - ingenic,x1000-cgu
+        - ingenic,x1830-cgu
       - const: simple-mfd
     minItems: 1
 
diff --git a/include/dt-bindings/clock/x1830-cgu.h b/include/dt-bindings/clock/x1830-cgu.h
new file mode 100644
index 00000000..f605a7b
--- /dev/null
+++ b/include/dt-bindings/clock/x1830-cgu.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides clock numbers for the ingenic,x1830-cgu DT binding.
+ *
+ * They are roughly ordered as:
+ *   - external clocks
+ *   - PLLs
+ *   - muxes/dividers in the order they appear in the x1830 programmers manual
+ *   - gates in order of their bit in the CLKGR* registers
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_X1830_CGU_H__
+#define __DT_BINDINGS_CLOCK_X1830_CGU_H__
+
+#define X1830_CLK_EXCLK			0
+#define X1830_CLK_RTCLK			1
+#define X1830_CLK_APLL			2
+#define X1830_CLK_MPLL			3
+#define X1830_CLK_EPLL			4
+#define X1830_CLK_VPLL			5
+#define X1830_CLK_SCLKA			6
+#define X1830_CLK_CPUMUX		7
+#define X1830_CLK_CPU			8
+#define X1830_CLK_L2CACHE		9
+#define X1830_CLK_AHB0			10
+#define X1830_CLK_AHB2PMUX		11
+#define X1830_CLK_AHB2			12
+#define X1830_CLK_PCLK			13
+#define X1830_CLK_DDR			14
+#define X1830_CLK_MAC			15
+#define X1830_CLK_LCD			16
+#define X1830_CLK_MSCMUX		17
+#define X1830_CLK_MSC0			18
+#define X1830_CLK_MSC1			19
+#define X1830_CLK_SSIPLL		20
+#define X1830_CLK_SSIPLL_DIV2	21
+#define X1830_CLK_SSIMUX		22
+#define X1830_CLK_EMC			23
+#define X1830_CLK_EFUSE			24
+#define X1830_CLK_OTG			25
+#define X1830_CLK_SSI0			26
+#define X1830_CLK_SMB0			27
+#define X1830_CLK_SMB1			28
+#define X1830_CLK_SMB2			29
+#define X1830_CLK_UART0			30
+#define X1830_CLK_UART1			31
+#define X1830_CLK_SSI1			32
+#define X1830_CLK_SFC			33
+#define X1830_CLK_PDMA			34
+#define X1830_CLK_DTRNG			35
+#define X1830_CLK_OST			36
+
+#endif /* __DT_BINDINGS_CLOCK_X1830_CGU_H__ */
-- 
2.7.4


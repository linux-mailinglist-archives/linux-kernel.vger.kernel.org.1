Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA6A1D146D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 15:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387706AbgEMNRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 09:17:40 -0400
Received: from out28-219.mail.aliyun.com ([115.124.28.219]:49868 "EHLO
        out28-219.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387608AbgEMNRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:17:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1813292|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0154397-0.00035353-0.984207;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03298;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HY0oTOn_1589375829;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HY0oTOn_1589375829)
          by smtp.aliyun-inc.com(10.147.41.120);
          Wed, 13 May 2020 21:17:23 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH v8 5/6] dt-bindings: clock: Add and reorder ABI for X1000.
Date:   Wed, 13 May 2020 21:16:43 +0800
Message-Id: <1589375804-78423-7-git-send-email-zhouyanjie@wanyeetech.com>
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

1.The SSI clock of X1000 not like JZ4770 and JZ4780, they are not
  directly derived from the output of SSIPLL, but from the clock
  obtained by dividing the frequency by 2. "X1000_CLK_SSIPLL_DIV2"
  is added for this purpose, it must between "X1000_CLK_SSIPLL"
  and "X1000_CLK_SSIMUX", otherwise an error will occurs when
  initializing the clock. These ABIs are only used for X1000, and
  I'm sure that no other devicetree out there is using these ABIs,
  so we should be able to reorder them.
2.Clocks of LCD, OTG, EMC, EFUSE, OST are also added.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    v5:
    New patch.
    
    v5->v6:
    Add missing part of X1000's CGU.
    
    v6->v7:
    No change.
    
    v7->v8:
    No change.

 include/dt-bindings/clock/x1000-cgu.h | 62 +++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/include/dt-bindings/clock/x1000-cgu.h b/include/dt-bindings/clock/x1000-cgu.h
index bbaebaf..ef6ff63 100644
--- a/include/dt-bindings/clock/x1000-cgu.h
+++ b/include/dt-bindings/clock/x1000-cgu.h
@@ -12,33 +12,39 @@
 #ifndef __DT_BINDINGS_CLOCK_X1000_CGU_H__
 #define __DT_BINDINGS_CLOCK_X1000_CGU_H__
 
-#define X1000_CLK_EXCLK		0
-#define X1000_CLK_RTCLK		1
-#define X1000_CLK_APLL		2
-#define X1000_CLK_MPLL		3
-#define X1000_CLK_SCLKA		4
-#define X1000_CLK_CPUMUX	5
-#define X1000_CLK_CPU		6
-#define X1000_CLK_L2CACHE	7
-#define X1000_CLK_AHB0		8
-#define X1000_CLK_AHB2PMUX	9
-#define X1000_CLK_AHB2		10
-#define X1000_CLK_PCLK		11
-#define X1000_CLK_DDR		12
-#define X1000_CLK_MAC		13
-#define X1000_CLK_MSCMUX	14
-#define X1000_CLK_MSC0		15
-#define X1000_CLK_MSC1		16
-#define X1000_CLK_SSIPLL	17
-#define X1000_CLK_SSIMUX	18
-#define X1000_CLK_SFC		19
-#define X1000_CLK_I2C0		20
-#define X1000_CLK_I2C1		21
-#define X1000_CLK_I2C2		22
-#define X1000_CLK_UART0		23
-#define X1000_CLK_UART1		24
-#define X1000_CLK_UART2		25
-#define X1000_CLK_SSI		26
-#define X1000_CLK_PDMA		27
+#define X1000_CLK_EXCLK			0
+#define X1000_CLK_RTCLK			1
+#define X1000_CLK_APLL			2
+#define X1000_CLK_MPLL			3
+#define X1000_CLK_SCLKA			4
+#define X1000_CLK_CPUMUX		5
+#define X1000_CLK_CPU			6
+#define X1000_CLK_L2CACHE		7
+#define X1000_CLK_AHB0			8
+#define X1000_CLK_AHB2PMUX		9
+#define X1000_CLK_AHB2			10
+#define X1000_CLK_PCLK			11
+#define X1000_CLK_DDR			12
+#define X1000_CLK_MAC			13
+#define X1000_CLK_LCD			14
+#define X1000_CLK_MSCMUX		15
+#define X1000_CLK_MSC0			16
+#define X1000_CLK_MSC1			17
+#define X1000_CLK_OTG			18
+#define X1000_CLK_SSIPLL		19
+#define X1000_CLK_SSIPLL_DIV2	20
+#define X1000_CLK_SSIMUX		21
+#define X1000_CLK_EMC			22
+#define X1000_CLK_EFUSE			23
+#define X1000_CLK_SFC			24
+#define X1000_CLK_I2C0			25
+#define X1000_CLK_I2C1			26
+#define X1000_CLK_I2C2			27
+#define X1000_CLK_UART0			28
+#define X1000_CLK_UART1			29
+#define X1000_CLK_UART2			30
+#define X1000_CLK_SSI			31
+#define X1000_CLK_OST			32
+#define X1000_CLK_PDMA			33
 
 #endif /* __DT_BINDINGS_CLOCK_X1000_CGU_H__ */
-- 
2.7.4


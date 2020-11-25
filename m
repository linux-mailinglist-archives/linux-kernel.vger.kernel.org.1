Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D389A2C46B2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbgKYR1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:27:18 -0500
Received: from out28-172.mail.aliyun.com ([115.124.28.172]:33115 "EHLO
        out28-172.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732765AbgKYR1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:27:16 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1504881|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00850855-0.00378725-0.987704;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.J.BPrxs_1606325224;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.J.BPrxs_1606325224)
          by smtp.aliyun-inc.com(10.147.41.137);
          Thu, 26 Nov 2020 01:27:13 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, mturquette@baylibre.com,
        paul@crapouillou.net
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH 2/4] dt-bindings: clock: Add missing clocks for Ingenic SoCs.
Date:   Thu, 26 Nov 2020 01:26:16 +0800
Message-Id: <20201125172618.112707-3-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201125172618.112707-1-zhouyanjie@wanyeetech.com>
References: <20201125172618.112707-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CIM, AIC, DMIC clocks bindings for the X1000 SoC, and CIM, AIC,
DMIC, I2S clocks for the X1830 SoC from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 include/dt-bindings/clock/x1000-cgu.h | 3 +++
 include/dt-bindings/clock/x1830-cgu.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/dt-bindings/clock/x1000-cgu.h b/include/dt-bindings/clock/x1000-cgu.h
index f187e07..fa92257 100644
--- a/include/dt-bindings/clock/x1000-cgu.h
+++ b/include/dt-bindings/clock/x1000-cgu.h
@@ -50,5 +50,8 @@
 #define X1000_CLK_PDMA			35
 #define X1000_CLK_EXCLK_DIV512	36
 #define X1000_CLK_RTC			37
+#define X1000_CLK_CIM			38
+#define X1000_CLK_AIC			39
+#define X1000_CLK_DMIC			40
 
 #endif /* __DT_BINDINGS_CLOCK_X1000_CGU_H__ */
diff --git a/include/dt-bindings/clock/x1830-cgu.h b/include/dt-bindings/clock/x1830-cgu.h
index 8845537..3732507 100644
--- a/include/dt-bindings/clock/x1830-cgu.h
+++ b/include/dt-bindings/clock/x1830-cgu.h
@@ -53,5 +53,9 @@
 #define X1830_CLK_OST			38
 #define X1830_CLK_EXCLK_DIV512	39
 #define X1830_CLK_RTC			40
+#define X1830_CLK_CIM			41
+#define X1830_CLK_AIC			42
+#define X1830_CLK_DMIC			43
+#define X1830_CLK_I2S			44
 
 #endif /* __DT_BINDINGS_CLOCK_X1830_CGU_H__ */
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537912DB4CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgLOUEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:04:41 -0500
Received: from out28-123.mail.aliyun.com ([115.124.28.123]:44307 "EHLO
        out28-123.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbgLOUEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:04:11 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1418542|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00378519-0.00113538-0.995079;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.J7YTY-B_1608062595;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.J7YTY-B_1608062595)
          by smtp.aliyun-inc.com(10.147.41.187);
          Wed, 16 Dec 2020 04:03:27 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     sboyd@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sihui.liu@ingenic.com, sernia.zhou@foxmail.com,
        paul@crapouillou.net
Subject: [PATCH v2 2/5] dt-bindings: clock: Add missing clocks for Ingenic SoCs.
Date:   Wed, 16 Dec 2020 04:02:49 +0800
Message-Id: <1608062572-42156-3-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608062572-42156-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1608062572-42156-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MACPHY, CIM, AIC, DMIC, I2S clocks bindings for the X1000 SoC
and the X1830 SoC from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    v1->v2:
    1.Add MACPHY and I2S for X1000, and add MACPHY for X1830.
    2.Add Paul Cercueil's Reviewed-by and Rob Herring's Acked-by.

 include/dt-bindings/clock/x1000-cgu.h | 5 +++++
 include/dt-bindings/clock/x1830-cgu.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/dt-bindings/clock/x1000-cgu.h b/include/dt-bindings/clock/x1000-cgu.h
index f187e07..3e79f36 100644
--- a/include/dt-bindings/clock/x1000-cgu.h
+++ b/include/dt-bindings/clock/x1000-cgu.h
@@ -50,5 +50,10 @@
 #define X1000_CLK_PDMA			35
 #define X1000_CLK_EXCLK_DIV512	36
 #define X1000_CLK_RTC			37
+#define X1000_CLK_MACPHY		38
+#define X1000_CLK_CIM			39
+#define X1000_CLK_AIC			40
+#define X1000_CLK_DMIC			41
+#define X1000_CLK_I2S			42
 
 #endif /* __DT_BINDINGS_CLOCK_X1000_CGU_H__ */
diff --git a/include/dt-bindings/clock/x1830-cgu.h b/include/dt-bindings/clock/x1830-cgu.h
index 8845537..8da2997 100644
--- a/include/dt-bindings/clock/x1830-cgu.h
+++ b/include/dt-bindings/clock/x1830-cgu.h
@@ -53,5 +53,10 @@
 #define X1830_CLK_OST			38
 #define X1830_CLK_EXCLK_DIV512	39
 #define X1830_CLK_RTC			40
+#define X1830_CLK_MACPHY		41
+#define X1830_CLK_CIM			42
+#define X1830_CLK_AIC			43
+#define X1830_CLK_DMIC			44
+#define X1830_CLK_I2S			45
 
 #endif /* __DT_BINDINGS_CLOCK_X1830_CGU_H__ */
-- 
2.7.4


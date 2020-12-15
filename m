Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB132DB4D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgLOUEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:04:39 -0500
Received: from out28-220.mail.aliyun.com ([115.124.28.220]:33705 "EHLO
        out28-220.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgLOUEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:04:08 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09273937|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.015602-0.000445999-0.983952;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.J7YTY-B_1608062595;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.J7YTY-B_1608062595)
          by smtp.aliyun-inc.com(10.147.41.187);
          Wed, 16 Dec 2020 04:03:25 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     sboyd@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sihui.liu@ingenic.com, sernia.zhou@foxmail.com,
        paul@crapouillou.net
Subject: [PATCH v2 1/5] clk: JZ4780: Add function for disable the second core.
Date:   Wed, 16 Dec 2020 04:02:48 +0800
Message-Id: <1608062572-42156-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608062572-42156-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1608062572-42156-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "jz4780_core1_disable()" for disable the second core of JZ4780,
prepare for later commits.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v1->v2:
    Add Paul Cercueil's Reviewed-by.

 drivers/clk/ingenic/jz4780-cgu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index 0268d23..dcca74e 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -252,8 +252,29 @@ static int jz4780_core1_enable(struct clk_hw *hw)
 	return 0;
 }
 
+static void jz4780_core1_disable(struct clk_hw *hw)
+{
+	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
+	struct ingenic_cgu *cgu = ingenic_clk->cgu;
+	unsigned long flags;
+	u32 lcr, clkgr1;
+
+	spin_lock_irqsave(&cgu->lock, flags);
+
+	lcr = readl(cgu->base + CGU_REG_LCR);
+	lcr |= LCR_PD_SCPU;
+	writel(lcr, cgu->base + CGU_REG_LCR);
+
+	clkgr1 = readl(cgu->base + CGU_REG_CLKGR1);
+	clkgr1 |= CLKGR1_CORE1;
+	writel(clkgr1, cgu->base + CGU_REG_CLKGR1);
+
+	spin_unlock_irqrestore(&cgu->lock, flags);
+}
+
 static const struct clk_ops jz4780_core1_ops = {
 	.enable = jz4780_core1_enable,
+	.disable = jz4780_core1_disable,
 };
 
 static const s8 pll_od_encoding[16] = {
-- 
2.7.4


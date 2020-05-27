Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777F71E3CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 10:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388190AbgE0I6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 04:58:15 -0400
Received: from out28-98.mail.aliyun.com ([115.124.28.98]:45689 "EHLO
        out28-98.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgE0I6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:58:15 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07497798|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.65544-0.000441388-0.344119;FP=12402199639513142574|1|1|7|0|-1|-1|-1;HT=e02c03298;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.HeHmYFS_1590569832;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HeHmYFS_1590569832)
          by smtp.aliyun-inc.com(10.147.44.129);
          Wed, 27 May 2020 16:58:10 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v11 1/7] clk: Ingenic: Remove unnecessary spinlock when reading registers.
Date:   Wed, 27 May 2020 16:54:43 +0800
Message-Id: <20200527085449.55573-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200527085449.55573-1-zhouyanjie@wanyeetech.com>
References: <20200527085449.55573-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not necessary to use spinlock when reading registers,
so remove it from cgu.c.

Suggested-by: Paul Cercueil <paul@crapouillou.net>
Suggested-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2:
    New patch.
    
    v2->v3:
    Adjust order from [5/5] in v2 to [1/5] in v3.
    
    v3->v4:
    Remove the spinlock around ingenic_cgu_gate_get().
    
    v4->v5:
    Rebase on top of kernel 5.6-rc1.
    
    v5->v6:
    No change.
    
    v6->v7:
    No change.
    
    v7->v8:
    No change.
    
    v8->v9:
    No change.
    
    v9->v10:
    No change.
    
    v10->v11:
    No change.

 drivers/clk/ingenic/cgu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 6e963031cd87..ab1302ad1450 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -76,16 +76,13 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	const struct ingenic_cgu_pll_info *pll_info;
 	unsigned m, n, od_enc, od;
 	bool bypass;
-	unsigned long flags;
 	u32 ctl;
 
 	clk_info = &cgu->clock_info[ingenic_clk->idx];
 	BUG_ON(clk_info->type != CGU_CLK_PLL);
 	pll_info = &clk_info->pll;
 
-	spin_lock_irqsave(&cgu->lock, flags);
 	ctl = readl(cgu->base + pll_info->reg);
-	spin_unlock_irqrestore(&cgu->lock, flags);
 
 	m = (ctl >> pll_info->m_shift) & GENMASK(pll_info->m_bits - 1, 0);
 	m += pll_info->m_offset;
@@ -259,12 +256,9 @@ static int ingenic_pll_is_enabled(struct clk_hw *hw)
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
 	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
 	const struct ingenic_cgu_pll_info *pll_info = &clk_info->pll;
-	unsigned long flags;
 	u32 ctl;
 
-	spin_lock_irqsave(&cgu->lock, flags);
 	ctl = readl(cgu->base + pll_info->reg);
-	spin_unlock_irqrestore(&cgu->lock, flags);
 
 	return !!(ctl & BIT(pll_info->enable_bit));
 }
@@ -562,16 +556,12 @@ static int ingenic_clk_is_enabled(struct clk_hw *hw)
 	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
 	const struct ingenic_cgu_clk_info *clk_info;
-	unsigned long flags;
 	int enabled = 1;
 
 	clk_info = &cgu->clock_info[ingenic_clk->idx];
 
-	if (clk_info->type & CGU_CLK_GATE) {
-		spin_lock_irqsave(&cgu->lock, flags);
+	if (clk_info->type & CGU_CLK_GATE)
 		enabled = !ingenic_cgu_gate_get(cgu, &clk_info->gate);
-		spin_unlock_irqrestore(&cgu->lock, flags);
-	}
 
 	return enabled;
 }
-- 
2.11.0


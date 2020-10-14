Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED1828D885
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 04:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgJNCfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 22:35:16 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:60758 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgJNCfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 22:35:15 -0400
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id 5B37BA51BD;
        Wed, 14 Oct 2020 10:28:17 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18907T140199837284096S1602642493459899_;
        Wed, 14 Oct 2020 10:28:16 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4943f9f179517a5b6aa54915bf2ae1a6>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v4 3/5] clk: rockchip: add a clock-type for muxes based in the pmugrf
Date:   Wed, 14 Oct 2020 10:28:10 +0800
Message-Id: <20201014022812.6733-4-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014022812.6733-1-zhangqing@rock-chips.com>
References: <20201014022812.6733-1-zhangqing@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip socs often have some tiny number of muxes not controlled from
the core clock controller but through bits set in the pmugrf.
Use MUXPMUGRF() to cover this special clock-type.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk.c |  9 +++++++++
 drivers/clk/rockchip/clk.h | 17 +++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 8f77c3f9fab7..4f238f2851ac 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -407,6 +407,8 @@ struct rockchip_clk_provider * __init rockchip_clk_init(struct device_node *np,
 
 	ctx->grf = syscon_regmap_lookup_by_phandle(ctx->cru_node,
 						   "rockchip,grf");
+	ctx->pmugrf = syscon_regmap_lookup_by_phandle(ctx->cru_node,
+						   "rockchip,pmugrf");
 
 	return ctx;
 
@@ -482,6 +484,13 @@ void __init rockchip_clk_register_branches(
 				list->mux_shift, list->mux_width,
 				list->mux_flags);
 			break;
+		case branch_muxpmugrf:
+			clk = rockchip_clk_register_muxgrf(list->name,
+				list->parent_names, list->num_parents,
+				flags, ctx->pmugrf, list->muxdiv_offset,
+				list->mux_shift, list->mux_width,
+				list->mux_flags);
+			break;
 		case branch_divider:
 			if (list->div_table)
 				clk = clk_register_divider_table(NULL,
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 0d401ce09a54..ae059b7744f9 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -238,6 +238,7 @@ struct rockchip_clk_provider {
 	struct clk_onecell_data clk_data;
 	struct device_node *cru_node;
 	struct regmap *grf;
+	struct regmap *pmugrf;
 	spinlock_t lock;
 };
 
@@ -390,6 +391,7 @@ enum rockchip_clk_branch_type {
 	branch_composite,
 	branch_mux,
 	branch_muxgrf,
+	branch_muxpmugrf,
 	branch_divider,
 	branch_fraction_divider,
 	branch_gate,
@@ -662,6 +664,21 @@ struct rockchip_clk_branch {
 		.gate_offset	= -1,				\
 	}
 
+#define MUXPMUGRF(_id, cname, pnames, f, o, s, w, mf)		\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_muxpmugrf,		\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.muxdiv_offset	= o,				\
+		.mux_shift	= s,				\
+		.mux_width	= w,				\
+		.mux_flags	= mf,				\
+		.gate_offset	= -1,				\
+	}
+
 #define DIV(_id, cname, pname, f, o, s, w, df)			\
 	{							\
 		.id		= _id,				\
-- 
2.17.1




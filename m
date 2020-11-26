Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928512C541C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389507AbgKZMlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:41:49 -0500
Received: from inva020.nxp.com ([92.121.34.13]:43122 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389007AbgKZMlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:41:47 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 50B6C1A0B97;
        Thu, 26 Nov 2020 13:41:45 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 392551A0BA9;
        Thu, 26 Nov 2020 13:41:45 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B9EBC2026B;
        Thu, 26 Nov 2020 13:41:44 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 2/5] clk: Add CLK_GET_PARENT_NOCACHE flag
Date:   Thu, 26 Nov 2020 14:40:06 +0200
Message-Id: <1606394409-12755-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606394409-12755-1-git-send-email-abel.vesa@nxp.com>
References: <1606394409-12755-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be used by the clocks that have their parents changed from EL3.
This way the clk_get_parent will read the value from register instead of
using the value stored in the core framework.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Suggested-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk.c            | 31 +++++++++++++++++--------------
 include/linux/clk-provider.h |  1 +
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c77feb6..2dd4bf4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2401,6 +2401,16 @@ int clk_set_max_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_set_max_rate);
 
+static struct clk_core *__clk_get_parent(struct clk_core *core)
+{
+	u8 index = 0;
+
+	if (core->num_parents > 1 && core->ops->get_parent)
+		index = core->ops->get_parent(core->hw);
+
+	return clk_core_get_parent_by_index(core, index);
+}
+
 /**
  * clk_get_parent - return the parent of a clk
  * @clk: the clk whose parent gets returned
@@ -2415,24 +2425,17 @@ struct clk *clk_get_parent(struct clk *clk)
 		return NULL;
 
 	clk_prepare_lock();
-	/* TODO: Create a per-user clk and change callers to call clk_put */
-	parent = !clk->core->parent ? NULL : clk->core->parent->hw->clk;
+	if (clk->core && (clk->core->flags & CLK_GET_PARENT_NOCACHE))
+		parent = __clk_get_parent(clk->core)->hw->clk;
+	else
+		/* TODO: Create a per-user clk and change callers to call clk_put */
+		parent = !clk->core->parent ? NULL : clk->core->parent->hw->clk;
 	clk_prepare_unlock();
 
 	return parent;
 }
 EXPORT_SYMBOL_GPL(clk_get_parent);
 
-static struct clk_core *__clk_init_parent(struct clk_core *core)
-{
-	u8 index = 0;
-
-	if (core->num_parents > 1 && core->ops->get_parent)
-		index = core->ops->get_parent(core->hw);
-
-	return clk_core_get_parent_by_index(core, index);
-}
-
 static void clk_core_reparent(struct clk_core *core,
 				  struct clk_core *new_parent)
 {
@@ -3352,7 +3355,7 @@ static void clk_core_reparent_orphans_nolock(void)
 	 * parent.
 	 */
 	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
-		struct clk_core *parent = __clk_init_parent(orphan);
+		struct clk_core *parent = __clk_get_parent(orphan);
 
 		/*
 		 * We need to use __clk_set_parent_before() and _after() to
@@ -3453,7 +3456,7 @@ static int __clk_core_init(struct clk_core *core)
 			goto out;
 	}
 
-	parent = core->parent = __clk_init_parent(core);
+	parent = core->parent = __clk_get_parent(core);
 
 	/*
 	 * Populate core->parent if parent has already been clk_core_init'd. If
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 81ba1aa..f871991b 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -32,6 +32,7 @@
 #define CLK_OPS_PARENT_ENABLE	BIT(12)
 /* duty cycle call may be forwarded to the parent clock */
 #define CLK_DUTY_CYCLE_PARENT	BIT(13)
+#define CLK_GET_PARENT_NOCACHE	BIT(14) /* read the parent from reg */
 
 struct clk;
 struct clk_hw;
-- 
2.7.4


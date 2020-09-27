Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A66127A2EE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgI0TzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:55:14 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:10039
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726280AbgI0TzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:55:14 -0400
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; 
   d="scan'208";a="360169487"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 27 Sep 2020 21:55:11 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/18] clk: uniphier: use semicolons rather than commas to separate statements
Date:   Sun, 27 Sep 2020 21:12:11 +0200
Message-Id: <1601233948-11629-2-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace commas with semicolons.  What is done is essentially described by
the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

// <smpl>
@@ expression e1,e2; @@
e1
-,
+;
e2
... when any
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/clk/uniphier/clk-uniphier-cpugear.c |    2 +-
 drivers/clk/uniphier/clk-uniphier-mux.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-cpugear.c b/drivers/clk/uniphier/clk-uniphier-cpugear.c
index 1a33a08abf2f..a2f01a4da127 100644
--- a/drivers/clk/uniphier/clk-uniphier-cpugear.c
+++ b/drivers/clk/uniphier/clk-uniphier-cpugear.c
@@ -90,7 +90,7 @@ struct clk_hw *uniphier_clk_register_cpugear(struct device *dev,
 	init.ops = &uniphier_clk_cpugear_ops;
 	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = data->parent_names;
-	init.num_parents = data->num_parents,
+	init.num_parents = data->num_parents;
 
 	gear->regmap = regmap;
 	gear->regbase = data->regbase;
diff --git a/drivers/clk/uniphier/clk-uniphier-mux.c b/drivers/clk/uniphier/clk-uniphier-mux.c
index c0f4631601e2..462c84321b2d 100644
--- a/drivers/clk/uniphier/clk-uniphier-mux.c
+++ b/drivers/clk/uniphier/clk-uniphier-mux.c
@@ -70,7 +70,7 @@ struct clk_hw *uniphier_clk_register_mux(struct device *dev,
 	init.ops = &uniphier_clk_mux_ops;
 	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = data->parent_names;
-	init.num_parents = data->num_parents,
+	init.num_parents = data->num_parents;
 
 	mux->regmap = regmap;
 	mux->reg = data->reg;


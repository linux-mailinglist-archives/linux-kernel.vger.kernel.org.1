Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AAF23FECE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Aug 2020 16:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgHIOuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 10:50:06 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:38039 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHIOuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 10:50:05 -0400
Received: from localhost.localdomain ([92.140.224.28])
        by mwinf5d52 with ME
        id DSq0230010dNxE403Sq0x6; Sun, 09 Aug 2020 16:50:02 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 Aug 2020 16:50:02 +0200
X-ME-IP: 92.140.224.28
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     david@lechnology.com, nsekhar@ti.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] clk: davinci: Use the correct size when allocating memory
Date:   Sun,  9 Aug 2020 16:49:59 +0200
Message-Id: <20200809144959.747986-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'sizeof(*pllen)' should be used in place of 'sizeof(*pllout)' to avoid a
small over-allocation.

Fixes: 2d1726915159 ("clk: davinci: New driver for davinci PLL clocks")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/davinci/pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 6c35e4bb7940..0d750433eb42 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -491,7 +491,7 @@ struct clk *davinci_pll_clk_register(struct device *dev,
 		parent_name = postdiv_name;
 	}
 
-	pllen = kzalloc(sizeof(*pllout), GFP_KERNEL);
+	pllen = kzalloc(sizeof(*pllen), GFP_KERNEL);
 	if (!pllen) {
 		ret = -ENOMEM;
 		goto err_unregister_postdiv;
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9742D8672
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 13:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395543AbgLLMaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 07:30:12 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:33949 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgLLMaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 07:30:07 -0500
Received: from localhost.localdomain ([93.22.36.60])
        by mwinf5d61 with ME
        id 3QUL2400B1HrHD103QULvm; Sat, 12 Dec 2020 13:28:22 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 12 Dec 2020 13:28:22 +0100
X-ME-IP: 93.22.36.60
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     krzk@kernel.org, b.zolnierkie@samsung.com, mturquette@baylibre.com,
        sboyd@kernel.org, yadi.brar@samsung.com, mturquette@linaro.org
Cc:     linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] clk: s2mps11: Fix a resource leak in error handling paths in the probe function
Date:   Sat, 12 Dec 2020 13:28:18 +0100
Message-Id: <20201212122818.86195-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some resource should be released in the error handling path of the probe
function, as already done in the remove function.

The remove function was fixed in commit bf416bd45738 ("clk: s2mps11: Add
missing of_node_put and of_clk_del_provider")

Fixes: 7cc560dea415 ("clk: s2mps11: Add support for s2mps11")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/clk-s2mps11.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index aa21371f9104..a3e883a9f406 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -195,6 +195,7 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 	return ret;
 
 err_reg:
+	of_node_put(s2mps11_clks[0].clk_np);
 	while (--i >= 0)
 		clkdev_drop(s2mps11_clks[i].lookup);
 
-- 
2.27.0


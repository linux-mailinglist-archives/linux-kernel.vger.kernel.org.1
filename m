Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A0A2DE884
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgLRRs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:48:28 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:17758 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgLRRs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:48:28 -0500
Received: from localhost.localdomain ([93.23.14.185])
        by mwinf5d07 with ME
        id 5tmb240023zZf0l03tmbXR; Fri, 18 Dec 2020 18:46:43 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 18 Dec 2020 18:46:43 +0100
X-ME-IP: 93.23.14.185
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ssantosh@kernel.org, tony@atomide.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] soc: ti: pm33xx: Fix some resource leak in the error handling paths of the probe function
Date:   Fri, 18 Dec 2020 18:46:36 +0100
Message-Id: <20201218174636.172239-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'am33xx_pm_rtc_setup()' allocates some resources that must be freed on the
error. Commit 2152fbbd47c0 ("soc: ti: pm33xx: Simplify RTC usage to prepare
to drop platform data") has introduced the use of these resources but has
only updated the remove function.

Fix the error handling path of the probe function now.

Fixes: 2152fbbd47c0 ("soc: ti: pm33xx: Simplify RTC usage to prepare to drop platform data")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/soc/ti/pm33xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index 64f3e3105540..7bab4bbaf02d 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -535,7 +535,7 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 
 	ret = am33xx_push_sram_idle();
 	if (ret)
-		goto err_free_sram;
+		goto err_unsetup_rtc;
 
 	am33xx_pm_set_ipc_ops();
 
@@ -575,6 +575,9 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 err_pm_runtime_disable:
 	pm_runtime_disable(dev);
 	wkup_m3_ipc_put(m3_ipc);
+err_unsetup_rtc:
+	iounmap(rtc_base_virt);
+	clk_put(rtc_fck);
 err_free_sram:
 	am33xx_pm_free_sram();
 	pm33xx_dev = NULL;
-- 
2.27.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C83D1BD3C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 06:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgD2Eey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 00:34:54 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:25803 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726634AbgD2Eey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 00:34:54 -0400
Received: from localhost.localdomain ([92.148.159.11])
        by mwinf5d72 with ME
        id YUak220030F2omL03UalTv; Wed, 29 Apr 2020 06:34:51 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 29 Apr 2020 06:34:51 +0200
X-ME-IP: 92.148.159.11
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
        mpe@ellerman.id.au, zhenzhong.duan@gmail.com, arnd@arndb.de,
        tglx@linutronix.de, eric.y.miao@gmail.com, daniel@caiaq.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] video: fbdev: pxa3xx_gcu: Fix some resource leak in an error handling path in 'pxa3xx_gcu_probe()'
Date:   Wed, 29 Apr 2020 06:34:38 +0200
Message-Id: <20200429043438.96212-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs in the loop where we call 'pxa3xx_gcu_add_buffer()',
any resource already allocated should be freed.

In order to fix it, add a call to 'pxa3xx_gcu_free_buffers()' in the error
handling path, as already done in the remove function.

Fixes: 364dbdf3b6c3 ("video: add driver for PXA3xx 2D graphics accelerator")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 4279e13a3b58..68d9c7a681d4 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -675,6 +675,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 
 err_disable_clk:
 	clk_disable_unprepare(priv->clk);
+	pxa3xx_gcu_free_buffers(dev, priv);
 
 	return ret;
 }
-- 
2.25.1


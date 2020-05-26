Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD191BD517
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 08:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgD2Gwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 02:52:39 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:49432 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgD2Gwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:52:39 -0400
Received: from localhost.localdomain ([92.148.159.11])
        by mwinf5d18 with ME
        id YWsd2200H0F2omL03WsdMR; Wed, 29 Apr 2020 08:52:38 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 29 Apr 2020 08:52:38 +0200
X-ME-IP: 92.148.159.11
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     richard.gong@linux.intel.com, gregkh@linuxfoundation.org,
        atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/4 v2] firmware: stratix10-svc: Fix genpool creation error handling
Date:   Wed, 29 Apr 2020 08:52:34 +0200
Message-Id: <660774ee8e63c03cb93a24d605c381eb0dce3b67.1588142343.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1588142343.git.christophe.jaillet@wanadoo.fr>
References: <cover.1588142343.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'svc_create_memory_pool()' returns an error pointer on error, not NULL.
Fix the corresponding test and return value accordingly.

Move the genpool allocation after a few devm_kzalloc in order to ease
error handling.

Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/firmware/stratix10-svc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index d5f0769f3761..3a176e62754a 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -997,10 +997,6 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	genpool = svc_create_memory_pool(pdev, sh_memory);
-	if (!genpool)
-		return -ENOMEM;
-
 	/* allocate service controller and supporting channel */
 	controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);
 	if (!controller)
@@ -1011,6 +1007,10 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	if (!chans)
 		return -ENOMEM;
 
+	genpool = svc_create_memory_pool(pdev, sh_memory);
+	if (IS_ERR(genpool))
+		return PTR_ERR(genpool);
+
 	controller->dev = dev;
 	controller->num_chans = SVC_NUM_CHANNEL;
 	controller->num_active_client = 0;
-- 
2.25.1


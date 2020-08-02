Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763E42357ED
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 17:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgHBPLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 11:11:03 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:36575 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgHBPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 11:11:03 -0400
Received: from localhost.localdomain ([93.22.148.198])
        by mwinf5d42 with ME
        id AfB02300F4H42jh03fB1mg; Sun, 02 Aug 2020 17:11:01 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Aug 2020 17:11:01 +0200
X-ME-IP: 93.22.148.198
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     3chas3@gmail.com
Cc:     linux-atm-general@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] atm: idt77252: Fix the size used in a 'dma_alloc_coherent()' call
Date:   Sun,  2 Aug 2020 17:10:59 +0200
Message-Id: <20200802151059.699977-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be TSQSIZE in order to be consistent with the surrounding code
and the corresponding 'dma_free_coherent()' in 'deinit_tsq()'

This is harmless because RSQSIZE and TSQSIZE have the same value (i.e.
8192)

Fixes: 	1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/atm/idt77252.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index df51680e8931..f459fafa902a 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -1373,7 +1373,7 @@ init_tsq(struct idt77252_dev *card)
 {
 	struct tsq_entry *tsqe;
 
-	card->tsq.base = dma_alloc_coherent(&card->pcidev->dev, RSQSIZE,
+	card->tsq.base = dma_alloc_coherent(&card->pcidev->dev, TSQSIZE,
 					    &card->tsq.paddr, GFP_KERNEL);
 	if (card->tsq.base == NULL) {
 		printk("%s: can't allocate TSQ.\n", card->name);
-- 
2.25.1


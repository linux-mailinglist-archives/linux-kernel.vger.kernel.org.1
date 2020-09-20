Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7F52712C0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 09:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgITHPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 03:15:53 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:59389 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgITHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 03:15:53 -0400
Received: from localhost.localdomain ([93.22.151.141])
        by mwinf5d49 with ME
        id W7Fo2300633He5H037Fo6F; Sun, 20 Sep 2020 09:15:49 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Sep 2020 09:15:49 +0200
X-ME-IP: 93.22.151.141
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     akpm@linux-foundation.org, natechancellor@gmail.com,
        geert+renesas@glider.be
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] lib/scatterlist: Avoid a double memset
Date:   Sun, 20 Sep 2020 09:15:44 +0200
Message-Id: <20200920071544.368841-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'sgl' is zeroed a few lines below in 'sg_init_table()'. There is no need to
clear it twice.

Remove the redundant initialization.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 lib/scatterlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 5d63a8857f36..d94628fa3349 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -504,7 +504,7 @@ struct scatterlist *sgl_alloc_order(unsigned long long length,
 		nalloc++;
 	}
 	sgl = kmalloc_array(nalloc, sizeof(struct scatterlist),
-			    (gfp & ~GFP_DMA) | __GFP_ZERO);
+			    gfp & ~GFP_DMA);
 	if (!sgl)
 		return NULL;
 
-- 
2.25.1


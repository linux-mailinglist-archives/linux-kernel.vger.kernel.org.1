Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA50271425
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 14:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgITMJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 08:09:30 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:50059 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726401AbgITMJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 08:09:15 -0400
X-IronPort-AV: E=Sophos;i="5.77,282,1596492000"; 
   d="scan'208";a="468612192"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256; 20 Sep 2020 14:08:58 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kernel-janitors@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] block: drop double zeroing
Date:   Sun, 20 Sep 2020 13:26:18 +0200
Message-Id: <1600601186-7420-7-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
References: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sg_init_table zeroes its first argument, so the allocation of that argument
doesn't have to.

the semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x;
@@

x =
- kzalloc
+ kmalloc
 (...)
...
sg_init_table(x,...)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 block/bsg-lib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/block/bsg-lib.c b/block/bsg-lib.c
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -207,7 +207,7 @@ static int bsg_map_buffer(struct bsg_buf
 
 	BUG_ON(!req->nr_phys_segments);
 
-	buf->sg_list = kzalloc(sz, GFP_KERNEL);
+	buf->sg_list = kmalloc(sz, GFP_KERNEL);
 	if (!buf->sg_list)
 		return -ENOMEM;
 	sg_init_table(buf->sg_list, req->nr_phys_segments);


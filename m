Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5F827141A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 14:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgITMJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 08:09:25 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:50064 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726405AbgITMJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 08:09:15 -0400
X-IronPort-AV: E=Sophos;i="5.77,282,1596492000"; 
   d="scan'208";a="468612193"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256; 20 Sep 2020 14:08:58 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] RDS: drop double zeroing
Date:   Sun, 20 Sep 2020 13:26:19 +0200
Message-Id: <1600601186-7420-8-git-send-email-Julia.Lawall@inria.fr>
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
expression x,n,flags;
@@

x = 
- kcalloc
+ kmalloc_array
  (n,sizeof(*x),flags)
...
sg_init_table(x,n)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 net/rds/rdma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/net/rds/rdma.c b/net/rds/rdma.c
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -269,7 +269,7 @@ static int __rds_rdma_map(struct rds_soc
 		goto out;
 	} else {
 		nents = ret;
-		sg = kcalloc(nents, sizeof(*sg), GFP_KERNEL);
+		sg = kmalloc_array(nents, sizeof(*sg), GFP_KERNEL);
 		if (!sg) {
 			ret = -ENOMEM;
 			goto out;


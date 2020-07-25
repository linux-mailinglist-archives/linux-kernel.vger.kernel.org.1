Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E100A22D637
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 10:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGYIww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 04:52:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726613AbgGYIww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 04:52:52 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 97E228D4D6552BF89A13;
        Sat, 25 Jul 2020 16:52:50 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 16:52:46 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] hpfs: convert to use le32_add_cpu()
Date:   Sat, 25 Jul 2020 16:56:13 +0800
Message-ID: <20200725085613.98222-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert cpu_to_le16(le16_to_cpu(E1) + E2) to use le16_add_cpu().

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 fs/hpfs/dnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hpfs/dnode.c b/fs/hpfs/dnode.c
index 4ada525c5..76f539601 100644
--- a/fs/hpfs/dnode.c
+++ b/fs/hpfs/dnode.c
@@ -208,7 +208,7 @@ static void hpfs_delete_de(struct super_block *s, struct dnode *d,
 		hpfs_error(s, "attempt to delete last dirent in dnode %08x", le32_to_cpu(d->self));
 		return;
 	}
-	d->first_free = cpu_to_le32(le32_to_cpu(d->first_free) - le16_to_cpu(de->length));
+	le32_add_cpu(&d->first_free, -le16_to_cpu(de->length));
 	memmove(de, de_next_de(de), le32_to_cpu(d->first_free) + (char *)d - (char *)de);
 }
 
-- 
2.25.1


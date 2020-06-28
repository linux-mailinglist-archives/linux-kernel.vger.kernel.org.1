Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD09E20C7E6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 14:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgF1MaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 08:30:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbgF1MaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 08:30:18 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AC6F8B8F7D5A3835E5DC;
        Sun, 28 Jun 2020 20:30:14 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Sun, 28 Jun 2020 20:30:06 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: fix wrong return value of f2fs_bmap_compress()
Date:   Sun, 28 Jun 2020 20:29:38 +0800
Message-ID: <20200628122940.29665-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If compression is disable, we should return zero rather than -EOPNOTSUPP
to indicate f2fs_bmap() is not supported.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dfd322515357..91dc7b598961 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3703,10 +3703,9 @@ static sector_t f2fs_bmap_compress(struct inode *inode, sector_t block)
 	}
 
 	f2fs_put_dnode(&dn);
-
 	return blknr;
 #else
-	return -EOPNOTSUPP;
+	return 0;
 #endif
 }
 
-- 
2.26.2


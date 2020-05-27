Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480B01E3EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 12:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgE0K2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 06:28:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726965AbgE0K2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:28:06 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0A807683E807A536D497;
        Wed, 27 May 2020 18:28:01 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 27 May 2020 18:27:54 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: fix wrong value of tracepoint parameter
Date:   Wed, 27 May 2020 18:27:51 +0800
Message-ID: <20200527102753.15743-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_lookup(), we should set @err correctly before printing it
in tracepoint.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 63b34a161cf4..2c2f8c36c828 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -504,6 +504,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 			err = PTR_ERR(page);
 			goto out;
 		}
+		err = -ENOENT;
 		goto out_splice;
 	}
 
@@ -549,7 +550,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 #endif
 	new = d_splice_alias(inode, dentry);
 	err = PTR_ERR_OR_ZERO(new);
-	trace_f2fs_lookup_end(dir, dentry, ino, err);
+	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
 	return new;
 out_iput:
 	iput(inode);
-- 
2.18.0.rc1


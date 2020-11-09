Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00422AC197
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgKIQ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:59:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbgKIQ7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:59:16 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB17820789;
        Mon,  9 Nov 2020 16:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604941155;
        bh=WGEcmPXvVRi61x7imWKMEdS2fqmM9HkxAxRybtdcPMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=mbzMWX6TniVjfRm/Dzn3m2IZcq5w1+5WtbJ+g2OhO0bjQwetVouM6RJMdI/rRT2Ne
         WcYtRaSgGZ9qwSYy8MR8EVzova6W1sGBuPWV2LGAU8wZsDpnzcSxTBm5IlzhbCRaTp
         E2yAIdN/SO2j939M9w1a0RZPGx86HZ00RdQmipVQ=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid unneeded data copy in f2fs_ioc_move_range()
Date:   Mon,  9 Nov 2020 08:59:14 -0800
Message-Id: <20201109165914.2118360-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Fields in struct f2fs_move_range won't change in f2fs_ioc_move_range(),
let's avoid copying this structure's data to userspace.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 52417a2e3f4f..22ae8ae0072f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2898,12 +2898,6 @@ static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
 					range.pos_out, range.len);
 
 	mnt_drop_write_file(filp);
-	if (err)
-		goto err_out;
-
-	if (copy_to_user((struct f2fs_move_range __user *)arg,
-						&range, sizeof(range)))
-		err = -EFAULT;
 err_out:
 	fdput(dst);
 	return err;
-- 
2.29.2.222.g5d2a92d10f8-goog


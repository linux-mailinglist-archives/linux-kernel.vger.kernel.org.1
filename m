Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553B41F31ED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 03:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgFIBWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 21:22:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60096 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726895AbgFIBWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 21:22:17 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 04AFF35E5A7AEEBD6161;
        Tue,  9 Jun 2020 09:22:13 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 9 Jun 2020
 09:22:12 +0800
Subject: Re: [PATCH v2] f2fs: use kfree() instead of kvfree() to free
 superblock data
To:     Denis Efremov <efremov@linux.com>, Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20200605181533.73113-1-efremov@linux.com>
 <20200608154123.235198-1-efremov@linux.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d5462b81-6b32-0810-026f-1c07e166cbc8@huawei.com>
Date:   Tue, 9 Jun 2020 09:22:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200608154123.235198-1-efremov@linux.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Denis,

On 2020/6/8 23:41, Denis Efremov wrote:
> Use kfree() instead of kvfree() to free super in read_raw_super_block()
> because the memory is allocated with kzalloc() in the function.
> Use kfree() instead of kvfree() to free sbi in f2fs_fill_super() and
> f2fs_put_super() because the memory is allocated with kzalloc().
> 
> Fixes: 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")
> Signed-off-by: Denis Efremov <efremov@linux.com>

I found two missing cases, so how about this?

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f3c151169542..f913a63e93f0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1206,7 +1206,7 @@ static void f2fs_put_super(struct super_block *sb)
 	sb->s_fs_info = NULL;
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
-	kvfree(sbi->raw_super);
+	kfree(sbi->raw_super);

 	destroy_device_list(sbi);
 	f2fs_destroy_xattr_caches(sbi);
@@ -1221,7 +1221,7 @@ static void f2fs_put_super(struct super_block *sb)
 #ifdef CONFIG_UNICODE
 	utf8_unload(sbi->s_encoding);
 #endif
-	kvfree(sbi);
+	kfree(sbi);
 }

 int f2fs_sync_fs(struct super_block *sb, int sync)
@@ -3101,7 +3101,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,

 	/* No valid superblock */
 	if (!*raw_super)
-		kvfree(super);
+		kfree(super);
 	else
 		err = 0;

@@ -3779,11 +3779,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 #endif
 	kvfree(options);
 free_sb_buf:
-	kvfree(raw_super);
+	kfree(raw_super);
 free_sbi:
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
-	kvfree(sbi);
+	kfree(sbi);

 	/* give only one another chance */
 	if (retry_cnt > 0 && skip_recovery) {


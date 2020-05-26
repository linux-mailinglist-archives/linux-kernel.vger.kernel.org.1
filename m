Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A551B6A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 03:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgDXBAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 21:00:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2881 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbgDXBAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 21:00:47 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AF19B14DBE6D1F9293D6;
        Fri, 24 Apr 2020 09:00:44 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 24 Apr
 2020 09:00:42 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix quota_sync failure due to
 f2fs_lock_op
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200409173056.229855-1-jaegeuk@kernel.org>
 <77e9f2e6-f3f3-8ca9-e6b5-3d57c4d2acc5@huawei.com>
 <20200416213946.GA196168@google.com>
 <fd8b116a-7830-809c-70a4-a3a12da1eb14@huawei.com>
 <20200423194952.GA99191@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e67273bc-7416-c86e-58ba-c025029e8099@huawei.com>
Date:   Fri, 24 Apr 2020 09:00:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200423194952.GA99191@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/24 3:49, Jaegeuk Kim wrote:
> On 04/23, Chao Yu wrote:
>> On 2020/4/17 5:39, Jaegeuk Kim wrote:
>>> f2fs_quota_sync() uses f2fs_lock_op() before flushing dirty pages, but
>>> f2fs_write_data_page() returns EAGAIN.
>>> Likewise dentry blocks, we can just bypass getting the lock, since quota
>>> blocks are also maintained by checkpoint.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>> v2:
>>>  - fix multipage write case
>>>
>>>  fs/f2fs/compress.c | 2 +-
>>>  fs/f2fs/data.c     | 4 ++--
>>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>>> index df7b2d15eacde..faaa358289010 100644
>>> --- a/fs/f2fs/compress.c
>>> +++ b/fs/f2fs/compress.c
>>> @@ -985,7 +985,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>>>  	loff_t psize;
>>>  	int i, err;
>>>  
>>> -	if (!f2fs_trylock_op(sbi))
>>> +	if (!IS_NOQUOTA(inode) && !f2fs_trylock_op(sbi))
>>>  		return -EAGAIN;
>>
>> I encounter deadlock..
>>
>> Should call f2fs_unlock_op() for non-quota compressed inode later.
> 
> Could you elaborate a bit?

I meant we need to change as below, otherwise, cp_rwsem can be negative
after f2fs_unlock_op if writebacked datas are belong to compressed quota
file.

From 817dc629c47d3000c595640ecb3099b880519d47 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 9 Apr 2020 10:25:21 -0700
Subject: [PATCH] f2fs: fix quota_sync failure due to f2fs_lock_op

f2fs_quota_sync() uses f2fs_lock_op() before flushing dirty pages, but
f2fs_write_data_page() returns EAGAIN.
Likewise dentry blocks, we can just bypass getting the lock, since quota
blocks are also maintained by checkpoint.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c | 8 +++++---
 fs/f2fs/data.c     | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index df7b2d15eacd..26b071afe48a 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -985,7 +985,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	loff_t psize;
 	int i, err;

-	if (!f2fs_trylock_op(sbi))
+	if (!IS_NOQUOTA(inode) && !f2fs_trylock_op(sbi))
 		return -EAGAIN;

 	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
@@ -1092,7 +1092,8 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);

 	f2fs_put_dnode(&dn);
-	f2fs_unlock_op(sbi);
+	if (!IS_NOQUOTA(inode))
+		f2fs_unlock_op(sbi);

 	spin_lock(&fi->i_size_lock);
 	if (fi->last_disk_size < psize)
@@ -1118,7 +1119,8 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 out_put_dnode:
 	f2fs_put_dnode(&dn);
 out_unlock_op:
-	f2fs_unlock_op(sbi);
+	if (!IS_NOQUOTA(inode))
+		f2fs_unlock_op(sbi);
 	return -EAGAIN;
 }

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8dd48c5b6c0d..dd439dbb134d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2660,8 +2660,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 			f2fs_available_free_memory(sbi, BASE_CHECK))))
 		goto redirty_out;

-	/* Dentry blocks are controlled by checkpoint */
-	if (S_ISDIR(inode->i_mode)) {
+	/* Dentry/quota blocks are controlled by checkpoint */
+	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
 		fio.need_lock = LOCK_DONE;
 		err = f2fs_do_write_data_page(&fio);
 		goto done;
-- 
2.18.0.rc1



> 
>>
>> Thanks,
>>
>>>  
>>>  	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index accd28728642a..5c8d3823d7593 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -2656,8 +2656,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
>>>  			f2fs_available_free_memory(sbi, BASE_CHECK))))
>>>  		goto redirty_out;
>>>  
>>> -	/* Dentry blocks are controlled by checkpoint */
>>> -	if (S_ISDIR(inode->i_mode)) {
>>> +	/* Dentry/quota blocks are controlled by checkpoint */
>>> +	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
>>>  		fio.need_lock = LOCK_DONE;
>>>  		err = f2fs_do_write_data_page(&fio);
>>>  		goto done;
>>>
> .
> 

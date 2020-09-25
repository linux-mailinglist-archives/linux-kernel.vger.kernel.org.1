Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6876D278EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgIYQiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbgIYQiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:38:21 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E52206BE;
        Fri, 25 Sep 2020 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601051901;
        bh=QGgqzYHKwLhU8qGchhG95ocnro20Uloj/gEjGanOpKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WXZNV2sUi/3rDC09k4sGxhoTano9Jr5dbiDuP626WoskNDGjMd0MRTKAnMKx4XQxz
         nIHpWb7E/D/qUUuw2r65VKRu9FEMgK2yAyy47ShyMUlLxmwtDf7Si917sgWXqYImby
         QLuYCTdxfodQirmxcyN15uEStZSRHx5K10lZ3IMk=
Date:   Fri, 25 Sep 2020 09:38:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     syzbot <syzbot+0eac6f0bbd558fd866d7@syzkaller.appspotmail.com>,
        chao@kernel.org, glider@google.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [f2fs-dev] KMSAN: uninit-value in f2fs_lookup
Message-ID: <20200925163819.GA3315208@gmail.com>
References: <000000000000f9f80905b01c7185@google.com>
 <eb03a5c9-eb77-eb91-e17f-8a3273aab7da@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb03a5c9-eb77-eb91-e17f-8a3273aab7da@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 05:06:33PM +0800, Chao Yu wrote:
> Hi,
> 
> I don't see any problem here, thanks for your report. :)
> 
> Thanks,

What about if max_depth == 0 in __f2fs_find_entry()?  Then __f2fs_find_entry()
would return NULL without initializing *res_page.

A fix could be:

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 069f498af1e3..ceb4431b5669 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -357,16 +357,15 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	unsigned int max_depth;
 	unsigned int level;
 
+	*res_page = NULL;
+
 	if (f2fs_has_inline_dentry(dir)) {
-		*res_page = NULL;
 		de = f2fs_find_in_inline_dir(dir, fname, res_page);
 		goto out;
 	}
 
-	if (npages == 0) {
-		*res_page = NULL;
+	if (npages == 0)
 		goto out;
-	}
 
 	max_depth = F2FS_I(dir)->i_current_depth;
 	if (unlikely(max_depth > MAX_DIR_HASH_DEPTH)) {
@@ -377,7 +376,6 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	}
 
 	for (level = 0; level < max_depth; level++) {
-		*res_page = NULL;
 		de = find_in_level(dir, level, fname, res_page);
 		if (de || IS_ERR(*res_page))
 			break;

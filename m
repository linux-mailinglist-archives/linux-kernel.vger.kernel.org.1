Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B2E268318
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 05:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgINDZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 23:25:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11825 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbgINDZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 23:25:04 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 09D43150C717E0C64E0F;
        Mon, 14 Sep 2020 11:25:02 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.214) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 11:24:55 +0800
Subject: Re: [PATCH 1/2] ubifs: xattr: Fix some potential memory leaks while
 iterating entries
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <20200601091037.3794172-1-chengzhihao1@huawei.com>
 <CAFLxGvxA9pw8D6Q8GbBD0SUP+EHhOsZmRMSPxrW4sq0gYi9N9Q@mail.gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <b82cd435-437d-e384-c95e-a7e031559c7e@huawei.com>
Date:   Mon, 14 Sep 2020 11:24:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvxA9pw8D6Q8GbBD0SUP+EHhOsZmRMSPxrW4sq0gYi9N9Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.214]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/9/14 3:08, Richard Weinberger 写道:
> On Mon, Jun 1, 2020 at 11:11 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>

> I agree that this needs fixing. Did you also look into getting rid of pxent?
> UBIFS uses the pxent pattern over and over and the same error got copy pasted
> a lot. :-(
> 
I thought about it. I'm not sure whether it is good to drop 'pxent'. 
Maybe you mean doing changes looks like following(Takes 
ubifs_jnl_write_inode() for example):

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 4a5b06f8d812..fcd5ac047b34 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -879,13 +879,19 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, 
const struct inode *inode)
  		union ubifs_key key;
  		struct fscrypt_name nm = {0};
  		struct inode *xino;
-		struct ubifs_dent_node *xent, *pxent = NULL;
+		struct ubifs_dent_node *xent;

  		if (ui->xattr_cnt >= ubifs_xattr_max_cnt(c)) {
  			ubifs_err(c, "Cannot delete inode, it has too much xattrs!");
  			goto out_release;
  		}

+		fname_name(&nm) = kmalloc(UBIFS_MAX_NLEN, GFP_NOFS);
+		if (!fname_name(&nm)) {
+			err = -ENOMEM;
+			goto out_release;
+		}
+
  		lowest_xent_key(c, &key, inode->i_ino);
  		while (1) {
  			xent = ubifs_tnc_next_ent(c, &key, &nm);
@@ -894,11 +900,12 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, 
const struct inode *inode)
  				if (err == -ENOENT)
  					break;

+				kfree(fname_name(&nm));
  				goto out_release;
  			}

-			fname_name(&nm) = xent->name;
  			fname_len(&nm) = le16_to_cpu(xent->nlen);
+			strncpy(fname_name(&nm), xent->name, fname_len(&nm));

  			xino = ubifs_iget(c->vfs_sb, le64_to_cpu(xent->inum));
  			if (IS_ERR(xino)) {
@@ -907,6 +914,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, 
const struct inode *inode)
  					  xent->name, err);
  				ubifs_ro_mode(c, err);
  				kfree(xent);
+				kfree(fname_name(&nm));
  				goto out_release;
  			}
  			ubifs_assert(c, ubifs_inode(xino)->xattr);
@@ -916,11 +924,10 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, 
const struct inode *inode)
  			ino = (void *)ino + UBIFS_INO_NODE_SZ;
  			iput(xino);

-			kfree(pxent);
-			pxent = xent;
  			key_read(c, &xent->key, &key);
+			kfree(xent);
  		}
-		kfree(pxent);
+		kfree(fname_name(&nm));
  	}

  	pack_inode(c, ino, inode, 1);

The kill_xattrs process is more intuitive without the pxent. However, 
the release process for the memory (stores xent->name) is similar to 
'pxent'. If you think it's better than v1, I will send v2.


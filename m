Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7797C2B3737
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 18:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbgKORkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 12:40:46 -0500
Received: from m12-12.163.com ([220.181.12.12]:47013 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgKORkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 12:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=M9YE+
        nEi7ToBJssgtcVSR4GHXesbHG/ju79zY8NhtOk=; b=hMf4/uI0UjRZ8+Rhx6JUm
        eDB2g4JJ/S6OH2RrVB2/25JbUTniHgs+mBoW1CRqQTpiHHSy+WdP18kao+RdogeZ
        3+IMrCjUkeVmBdhr/IaggPj7SN0mFeO72D8ueNdWcbX6HZjR4/a/1C2tHQssMnCK
        ziXnJberGk6P+kqUk6vxOI=
Received: from localhost (unknown [101.86.213.176])
        by smtp8 (Coremail) with SMTP id DMCowAC3SdgLaLFfPOWJBw--.63244S2;
        Mon, 16 Nov 2020 01:40:27 +0800 (CST)
Date:   Mon, 16 Nov 2020 01:40:26 +0800
From:   Hui Su <sh_def@163.com>
To:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] mm/shmem: use kmem_cache_zalloc in shmem_alloc_inode()
Message-ID: <20201115174026.GA365412@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DMCowAC3SdgLaLFfPOWJBw--.63244S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw47GrWrJFWDury7ur1xXwb_yoW8Jw1rpF
        W7Gw18Ja15XFyIgrW8tr4kuryrKayxKrW2ya42qwsIv3Z0q340gF4UtFy5ZFyrCFWxZF4S
        vr10kr18uF45ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UONVkUUUUU=
X-Originating-IP: [101.86.213.176]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiJgvdX1v2fAJsmgAAsK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in shmem_get_inode():
new_inode();
  new_inode_pseudo();
    alloc_inode();
      ops->alloc_inode(); -> shmem_alloc_inode()
        kmem_cache_alloc();

memset(info, 0, (char *)inode - (char *)info);

So use kmem_cache_zalloc() in shmem_alloc_inode(),
and remove the memset in shmem_get_inode().

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/shmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 537c137698f8..b84adda45461 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2308,7 +2308,6 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode->i_generation = prandom_u32();
 		info = SHMEM_I(inode);
-		memset(info, 0, (char *)inode - (char *)info);
 		spin_lock_init(&info->lock);
 		atomic_set(&info->stop_eviction, 0);
 		info->seals = F_SEAL_SEAL;
@@ -3828,7 +3827,7 @@ static struct kmem_cache *shmem_inode_cachep;
 static struct inode *shmem_alloc_inode(struct super_block *sb)
 {
 	struct shmem_inode_info *info;
-	info = kmem_cache_alloc(shmem_inode_cachep, GFP_KERNEL);
+	info = kmem_cache_zalloc(shmem_inode_cachep, GFP_KERNEL);
 	if (!info)
 		return NULL;
 	return &info->vfs_inode;
-- 
2.29.0



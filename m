Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE6A2B2078
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgKMQ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:28:45 -0500
Received: from m12-13.163.com ([220.181.12.13]:32789 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgKMQ2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=w2BQA
        sMLFD23/RsKBW5LfLuDr6E3ojWa2/MmrEL46cc=; b=kUV2N3gZoRmAlrSdsCkzF
        NhOixRcl0/p0fB8jn/Mo5KWKvuAIMbC6w5vIUG2SGaWtFZZqEVuekgyApn0g/tnB
        k8J7f3urDWjb/IpX0KqF63hPQ93idcRL+n5fXvDE2x/7JWGkCqsAurZ0qrZNuVHr
        09Ws8fb4X1bJpuF4iq/iPU=
Received: from localhost (unknown [101.86.208.122])
        by smtp9 (Coremail) with SMTP id DcCowAD3qzkTkK5fs_btQQ--.30535S2;
        Fri, 13 Nov 2020 21:54:27 +0800 (CST)
Date:   Fri, 13 Nov 2020 21:54:27 +0800
From:   Hui Su <sh_def@163.com>
To:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] mm/shmem.c: make shmem_mapping() inline
Message-ID: <20201113135427.GA167783@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DcCowAD3qzkTkK5fs_btQQ--.30535S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4UXw4xAr45GFyrGw17ZFb_yoW8Aw1UpF
        98Aw15Cr4UWryjgFWIva18Zryaqa1kJ3y0yry3W3s0yF1kKFy7tF4jkr1qvFy5Ary8Cw42
        qrW2k3y0kr1UtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4lk3UUUUU=
X-Originating-IP: [101.86.208.122]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiMQbbX1UMWVTI8wABsd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inline the shmem_mapping(), and use shmem_mapping()
instead of 'inode->i_mapping->a_ops == &shmem_aops'
in shmem_evict_inode().

Signed-off-by: Hui Su <sh_def@163.com>
---
 include/linux/shmem_fs.h | 2 +-
 mm/shmem.c               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index a5a5d1d4d7b1..154a16fe7fd5 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -67,7 +67,7 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct user_struct *user);
 #ifdef CONFIG_SHMEM
-extern bool shmem_mapping(struct address_space *mapping);
+extern inline bool shmem_mapping(struct address_space *mapping);
 #else
 static inline bool shmem_mapping(struct address_space *mapping)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index 537c137698f8..7395d8e8226a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1152,7 +1152,7 @@ static void shmem_evict_inode(struct inode *inode)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 
-	if (inode->i_mapping->a_ops == &shmem_aops) {
+	if (shmem_mapping(inode->i_mapping)) {
 		shmem_unacct_size(info->flags, inode->i_size);
 		inode->i_size = 0;
 		shmem_truncate_range(inode, 0, (loff_t)-1);
@@ -2352,7 +2352,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 	return inode;
 }
 
-bool shmem_mapping(struct address_space *mapping)
+inline bool shmem_mapping(struct address_space *mapping)
 {
 	return mapping->a_ops == &shmem_aops;
 }
-- 
2.29.0



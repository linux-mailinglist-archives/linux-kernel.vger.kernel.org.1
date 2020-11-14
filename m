Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8062B2BC7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 07:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgKNGkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 01:40:39 -0500
Received: from m12-13.163.com ([220.181.12.13]:34511 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgKNGkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 01:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=lkm4a
        +uLOZfmtVm/YQoveCEH7utKvlhIajwwKMP3Kgw=; b=MXzIXe2bbsDdYAlNT6bZB
        frpV3jFJV/GZn4JcitLGaZjCdjSBRDPIvFUqbRZGTeBhy8KcXbcsxr9Pe+e74OEL
        UoEqWPum7ZnvuqFIk2nQOX/AoyOEivS+CCw/lsOIX+n9bZe3x1VSh7imnpI3qWaF
        /f7iH4njpNcEv6LnHaG1UI=
Received: from localhost (unknown [101.86.213.176])
        by smtp9 (Coremail) with SMTP id DcCowADXbmtmcK9fE_lkQg--.57491S2;
        Sat, 14 Nov 2020 13:51:35 +0800 (CST)
Date:   Sat, 14 Nov 2020 13:51:34 +0800
From:   Hui Su <sh_def@163.com>
To:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pankaj.gupta.linux@gmail.com,
        lkp@intel.com
Cc:     sh_def@163.com
Subject: [PATCH v2] mm/shmem.c: make shmem_mapping() inline
Message-ID: <20201114055134.GA186011@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DcCowADXbmtmcK9fE_lkQg--.57491S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jw1xJr15WrWxJry7uF45ZFb_yoW8JF1UpF
        y3Cw1rCrW8XFy2gFW0qa18Zryaqa1kJ3y0y3s8Gwn0vF1kJa4UtF1jkF12vFW5AFy8Cw42
        qr42kF109w4UtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Un6pPUUUUU=
X-Originating-IP: [101.86.213.176]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiLgfcX1SIq0wwugAAsb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inline the shmem_mapping(), and use shmem_mapping()
instead of 'inode->i_mapping->a_ops == &shmem_aops'
in shmem_evict_inode().

v1->v2:
remove the inline for func declaration in shmem_fs.h

Reviewed-by: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/shmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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



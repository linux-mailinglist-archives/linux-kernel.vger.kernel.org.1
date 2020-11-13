Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2077A2B1BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgKMNWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:22:00 -0500
Received: from m12-15.163.com ([220.181.12.15]:57723 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgKMNV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=63OUI
        zw2aUGnCBaiNypesrO/7WLRAJafkbBWFnu57xE=; b=To8U5WSUNc+3g+D02xeTj
        QQk5oWBhGada7BIenBO5D/67dG7aAbnLcoj5kD812M9zxi6rDZsNigiaQJx1fPRR
        8Z+ssH0aLFKbf1+fYN1lGz4hjgJM36mq3vBYvQ+RJ6NHA/HgfXkR7tF8ugYkZTTc
        hEbAVUssYlzz8Ku0yiImOg=
Received: from localhost (unknown [101.86.208.122])
        by smtp11 (Coremail) with SMTP id D8CowACHSz1niK5fnjh5Aw--.40599S2;
        Fri, 13 Nov 2020 21:21:43 +0800 (CST)
Date:   Fri, 13 Nov 2020 21:21:43 +0800
From:   Hui Su <sh_def@163.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] fs/kernfs: remove the double check of dentry->inode
Message-ID: <20201113132143.GA119541@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: D8CowACHSz1niK5fnjh5Aw--.40599S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruryDZryDZw1DJr13Kw43Awb_yoW3Cwb_CF
        18XrZakrW7Xr1xJrs8C39Iqr4av3Z8ur1vka1rJayUta4qywn8G3Z5J3Z8XryxW34fGr95
        AF1DA34vyryUtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1fOzPUUUUU==
X-Originating-IP: [101.86.208.122]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbitwfbX1aEGYqtAAAAsY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In both kernfs_node_from_dentry() and in
kernfs_dentry_node(), we will check the dentry->inode
is NULL or not, which is superfluous.

So remove the check in kernfs_node_from_dentry().

Signed-off-by: Hui Su <sh_def@163.com>
---
 fs/kernfs/dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 9aec80b9d7c6..b062c666df05 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -604,8 +604,7 @@ const struct dentry_operations kernfs_dops = {
  */
 struct kernfs_node *kernfs_node_from_dentry(struct dentry *dentry)
 {
-	if (dentry->d_sb->s_op == &kernfs_sops &&
-	    !d_really_is_negative(dentry))
+	if (dentry->d_sb->s_op == &kernfs_sops)
 		return kernfs_dentry_node(dentry);
 	return NULL;
 }
-- 
2.29.0



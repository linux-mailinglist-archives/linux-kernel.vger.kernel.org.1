Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49552B17A7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgKMI6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:58:45 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:36172 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbgKMI6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:58:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UFAepvk_1605257910;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFAepvk_1605257910)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Nov 2020 16:58:38 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] configfs: fix kernel-doc markup issue
Date:   Fri, 13 Nov 2020 16:58:13 +0800
Message-Id: <1605257895-5536-4-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605257895-5536-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605257895-5536-1-git-send-email-alex.shi@linux.alibaba.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add explanation for 'frag' parameter to avoid kernel-doc issue:
fs/configfs/dir.c:277: warning: Function parameter or member 'frag' not
described in 'configfs_create_dir'

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Joel Becker <jlbec@evilplan.org> 
Cc: Christoph Hellwig <hch@lst.de> 
Cc: linux-kernel@vger.kernel.org 
---
 fs/configfs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index b0983e2a4e2c..b839dd1b459f 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -267,6 +267,7 @@ static void configfs_remove_dirent(struct dentry *dentry)
  *	configfs_create_dir - create a directory for an config_item.
  *	@item:		config_itemwe're creating directory for.
  *	@dentry:	config_item's dentry.
+ *	@frag:		config_item's fragment.
  *
  *	Note: user-created entries won't be allowed under this new directory
  *	until it is validated by configfs_dir_set_ready()
-- 
2.29.GIT


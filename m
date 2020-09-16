Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7893C26BA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgIPC3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:29:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbgIPC16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:27:58 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C48CB9466F007020C82C;
        Wed, 16 Sep 2020 10:27:52 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 10:27:45 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
CC:     <cluster-devel@redhat.com>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] gfs2: convert to use DEFINE_SEQ_ATTRIBUTE macro
Date:   Wed, 16 Sep 2020 10:50:21 +0800
Message-ID: <20200916025021.3992575-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 fs/gfs2/glock.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index f13b136654ca..15c5c26f6ae7 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2415,7 +2415,7 @@ static const struct seq_operations gfs2_glstats_seq_ops = {
 	.show  = gfs2_glstats_seq_show,
 };
 
-static const struct seq_operations gfs2_sbstats_seq_ops = {
+static const struct seq_operations gfs2_sbstats_sops = {
 	.start = gfs2_sbstats_seq_start,
 	.next  = gfs2_sbstats_seq_next,
 	.stop  = gfs2_sbstats_seq_stop,
@@ -2468,16 +2468,6 @@ static int gfs2_glstats_open(struct inode *inode, struct file *file)
 	return __gfs2_glocks_open(inode, file, &gfs2_glstats_seq_ops);
 }
 
-static int gfs2_sbstats_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &gfs2_sbstats_seq_ops);
-	if (ret == 0) {
-		struct seq_file *seq = file->private_data;
-		seq->private = inode->i_private;  /* sdp */
-	}
-	return ret;
-}
-
 static const struct file_operations gfs2_glocks_fops = {
 	.owner   = THIS_MODULE,
 	.open    = gfs2_glocks_open,
@@ -2494,13 +2484,7 @@ static const struct file_operations gfs2_glstats_fops = {
 	.release = gfs2_glocks_release,
 };
 
-static const struct file_operations gfs2_sbstats_fops = {
-	.owner   = THIS_MODULE,
-	.open	 = gfs2_sbstats_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
-};
+DEFINE_SEQ_ATTRIBUTE(gfs2_sbstats);
 
 void gfs2_create_debugfs_file(struct gfs2_sbd *sdp)
 {
-- 
2.25.1


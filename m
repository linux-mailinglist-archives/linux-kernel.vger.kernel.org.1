Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A24026FCB4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgIRMjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:39:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbgIRMjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:39:44 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3C2E126788BB5678895E;
        Fri, 18 Sep 2020 20:39:41 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 20:39:36 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <konishi.ryusuke@gmail.com>
CC:     <linux-nilfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] nilfs2: Fix some kernel-doc warnings for nilfs2
Date:   Fri, 18 Sep 2020 20:36:40 +0800
Message-ID: <20200918123640.72014-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

fs/nilfs2/bmap.c:378: warning: Excess function parameter 'bhp' description in 'nilfs_bmap_assign'
fs/nilfs2/cpfile.c:907: warning: Excess function parameter 'status' description in 'nilfs_cpfile_change_cpmode'
fs/nilfs2/cpfile.c:946: warning: Excess function parameter 'stat' description in 'nilfs_cpfile_get_stat'
fs/nilfs2/page.c:76: warning: Excess function parameter 'inode' description in 'nilfs_forget_buffer'
fs/nilfs2/sufile.c:563: warning: Excess function parameter 'stat' description in 'nilfs_sufile_get_stat'

Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/nilfs2/bmap.c   | 2 +-
 fs/nilfs2/cpfile.c | 6 +++---
 fs/nilfs2/page.c   | 1 -
 fs/nilfs2/sufile.c | 4 ++--
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index e516ae389ca5..5900879d5693 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -355,7 +355,7 @@ void nilfs_bmap_lookup_dirty_buffers(struct nilfs_bmap *bmap,
 /**
  * nilfs_bmap_assign - assign a new block number to a block
  * @bmap: bmap
- * @bhp: pointer to buffer head
+ * @bh: pointer to buffer head
  * @blocknr: block number
  * @binfo: block information
  *
diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index 86d4d850d130..025fb082575a 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -889,7 +889,7 @@ int nilfs_cpfile_is_snapshot(struct inode *cpfile, __u64 cno)
  * nilfs_cpfile_change_cpmode - change checkpoint mode
  * @cpfile: inode of checkpoint file
  * @cno: checkpoint number
- * @status: mode of checkpoint
+ * @mode: mode of checkpoint
  *
  * Description: nilfs_change_cpmode() changes the mode of the checkpoint
  * specified by @cno. The mode @mode is NILFS_CHECKPOINT or NILFS_SNAPSHOT.
@@ -930,12 +930,12 @@ int nilfs_cpfile_change_cpmode(struct inode *cpfile, __u64 cno, int mode)
 /**
  * nilfs_cpfile_get_stat - get checkpoint statistics
  * @cpfile: inode of checkpoint file
- * @stat: pointer to a structure of checkpoint statistics
+ * @cpstat: pointer to a structure of checkpoint statistics
  *
  * Description: nilfs_cpfile_get_stat() returns information about checkpoints.
  *
  * Return Value: On success, 0 is returned, and checkpoints information is
- * stored in the place pointed by @stat. On error, one of the following
+ * stored in the place pointed by @cpstat. On error, one of the following
  * negative error codes is returned.
  *
  * %-EIO - I/O error.
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index b175f1330408..171fb5cd427f 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -69,7 +69,6 @@ struct buffer_head *nilfs_grab_buffer(struct inode *inode,
 
 /**
  * nilfs_forget_buffer - discard dirty state
- * @inode: owner inode of the buffer
  * @bh: buffer head of the buffer to be discarded
  */
 void nilfs_forget_buffer(struct buffer_head *bh)
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index 42ff67c0c14f..63722475e17e 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -546,13 +546,13 @@ int nilfs_sufile_set_segment_usage(struct inode *sufile, __u64 segnum,
 /**
  * nilfs_sufile_get_stat - get segment usage statistics
  * @sufile: inode of segment usage file
- * @stat: pointer to a structure of segment usage statistics
+ * @sustat: pointer to a structure of segment usage statistics
  *
  * Description: nilfs_sufile_get_stat() returns information about segment
  * usage.
  *
  * Return Value: On success, 0 is returned, and segment usage information is
- * stored in the place pointed by @stat. On error, one of the following
+ * stored in the place pointed by @sustat. On error, one of the following
  * negative error codes is returned.
  *
  * %-EIO - I/O error.
-- 
2.17.1


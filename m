Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7152227CF31
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgI2NbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgI2NbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:31:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D23EC061755;
        Tue, 29 Sep 2020 06:31:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so4523932pfp.11;
        Tue, 29 Sep 2020 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ho5XezCi0jEfIdNYgqbsGvsWzc8ifvPB5JxGwZPouQQ=;
        b=NcYxnt9XPk5/JLAUMEen4gOOPY7m5+YdRgGzDkLDladhA//K9z5U+swN4EuIQbpHwl
         crN3kukT6dh1Tl7OSAPP38gxOQ3/gGQ5yj+ZWwJFl8FlTEgeBAxv644qQkHRDUpd47C7
         oshXnTYDEFtJciVF2mS9TXysQuugFKZDw+BwFfvNLYriUpclzy/Vcecdu7H6bFfZwCTH
         hPmdFNdhZkk4+N8mYIWUQbaEmd+mkHqdW8kTgsHvNMREYD2/OeEdw8CxYR0yDaoMXYog
         z/EDM2WzoaGOH0o0S6MRKnX2pIIvgN5BCKc8LEzKuxCNRC7X6pqQLIIKMHWHq3RDJRmw
         xXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ho5XezCi0jEfIdNYgqbsGvsWzc8ifvPB5JxGwZPouQQ=;
        b=V+/DWRLdd5FaubEaEbnxfdS4OA/GuKOOXHHj8/sr2zTzEFc3JYXgLkl33qZzmYHPho
         mzXn0d7Vnxqz/JLz3HFqNFgF9nSLajVoH5nsX4m6GNnXfoM1snJZSRVNo5DQuCFam2kR
         zWi49qSgAatoUoGlvsu7czjE8h1XVDvDZ/5wLcJsCVbPU8MVKMc6Y7z6Wt+7tRjEiuBe
         Y68BUUWZgASXfujqu8ilUvJV4tx+Grwhh6EqUk7seMd0OHT41SeLfPK1Jc8QJ1+oCIRe
         OyJATLu4NDfitP27WLlOz73duJbl4spmarlNVINiGSfrnwBJoTwPwhuN16OpwTU00HEV
         4E+w==
X-Gm-Message-State: AOAM5302EtlNP9Yg8hnNwOY3pkmJ8RcmpCYqLAcRNbjTe08ybwn9rnUS
        lf8hblFoEdg/cNvEBgZUOjg=
X-Google-Smtp-Source: ABdhPJxi2LgYwQJN415bHnR2z4Xtv/eyeg/N7ab2DoXvG7fpdmHHs0haQLKT1DNoJuYKwaQaX5pI3g==
X-Received: by 2002:a63:1cd:: with SMTP id 196mr3266916pgb.108.1601386273733;
        Tue, 29 Sep 2020 06:31:13 -0700 (PDT)
Received: from carrot.localdomain (i125-203-169-180.s42.a014.ap.plala.or.jp. [125.203.169.180])
        by smtp.gmail.com with ESMTPSA id g9sm5735763pfo.144.2020.09.29.06.31.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 06:31:12 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: Fix some kernel-doc warnings for nilfs2
Date:   Tue, 29 Sep 2020 22:31:09 +0900
Message-Id: <1601386269-2423-1-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>

Fixes the following W=1 kernel build warning(s):

fs/nilfs2/bmap.c:378: warning: Excess function parameter 'bhp' description in 'nilfs_bmap_assign'
fs/nilfs2/cpfile.c:907: warning: Excess function parameter 'status' description in 'nilfs_cpfile_change_cpmode'
fs/nilfs2/cpfile.c:946: warning: Excess function parameter 'stat' description in 'nilfs_cpfile_get_stat'
fs/nilfs2/page.c:76: warning: Excess function parameter 'inode' description in 'nilfs_forget_buffer'
fs/nilfs2/sufile.c:563: warning: Excess function parameter 'stat' description in 'nilfs_sufile_get_stat'

Signed-off-by: Wang Hai <wanghai38@huawei.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
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
1.8.3.1


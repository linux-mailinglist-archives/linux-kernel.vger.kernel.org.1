Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87502DDDCE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 06:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbgLRFUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 00:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731747AbgLRFUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 00:20:10 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915F8C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 21:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=oZuF6ObLw2MhepsfeO7KviO77+kjHkMk2gYyhSP9s8E=; b=ismFjqs4KR+eixVDEwUkDCT89B
        Rz4b+lVUNrDUvnKbXrW032F+JoK7govK3ZFfasiEUl0TUUzFf8d2zpFPxb2gZNfFDPKX5owjNhQKy
        M1Y+qOAqI71PDiCYQWBoscx5+yEVJP2sEd0YmzBBiHwr3k52prXQadxXntpJD7gbi2YjxBEpki2NS
        5sVKOFzHIXhc/Ve5dXKj0g2fnyPUp38ho3EvYMuWLhQagqZQDiERyhL618m3Z/mwwFdH+Lbn52nXx
        gpRQgMxGdNBaY+bLaL/9kSoo+iaXLxCWaAG7HyFPhAHEcKezUN5M8pzjuPYO8Rho5m59AbHcPopGI
        02DlTw/g==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kq8Ap-0003Kf-Q5; Fri, 18 Dec 2020 05:19:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        syzbot+36315852ece4132ec193@syzkaller.appspotmail.com,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH] JFS: more checks for invalid superblock
Date:   Thu, 17 Dec 2020 21:19:20 -0800
Message-Id: <20201218051920.6229-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is feeding invalid superblock data to JFS for mount testing.
JFS does not check several of the fields -- just assumes that they
are good since the JFS_MAGIC and version fields are good.

In this case (syzbot reproducer), we have s_l2bsize == 0xda0c,
pad == 0xf045, and s_state == 0x50, all of which are invalid IMO.
Having s_l2bsize == 0xda0c causes this UBSAN warning:
  UBSAN: shift-out-of-bounds in fs/jfs/jfs_mount.c:373:25
  shift exponent -9716 is negative

s_l2bsize can be tested for correctness. pad can be tested for non-0
and punted. s_state can be tested for its valid values and punted.

Do those 3 tests and if any of them fails, report the superblock as
invalid/corrupt and let fsck handle it.

With this patch, chkSuper() says this when JFS_DEBUG is enabled:
  jfs_mount: Mount Failure: superblock is corrupt!
  Mount JFS Failure: -22
  jfs_mount failed w/return code = -22

The obvious problem with this method is that next week there could
be another syzbot test that uses different fields for invalid values,
this making this like a game of whack-a-mole.

syzkaller link: https://syzkaller.appspot.com/bug?extid=36315852ece4132ec193

Reported-by: syzbot+36315852ece4132ec193@syzkaller.appspotmail.com
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net
---
 fs/jfs/jfs_filsys.h |    1 +
 fs/jfs/jfs_mount.c  |   10 ++++++++++
 2 files changed, 11 insertions(+)

--- lnx-510.orig/fs/jfs/jfs_mount.c
+++ lnx-510/fs/jfs/jfs_mount.c
@@ -37,6 +37,7 @@
 #include <linux/fs.h>
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
+#include <linux/log2.h>
 
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
@@ -366,6 +367,15 @@ static int chkSuper(struct super_block *
 	sbi->bsize = bsize;
 	sbi->l2bsize = le16_to_cpu(j_sb->s_l2bsize);
 
+	/* check some fields for possible corruption */
+	if (sbi->l2bsize != ilog2((u32)bsize) ||
+	    j_sb->pad != 0 ||
+	    j_sb->s_state > FM_STATE_MAX) {
+		rc = -EINVAL;
+		jfs_err("jfs_mount: Mount Failure: superblock is corrupt!");
+		goto out;
+	}
+
 	/*
 	 * For now, ignore s_pbsize, l2bfactor.  All I/O going through buffer
 	 * cache.
--- lnx-510.orig/fs/jfs/jfs_filsys.h
+++ lnx-510/fs/jfs/jfs_filsys.h
@@ -268,5 +268,6 @@
 				 * fsck() must be run to repair
 				 */
 #define	FM_EXTENDFS 0x00000008	/* file system extendfs() in progress */
+#define	FM_STATE_MAX 0x0000000f	/* max value of s_state */
 
 #endif				/* _H_JFS_FILSYS */

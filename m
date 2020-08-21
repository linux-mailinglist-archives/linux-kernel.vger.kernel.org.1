Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FC124E311
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 00:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHUWQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 18:16:52 -0400
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:34558 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726934AbgHUWQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 18:16:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 49CBA181D341E;
        Fri, 21 Aug 2020 22:16:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:966:973:988:989:1260:1311:1314:1345:1359:1437:1515:1535:1544:1711:1730:1747:1777:1792:2196:2198:2199:2200:2393:2559:2562:2731:2898:3138:3139:3140:3141:3142:3280:3355:3653:3865:3867:3868:3870:3871:4250:4321:4385:5007:6117:6119:6261:7903:8957:9036:10004:10848:11026:11473:11658:11914:12043:12296:12297:12438:12555:12679:12895:12986:13894:14096:14181:14394:14721:21080:21451:21505:21627:21990:30029:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: skirt61_500f9412703c
X-Filterd-Recvd-Size: 5671
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 22:16:48 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ntfs3: Rename ntfs_trace to ntfs_notice
Date:   Fri, 21 Aug 2020 15:16:40 -0700
Message-Id: <2c137a403d1ebbfb1347a9e5310b5e469c870f8d.1598047823.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598047822.git.joe@perches.com>
References: <cover.1598047822.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the normal name.

Miscellanea:

o Reorder the macro logging definitions in KERN_<LEVEL> order

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/ntfs3/debug.h  |  4 ++--
 fs/ntfs3/fsntfs.c | 16 +++++++---------
 fs/ntfs3/index.c  |  4 ++--
 fs/ntfs3/super.c  | 13 ++++++-------
 4 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/fs/ntfs3/debug.h b/fs/ntfs3/debug.h
index 1ad0e8730745..1c924bfa2c0b 100644
--- a/fs/ntfs3/debug.h
+++ b/fs/ntfs3/debug.h
@@ -31,12 +31,12 @@ __printf(3, 4) void __ntfs_fs_error(struct super_block *sb, int report,
 __printf(2, 3)
 void ntfs_inode_printk(struct inode *inode, const char *fmt, ...);
 
-#define ntfs_trace(sb, fmt, ...)					\
-	ntfs_printk(sb, KERN_NOTICE fmt, ##__VA_ARGS__)
 #define ntfs_err(sb, fmt, ...)						\
 	ntfs_printk(sb, KERN_ERR fmt, ##__VA_ARGS__)
 #define ntfs_warn(sb, fmt, ...)					\
 	ntfs_printk(sb, KERN_WARNING fmt, ##__VA_ARGS__)
+#define ntfs_notice(sb, fmt, ...)					\
+	ntfs_printk(sb, KERN_NOTICE fmt, ##__VA_ARGS__)
 
 #define ntfs_fs_error(sb, fmt, ...)					\
 	__ntfs_fs_error(sb, 1, fmt, ##__VA_ARGS__)
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 12d8cf7f1725..e226db96fc2a 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -172,7 +172,7 @@ int ntfs_extend_init(ntfs_sb_info *sbi)
 	MFT_REF ref;
 
 	if (sbi->volume.major_ver < 3) {
-		ntfs_trace(sb, "Skip $Extend 'cause NTFS version");
+		ntfs_notice(sb, "Skip $Extend 'cause NTFS version");
 		return 0;
 	}
 
@@ -444,10 +444,8 @@ int ntfs_look_for_free_space(ntfs_sb_info *sbi, CLST lcn, CLST len,
 	}
 
 no_space:
-	ntfs_trace(
-		sb,
-		"Can not allocate %x cluster(s), Zone: %zx, free %zx, flags %d",
-		(u32)len, zlen, wnd_zeroes(wnd), (int)opt);
+	ntfs_notice(sb, "Can not allocate %x cluster(s), Zone: %zx, free %zx, flags %d",
+		    (u32)len, zlen, wnd_zeroes(wnd), (int)opt);
 
 	up_write(&wnd->rw_lock);
 
@@ -615,8 +613,8 @@ int ntfs_look_free_mft(ntfs_sb_info *sbi, CLST *rno, bool mft, ntfs_inode *ni,
 			i = ntfs_iget5(sb, &ref, NULL);
 			if (IS_ERR(i)) {
 next:
-				ntfs_trace(sb, "Invalid reserved record %x",
-					   ref.low);
+				ntfs_notice(sb, "Invalid reserved record %x",
+					    ref.low);
 				continue;
 			}
 			if (is_bad_inode(i)) {
@@ -845,7 +843,7 @@ int ntfs_refresh_zone(ntfs_sb_info *sbi)
 	/* Try to allocate clusters after last MFT run */
 	zlen = wnd_find(wnd, zone_max, lcn_s, 0, &lcn_s);
 	if (!zlen) {
-		ntfs_trace(sbi->sb, "MftZone: unavailable");
+		ntfs_notice(sbi->sb, "MftZone: unavailable");
 		return 0;
 	}
 
@@ -974,7 +972,7 @@ int ntfs_set_state(ntfs_sb_info *sbi, enum NTFS_DIRTY_FLAGS dirty)
 
 	switch (dirty) {
 	case NTFS_DIRTY_ERROR:
-		ntfs_trace(sbi->sb, "Mark volume as dirty due to NTFS errors");
+		ntfs_notice(sbi->sb, "Mark volume as dirty due to NTFS errors");
 		sbi->volume.real_dirty = true;
 		fallthrough;
 	case NTFS_DIRTY_DIRTY:
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 1c1903b2c670..24f3d7ddb1cc 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1691,8 +1691,8 @@ static int indx_insert_into_root(ntfs_index *indx, ntfs_inode *ni,
 		 * new entry classic case when mft record is 1K and index
 		 * buffer 4K the problem should not occurs
 		 */
-		ntfs_trace(sbi->sb,
-			   "Failed: root + new entry > index. Reinsert");
+		ntfs_notice(sbi->sb,
+			    "Failed: root + new entry > index. Reinsert");
 		ntfs_free(re);
 		indx_write(indx, ni, n, 0);
 
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index d72d06f4adbe..c06a81b01423 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -291,7 +291,7 @@ static void ntfs_put_super(struct super_block *sb)
 	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
 
 	close_ntfs(sbi);
-	ntfs_trace(sb, "is unmounted at %.*s\n", time_str(buf, sizeof(buf)),
+	ntfs_notice(sb, "is unmounted at %.*s\n", time_str(buf, sizeof(buf)),
 		   buf);
 }
 
@@ -592,10 +592,8 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 #else
 	/* 32 bits per cluster */
 	if (clusters >> 32) {
-		ntfs_trace(
-			sb,
-			"NTFS %u.%02u Gb is too big to use 32 bits per cluster",
-			gb, mb);
+		ntfs_notice(sb, "NTFS %u.%02u Gb is too big to use 32 bits per cluster",
+			    gb, mb);
 		goto out;
 	}
 #endif
@@ -1033,7 +1031,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 			continue;
 
 		if (!sbi->bad_clusters)
-			ntfs_trace(sb, "Volume contains bad blocks");
+			ntfs_notice(sb, "Volume contains bad blocks");
 
 		sbi->bad_clusters += len;
 	}
@@ -1246,7 +1244,8 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 		goto out;
 	}
 
-	ntfs_trace(sb, "is mounted as NTFS at %.*s", time_str(buf, sizeof(buf)),
+	ntfs_notice(sb, "is mounted as NTFS at %.*s",
+		    time_str(buf, sizeof(buf)),
 		   buf);
 
 	return 0;
-- 
2.26.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00372DDA6D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 21:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbgLQU5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 15:57:14 -0500
Received: from smtprelay0090.hostedemail.com ([216.40.44.90]:46748 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731327AbgLQU5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:57:13 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id CDD30182D5853
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 20:56:32 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id DAC05181D341E;
        Thu, 17 Dec 2020 20:55:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:968:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3865:3867:3868:3870:3872:5007:7901:10004:10400:10848:11026:11658:11914:12043:12296:12297:12438:12555:12760:13069:13071:13311:13357:13439:14096:14097:14180:14659:14721:21080:21324:21451:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: thing75_04036b127437
X-Filterd-Recvd-Size: 1795
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Dec 2020 20:55:51 +0000 (UTC)
Message-ID: <fddfd9cbf1b454b1259e8559cd535433c9d0e91a.camel@perches.com>
Subject: ntfs: extern vs inline?
From:   Joe Perches <joe@perches.com>
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 17 Dec 2020 12:55:49 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Anton.

I was looking around for bare inline uses and found this in
fs/ntfs/inode.[ch]:

$ git grep -w ntfs_new_extent_inode
fs/ntfs/inode.c:inline ntfs_inode *ntfs_new_extent_inode(struct super_block *sb,
fs/ntfs/inode.h:extern ntfs_inode *ntfs_new_extent_inode(struct super_block *sb,
fs/ntfs/mft.c:  ni = ntfs_new_extent_inode(base_ni->vol->sb, mft_no);

It seems odd for the function declaration to be extern but the definition
to be inline.

mft.c doesn't include inode.c, so the compiler shouldn't be able to inline it.

Likely the inline use in inode.c should be removed.
---
 fs/ntfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)fs/

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index f7e4cbc26eaf..33386e8818de 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -399,8 +399,7 @@ void __ntfs_init_inode(struct super_block *sb, ntfs_inode *ni)
  */
 static struct lock_class_key extent_inode_mrec_lock_key;
 
-inline ntfs_inode *ntfs_new_extent_inode(struct super_block *sb,
-		unsigned long mft_no)
+ntfs_inode *ntfs_new_extent_inode(struct super_block *sb, unsigned long mft_no)
 {
 	ntfs_inode *ni = ntfs_alloc_extent_inode();
 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7370B24E30F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 00:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHUWQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 18:16:45 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:53246 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726747AbgHUWQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 18:16:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B8B091802A392;
        Fri, 21 Aug 2020 22:16:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:973:988:989:1260:1311:1314:1345:1437:1515:1534:1539:1711:1714:1730:1747:1777:1792:2198:2199:2393:2559:2562:3138:3139:3140:3141:3142:3351:3865:3867:3868:5007:6261:7974:8603:10004:10848:11026:11658:11914:12043:12291:12296:12297:12679:12683:12895:13069:13161:13229:13311:13357:13894:14095:14096:14384:14394:14721:21080:21451:21627:30030:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:121,LUA_SUMMARY:none
X-HE-Tag: silk63_4906fc22703c
X-Filterd-Recvd-Size: 1349
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 22:16:42 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/3] ntfs3: Update logging
Date:   Fri, 21 Aug 2020 15:16:37 -0700
Message-Id: <cover.1598047822.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the more typical kernel logging styles.
These changes also trivially reduce overall object size.

btw: ntfs_fs_error/__ntfs_fs_error were and are left unused

Joe Perches (3):
  ntfs3: Use more common logging function names and style
  ntfs3: Rename logging macros and uses
  ntfs3: Rename ntfs_trace to ntfs_notice

 fs/ntfs3/debug.h   | 30 ++++++++------
 fs/ntfs3/dir.c     | 22 +++++------
 fs/ntfs3/file.c    | 27 ++++++-------
 fs/ntfs3/frecord.c |  2 +-
 fs/ntfs3/fslog.c   |  4 +-
 fs/ntfs3/fsntfs.c  | 39 +++++++++---------
 fs/ntfs3/index.c   |  4 +-
 fs/ntfs3/inode.c   | 14 +++----
 fs/ntfs3/ntfs_fs.h |  4 +-
 fs/ntfs3/super.c   | 99 ++++++++++++++++++++++++----------------------
 10 files changed, 121 insertions(+), 124 deletions(-)

-- 
2.26.0


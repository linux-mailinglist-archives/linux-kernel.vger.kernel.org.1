Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B50255EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 18:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgH1QjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 12:39:13 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:53070 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726733AbgH1QjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:39:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3353B837F24F;
        Fri, 28 Aug 2020 16:39:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:973:988:989:1260:1311:1314:1345:1437:1515:1534:1541:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:3138:3139:3140:3141:3142:3352:3867:3868:4605:5007:6261:10004:10848:11026:11473:11657:11658:11914:12043:12297:12438:12683:12895:13069:13311:13357:13894:14096:14110:14384:14394:21080:21451:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bear07_1f04dee27077
X-Filterd-Recvd-Size: 1642
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2020 16:39:09 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Jiri Kosina <trivial@kernel.org>
Subject: [PATCH 0/3] ntfs3: trivial style cleanups
Date:   Fri, 28 Aug 2020 09:39:02 -0700
Message-Id: <cover.1598632661.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches (3):
  ntfs3: Add and use logging macros
  ntfs3: Use more common brace style
  ntfs3: Rename NTFS_FLAGS_LOG_REPLAING to NTFS_FLAGS_LOG_REPLAYING

 fs/ntfs3/attrib.c   |  7 +++--
 fs/ntfs3/attrlist.c |  4 +--
 fs/ntfs3/bitmap.c   | 43 +++++++++++++++--------------
 fs/ntfs3/debug.h    | 12 ++++++++
 fs/ntfs3/dir.c      | 24 +++++++---------
 fs/ntfs3/file.c     | 62 +++++++++++++++++------------------------
 fs/ntfs3/frecord.c  | 45 +++++++++++++++---------------
 fs/ntfs3/fslog.c    | 24 ++++++++--------
 fs/ntfs3/fsntfs.c   | 60 +++++++++++++++++-----------------------
 fs/ntfs3/index.c    | 18 ++++++------
 fs/ntfs3/inode.c    | 22 ++++++---------
 fs/ntfs3/lznt.c     |  3 +-
 fs/ntfs3/namei.c    |  3 +-
 fs/ntfs3/ntfs_fs.h  |  6 ++--
 fs/ntfs3/record.c   | 13 +++++----
 fs/ntfs3/run.c      |  8 +++---
 fs/ntfs3/super.c    | 67 ++++++++++++++++++---------------------------
 fs/ntfs3/xattr.c    | 24 ++++++++--------
 18 files changed, 207 insertions(+), 238 deletions(-)

-- 
2.26.0


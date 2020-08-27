Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2D42546EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 16:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0Oca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 10:32:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:45498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbgH0O2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:28:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49B0AAC8B;
        Thu, 27 Aug 2020 14:28:03 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/cachefiles: Drop superfluous readpages aops NULL check
Date:   Thu, 27 Aug 2020 16:27:24 +0200
Message-Id: <20200827142724.15032-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the recent actions to convert readpages aops to readahead, the
NULL checks of readpages aops in cachefiles_read_or_alloc_page() may
hit falsely.  More badly, it's an ASSERT() call, and this panics.

Drop the superfluous NULL checks for fixing this regression.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208883
BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1175245
Cc: <stable@vger.kernel.org> # v5.8
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 fs/cachefiles/rdwr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 3080cda9e824..5b4cee71fa32 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -412,7 +412,6 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
 
 	inode = d_backing_inode(object->backer);
 	ASSERT(S_ISREG(inode->i_mode));
-	ASSERT(inode->i_mapping->a_ops->readpages);
 
 	/* calculate the shift required to use bmap */
 	shift = PAGE_SHIFT - inode->i_sb->s_blocksize_bits;
@@ -712,7 +711,6 @@ int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
 
 	inode = d_backing_inode(object->backer);
 	ASSERT(S_ISREG(inode->i_mode));
-	ASSERT(inode->i_mapping->a_ops->readpages);
 
 	/* calculate the shift required to use bmap */
 	shift = PAGE_SHIFT - inode->i_sb->s_blocksize_bits;
-- 
2.16.4


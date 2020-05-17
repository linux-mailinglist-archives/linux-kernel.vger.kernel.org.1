Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2BE1D6D73
	for <lists+linux-kernel@lfdr.de>; Sun, 17 May 2020 23:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgEQVZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 17:25:27 -0400
Received: from mail.hallyn.com ([178.63.66.53]:56782 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgEQVZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 17:25:27 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 45C1A6C9; Sun, 17 May 2020 16:25:25 -0500 (CDT)
Date:   Sun, 17 May 2020 16:25:25 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     James.Bottomley@HansenPartnership.com
Cc:     Christian Brauner <christian.brauner@canonical.com>,
        lkml <linux-kernel@vger.kernel.org>, serge@hallyn.com
Subject: [PATCH 1/1] shiftfs: specify struct members
Message-ID: <20200517212525.GA29858@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct path is declared as randomize_layout, so specify the
struct members when initializing to avoid build failure.

Signed-off-by: Serge Hallyn <shallyn@cisco.com>
---

[ this is for https://git.kernel.org/pub/scm/linux/kernel/git/jejb/binfmt_misc.git/commit/?h=shiftfs-v3 ,
which i was just building for an experiment ]

 fs/shiftfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/shiftfs.c b/fs/shiftfs.c
index 7984a93745d2..6028244c2f42 100644
--- a/fs/shiftfs.c
+++ b/fs/shiftfs.c
@@ -535,7 +535,7 @@ static int shiftfs_getattr(const struct path *path, struct kstat *stat,
 	struct dentry *real = path->dentry->d_fsdata;
 	struct inode *reali = real->d_inode;
 	const struct inode_operations *iop = reali->i_op;
-	struct path newpath = { path->dentry->d_sb->s_fs_info, real };
+	struct path newpath = { .mnt = path->dentry->d_sb->s_fs_info, .dentry = real };
 	int err = 0;
 
 	if (iop->getattr)
-- 
2.17.1


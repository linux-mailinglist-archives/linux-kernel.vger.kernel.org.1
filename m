Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB8925A456
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 06:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIBEQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 00:16:39 -0400
Received: from winds.org ([68.75.195.9]:54128 "EHLO winds.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgIBEQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:16:37 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Sep 2020 00:16:36 EDT
Received: by winds.org (Postfix, from userid 0)
        id 4775C13BC8FD; Tue,  1 Sep 2020 23:58:21 -0400 (EDT)
From:   Byron Stanoszek <gandalf@winds.org>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Byron Stanoszek <gandalf@winds.org>,
        Chris Down <chris@chrisdown.name>
Subject: [PATCH] tmpfs: Restore functionality of nr_inodes=0
Date:   Tue,  1 Sep 2020 23:57:15 -0400
Message-Id: <20200902035715.16414-1-gandalf@winds.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e809d5f0b5c9 ("tmpfs: per-superblock i_ino support") made changes to
shmem_reserve_inode() in mm/shmem.c, however the original test for
(sbinfo->max_inodes) got dropped. This causes mounting tmpfs with option
nr_inodes=0 to fail:

  # mount -ttmpfs -onr_inodes=0 none /ext0
  mount: /ext0: mount(2) system call failed: Cannot allocate memory.

This patch restores the nr_inodes=0 functionality.

Fixes: e809d5f0b5c9 ("tmpfs: per-superblock i_ino support")
Cc: Chris Down <chris@chrisdown.name>
Signed-off-by: Byron Stanoszek <gandalf@winds.org>
---
 mm/shmem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 271548ca20f3..8e2b35ba93ad 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -279,11 +279,13 @@ static int shmem_reserve_inode(struct super_block *sb, ino_t *inop)
 
 	if (!(sb->s_flags & SB_KERNMOUNT)) {
 		spin_lock(&sbinfo->stat_lock);
-		if (!sbinfo->free_inodes) {
-			spin_unlock(&sbinfo->stat_lock);
-			return -ENOSPC;
+		if (sbinfo->max_inodes) {
+			if (!sbinfo->free_inodes) {
+				spin_unlock(&sbinfo->stat_lock);
+				return -ENOSPC;
+			}
+			sbinfo->free_inodes--;
 		}
-		sbinfo->free_inodes--;
 		if (inop) {
 			ino = sbinfo->next_ino++;
 			if (unlikely(is_zero_ino(ino)))
-- 
2.28.0


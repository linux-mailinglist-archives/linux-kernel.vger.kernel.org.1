Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7D12AAA02
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 08:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgKHHyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 02:54:19 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:49985 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726869AbgKHHyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 02:54:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UEabaDp_1604822057;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEabaDp_1604822057)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 Nov 2020 15:54:17 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ntfs: remove unused varible attr_len
Date:   Sun,  8 Nov 2020 15:54:16 +0800
Message-Id: <1604822056-65430-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This varible isn't used anymore, remove it to skip W=1 warning:
fs/ntfs/inode.c:2350:6: warning: variable ‘attr_len’ set but not used
[-Wunused-but-set-variable]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Anton Altaparmakov <anton@tuxera.com> 
Cc: linux-ntfs-dev@lists.sourceforge.net 
Cc: linux-kernel@vger.kernel.org 
---
 fs/ntfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index caf563981532..d3127ea201ec 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2347,7 +2347,6 @@ int ntfs_truncate(struct inode *vi)
 	ATTR_RECORD *a;
 	const char *te = "  Leaving file length out of sync with i_size.";
 	int err, mp_size, size_change, alloc_change;
-	u32 attr_len;
 
 	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
 	BUG_ON(NInoAttr(ni));
@@ -2721,7 +2720,7 @@ int ntfs_truncate(struct inode *vi)
 	 * this cannot fail since we are making the attribute smaller thus by
 	 * definition there is enough space to do so.
 	 */
-	attr_len = le32_to_cpu(a->length);
+	le32_to_cpu(a->length);
 	err = ntfs_attr_record_resize(m, a, mp_size +
 			le16_to_cpu(a->data.non_resident.mapping_pairs_offset));
 	BUG_ON(err);
-- 
1.8.3.1


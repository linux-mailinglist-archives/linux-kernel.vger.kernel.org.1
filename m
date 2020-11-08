Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7162AAA06
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 09:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgKHIHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 03:07:16 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:41536 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbgKHIHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 03:07:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UEZhB8b_1604822833;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEZhB8b_1604822833)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 Nov 2020 16:07:14 +0800
Subject: Re: [PATCH] fs/ntfs: remove unused varible attr_len
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1604822056-65430-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <4194376f-898b-b602-81c3-210567712092@linux.alibaba.com>
Date:   Sun, 8 Nov 2020 16:06:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1604822056-65430-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/11/8 下午3:54, Alex Shi 写道:
>  	 */
> -	attr_len = le32_to_cpu(a->length);
> +	le32_to_cpu(a->length);

This line is also useless. and should be removed. so:

From d1c6de723995adeeecb90c6fd77811dd85b697e6 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Sun, 8 Nov 2020 15:52:32 +0800
Subject: [PATCH] fs/ntfs: remove unused varible attr_len
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This varible isn't used anymore, remove it to skip W=1 warning:
fs/ntfs/inode.c:2350:6: warning: variable ‘attr_len’ set but not used
[-Wunused-but-set-variable]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
---
 fs/ntfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index caf563981532..f7e4cbc26eaf 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2347,7 +2347,6 @@ int ntfs_truncate(struct inode *vi)
 	ATTR_RECORD *a;
 	const char *te = "  Leaving file length out of sync with i_size.";
 	int err, mp_size, size_change, alloc_change;
-	u32 attr_len;
 
 	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
 	BUG_ON(NInoAttr(ni));
@@ -2721,7 +2720,6 @@ int ntfs_truncate(struct inode *vi)
 	 * this cannot fail since we are making the attribute smaller thus by
 	 * definition there is enough space to do so.
 	 */
-	attr_len = le32_to_cpu(a->length);
 	err = ntfs_attr_record_resize(m, a, mp_size +
 			le16_to_cpu(a->data.non_resident.mapping_pairs_offset));
 	BUG_ON(err);
-- 
1.8.3.1


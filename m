Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F23207DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 22:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389065AbgFXUtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 16:49:53 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:41397 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731184AbgFXUtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:49:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U0dB-ik_1593031747;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0U0dB-ik_1593031747)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Jun 2020 04:49:50 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: filemap: add missing FGP_ flags in kerneldoc comment for pagecache_get_page
Date:   Thu, 25 Jun 2020 04:49:07 +0800
Message-Id: <1593031747-4249-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FGP_{WRITE|NOFS|NOWAIT} were missed in pagecache_get_page's kerneldoc
comment.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/filemap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 0589aef..9b47ffe 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1590,6 +1590,9 @@ struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset)
  * * %FGP_FOR_MMAP - The caller wants to do its own locking dance if the
  *   page is already in cache.  If the page was allocated, unlock it before
  *   returning so the caller can do the same dance.
+ * * %FGP_WRITE - The page will be written
+ * * %FGP_NOFS - __GFP_FS will get cleared in gfp mask
+ * * %FGP_NOWAIT - Don't get blocked by page lock
  *
  * If %FGP_LOCK or %FGP_CREAT are specified then the function may sleep even
  * if the %GFP flags specified for %FGP_CREAT are atomic.
-- 
1.8.3.1


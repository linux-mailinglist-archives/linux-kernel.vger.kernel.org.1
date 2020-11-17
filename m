Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528B02B5A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 08:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgKQHMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 02:12:55 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:40165 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbgKQHMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 02:12:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UFg6Xp9_1605597170;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFg6Xp9_1605597170)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Nov 2020 15:12:51 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: add colon to fix kernel-doc markups error for check_pte
Date:   Tue, 17 Nov 2020 15:12:47 +0800
Message-Id: <1605597167-25145-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function check_pte needs a correct colon for kernel-doc markup,
otherwise, gcc has the following warning for W=1,
mm/page_vma_mapped.c:86: warning: Function parameter or member 'pvmw'
not described in 'check_pte'

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/page_vma_mapped.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 5e77b269c330..86e3a3688d59 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -66,18 +66,19 @@ static inline bool pfn_is_match(struct page *page, unsigned long pfn)
 
 /**
  * check_pte - check if @pvmw->page is mapped at the @pvmw->pte
+ * @pvmw: page_vma_mapped_walk struct, includes a pair pte and page for checking
  *
  * page_vma_mapped_walk() found a place where @pvmw->page is *potentially*
  * mapped. check_pte() has to validate this.
  *
- * @pvmw->pte may point to empty PTE, swap PTE or PTE pointing to arbitrary
- * page.
+ * pvmw->pte may point to empty PTE, swap PTE or PTE pointing to
+ * arbitrary page.
  *
  * If PVMW_MIGRATION flag is set, returns true if @pvmw->pte contains migration
  * entry that points to @pvmw->page or any subpage in case of THP.
  *
- * If PVMW_MIGRATION flag is not set, returns true if @pvmw->pte points to
- * @pvmw->page or any subpage in case of THP.
+ * If PVMW_MIGRATION flag is not set, returns true if pvmw->pte points to
+ * pvmw->page or any subpage in case of THP.
  *
  * Otherwise, return false.
  *
-- 
2.29.GIT


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF1428CE23
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgJMMQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgJMMO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:14:56 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1830822261;
        Tue, 13 Oct 2020 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602591295;
        bh=v7xvZE08GeJrZFEuozEOJEqCvb7eyGbV4GNw/+N4zeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azJcxpZwEUFfCCB2krYUl8xMZdMcRna4TAswUJH5oCLfqZTeM1SKCu6VoXpGDmNJ2
         iJUyGMvWgnyRH3MTuMOvDIzkdGngeP2dUSPQ6dNkm/mNjdZ71K9QkLh5MRAYrIcL9t
         70PjXmGglUHbS5FGXe+1aaH+uZiMM7Ska/PqGnL8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSJCe-006CoB-Uy; Tue, 13 Oct 2020 14:14:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Kucharski <william.kucharski@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/24] mm: pagemap.h: fix two kernel-doc markups
Date:   Tue, 13 Oct 2020 14:14:37 +0200
Message-Id: <54ea6dd0fc37c48aef3fc3ae454c54a80db313dc.1602590106.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602590106.git.mchehab+huawei@kernel.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 6c8adf8446a3 ("mm: add find_lock_head") renamed the
index parameter, but forgot to update the kernel-doc markups
accordingly.

Fixes: 6c8adf8446a3 ("mm: add find_lock_head")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/pagemap.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7dd3523093db..932a260a29f2 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -342,9 +342,9 @@ static inline struct page *find_get_page_flags(struct address_space *mapping,
 /**
  * find_lock_page - locate, pin and lock a pagecache page
  * @mapping: the address_space to search
- * @offset: the page index
+ * @index: the page index
  *
- * Looks up the page cache entry at @mapping & @offset.  If there is a
+ * Looks up the page cache entry at @mapping & @index.  If there is a
  * page cache page, it is returned locked and with an increased
  * refcount.
  *
@@ -361,9 +361,9 @@ static inline struct page *find_lock_page(struct address_space *mapping,
 /**
  * find_lock_head - Locate, pin and lock a pagecache page.
  * @mapping: The address_space to search.
- * @offset: The page index.
+ * @index: The page index.
  *
- * Looks up the page cache entry at @mapping & @offset.  If there is a
+ * Looks up the page cache entry at @mapping & @index.  If there is a
  * page cache page, its head page is returned locked and with an increased
  * refcount.
  *
-- 
2.26.2


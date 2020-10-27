Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBD329A8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896803AbgJ0KBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896038AbgJ0Jvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:51:43 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63D972242F;
        Tue, 27 Oct 2020 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603792301;
        bh=3vvnE1em6mmP7ZQ1BF47N0SjjEqymcV2EcpEutuqSu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1IM9lZPpp3e2P+lBjpHqQerSqi11wFhmvVoXUnbtSrCdE7Bz2bWEKJSP0CXu2KDgA
         sILV6F3ZkRGl9aG2ZGJbgtinsQDloIISIYNkn5rln/LqoLqfGz/Jnm/WZNrj7BdkjN
         mFn5oYpe6WQiELcxsixTnXe4Iy5Bao2+pnHvz7E8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXLdj-003FEz-Aw; Tue, 27 Oct 2020 10:51:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/32] mm: pagemap.h: fix two kernel-doc markups
Date:   Tue, 27 Oct 2020 10:51:17 +0100
Message-Id: <dce89b296a4f5f9f8f798d5e76b6736c14a916ac.1603791716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603791716.git.mchehab+huawei@kernel.org>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset a8cf7f272b5a ("mm: add find_lock_head") renamed the
index parameter, but forgot to update the kernel-doc markups
accordingly.

Fixes: a8cf7f272b5a ("mm: add find_lock_head")
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/pagemap.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c77b7c31b2e4..e1e19c1f9ec9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -344,9 +344,9 @@ static inline struct page *find_get_page_flags(struct address_space *mapping,
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
@@ -363,9 +363,9 @@ static inline struct page *find_lock_page(struct address_space *mapping,
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


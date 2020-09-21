Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA22735EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgIUWqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbgIUWqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:46:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29261C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=19+dtww1aGUNEiGQP1W/amiaMHLfx0Q734F1r1AzV60=; b=Fb/3jiqanZ49Dm+0wD08pYCR1N
        lgIncSYKeYTujRcc2wcYZLSUpAl4sWmzNV1VIpuM+JeEYDzaHVoov+8uHKPbAdaYK1Bf0NozIRDL2
        tLU2VfpVtD8jp3h3L887Sjt8dRoeG1Ec4rnpEJdttKNbAtAs/HYeXuO82jtZAjCvxoNouRiwlLtqq
        rejOwFhoMp8JKpQJHRwNKrLv1f5QvKZclmoua6wnXOTCKHBbKDPY+NNVvCHUDUXXrQ6KZ8C3VBdVT
        Nsstm9ofRG4gG8LlwrxXWa84Gk9bsfe4g7U0TPNU/XdV7GgKKIK2MzZO1wqpmFLcYUk4pNp5bPEem
        L91v3UAA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKUZq-0005PD-K9; Mon, 21 Sep 2020 22:46:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, hch@lst.de,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 2/2] vfree: Update documentation
Date:   Mon, 21 Sep 2020 23:46:28 +0100
Message-Id: <20200921224628.20704-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200921224628.20704-1-willy@infradead.org>
References: <20200921224628.20704-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 * Document that you can call vfree() on an address returned from vmap()
 * Remove the note about the minimum size -- the minimum size of a vmalloc
   allocation is one page
 * Add a Context: section
 * Fix capitalisation
 * Reword the prohibition on calling from NMI context to avoid a double
   negative

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmalloc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3893fc8915c4..942a44bdeec6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2313,20 +2313,20 @@ static void __vfree(const void *addr)
 }
 
 /**
- * vfree - release memory allocated by vmalloc()
- * @addr:  memory base address
+ * vfree - Release memory allocated by vmalloc()
+ * @addr:  Memory base address
  *
  * Free the virtually continuous memory area starting at @addr, as
- * obtained from vmalloc(), vmalloc_32() or __vmalloc(). If @addr is
- * NULL, no operation is performed.
- *
- * Must not be called in NMI context (strictly speaking, only if we don't
- * have CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG, but making the calling
- * conventions for vfree() arch-depenedent would be a really bad idea)
+ * obtained from vmalloc(), vmalloc_32() or __vmalloc().  If called
+ * on an @addr obtained from vmap(), it will put one refcount on each
+ * mapped page, which will free the page if this is the last refcount
+ * on the page.  If @addr is NULL, no operation is performed.
  *
+ * Context:
  * May sleep if called *not* from interrupt context.
- *
- * NOTE: assumes that the object at @addr has a size >= sizeof(llist_node)
+ * Must not be called in NMI context (strictly speaking, it could be
+ * if we have CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG, but making the calling
+ * conventions for vfree() arch-depenedent would be a really bad idea).
  */
 void vfree(const void *addr)
 {
-- 
2.28.0


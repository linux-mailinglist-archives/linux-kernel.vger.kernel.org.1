Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2309D2C37C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 05:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgKYDrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 22:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgKYDrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 22:47:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1697FC0613D4;
        Tue, 24 Nov 2020 19:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=B1PQC6WJEM7TGPBmASC/1k4P2JlH4NZxClv0snmsy5s=; b=RwKPNYEq5QLhIR2aZMYoq+cj5G
        voHrlRyVacNfgkKFhT6XqCOVKiTAWYG7brDli+xT9QfZ4AHDRcZkG3IHXdNAT0shPCK8XFTy2dX5Q
        OCs+M2aWNCwW4AZoNtrRTUs6vZ9aRQ1MufP/y7EMrkmmN2hyBXpNWNFXMS0wsJZjdi/ASxeTHotSn
        ngzvjva2JB1E0w2VSZg5gUtcuBcdAAStV0zLJkMKxWu1EDl1E3fdoZxvihZj7VRf2X3jY905vWqt9
        s8UA99h3LCmXF6SYcb5d0JUYti5KHBT6Kj90N5AlYidbKALhBhSAT+qacsFcWCcr6wv8Cwc183PKO
        QMBooKUA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khlli-0007EP-7o; Wed, 25 Nov 2020 03:46:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        davem@davemloft.net, rppt@kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/2] mm: Move free_unref_page to mm/internal.h
Date:   Wed, 25 Nov 2020 03:46:55 +0000
Message-Id: <20201125034655.27687-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201125034655.27687-1-willy@infradead.org>
References: <20201125034655.27687-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code outside mm/ should not be calling free_unref_page().  Also
move free_unref_page_list().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/gfp.h | 2 --
 mm/internal.h       | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index c603237e006c..6e479e9c48ce 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -580,8 +580,6 @@ void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask);
 
 extern void __free_pages(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
-extern void free_unref_page(struct page *page);
-extern void free_unref_page_list(struct list_head *list);
 
 struct page_frag_cache;
 extern void __page_frag_cache_drain(struct page *page, unsigned int count);
diff --git a/mm/internal.h b/mm/internal.h
index 75ae680d0a2c..5864815947fe 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -201,6 +201,9 @@ extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
 extern int user_min_free_kbytes;
 
+extern void free_unref_page(struct page *page);
+extern void free_unref_page_list(struct list_head *list);
+
 extern void zone_pcp_update(struct zone *zone);
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B5427736F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgIXN7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgIXN7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:59:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D5DC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=71LvYnHcMs7/rXGs508r2vzZrQvLA4mfS9GwJnz8e8I=; b=NUh5M0VarQIgBQqYaNlO1oJ5uD
        w8nVLotPmpd4oOZHHmvT2oHT7kVaN0TcgUMi5DUHiHdGTOvq+g3NO/KutuwysCvRae9RwPYp4rIvr
        iYNqfACDnH46rTLtHfvdsfC5VKzkUhO4F7ry/18RDOE0cR9gOYIJqR61QLO0qCQoj84BLYu10d+QK
        jc5SfjEAV8jLUC7hFJUbKC2hBzexIDKoQBbp6+XtPVn9ewLvlb4tB3C3LgoKZwg19+/aKKBtYx35D
        VOCzQ531qSBqmHg9FlZAu3/x99eoa2dKESyDZSZVYteLbCXHwidWSrgcqQ9no1BgOWJ5GpHmtXMo1
        1w5Yhf8A==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLRlw-0003uz-IY; Thu, 24 Sep 2020 13:58:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nitin Gupta <ngupta@vflare.org>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: [PATCH 02/11] mm: add a VM_MAP_PUT_PAGES flag for vmap
Date:   Thu, 24 Sep 2020 15:58:44 +0200
Message-Id: <20200924135853.875294-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924135853.875294-1-hch@lst.de>
References: <20200924135853.875294-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag so that vmap takes ownership of the passed in page array.
When vfree is called on such an allocation it will put one reference
on each page, and free the page array itself.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/vmalloc.h | 1 +
 mm/vmalloc.c            | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 0221f852a7e1a3..b899681e3ff9f0 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -24,6 +24,7 @@ struct notifier_block;		/* in notifier.h */
 #define VM_UNINITIALIZED	0x00000020	/* vm_struct is not fully initialized */
 #define VM_NO_GUARD		0x00000040      /* don't add guard page */
 #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
+#define VM_MAP_PUT_PAGES	0x00000100	/* put pages and free array in vfree */
 
 /*
  * VM_KASAN is used slighly differently depending on CONFIG_KASAN_VMALLOC.
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 8770260419af06..ffad65f052c3f9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2377,8 +2377,11 @@ EXPORT_SYMBOL(vunmap);
  * @flags: vm_area->flags
  * @prot: page protection for the mapping
  *
- * Maps @count pages from @pages into contiguous kernel virtual
- * space.
+ * Maps @count pages from @pages into contiguous kernel virtual space.
+ * If @flags contains %VM_MAP_PUT_PAGES the ownership of the pages array itself
+ * (which must be kmalloc or vmalloc memory) and one reference per pages in it
+ * are transferred from the caller to vmap(), and will be freed / dropped when
+ * vfree() is called on the return value.
  *
  * Return: the address of the area or %NULL on failure
  */
@@ -2404,6 +2407,8 @@ void *vmap(struct page **pages, unsigned int count,
 		return NULL;
 	}
 
+	if (flags & VM_MAP_PUT_PAGES)
+		area->pages = pages;
 	return area->addr;
 }
 EXPORT_SYMBOL(vmap);
-- 
2.28.0


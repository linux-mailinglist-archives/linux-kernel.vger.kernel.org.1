Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050C82F81BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbhAORLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:11:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731652AbhAORLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=owFz0J6uPi+bEZ5VVUVLD8wcRysHu0om3GiZkucTTw0=;
        b=dHKb7z8z8iGD+gu+odGXXKEIuwwM0JHvJRSgdqg/orgh15mlkmJPfnMy/7RvZGjHJ7Yz1S
        lcmEBiqsSM4eppuWM4lxyCNJ1wfpjxwPIm0DS0tzQSCKzDGnbARcIRoZWkWn82E/Wr6kPq
        3hVQ0y0ubH5LkGSJyX/bA/O7OgNZqGk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-jYJiriEOMDyC7jsg0JUQXA-1; Fri, 15 Jan 2021 12:09:34 -0500
X-MC-Unique: jYJiriEOMDyC7jsg0JUQXA-1
Received: by mail-qv1-f72.google.com with SMTP id bp20so8242029qvb.20
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=owFz0J6uPi+bEZ5VVUVLD8wcRysHu0om3GiZkucTTw0=;
        b=HvBFPMLrR7NDNzP492895w7UYPrMdfS2DqDkcZ28HX17OR23dLHoD4oIPN5ULw9Ha7
         dvAREJvz38+qggtGrHoaMhGjR811XNb7N5alppljj8Q0yAVb96pNdnpTBLh+wKQRMvld
         w3EcqQbG3/MQhlU86qW77HtnBxnPdExFhctYSvHVyompMw3x/FaHYvd0qYuj2v4udQS8
         kTDvi3TiDwPQEFJy7kO8BDQ2yCdCxypbD+mTEjRarheLDN+NdptYuWbkZpKM9Q67zPnj
         +xhknKvxmPod9Yol/bNfP9XSty2fzG+Q982Qkg7CbYvbLd6bac8QGI+PqsIkblc7mAXn
         sIkA==
X-Gm-Message-State: AOAM5316O9op2l08Bq2apXXaYB4uaXPamRLmMt9dczx9NQFuE5i2MX3P
        RBoZp5pIyKt7gemDPK35OMpQER38Hch5NlNgqBC4sN2Cnvfo4r/OuBkOQ+Esgx4AWpujxb7il7t
        GlqXaJi9WXl2Dk/Azv41tUe2R/RpJ1OCAf/FD6dQqBWPp0wHySlPK6Sp37mGX/Hr2Sgz1Q30V0A
        ==
X-Received: by 2002:a05:6214:b82:: with SMTP id fe2mr13163956qvb.3.1610730573735;
        Fri, 15 Jan 2021 09:09:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCJFBxV0A3cvs+bbtsL/5sswye4yXD71jk13j8IwVrx/u1KMNc/UbMaGnP6Gb/A3uNc8DhIA==
X-Received: by 2002:a05:6214:b82:: with SMTP id fe2mr13163910qvb.3.1610730573340;
        Fri, 15 Jan 2021 09:09:33 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:32 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH RFC 12/30] mm: Pass zap_flags into unmap_mapping_pages()
Date:   Fri, 15 Jan 2021 12:08:49 -0500
Message-Id: <20210115170907.24498-13-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give unmap_mapping_pages() more power by allowing to specify a zap flag so that
it can pass in more information than "whether we'd also like to zap cow pages".
With the new flag, we can remove the even_cow parameter because even_cow==false
equals to zap_flags==ZAP_FLAG_CHECK_MAPPING, while even_cow==true means a none
zap flag to pass in (though in most cases we have had even_cow==false).

No functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/dax.c           | 10 ++++++----
 include/linux/mm.h |  4 ++--
 mm/khugepaged.c    |  3 ++-
 mm/memory.c        | 15 ++++++++-------
 mm/truncate.c      | 11 +++++++----
 5 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5b47834f2e1b..6a123c2bfc59 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -517,7 +517,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 			xas_unlock_irq(xas);
 			unmap_mapping_pages(mapping,
 					xas->xa_index & ~PG_PMD_COLOUR,
-					PG_PMD_NR, false);
+					PG_PMD_NR, ZAP_FLAG_CHECK_MAPPING);
 			xas_reset(xas);
 			xas_lock_irq(xas);
 		}
@@ -612,7 +612,8 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	 * guaranteed to either see new references or prevent new
 	 * references from being established.
 	 */
-	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1, 0);
+	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1,
+			    ZAP_FLAG_CHECK_MAPPING);
 
 	xas_lock_irq(&xas);
 	xas_for_each(&xas, entry, end_idx) {
@@ -743,9 +744,10 @@ static void *dax_insert_entry(struct xa_state *xas,
 		/* we are replacing a zero page with block mapping */
 		if (dax_is_pmd_entry(entry))
 			unmap_mapping_pages(mapping, index & ~PG_PMD_COLOUR,
-					PG_PMD_NR, false);
+					PG_PMD_NR, ZAP_FLAG_CHECK_MAPPING);
 		else /* pte entry */
-			unmap_mapping_pages(mapping, index, 1, false);
+			unmap_mapping_pages(mapping, index, 1,
+					    ZAP_FLAG_CHECK_MAPPING);
 	}
 
 	xas_reset(xas);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0b1d04404275..57bb3d680844 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1710,7 +1710,7 @@ extern int fixup_user_fault(struct mm_struct *mm,
 			    unsigned long address, unsigned int fault_flags,
 			    bool *unlocked);
 void unmap_mapping_pages(struct address_space *mapping,
-		pgoff_t start, pgoff_t nr, bool even_cows);
+		pgoff_t start, pgoff_t nr, unsigned long zap_flags);
 void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows);
 #else
@@ -1730,7 +1730,7 @@ static inline int fixup_user_fault(struct mm_struct *mm, unsigned long address,
 	return -EFAULT;
 }
 static inline void unmap_mapping_pages(struct address_space *mapping,
-		pgoff_t start, pgoff_t nr, bool even_cows) { }
+		pgoff_t start, pgoff_t nr, unsigned long zap_flags) { }
 static inline void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows) { }
 #endif
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 20807163a25f..981d7abb09ef 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1817,7 +1817,8 @@ static void collapse_file(struct mm_struct *mm,
 		}
 
 		if (page_mapped(page))
-			unmap_mapping_pages(mapping, index, 1, false);
+			unmap_mapping_pages(mapping, index, 1,
+					    ZAP_FLAG_CHECK_MAPPING);
 
 		xas_lock_irq(&xas);
 		xas_set(&xas, index);
diff --git a/mm/memory.c b/mm/memory.c
index 873b2515e187..afe09fccdee1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3156,7 +3156,10 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
  * @mapping: The address space containing pages to be unmapped.
  * @start: Index of first page to be unmapped.
  * @nr: Number of pages to be unmapped.  0 to unmap to end of file.
- * @even_cows: Whether to unmap even private COWed pages.
+ * @zap_flags: Zap flags for the process.  E.g., when ZAP_FLAG_CHECK_MAPPING is
+ *   passed into it, we will only zap the pages that are in the same mapping
+ *   specified in the @mapping parameter; otherwise we will not check mapping,
+ *   IOW cow pages will be zapped too.
  *
  * Unmap the pages in this address space from any userspace process which
  * has them mmaped.  Generally, you want to remove COWed pages as well when
@@ -3164,17 +3167,14 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
  * cache.
  */
 void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
-		pgoff_t nr, bool even_cows)
+		pgoff_t nr, unsigned long zap_flags)
 {
 	pgoff_t	first_index = start, last_index = start + nr - 1;
 	struct zap_details details = {
 		.zap_mapping = mapping,
-		.zap_flags = ZAP_FLAG_SKIP_SWAP,
+		.zap_flags = zap_flags | ZAP_FLAG_SKIP_SWAP,
 	};
 
-	if (!even_cows)
-		details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;
-
 	if (last_index < first_index)
 		last_index = ULONG_MAX;
 
@@ -3216,7 +3216,8 @@ void unmap_mapping_range(struct address_space *mapping,
 			hlen = ULONG_MAX - hba + 1;
 	}
 
-	unmap_mapping_pages(mapping, hba, hlen, even_cows);
+	unmap_mapping_pages(mapping, hba, hlen, even_cows ?
+			    0 : ZAP_FLAG_CHECK_MAPPING);
 }
 EXPORT_SYMBOL(unmap_mapping_range);
 
diff --git a/mm/truncate.c b/mm/truncate.c
index 960edf5803ca..dac66749e400 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -178,7 +178,8 @@ truncate_cleanup_page(struct address_space *mapping, struct page *page)
 {
 	if (page_mapped(page)) {
 		unsigned int nr = thp_nr_pages(page);
-		unmap_mapping_pages(mapping, page->index, nr, false);
+		unmap_mapping_pages(mapping, page->index, nr,
+				    ZAP_FLAG_CHECK_MAPPING);
 	}
 
 	if (page_has_private(page))
@@ -750,14 +751,15 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 					 * Zap the rest of the file in one hit.
 					 */
 					unmap_mapping_pages(mapping, index,
-						(1 + end - index), false);
+							    (1 + end - index),
+							    ZAP_FLAG_CHECK_MAPPING);
 					did_range_unmap = 1;
 				} else {
 					/*
 					 * Just zap this page
 					 */
 					unmap_mapping_pages(mapping, index,
-								1, false);
+							    1, ZAP_FLAG_CHECK_MAPPING);
 				}
 			}
 			BUG_ON(page_mapped(page));
@@ -783,7 +785,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	 * get remapped later.
 	 */
 	if (dax_mapping(mapping)) {
-		unmap_mapping_pages(mapping, start, end - start + 1, false);
+		unmap_mapping_pages(mapping, start, end - start + 1,
+				    ZAP_FLAG_CHECK_MAPPING);
 	}
 out:
 	cleancache_invalidate_inode(mapping);
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1DD2F81BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbhAORLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:11:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732850AbhAORK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0JYz3HBZ34RwENyJxX7OSGITuFKgQMNHlEyQKe2PSI=;
        b=Ry0n4tb7TOeEnEod/7ekFfNV79OG1mtr8xGyS3IWU47hCMJBUYxYkFaAPV6NfLDCkbS/ll
        XeVryUJhvyvUEVgYCcd5JJU1ChOKYB8BVzuxdmULyzZLI6S1FD+fpDnViSWpuwrs3NoBEo
        u58HxVkj/CF9o8vt3arZOO09eVqRQ8w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-PMPJSRRaN4e8oS0AgqUJ2g-1; Fri, 15 Jan 2021 12:09:28 -0500
X-MC-Unique: PMPJSRRaN4e8oS0AgqUJ2g-1
Received: by mail-qt1-f200.google.com with SMTP id d26so1369741qto.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0JYz3HBZ34RwENyJxX7OSGITuFKgQMNHlEyQKe2PSI=;
        b=UMFHGMNN5BKGUKBcjKD2f0Xz8wc/EHmH//4jUjFqegmWAoE33J1+RkoCVhL+3YhIXh
         wJowGPlrxJAwIytaIPEa+XhlWXix7SlKrAxL163BHNnUt5yOuCJWeEr0dK+CBuV/gugB
         iYYUZ3EeWfCCcWBL8ECGdTEIRAQZV/04uAbKt6YUj+qqPNTa9onn5B8KpYvR+EpAla6B
         b/OidJ6uqu7W54pAY8j8NIgA/BxwbtBtj1EFmGmoXfJNJ/lD0tS8G3KdD1OQvCOgl2tz
         6qaUEDRK14ujmGh10Ef5x0WFbz106TkZArd1GLL1GrhCzRQ0d/VLl+1Y2pD+RZcvDeMV
         /U8Q==
X-Gm-Message-State: AOAM533Or2Ugdtzd32X+oQansvH21q/M3LZEaenW08yUvr4QpMKwBOGq
        vFEN57ZEesG1d+k+hlvQU7krJPtqk3ZzPzCB9RPOoNIyaza7uSm0Ov571wB6E1N4NP5c3FWsh21
        vHLgT5peqjaOGtKdSWSBOMe0Ifl/+9OA7b4gfLBpOMBMglgScwBKHTiMueb+gfKpR9oW6wgqZyQ
        ==
X-Received: by 2002:a05:6214:533:: with SMTP id x19mr13215482qvw.20.1610730567683;
        Fri, 15 Jan 2021 09:09:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjUXdkNSM6Ii2VUn7NnUVKuMeCISUxdtKhPGypjO2PwOsx14vwE6XLqQeJD6if0ENarzbWBQ==
X-Received: by 2002:a05:6214:533:: with SMTP id x19mr13215453qvw.20.1610730567461;
        Fri, 15 Jan 2021 09:09:27 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:26 -0800 (PST)
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
Subject: [PATCH RFC 09/30] mm: Drop first_index/last_index in zap_details
Date:   Fri, 15 Jan 2021 12:08:46 -0500
Message-Id: <20210115170907.24498-10-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first_index/last_index parameters in zap_details are actually only used in
unmap_mapping_range_tree().  At the meantime, this function is only called by
unmap_mapping_pages() once.  Instead of passing these two variables through the
whole stack of page zapping code, remove them from zap_details and let them
simply be parameters of unmap_mapping_range_tree(), which is inlined.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |  2 --
 mm/memory.c        | 20 ++++++++++----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 85d928764b64..faf9538c13b2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1635,8 +1635,6 @@ extern void user_shm_unlock(size_t, struct user_struct *);
  */
 struct zap_details {
 	struct address_space *check_mapping;	/* Check page->mapping if set */
-	pgoff_t	first_index;			/* Lowest page->index to unmap */
-	pgoff_t last_index;			/* Highest page->index to unmap */
 };
 
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 0b687f0be4d0..dd49dea276e3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3145,20 +3145,20 @@ static void unmap_mapping_range_vma(struct vm_area_struct *vma,
 }
 
 static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
+					    pgoff_t first_index,
+					    pgoff_t last_index,
 					    struct zap_details *details)
 {
 	struct vm_area_struct *vma;
 	pgoff_t vba, vea, zba, zea;
 
-	vma_interval_tree_foreach(vma, root,
-			details->first_index, details->last_index) {
-
+	vma_interval_tree_foreach(vma, root, first_index, last_index) {
 		vba = vma->vm_pgoff;
 		vea = vba + vma_pages(vma) - 1;
-		zba = details->first_index;
+		zba = first_index;
 		if (zba < vba)
 			zba = vba;
-		zea = details->last_index;
+		zea = last_index;
 		if (zea > vea)
 			zea = vea;
 
@@ -3184,17 +3184,17 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
 void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 		pgoff_t nr, bool even_cows)
 {
+	pgoff_t	first_index = start, last_index = start + nr - 1;
 	struct zap_details details = { };
 
 	details.check_mapping = even_cows ? NULL : mapping;
-	details.first_index = start;
-	details.last_index = start + nr - 1;
-	if (details.last_index < details.first_index)
-		details.last_index = ULONG_MAX;
+	if (last_index < first_index)
+		last_index = ULONG_MAX;
 
 	i_mmap_lock_write(mapping);
 	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
-		unmap_mapping_range_tree(&mapping->i_mmap, &details);
+		unmap_mapping_range_tree(&mapping->i_mmap, first_index,
+					 last_index, &details);
 	i_mmap_unlock_write(mapping);
 }
 
-- 
2.26.2


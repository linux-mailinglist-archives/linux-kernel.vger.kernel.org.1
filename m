Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D262D2128
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgLHCv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:51:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59725 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728226AbgLHCv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607395829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1zmhnvZUSAT9HT8Rbhab0qM8yDo/F72PDPxbzWHzkX0=;
        b=SfKj0laEUvD/TqxRhL5xvBWRZGZ+TSDEDigHmP+mIJkdzu7bwZEMOi2dP1m92Vs17ZBYck
        fHCxDbrYLxcLiWovDKHn9yfHYGj4AWYTzMuO784yC+ByGRPZPadDWE14gd0B22XWj4sM4R
        kLzbvonWusOvSwNQgX5tdPD7ShBw8vs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-xUVkn42FO-OWHoLgVQv1FA-1; Mon, 07 Dec 2020 21:50:28 -0500
X-MC-Unique: xUVkn42FO-OWHoLgVQv1FA-1
Received: by mail-qk1-f198.google.com with SMTP id a68so7595724qke.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 18:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1zmhnvZUSAT9HT8Rbhab0qM8yDo/F72PDPxbzWHzkX0=;
        b=dziKFjufBoDisonSWqXi02I3Nne2Sxv7+hfOqjo3kXZ6vaUbZRF5K+ACT832m9z4Km
         2PNwOf+//iTw17rkMsrJl53VTvyGZ0iR1tAX7bYU1jAzCRYLXOiOSuh9BDrsP0qcZhcD
         vchODMwkql/HfML0hQhJ+lbkYx9VtZU5c+1PGL5MPj5iW7i/WasRfphXYSFe++gVYSGf
         68AX0FMfULz13Z8Qw8T4K2etKb8yBxBzX+zc2DVeG9/QPVjqnfkRgTFtshZ8jU5MhTmO
         aM+hCSVpJ1+r8slWhAkyLRPbqGigw7mB30FNJZ2Ev+DY5kCENXnC9vFNPWexgN7pIHGM
         W2JA==
X-Gm-Message-State: AOAM530yM1sw0X9X/KqqrI0oybAmEbMfCk/nGaHSOBD54CIho+5TEbj+
        rUjatC4Kixau+Xz8OE/R0ZLQ1/yFGvnUj+CPtM5l8ojvdMbG9VRsNbAiOgdh4DiK3r7B9CBVj7H
        MW0HGr11hin+7ce/N4fcO9BHSv4U+gKayhEL9SJI3fdFA6z4taHwQ2ieMRvxqXdUpFyHX+/K2Pg
        ==
X-Received: by 2002:ac8:6b86:: with SMTP id z6mr27358543qts.26.1607395827660;
        Mon, 07 Dec 2020 18:50:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzY8pmpVE01uuFXf+fUJmcxo7NWgrHtZoBueRunXhjVH/tM0j0V2OQkmMM/a50rNIjWgvvmmg==
X-Received: by 2002:ac8:6b86:: with SMTP id z6mr27358528qts.26.1607395827344;
        Mon, 07 Dec 2020 18:50:27 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id a28sm2632766qtm.80.2020.12.07.18.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 18:50:26 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/3] mm: Introduce zap_details.zap_flags
Date:   Mon,  7 Dec 2020 21:50:21 -0500
Message-Id: <20201208025022.8234-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201208025022.8234-1-peterx@redhat.com>
References: <20201208025022.8234-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of trying to introduce one variable for every new zap_details fields,
let's introduce a flag so that it can start to encode true/false informations.

Let's start to use this flag first to clean up the only check_mapping variable.
Firstly, the name "check_mapping" implies this is a "boolean", but actually it
stores the mapping inside, just in a way that it won't be set if we don't want
to check the mapping.

To make things clearer, introduce the 1st zap flag ZAP_FLAG_CHECK_MAPPING, so
that we only check against the mapping if this bit set.  At the same time, we
can rename check_mapping into zap_mapping and set it always.

Since at it, introduce another helper zap_check_mapping_skip() and use it in
zap_pte_range() properly.

Some old comments have been removed in zap_pte_range() because they're
duplicated, and since now we're with ZAP_FLAG_CHECK_MAPPING flag, it'll be very
easy to grep this information by simply grepping the flag.

It'll also make life easier when we want to e.g. pass in zap_flags into the
callers like unmap_mapping_pages() (instead of adding new booleans besides the
even_cows parameter).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 19 ++++++++++++++++++-
 mm/memory.c        | 31 ++++++++-----------------------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5d977e484095..7ed4352ec84f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1620,13 +1620,30 @@ static inline bool can_do_mlock(void) { return false; }
 extern int user_shm_lock(size_t, struct user_struct *);
 extern void user_shm_unlock(size_t, struct user_struct *);
 
+/* Whether to check page->mapping when zapping */
+#define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
+
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
 struct zap_details {
-	struct address_space *check_mapping;	/* Check page->mapping if set */
+	struct address_space *zap_mapping;	/* Check page->mapping if set */
+	unsigned long zap_flags;		/* Special flags for zapping */
 };
 
+/* Return true if skip zapping this page, false otherwise */
+static inline bool
+zap_check_mapping_skip(struct zap_details *details, struct page *page)
+{
+	if (!details || !page)
+		return false;
+
+	if (!(details->zap_flags & ZAP_FLAG_CHECK_MAPPING))
+		return false;
+
+	return details->zap_mapping != page_rmapping(page);
+}
+
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 70d57c39380d..20a8ba05c334 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1220,16 +1220,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			struct page *page;
 
 			page = vm_normal_page(vma, addr, ptent);
-			if (unlikely(details) && page) {
-				/*
-				 * unmap_shared_mapping_pages() wants to
-				 * invalidate cache without truncating:
-				 * unmap shared but keep private pages.
-				 */
-				if (details->check_mapping &&
-				    details->check_mapping != page_rmapping(page))
-					continue;
-			}
+			if (unlikely(zap_check_mapping_skip(details, page)))
+				continue;
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
@@ -1261,17 +1253,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		if (is_device_private_entry(entry)) {
 			struct page *page = device_private_entry_to_page(entry);
 
-			if (unlikely(details && details->check_mapping)) {
-				/*
-				 * unmap_shared_mapping_pages() wants to
-				 * invalidate cache without truncating:
-				 * unmap shared but keep private pages.
-				 */
-				if (details->check_mapping !=
-				    page_rmapping(page))
-					continue;
-			}
-
+			if (unlikely(zap_check_mapping_skip(details, page)))
+				continue;
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			rss[mm_counter(page)]--;
 			page_remove_rmap(page, false);
@@ -3176,9 +3159,11 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 		pgoff_t nr, bool even_cows)
 {
 	pgoff_t	first_index = start, last_index = start + nr - 1;
-	struct zap_details details = { };
+	struct zap_details details = { .zap_mapping = mapping };
+
+	if (!even_cows)
+		details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;
 
-	details.check_mapping = even_cows ? NULL : mapping;
 	if (last_index < first_index)
 		last_index = ULONG_MAX;
 
-- 
2.26.2


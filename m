Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8B22F81BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbhAORLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:11:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729599AbhAORLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJk71zqOOD6fILHtrWgSqq8ioKD+WcJBLRfGm+Kflhs=;
        b=Mg9xWOnrLA4uJjvP9tfWRS84j3IVDQl9PFmSga/PYmfbNlY5FZrcfYv2j3bzGJq59bB3IR
        5GyXz5KV2bQdBlmurEMLngzrzQCLrgzBsaVuKOWktg5WrOst5I97SMxuoXqRRgSOG2ASjM
        BgxhaesofWWMDMNN7KZlI9oAuDhEskA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-2Otgv2JbN3q00mafNMC5vg-1; Fri, 15 Jan 2021 12:09:32 -0500
X-MC-Unique: 2Otgv2JbN3q00mafNMC5vg-1
Received: by mail-qk1-f197.google.com with SMTP id p21so8620990qke.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zJk71zqOOD6fILHtrWgSqq8ioKD+WcJBLRfGm+Kflhs=;
        b=ia1KnWcqWi3fE1AYzK8xHrVLddXwmGTygh5CKUBuuyvz1NfZPoPxEJgXc0i9sFZKog
         a55GbLnvNilEQTJaotdtLqh3Cz1eGCbgth/d+5m57S8GqAXq6YfkuVBNVkk2k+B3yVin
         3vzoR4mkMfSZ8JuUHqmk9psH2U+14ZN5l5FqawGhVBHeizrn/P5a4Lkrc0Fm3rCXcoZO
         8FW+Nj6afuAb8xbKIH8ekvoPD0JjWjHq7Y/3oNq9ZxmuQ/mvolV8HKBO48cJc3Gm6pF9
         GMQc8FX+eHN4B013rVp25e8PscvI549veiaW5cc++CPzgBADaj58zicdpJ/GF572NrhR
         Qe8Q==
X-Gm-Message-State: AOAM532R1J6/SzeQ+xVBqTjHfZhoxTesm9Ud0fIYhJXvDAfKQpNwl92y
        LhCUCcM3K/R4k6rb4pOTGqRxwgGMWIcvW8Pb6NhIai3dlf0FNrucnH3HPkjynfC9VCh/SAI9uXD
        q20oUnEXpw1oH6eU7B3wvlHlC6NSpp5BXt79RPcwp85hObZyu0Lq3oDe6uEtgBMK+8VSC/qhAYA
        ==
X-Received: by 2002:ad4:58c2:: with SMTP id dh2mr13333741qvb.4.1610730571926;
        Fri, 15 Jan 2021 09:09:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/ZGLVCHpITAQmxUytH5fcvrbscIS0jfSoJpLhoJN9VFYKioBq4OLm6JnuowYdUKczUKfJBw==
X-Received: by 2002:ad4:58c2:: with SMTP id dh2mr13333709qvb.4.1610730571685;
        Fri, 15 Jan 2021 09:09:31 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:30 -0800 (PST)
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
Subject: [PATCH RFC 11/30] mm: Introduce ZAP_FLAG_SKIP_SWAP
Date:   Fri, 15 Jan 2021 12:08:48 -0500
Message-Id: <20210115170907.24498-12-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, the comment in zap_pte_range() is misleading because it checks against
details rather than check_mappings, so it's against what the code did.

Meanwhile, it's confusing too on not explaining why passing in the details
pointer would mean to skip all swap entries.  New user of zap_details could
very possibly miss this fact if they don't read deep until zap_pte_range()
because there's no comment at zap_details talking about it at all, so swap
entries could be errornously skipped without being noticed.

This partly reverts 3e8715fdc03e ("mm: drop zap_details::check_swap_entries"),
but introduce ZAP_FLAG_SKIP_SWAP flag, which means the opposite of previous
"details" parameter: the caller should explicitly set this to skip swap
entries, otherwise swap entries will always be considered (which is still the
major case here).

Cc: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 12 ++++++++++++
 mm/memory.c        |  8 +++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2380e1df6a49..0b1d04404275 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1632,6 +1632,8 @@ extern void user_shm_unlock(size_t, struct user_struct *);
 
 /* Whether to check page->mapping when zapping */
 #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
+/* Whether to skip zapping swap entries */
+#define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
@@ -1654,6 +1656,16 @@ zap_check_mapping_skip(struct zap_details *details, struct page *page)
 	return details->zap_mapping != page_rmapping(page);
 }
 
+/* Return true if skip swap entries, false otherwise */
+static inline bool
+zap_skip_swap(struct zap_details *details)
+{
+	if (!details)
+		return false;
+
+	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
+}
+
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 43d8641dbe18..873b2515e187 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1268,8 +1268,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			continue;
 		}
 
-		/* If details->check_mapping, we leave swap entries. */
-		if (unlikely(details))
+		if (unlikely(zap_skip_swap(details)))
 			continue;
 
 		if (!non_swap_entry(entry))
@@ -3168,7 +3167,10 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 		pgoff_t nr, bool even_cows)
 {
 	pgoff_t	first_index = start, last_index = start + nr - 1;
-	struct zap_details details = { .zap_mapping = mapping };
+	struct zap_details details = {
+		.zap_mapping = mapping,
+		.zap_flags = ZAP_FLAG_SKIP_SWAP,
+	};
 
 	if (!even_cows)
 		details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;
-- 
2.26.2


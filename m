Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E87727942B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgIYW0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727258AbgIYW0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:26:08 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601072766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=83VPDmzYEL7zTGyeIJw5KGTP3VVq8cB09Qjoi453FqI=;
        b=QisG2VMrUkBIMPlln19n+kv8VYYbdQyMhxBOr4iiQavzcsothU64aqg19LZDHKvQaVwwCe
        7ul1grbhTBs1M2Y1f28rI/Lqj8IWfp4H0CyzEwGKyUi0m5ok0JCKuXjl+wB8HuifoKKelK
        gefzv0fiYGdhjBLUd+bWN8pTnGzq8Kg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-ZRY1F8k1PNKhIQqnS2XxQA-1; Fri, 25 Sep 2020 18:26:05 -0400
X-MC-Unique: ZRY1F8k1PNKhIQqnS2XxQA-1
Received: by mail-qv1-f71.google.com with SMTP id w32so2699401qvw.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83VPDmzYEL7zTGyeIJw5KGTP3VVq8cB09Qjoi453FqI=;
        b=goxtrYTrLShED2BuJBgKr5MfqOg311T3lOrHeJOyb81Qke+cByAJMnW1NQFAwZoc/J
         kctfjIdHophSziJWaIMHegZva0KOZBRekw9ke0tUFDNLeAzbwFp1e4XpyI2z6aoEIwOc
         cKfFk//YydLHt4Gr4TVHVSqTIAk6elEhGcNxX4FKnaDYBoErP+IRbE3KfCiOF644K9oY
         E4tC0OQW+jMfUnVtnLvO5tBGOCPXdwafQfP5bgcS5PpAcaBmneLABtpsDfqPR/nHmqHo
         Z6VqYe7Fk/UVzt9lreL+v/BS9A/BHdp5Gky1kMHOMl906zge0NbuHoRtO1+JTQr12Tve
         6eGg==
X-Gm-Message-State: AOAM530AXHbBWxhsbp3r/pbFsHx4cwPgPlZFJ/09A+F5F+N6fbcslk8m
        L2bJSFwVd/1hVJqTXOmd1q9PHSVHMlGy5tQgjJS0vHyrINHKx5E7h4d25BB1epsWJMPr/+qOjS6
        dkq2NRs6xBvNXFq0vpCvRoYyz
X-Received: by 2002:a05:620a:1367:: with SMTP id d7mr2294638qkl.20.1601072763956;
        Fri, 25 Sep 2020 15:26:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRyeulRe69kAimB9nqfmhL3dvaIO6LziVgyjL+yf/PZwpi4PZATybtfpDGIbm/A0z9wGWDeA==
X-Received: by 2002:a05:620a:1367:: with SMTP id d7mr2294608qkl.20.1601072763613;
        Fri, 25 Sep 2020 15:26:03 -0700 (PDT)
Received: from localhost.localdomain (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id w44sm3051471qth.9.2020.09.25.15.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 15:26:02 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v2 4/4] mm/thp: Split huge pmds/puds if they're pinned when fork()
Date:   Fri, 25 Sep 2020 18:26:00 -0400
Message-Id: <20200925222600.6832-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200925222600.6832-1-peterx@redhat.com>
References: <20200925222600.6832-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinned pages shouldn't be write-protected when fork() happens, because follow
up copy-on-write on these pages could cause the pinned pages to be replaced by
random newly allocated pages.

For huge PMDs, we split the huge pmd if pinning is detected.  So that future
handling will be done by the PTE level (with our latest changes, each of the
small pages will be copied).  We can achieve this by let copy_huge_pmd() return
-EAGAIN for pinned pages, so that we'll fallthrough in copy_pmd_range() and
finally land the next copy_pte_range() call.

Huge PUDs will be even more special - so far it does not support anonymous
pages.  But it can actually be done the same as the huge PMDs even if the split
huge PUDs means to erase the PUD entries.  It'll guarantee the follow up fault
ins will remap the same pages in either parent/child later.

This might not be the most efficient way, but it should be easy and clean
enough.  It should be fine, since we're tackling with a very rare case just to
make sure userspaces that pinned some thps will still work even without
MADV_DONTFORK and after they fork()ed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index faadc449cca5..da397779a6d4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1074,6 +1074,24 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 	src_page = pmd_page(pmd);
 	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
+
+	/*
+	 * If this page is a potentially pinned page, split and retry the fault
+	 * with smaller page size.  Normally this should not happen because the
+	 * userspace should use MADV_DONTFORK upon pinned regions.  This is a
+	 * best effort that the pinned pages won't be replaced by another
+	 * random page during the coming copy-on-write.
+	 */
+	if (unlikely(is_cow_mapping(vma->vm_flags) &&
+		     atomic_read(&src_mm->has_pinned) &&
+		     page_maybe_dma_pinned(src_page))) {
+		pte_free(dst_mm, pgtable);
+		spin_unlock(src_ptl);
+		spin_unlock(dst_ptl);
+		__split_huge_pmd(vma, src_pmd, addr, false, NULL);
+		return -EAGAIN;
+	}
+
 	get_page(src_page);
 	page_dup_rmap(src_page, true);
 	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
@@ -1177,6 +1195,16 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		/* No huge zero pud yet */
 	}
 
+	/* Please refer to comments in copy_huge_pmd() */
+	if (unlikely(is_cow_mapping(vma->vm_flags) &&
+		     atomic_read(&src_mm->has_pinned) &&
+		     page_maybe_dma_pinned(pud_page(pud)))) {
+		spin_unlock(src_ptl);
+		spin_unlock(dst_ptl);
+		__split_huge_pud(vma, src_pud, addr);
+		return -EAGAIN;
+	}
+
 	pudp_set_wrprotect(src_mm, addr, src_pud);
 	pud = pud_mkold(pud_wrprotect(pud));
 	set_pud_at(dst_mm, addr, dst_pud, pud);
-- 
2.26.2


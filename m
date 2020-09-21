Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3403F2734CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgIUVUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbgIUVUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600723236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDMdof6ALSopUITXJ9LE96zIR7LM2dnpA2weFW14G1E=;
        b=KxRkSqRZ3VQga4nSR2XtIn2NUD+u/JZHsN2wbJtlGPdHPdsptuh6X0vjiYz5NwFxiBX5ef
        s/OgcFpLeSg8s/P2R7WoQpPe/hTl4Ewx+usmcypsBbNiHfiCjgnEYzcSPUsIKPUfYH3m2o
        M9BSpMP4xwKHGumO6XeIG5TwMUOiG7M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-eb577YOUN92ER44ka_iq0A-1; Mon, 21 Sep 2020 17:20:34 -0400
X-MC-Unique: eb577YOUN92ER44ka_iq0A-1
Received: by mail-qt1-f199.google.com with SMTP id e6so14125998qtg.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 14:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDMdof6ALSopUITXJ9LE96zIR7LM2dnpA2weFW14G1E=;
        b=mJ8Eq+syRjsZVe0T2rO3hJrmckGamgvCYCzrmW1JJghLPsVMnX5BeoSy+bq6EAhhzk
         UeM53m27YAusOzik8e2e0mCKydwBQ7AFRrOO9yGtYVdz+8hInREOOwuePXgZtsm0Hdx+
         nu5uPebjMdqqj9bbIr7cbDw1kAZmvUFLNcfrO47xZ34AFt711ezppGNGZQLX4Tagiktc
         4o/vWhFfxaYfDTQ5WFD22iy7QmoV1ZgcOxCcTAhkBazwBYCa4Ge4s0jWUa6Qn9aJPD+F
         TWga7CV4ThqJ55HAybYemIypUM/VuUCRs3NqpG2sc+yBtedW98gIN/41wqRlxGzuQtt4
         u0jg==
X-Gm-Message-State: AOAM531lif7vlauQF45zFHOpBCVqoebbRh+s7ABJfQgwLOtHYcZllgUO
        qWW418OPlrn0YLiugoFdXE0rySvib2FRtj0h9wbnW8DQVJKXfFyP0j4x34PnogPYqOWlepQ+duh
        a0BPe31m5Rr1KH6LxJnUUhLGs
X-Received: by 2002:ad4:42b3:: with SMTP id e19mr2290405qvr.6.1600723234195;
        Mon, 21 Sep 2020 14:20:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDjASxm4cZwqCyNr7H0oNe8o3ayVDHqmTX72bTOJkJWKrmKm1WB/Vws768Lk5uQL2LI2S7ew==
X-Received: by 2002:ad4:42b3:: with SMTP id e19mr2290376qvr.6.1600723233967;
        Mon, 21 Sep 2020 14:20:33 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id p28sm11437356qta.88.2020.09.21.14.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 14:20:33 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH 5/5] mm/thp: Split huge pmds/puds if they're pinned when fork()
Date:   Mon, 21 Sep 2020 17:20:31 -0400
Message-Id: <20200921212031.25233-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921211744.24758-1-peterx@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
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
 mm/huge_memory.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7ff29cc3d55c..c40aac0ad87e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1074,6 +1074,23 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
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
+	if (unlikely(READ_ONCE(src_mm->has_pinned) &&
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
@@ -1177,6 +1194,15 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		/* No huge zero pud yet */
 	}
 
+	/* Please refer to comments in copy_huge_pmd() */
+	if (unlikely(READ_ONCE(src_mm->has_pinned) &&
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3E62F81C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbhAORLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:11:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733191AbhAORLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2RW1oC/qi3s0vECjAVM4EdHx2RWM3abAnstC0UUqfa4=;
        b=AEXL2u5MDqL+M/YVUO6xahw8iohFYutgA9r24r1kyS7os9FQ02qTFFuDfzldLykNhssgPI
        mISISLMllDyD4GDpHfX5uZ/vW2Wabm7Ko0PEOit+xPYlU48RTe1KYHb2OwgHQFHDtrleLg
        Prjsfi7nvHGvILKHikzqKX3/aBxvj9s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-1qcic9iUN4Wfvi4exQVoQQ-1; Fri, 15 Jan 2021 12:09:42 -0500
X-MC-Unique: 1qcic9iUN4Wfvi4exQVoQQ-1
Received: by mail-qk1-f200.google.com with SMTP id l138so8616599qke.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2RW1oC/qi3s0vECjAVM4EdHx2RWM3abAnstC0UUqfa4=;
        b=dKLbujEkw1iTODkSXDZkPOMdlj9oWwe+cO99qU8TNzPY9yopRcfhYqxOEhL5M9rl0N
         9DLz7vhdyFOE6i4nFitunbrmqtBDO+89vPKmyFgQPL++AmsLCV1WMhxiFkoLartrAX2z
         7OYQPlwpqOUSb94t5qZuNX9DnnPZF/gAUDFOy257VBzWnfq+kv8SSSq8V0GoLsSVMwrq
         a5LJusr2DeoF7pI9yYxbSf5+jPumuAjtEM7ZjlHZ21iusk1uPcFlb37toGHioJaA1AXg
         iwljkjq7QTEo6y7uYq67ErLKkQwT2Xo/UhT3jODrDTaTkyzT2K5tih1wd8bfHRqQTCFB
         XOIw==
X-Gm-Message-State: AOAM531adEIQygXCk8vPIHG1Rkq093StyLSeYuq8+WzQkIZslgYbVKKL
        Mrts8CRGkJJ6v4juxlVRDw9ub3l+dImDiPYTYikWZQPBM2ASO6q7richgCwLFJJmjH5ICe2JhFF
        +fUnJ8FvqJMXvYw6m+HKo9z4uGV6p0i75cbVDULMD9AzhYFuL73pYz1NmNACBNFCF93/iDCBp8Q
        ==
X-Received: by 2002:ae9:ebd5:: with SMTP id b204mr13053912qkg.195.1610730581789;
        Fri, 15 Jan 2021 09:09:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwE1LDryFn9iuF2RmMnRgFXb7Hrs0U9bk25uHUYNCYsMb0UtyRhx3yW16acT/76VwhO+7vNHA==
X-Received: by 2002:ae9:ebd5:: with SMTP id b204mr13053878qkg.195.1610730581492;
        Fri, 15 Jan 2021 09:09:41 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:40 -0800 (PST)
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
Subject: [PATCH RFC 16/30] shmem/userfaultfd: Handle the left-overed special swap ptes
Date:   Fri, 15 Jan 2021 12:08:53 -0500
Message-Id: <20210115170907.24498-17-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that the special uffd-wp swap pte can be left over even if the page under
the pte got evicted.  Normally when evict a page, we will unmap the ptes by
walking through the reverse mapping.  However we never tracked such information
for the special swap ptes because they're not real mappings but just markers.
So we need to take care of that when we see a marker but when it's actually
meaningless (the page behind it got evicted).

We have already taken care of that in e.g. alloc_set_pte() where we'll treat
the special swap pte as pte_none() when necessary.  However we need to also
teach userfaultfd itself on either UFFDIO_COPY or handling page faults, so that
everything will still work as expected.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 15 +++++++++++++++
 mm/shmem.c       | 13 ++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 000b457ad087..3537a43b69c9 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -331,6 +331,21 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	 */
 	if (pte_none(*pte))
 		ret = true;
+	/*
+	 * We also treat the swap special uffd-wp pte as the pte_none() here.
+	 * This should in most cases be a missing event, as we never handle
+	 * wr-protect upon a special uffd-wp swap pte - it should first be
+	 * converted into a normal read request before handling wp.  It just
+	 * means the page/swap cache that backing this pte is gone, so this
+	 * special pte is leftover.
+	 *
+	 * We can't simply replace it with a none pte because we're not with
+	 * the pgtable lock here.  Instead of taking it and clearing the pte,
+	 * the easy way is to let UFFDIO_COPY understand this pte too when
+	 * trying to install a new page onto it.
+	 */
+	if (pte_swp_uffd_wp_special(*pte))
+		ret = true;
 	if (!pte_write(*pte) && (reason & VM_UFFD_WP))
 		ret = true;
 	pte_unmap(pte);
diff --git a/mm/shmem.c b/mm/shmem.c
index de45333626f7..9947bcf92663 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2456,7 +2456,18 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release_unlock;
 
 	ret = -EEXIST;
-	if (!pte_none(*dst_pte))
+	/*
+	 * Besides the none pte, we also allow UFFDIO_COPY to install a pte
+	 * onto the uffd-wp swap special pte, because that pte should be the
+	 * same as a pte_none() just in that it contains wr-protect information
+	 * (which could only be dropped when unmap the memory).
+	 *
+	 * It's safe to drop that marker because we know this is part of a
+	 * MISSING fault, and the caller is very clear about this page missing
+	 * rather than wr-protected.  Then we're sure the wr-protect bit is
+	 * just a leftover so it's useless already.
+	 */
+	if (!pte_none(*dst_pte) && !pte_swp_uffd_wp_special(*dst_pte))
 		goto out_release_unlock;
 
 	lru_cache_add(page);
-- 
2.26.2


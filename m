Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378432F81B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbhAORKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:10:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727670AbhAORKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mHLrJ5S0GG/KaPJKytrt7gQrBF3eoNX3484kaZfBHrA=;
        b=FoDgXvSdnA7A0AEAqBtkCvzP19Lr97Qhij60vtocOqFug4gNB8xxNBhEyZSCyGIZk9gf5y
        657hYpDbFHUxqebpG2Pu8P1TBk25FXme+FKnYXUA1nCQ/MX7pPBTDG4sow3512V5VtgVOn
        7++bfKtZrJnfRhyuFZtzSDNPzkd6Ovs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-Tn1_pFslMPu98W_sZYFPvA-1; Fri, 15 Jan 2021 12:09:13 -0500
X-MC-Unique: Tn1_pFslMPu98W_sZYFPvA-1
Received: by mail-qt1-f198.google.com with SMTP id e14so7871369qtr.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHLrJ5S0GG/KaPJKytrt7gQrBF3eoNX3484kaZfBHrA=;
        b=B+LNX0kgU9tpKyvhqVryGKhgrWZir/ftxkZOTTsAUFJzUrAHLUcs8r1A3sqnokPoK1
         wgCtxlyIN3kXHUR5oNNwJdIUlnJEoqQuJMQbWlHrbeJuvBZWWCCL3e3J9LPcZKvdDt6+
         JHBnd3KtTBluEWfDg179AMZD28UXZewTv7xND0I8OJwx5aZuTFEWosmlQdbCJCPfI4Pa
         I2OEHwskuZR+LIdET4PCjXDKhD7S79/X77Eq8lPTuv0aJEbQFMhSbXLWk4SHXTfu/SR1
         CsjRz9b0P8YIJZwIPSxZPquVOopZ7w7tSyYBM6o6y/Q0dsbvGUolttNaPbm3KGDX9w9a
         Sb/A==
X-Gm-Message-State: AOAM533isFtYo++wAUFbKZiHOeFRXPHUhUDgVzSf+TodzibRz8X02/dl
        DOc202obgFjIxfE4olWf3ZnhBfFoAGoVfPaYFvcdRvbTpxk7JxtPV/Tz1VLHYIzmBJHz+k1dJpf
        d+nk5kf9eA6j80/5hzq3Uh7amvt0R9Ca9qux0W5Pr0CT6DxVySDpz3LMXf4Ab/NfdTvfQsbR4Rg
        ==
X-Received: by 2002:ac8:488e:: with SMTP id i14mr12617658qtq.372.1610730551370;
        Fri, 15 Jan 2021 09:09:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsp9bEM5PMzBbT8M14w42+8pX/BLJyTHZkLiXgcRVTGoU7UpYGDMzrmgA0vG0YbE5PiQX55A==
X-Received: by 2002:ac8:488e:: with SMTP id i14mr12617613qtq.372.1610730551089;
        Fri, 15 Jan 2021 09:09:11 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:10 -0800 (PST)
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
Subject: [PATCH RFC 01/30] mm/thp: Simplify copying of huge zero page pmd when fork
Date:   Fri, 15 Jan 2021 12:08:38 -0500
Message-Id: <20210115170907.24498-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huge zero page is handled in a special path in copy_huge_pmd(), however it
should share most codes with a normal thp page.  Trying to share more code with
it by removing the special path.  The only leftover so far is the huge zero
page refcounting (mm_get_huge_zero_page()), because that's separately done with
a global counter.

This prepares for a future patch to modify the huge pmd to be installed, so
that we don't need to duplicate it explicitly into huge zero page case too.

Cc: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ec2bb93f7431..b64ad1947900 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1058,17 +1058,13 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 * a page table.
 	 */
 	if (is_huge_zero_pmd(pmd)) {
-		struct page *zero_page;
 		/*
 		 * get_huge_zero_page() will never allocate a new page here,
 		 * since we already have a zero page to copy. It just takes a
 		 * reference.
 		 */
-		zero_page = mm_get_huge_zero_page(dst_mm);
-		set_huge_zero_page(pgtable, dst_mm, vma, addr, dst_pmd,
-				zero_page);
-		ret = 0;
-		goto out_unlock;
+		mm_get_huge_zero_page(dst_mm);
+		goto out_zero_page;
 	}
 
 	src_page = pmd_page(pmd);
@@ -1094,6 +1090,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	get_page(src_page);
 	page_dup_rmap(src_page, true);
 	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+out_zero_page:
 	mm_inc_nr_ptes(dst_mm);
 	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
 
-- 
2.26.2


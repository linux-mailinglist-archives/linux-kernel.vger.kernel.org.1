Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619E82F81C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733264AbhAORLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:11:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733234AbhAORLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6siyxttlu7KCpWlkxB4VjYp+yZ18KeXRH4qtrNiwZw=;
        b=VqXDcHVGCh8qUN0/9qu7AUxUK+F3zwai7xvtlBoDIApL9x5b1gpvQDHYd8p5nSjxtpISqA
        BrjHUdw67J5nYJJSHcZl6L7jEPXUfwn+N1VD0kTXoq6jCUjYZDX5J20G1RCcqHiB0mMRv/
        pMzr/NjnsGnws78CN6R4Q2N945DbZSw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-fFGrO0bUNrCrYdeWtf58Mg-1; Fri, 15 Jan 2021 12:09:46 -0500
X-MC-Unique: fFGrO0bUNrCrYdeWtf58Mg-1
Received: by mail-qk1-f199.google.com with SMTP id l138so8616767qke.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6siyxttlu7KCpWlkxB4VjYp+yZ18KeXRH4qtrNiwZw=;
        b=FqZxei6kU9MlC6aa6L9Qh2KFXx7mo+0oKhJc1ocjcpmrdHIx/oonD8bsMI/MUV3Myj
         jYppOYcc6nFv8qD0vINuCDHHM6E17Ee2q7/ciAIT4wiUvk5aXPYUyyrT2aT/O74O9hSN
         +pa3Xw3unT/wTM3qZgdmS1hX97CDenirkntlOKPYo0w0XGYeFjauN2YjJhPJh5dmy+Uy
         MzGtWWSrxhiodfq4F/KVC0d2tWAkFfeVnrJ4EDrmPXZ5mPMzalBo87rol6WHKLyG40Qc
         /0OVG7G8vxM/HWouV1sR3RLk8G+JNEYxfZGLvKpOKntAWsLA5LyY4Trkgka+dCnOugEx
         uWgg==
X-Gm-Message-State: AOAM531W5l2ujTBkbVTmFHJJ4TzyuTmUzuvonyq42yt9vSYsoOOQ0Q3r
        DVzd4ybSB6q40rgGl0R6jary7brVOh0F768UTbGhReCmGzV2FDDPsjYjKfoZ5VKLhjs0jy8f1G6
        MM+2ANw5eW7kpWFcXmIsaWN/wHrBwUAjyzyOPaeiWxQ1GRgqooPP0Gf8YLndYv4BozWjB1qGFsQ
        ==
X-Received: by 2002:a37:4a4e:: with SMTP id x75mr13396472qka.89.1610730586008;
        Fri, 15 Jan 2021 09:09:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy247OPfvvMBFwBHFtTUpj3tm1FUibXTgft3ZPmifm23yeptWRPKyFEZ5qXtk/qtx/VoM7IRQ==
X-Received: by 2002:a37:4a4e:: with SMTP id x75mr13396416qka.89.1610730585574;
        Fri, 15 Jan 2021 09:09:45 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:44 -0800 (PST)
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
Subject: [PATCH RFC 18/30] hugetlb/userfaultfd: Hook page faults for uffd write protection
Date:   Fri, 15 Jan 2021 12:08:55 -0500
Message-Id: <20210115170907.24498-19-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hook up hugetlbfs_fault() with the capability to handle userfaultfd-wp faults.

We do this slightly earlier than hugetlb_cow() so that we can avoid taking some
extra locks that we definitely don't need.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d029d938d26d..dcbbba53bd10 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4544,6 +4544,25 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
 		goto out_ptl;
 
+	/* Handle userfault-wp first, before trying to lock more pages */
+	if (userfaultfd_pte_wp(vma, huge_ptep_get(ptep)) &&
+	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
+		struct vm_fault vmf = {
+			.vma = vma,
+			.address = haddr,
+			.flags = flags,
+		};
+
+		spin_unlock(ptl);
+		if (pagecache_page) {
+			unlock_page(pagecache_page);
+			put_page(pagecache_page);
+		}
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		i_mmap_unlock_read(mapping);
+		return handle_userfault(&vmf, VM_UFFD_WP);
+	}
+
 	/*
 	 * hugetlb_cow() requires page locks of pte_page(entry) and
 	 * pagecache_page, so here we need take the former one
-- 
2.26.2


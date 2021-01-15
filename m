Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497AC2F81CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbhAORLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:11:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21055 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbhAORL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7v8QDeNoG8OU/p7s9fC8RzrSPTHJdCM/pVMqrxY8yjM=;
        b=cVJzPLkK/9GFwZkPFeu3VX7gLXsEWfgIYMzzFapcEVh7KpSxlmBZj/hysmsklZX/derqTr
        MLAOhWCImmrOsQHf0Z3QvTogLItEcVU1ch5VNfGSao+GuJ0Yfy/qX0EyMGx9qPSSw2w/b0
        FetHiEfwZv34FHGR8jH3gDWK91hI/2k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-AMPOAOGoNhu4AWpF7EUh3g-1; Fri, 15 Jan 2021 12:10:00 -0500
X-MC-Unique: AMPOAOGoNhu4AWpF7EUh3g-1
Received: by mail-qk1-f197.google.com with SMTP id u9so8617663qkk.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7v8QDeNoG8OU/p7s9fC8RzrSPTHJdCM/pVMqrxY8yjM=;
        b=PURqB+ejARsN/1yPg23Dkvk7CmiqilM0YWpobStqOQ1S5K4STnLk2dhqJuW32UBppb
         Fo5hnOFtFEXG3Ex7l2JqWmIkRbNL9EqpE0VGRM3H59q3UjRV5aclmzQH78SsqZ+GDqsp
         w//6bjzP4Y4I/8rf+hdFToIMYITSJesd4EBIVJ60jnzDWqBa3aX9jGfRnIFYmH6VnHEz
         VVoNPR+B5a0JnKCJzGaDjtbqmUNp7n1dbXus8MywaBf6L0GgWOx0aIeGkz46Ra8BCX2M
         pBRDAiq4azdhJzf1BpTV6y2FnW7PGTHPWdbg6eTaWJVKEI7fGMo+NcJADvHLFIGlsc9V
         2svw==
X-Gm-Message-State: AOAM530CE81pHSTx95Eh/G//K+ub0/APQu9bD6gOe+rYT97qKK8T/WDM
        vDqt/WoWZRILgr+2IXLHQpeDy968rkEIIH7weW0rpadNy3KRloV63qNFXuac0G+lNJzQrFRVJgB
        uJkBuZ7SGr0IcxwNf784iW6UVJ9Ve5okouOiJGuDOSfyusxOqjh9ZcAj/tfJDfXPfwgU+2fDm+Q
        ==
X-Received: by 2002:aed:3964:: with SMTP id l91mr1920036qte.32.1610730598822;
        Fri, 15 Jan 2021 09:09:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBMs/Rjdvzmsm9NCdgZQkWUAdVthi7FvD5c8VyUB4WKoACNSo+uWAgz6uRc12xEta7mwRbgA==
X-Received: by 2002:aed:3964:: with SMTP id l91mr1919997qte.32.1610730598498;
        Fri, 15 Jan 2021 09:09:58 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:57 -0800 (PST)
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
Subject: [PATCH RFC 25/30] hugetlb/userfaultfd: Unshare all pmds for hugetlbfs when register wp
Date:   Fri, 15 Jan 2021 12:09:02 -0500
Message-Id: <20210115170907.24498-26-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huge pmd sharing for hugetlbfs is racy with userfaultfd-wp because
userfaultfd-wp is always based on pgtable entries, so they cannot be shared.

Walk the hugetlb range and unshare all such mappings if there is, right before
UFFDIO_REGISTER will succeed and return to userspace.

This will pair with want_pmd_share() in hugetlb code so that huge pmd sharing
is completely disabled for userfaultfd-wp registered range.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c             | 43 ++++++++++++++++++++++++++++++++++++
 include/linux/mmu_notifier.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 3537a43b69c9..3190dff39d6c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -15,6 +15,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/mm.h>
+#include <linux/mmu_notifier.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
@@ -1198,6 +1199,45 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 	}
 }
 
+/*
+ * This function will unconditionally remove all the shared pmd pgtable entries
+ * within the specific vma for a hugetlbfs memory range.
+ */
+static void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
+{
+	struct hstate *h = hstate_vma(vma);
+	unsigned long sz = huge_page_size(h);
+	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_notifier_range range;
+	unsigned long address;
+	spinlock_t *ptl;
+	pte_t *ptep;
+
+	/*
+	 * No need to call adjust_range_if_pmd_sharing_possible(), because
+	 * we're going to operate on the whole vma
+	 */
+	mmu_notifier_range_init(&range, MMU_NOTIFY_HUGETLB_UNSHARE,
+				0, vma, mm, vma->vm_start, vma->vm_end);
+	mmu_notifier_invalidate_range_start(&range);
+	i_mmap_lock_write(vma->vm_file->f_mapping);
+	for (address = vma->vm_start; address < vma->vm_end; address += sz) {
+		ptep = huge_pte_offset(mm, address, sz);
+		if (!ptep)
+			continue;
+		ptl = huge_pte_lock(h, mm, ptep);
+		huge_pmd_unshare(mm, vma, &address, ptep);
+		spin_unlock(ptl);
+	}
+	flush_hugetlb_tlb_range(vma, vma->vm_start, vma->vm_end);
+	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	/*
+	 * No need to call mmu_notifier_invalidate_range(), see
+	 * Documentation/vm/mmu_notifier.rst.
+	 */
+	mmu_notifier_invalidate_range_end(&range);
+}
+
 static void __wake_userfault(struct userfaultfd_ctx *ctx,
 			     struct userfaultfd_wake_range *range)
 {
@@ -1456,6 +1496,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx.ctx = ctx;
 
+		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
+			hugetlb_unshare_all_pmds(vma);
+
 	skip:
 		prev = vma;
 		start = vma->vm_end;
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index b8200782dede..ff50c8528113 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -51,6 +51,7 @@ enum mmu_notifier_event {
 	MMU_NOTIFY_SOFT_DIRTY,
 	MMU_NOTIFY_RELEASE,
 	MMU_NOTIFY_MIGRATE,
+	MMU_NOTIFY_HUGETLB_UNSHARE,
 };
 
 #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
-- 
2.26.2


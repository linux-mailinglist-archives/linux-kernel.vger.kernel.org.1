Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420192F81D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbhAORM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:12:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42960 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729026AbhAORLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uo187ljIKtl+Ve2u3XKyxHQxREG1CzLvXoZ9sZssXMc=;
        b=gTxPGRFE/47cEqJmt61xl5SgvXE9Mdebbum8kS9TcJJm5RWr38E0Jl9k6suSQVE+/nhYuP
        Xr1bMMoIPHzh00oLtqVDsQlZfJk1ggY0p+zDm4W14wOZgQxoWGYfQtAzbrzrbaeevbP9Et
        eh0wa7VScxQIif9zzbqywPHQ0tU1gNQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-8-_UeX1DNmaXV4GOEcr8mw-1; Fri, 15 Jan 2021 12:09:48 -0500
X-MC-Unique: 8-_UeX1DNmaXV4GOEcr8mw-1
Received: by mail-qt1-f197.google.com with SMTP id c14so7881727qtn.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uo187ljIKtl+Ve2u3XKyxHQxREG1CzLvXoZ9sZssXMc=;
        b=JiK69amKX/V8LpJTs1bk4zJ9gQCeIt5+5jnhjZP3Mcb/NTlg4PbxULYxbzPL2q4sF+
         OkIal6zSOKNg3QVp7bmTVv0CFKmWLKoD4VIEphPCzD7gPsW+DJlklyX3lt0pYegzbYjE
         aCu8/y6s1+GJSZfJVXBRPYzBKTHeWosZtusPZa+6UlmxLSbfqL9YrZ+hGnTEiaHV/Qqv
         8RxwViC58GR4rBwoLn+CnqKrW6lgacueJL99K10E3r87IWppPyUgDctiJ+5q7mvGmSUt
         XdNBLhEAN02aF/7/h+M0xVY+VEFeQTNubRdTcfq8m8bBCk3IsV77u0Kh/j4BXYvxyK96
         bbWw==
X-Gm-Message-State: AOAM533oGP1BI9XOjOJgzOLUIVhuAx9g0H1QU2VfyVh3ZkVg7OKToaLD
        wumGEa9cAHiSN4lg07k8Xk+Q5ip/y06TifbbXVwdJtvgdwUa+yvsZsonhQcPHcgpUKJmgII6z4s
        mYhOatbvm/+nN8rpIxfeXOGuzVrhQJIy91mlwJLqxq8W8UQs47T3Ia1uxjObNhzBW8NPqCbzlDw
        ==
X-Received: by 2002:a05:6214:504:: with SMTP id v4mr12626552qvw.54.1610730587465;
        Fri, 15 Jan 2021 09:09:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZfKqOh3ezoGUMGkQTHnf/tdFrONUsOKGa4/2/CEv0Wfi0RVejL4iZxSP/JZlIQULBxfJCjA==
X-Received: by 2002:a05:6214:504:: with SMTP id v4mr12626514qvw.54.1610730587234;
        Fri, 15 Jan 2021 09:09:47 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:46 -0800 (PST)
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
Subject: [PATCH RFC 19/30] hugetlb/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
Date:   Fri, 15 Jan 2021 12:08:56 -0500
Message-Id: <20210115170907.24498-20-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, pass the wp_copy variable into hugetlb_mcopy_atomic_pte() thoughout
the stack.  Then, apply the UFFD_WP bit if UFFDIO_COPY_MODE_WP is with
UFFDIO_COPY.  Introduce huge_pte_mkuffd_wp() for it.

Note that similar to how we've handled shmem, we'd better keep setting the
dirty bit even if UFFDIO_COPY_MODE_WP is provided, so that the core mm will
know this page contains valid data and never drop it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/asm-generic/hugetlb.h |  5 +++++
 include/linux/hugetlb.h       |  6 ++++--
 mm/hugetlb.c                  |  9 +++++++--
 mm/userfaultfd.c              | 12 ++++++++----
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 8e1e6244a89d..548212eccbd6 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -27,6 +27,11 @@ static inline pte_t huge_pte_mkdirty(pte_t pte)
 	return pte_mkdirty(pte);
 }
 
+static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
+{
+	return pte_mkuffd_wp(pte);
+}
+
 static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return pte_modify(pte, newprot);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ebca2ef02212..bd061f7eedcb 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -138,7 +138,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				struct vm_area_struct *dst_vma,
 				unsigned long dst_addr,
 				unsigned long src_addr,
-				struct page **pagep);
+				struct page **pagep,
+				bool wp_copy);
 int hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
 						vm_flags_t vm_flags);
@@ -313,7 +314,8 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 						struct vm_area_struct *dst_vma,
 						unsigned long dst_addr,
 						unsigned long src_addr,
-						struct page **pagep)
+						struct page **pagep,
+						bool wp_copy)
 {
 	BUG();
 	return 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dcbbba53bd10..563b8f70537f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4624,7 +4624,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    struct vm_area_struct *dst_vma,
 			    unsigned long dst_addr,
 			    unsigned long src_addr,
-			    struct page **pagep)
+			    struct page **pagep,
+			    bool wp_copy)
 {
 	struct address_space *mapping;
 	pgoff_t idx;
@@ -4717,8 +4718,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	}
 
 	_dst_pte = make_huge_pte(dst_vma, page, dst_vma->vm_flags & VM_WRITE);
-	if (dst_vma->vm_flags & VM_WRITE)
+	if (dst_vma->vm_flags & VM_WRITE) {
 		_dst_pte = huge_pte_mkdirty(_dst_pte);
+		if (wp_copy)
+			_dst_pte = huge_pte_mkuffd_wp(
+			    huge_pte_wrprotect(_dst_pte));
+	}
 	_dst_pte = pte_mkyoung(_dst_pte);
 
 	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 6d4b3b7c7f9f..b00e5e6b8b8b 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -207,7 +207,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
-					      bool zeropage)
+					      bool zeropage,
+					      bool wp_copy)
 {
 	int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
@@ -306,7 +307,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		}
 
 		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
-						dst_addr, src_addr, &page);
+					       dst_addr, src_addr, &page,
+					       wp_copy);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		i_mmap_unlock_read(mapping);
@@ -408,7 +410,8 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
-				      bool zeropage);
+				      bool zeropage,
+				      bool wp_copy);
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
@@ -527,7 +530,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-						src_start, len, zeropage);
+					       src_start, len, zeropage,
+					       wp_copy);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477C82F81B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbhAORKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:10:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732382AbhAORKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPPhkXY6qqcoUMjqvnKf4Rq6Ghiq17Gr0NJKks49TF8=;
        b=Os3puhMGfo+oHPlDUvXbrPjHZryj0qoLlYBS6LAknj4HxywcXwHLsEE1YUSzQA63QNvly0
        5CPGwFvEmXOzuuB9W87IlkGM0dq04GZIKkcC96APqNT35X6YsSXS0mJYCcqnaqdMD3x/9W
        R+amqmQ5SYbGn8fndMzxqyPdil3nKwQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-eeECNwnBMqOs511rIQZ9Wg-1; Fri, 15 Jan 2021 12:09:19 -0500
X-MC-Unique: eeECNwnBMqOs511rIQZ9Wg-1
Received: by mail-qt1-f197.google.com with SMTP id b11so7869738qtj.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EPPhkXY6qqcoUMjqvnKf4Rq6Ghiq17Gr0NJKks49TF8=;
        b=rFea0RAn8QVyZzRaurjYa1mzfQ1A/xjp86igHHzVC07mencgTkHprmJbp/bIeL/C89
         ZP+E0hJbuzKErf2o6q8BjmT5DyeC7Vzm7vNGkZn2C9Il8JA1EHKPQfsBq504F1QE1yKX
         ba0hBiPhIQNfpjxd7dPPKp2xaW+2MMdyvrqGGMF0GHj1aQr4Wy/w18Dv0Msn9eQRaOfq
         4rj5WtMFtmIljxC7VXmfVBiSkbaol9XBWgf7pLt2fQ18rfYXMbRJDJi3FdCiWrdpOs3k
         X1OaLVOOiJEOkByy8kDP0sLQk97rsqfTjXyQVxIIR7eh5zaiQOSdMKRxqvplQCGRMZVw
         MNbA==
X-Gm-Message-State: AOAM533zs18xCB/JtUMlLUe75HM+fzd/sjLqhAKLzDn9yXWPTSUiol7S
        yB92anYE10nXu3kk95LbE8ZdQxaMPDDpg/w78/dleR9trW+NH/7iBKEGoawfus5VwaA/oDxw/E5
        Q2HZcWw+T5h0675qP5RiJ3RitIaxXcfYudFvWizhPANx0J+o8UFXsozkx22Nr89VZgVFNumKnag
        ==
X-Received: by 2002:ac8:5909:: with SMTP id 9mr12534459qty.39.1610730556652;
        Fri, 15 Jan 2021 09:09:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyA6aXXTk8b7KR4J5Sp3e2w3GhtAjwNrFTg1PW5St0nUpfk5uptN72sS8pOhTvI4iezxGfWTQ==
X-Received: by 2002:ac8:5909:: with SMTP id 9mr12534416qty.39.1610730556339;
        Fri, 15 Jan 2021 09:09:16 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:15 -0800 (PST)
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
Subject: [PATCH RFC 04/30] shmem/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
Date:   Fri, 15 Jan 2021 12:08:41 -0500
Message-Id: <20210115170907.24498-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, pass wp_copy into shmem_mfill_atomic_pte() through the stack.
Then apply the UFFD_WP bit properly when the UFFDIO_COPY on shmem is with
UFFDIO_COPY_MODE_WP.

One thing to mention is that shmem_mfill_atomic_pte() needs to set the dirty
bit in pte even if UFFDIO_COPY_MODE_WP is set.  The reason is similar to
dcf7fe9d8976 ("userfaultfd: shmem: UFFDIO_COPY: set the page dirty if VM_WRITE
is not set") where we need to set page as dirty even if VM_WRITE is no there.
It's just that shmem can drop the pte any time later, and if it's not dirty the
data will be dropped.  For uffd-wp, that could lead to data loss if without the
dirty bit set.

Note that shmem_mfill_zeropage_pte() will always call shmem_mfill_atomic_pte()
with wp_copy==false because UFFDIO_ZEROCOPY does not support UFFDIO_COPY_MODE_WP.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/shmem_fs.h |  5 +++--
 mm/shmem.c               | 26 +++++++++++++++++++-------
 mm/userfaultfd.c         |  2 +-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index a5a5d1d4d7b1..9d6fc68a1e57 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -123,14 +123,15 @@ extern int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 				  struct vm_area_struct *dst_vma,
 				  unsigned long dst_addr,
 				  unsigned long src_addr,
-				  struct page **pagep);
+				  struct page **pagep,
+				  bool wp_copy);
 extern int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
 				    pmd_t *dst_pmd,
 				    struct vm_area_struct *dst_vma,
 				    unsigned long dst_addr);
 #else
 #define shmem_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
-			       src_addr, pagep)        ({ BUG(); 0; })
+			       src_addr, pagep, wp_copy)    ({ BUG(); 0; })
 #define shmem_mfill_zeropage_pte(dst_mm, dst_pmd, dst_vma, \
 				 dst_addr)      ({ BUG(); 0; })
 #endif
diff --git a/mm/shmem.c b/mm/shmem.c
index 537c137698f8..de45333626f7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2363,7 +2363,8 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 				  unsigned long dst_addr,
 				  unsigned long src_addr,
 				  bool zeropage,
-				  struct page **pagep)
+				  struct page **pagep,
+				  bool wp_copy)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -2425,9 +2426,18 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release;
 
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
-	if (dst_vma->vm_flags & VM_WRITE)
-		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
-	else {
+	if (dst_vma->vm_flags & VM_WRITE) {
+		if (wp_copy)
+			_dst_pte = pte_mkuffd_wp(pte_wrprotect(_dst_pte));
+		else
+			_dst_pte = pte_mkwrite(_dst_pte);
+		/*
+		 * Similar reason to set_page_dirty(), that we need to mark the
+		 * pte dirty even if wp_copy==true here, otherwise the pte and
+		 * its page could be dropped at anytime when e.g. swapped out.
+		 */
+		_dst_pte = pte_mkdirty(_dst_pte);
+	} else {
 		/*
 		 * We don't set the pte dirty if the vma has no
 		 * VM_WRITE permission, so mark the page dirty or it
@@ -2485,10 +2495,12 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr,
 			   unsigned long src_addr,
-			   struct page **pagep)
+			   struct page **pagep,
+			   bool wp_copy)
 {
 	return shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
-				      dst_addr, src_addr, false, pagep);
+				      dst_addr, src_addr, false, pagep,
+				      wp_copy);
 }
 
 int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
@@ -2499,7 +2511,7 @@ int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
 	struct page *page = NULL;
 
 	return shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
-				      dst_addr, 0, true, &page);
+				      dst_addr, 0, true, &page, false);
 }
 
 #ifdef CONFIG_TMPFS
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 9a3d451402d7..6d4b3b7c7f9f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -445,7 +445,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 		if (!zeropage)
 			err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd,
 						     dst_vma, dst_addr,
-						     src_addr, page);
+						     src_addr, page, wp_copy);
 		else
 			err = shmem_mfill_zeropage_pte(dst_mm, dst_pmd,
 						       dst_vma, dst_addr);
-- 
2.26.2


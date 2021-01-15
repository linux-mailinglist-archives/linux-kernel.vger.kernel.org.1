Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911DC2F81C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbhAORLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:11:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732001AbhAORLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qc9c/gofLjGafrTcbLQ3n1guQABnxcjbcx/uBfZWm9I=;
        b=YtqMBB5JI2/Qjx+GnkLZDruv51TeCKJfna4z0ip8UNXXBjTeAfZwKIMJNIct90MDeTLgNU
        MjdQ3BHI/ftUMUK+78RQNmgVY1/IKwT0X7cDdEwSGxoZaBA0qq2tpOOcRYKLluQua20kwR
        rMspU9XI6dhnHy+H87WOgQd2qUkbD/8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-ascgd0LDOTyDi1yCpvFzOg-1; Fri, 15 Jan 2021 12:10:08 -0500
X-MC-Unique: ascgd0LDOTyDi1yCpvFzOg-1
Received: by mail-qv1-f71.google.com with SMTP id k16so8245748qve.19
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qc9c/gofLjGafrTcbLQ3n1guQABnxcjbcx/uBfZWm9I=;
        b=BBrKZ2eyHLyRvE5GR7fEUFUdiFlulf86Xqy808aQSyWBcPnxe0aZpdKN34xVzvThRv
         hrYcWTdCCE1yq7ynvo3eIgrupIM8UkoH5Sxaw2Jos1g1RzdFZY+JlXxpk1qw5guKrmSu
         XC23UfRw+UwWe1Z26t/sfAmg8HThCeyQ3ATTGLcWbz7w/br9LTBHdPlVf8xl0zWA4bCX
         IbGPBKu0IpztwZ7iHPo0LEF5Sg0dZsiAvn1dKiwM+okJpPLuL5Faf7pcUzIRD/trSFeb
         76ppaB6w05osi64scn2RYnep3H2D2Hhzo6LhWSk6NKFPFtZagQuiWM4haS1SpZLu+AX2
         Y3ig==
X-Gm-Message-State: AOAM531PpLLdcVCVS+XQnqJPVHfjcYv/jCIZ8VshG32AV2y1fDFnsbNA
        SHdiwUlSrhfSEdNeaioUwOYKMIgQZza4V0Ak1RrMAuChU77eDlZvOBG2Sk10GjlCVxcWpvDSyz+
        vs/wxJN+ggvN/nNoVoI5Lt4zwczLvp7mkWRAym9H8+IbHzkYWttL/Hf/iO/7+4rH6gGw/ByaqZA
        ==
X-Received: by 2002:ac8:4553:: with SMTP id z19mr12589532qtn.278.1610730605835;
        Fri, 15 Jan 2021 09:10:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoMgM51c/GHRmaGeJ+Zy2tSzT8SlyOfu7E1vA+zEc9W0Bb9NoJGtjyJUxMHvZEaMYWNpZWYw==
X-Received: by 2002:ac8:4553:: with SMTP id z19mr12589487qtn.278.1610730605474;
        Fri, 15 Jan 2021 09:10:05 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:10:04 -0800 (PST)
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
Subject: [PATCH RFC 29/30] userfaultfd: Enable write protection for shmem & hugetlbfs
Date:   Fri, 15 Jan 2021 12:09:06 -0500
Message-Id: <20210115170907.24498-30-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've had all the necessary changes ready for both shmem and hugetlbfs.  Turn
on all the shmem/hugetlbfs switches for userfaultfd-wp.

Now we can remove the flags parameter for vma_can_userfault() since not used
any more.  Meanwhile, we can expand UFFD_API_RANGE_IOCTLS_BASIC with
_UFFDIO_WRITEPROTECT too because all existing types now support write
protection mode.

Since vma_can_userfault() will be used elsewhere, move into userfaultfd_k.h.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c                 | 17 ++++-------------
 include/linux/userfaultfd_k.h    |  7 +++++++
 include/uapi/linux/userfaultfd.h |  3 ++-
 mm/userfaultfd.c                 | 10 +++-------
 4 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 3264ec46242b..88ad90fc8539 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1307,15 +1307,6 @@ static __always_inline int validate_range(struct mm_struct *mm,
 	return 0;
 }
 
-static inline bool vma_can_userfault(struct vm_area_struct *vma,
-				     unsigned long vm_flags)
-{
-	/* FIXME: add WP support to hugetlbfs and shmem */
-	return vma_is_anonymous(vma) ||
-		((is_vm_hugetlb_page(vma) || vma_is_shmem(vma)) &&
-		 !(vm_flags & VM_UFFD_WP));
-}
-
 static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 				unsigned long arg)
 {
@@ -1394,7 +1385,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 
 		/* check not compatible vmas */
 		ret = -EINVAL;
-		if (!vma_can_userfault(cur, vm_flags))
+		if (!vma_can_userfault(cur))
 			goto out_unlock;
 
 		/*
@@ -1453,7 +1444,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	do {
 		cond_resched();
 
-		BUG_ON(!vma_can_userfault(vma, vm_flags));
+		BUG_ON(!vma_can_userfault(vma));
 		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
 		       vma->vm_userfaultfd_ctx.ctx != ctx);
 		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
@@ -1602,7 +1593,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		 * provides for more strict behavior to notice
 		 * unregistration errors.
 		 */
-		if (!vma_can_userfault(cur, cur->vm_flags))
+		if (!vma_can_userfault(cur))
 			goto out_unlock;
 
 		found = true;
@@ -1616,7 +1607,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	do {
 		cond_resched();
 
-		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
+		BUG_ON(!vma_can_userfault(vma));
 
 		/*
 		 * Nothing to do: this vma is already registered into this
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 7d14444862d4..fd7031173949 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -16,6 +16,7 @@
 #include <linux/fcntl.h>
 #include <linux/mm.h>
 #include <asm-generic/pgtable_uffd.h>
+#include <linux/hugetlb_inline.h>
 
 /*
  * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
@@ -88,6 +89,12 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 	return vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP);
 }
 
+static inline bool vma_can_userfault(struct vm_area_struct *vma)
+{
+	return vma_is_anonymous(vma) || vma_is_shmem(vma) ||
+	    is_vm_hugetlb_page(vma);
+}
+
 extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
 extern void dup_userfaultfd_complete(struct list_head *);
 
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index e7e98bde221f..83bcd739de50 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -39,7 +39,8 @@
 	 (__u64)1 << _UFFDIO_WRITEPROTECT)
 #define UFFD_API_RANGE_IOCTLS_BASIC		\
 	((__u64)1 << _UFFDIO_WAKE |		\
-	 (__u64)1 << _UFFDIO_COPY)
+	 (__u64)1 << _UFFDIO_COPY |		\
+	 (__u64)1 << _UFFDIO_WRITEPROTECT)
 
 /*
  * Valid ioctl command number range with this API is from 0x00 to
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 1dff5b9a2c26..3ad52f01553b 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -445,7 +445,6 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 			err = mfill_zeropage_pte(dst_mm, dst_pmd,
 						 dst_vma, dst_addr);
 	} else {
-		VM_WARN_ON_ONCE(wp_copy);
 		if (!zeropage)
 			err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd,
 						     dst_vma, dst_addr,
@@ -671,15 +670,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 
 	err = -ENOENT;
 	dst_vma = find_dst_vma(dst_mm, start, len);
-	/*
-	 * Make sure the vma is not shared, that the dst range is
-	 * both valid and fully within a single existing vma.
-	 */
-	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
+
+	if (!dst_vma)
 		goto out_unlock;
 	if (!userfaultfd_wp(dst_vma))
 		goto out_unlock;
-	if (!vma_is_anonymous(dst_vma))
+	if (!vma_can_userfault(dst_vma))
 		goto out_unlock;
 
 	if (is_vm_hugetlb_page(dst_vma)) {
-- 
2.26.2


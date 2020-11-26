Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16B2C5DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 23:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391829AbgKZWYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 17:24:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391811AbgKZWYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 17:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606429445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kjJ3uf7v5WaBpBCr7bqxgU6BDn3tacPiof+m7txYtT8=;
        b=GhDYvN+V/6NwFfZPIjsaGWsC9VNoXGXumCMpOUmxJAqEQz8yX2/XbiGja/oERf9NYvTZty
        rq9Hh2H2v8u1t1aIVmdfveqZ7SGeKZIp28G6zUZqxtXkFD03gAB6fuMtSLA11BiEjvy2Ff
        ixROC2fU9/McrimQZNRM2El80ZDClis=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-z8w6peGpPSaNZHeu-onJZQ-1; Thu, 26 Nov 2020 17:24:03 -0500
X-MC-Unique: z8w6peGpPSaNZHeu-onJZQ-1
Received: by mail-qt1-f199.google.com with SMTP id o12so1663233qtw.14
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 14:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kjJ3uf7v5WaBpBCr7bqxgU6BDn3tacPiof+m7txYtT8=;
        b=V7xGCuCkXjiocy3ii59eq6aLVXDwQQQ2GdByB+5Pzl0NShKIqqPtF6CTlmIYM5UrUV
         rRQLigKKluQuOEHLOPhWyNXsuHWi5M4//ofIObON7m5hFSP6VurasEA2Dm/UJUMG6CEX
         uHnsuuF0YFT+IiKf8mvu4v2iKKWxAQ/G3KJQ9L4HSCSGFCe8SBAKgM6+qdJ4wfVumh5d
         yr08gc/55VamzlfcYHZOenK/CXtZpw/pn7QOgRXg/Hw6fzuuN5heHRT1fXO1+xKmbFou
         ibJMVMVwbuOGbR1xINoI1hARPDWoBQbi3sGiS8t/wUDXk3ZbpDIZp2Jd6V+jrrIxkwnf
         mp9Q==
X-Gm-Message-State: AOAM530GMoiX3d0iTTKy78bhIpqSOuJ25uWwZPfGYqhj9QlQjnEsF5Cn
        u5iBVYnp4yWyYQbZOzlTQFWiWNe0crZFtDuF3Rmy0BkEsiuDG79hZGp/wGsyfgf5TJp4Ba8/Pn+
        7nIUS0ZzxgrOBh5zycFyOIxizr0IKLAEJ4CoGkyy2MEFIUegRVclCsfnZ29v/TWx7/uqWtKivhg
        ==
X-Received: by 2002:ac8:134b:: with SMTP id f11mr5109691qtj.126.1606429442976;
        Thu, 26 Nov 2020 14:24:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyR7i78Qb3v31x/mfYi/TUGN6S5qVtXLyNjSQ82qD1sJmiqf9i7czpgLvmAF/p3bLO6fXlvBw==
X-Received: by 2002:ac8:134b:: with SMTP id f11mr5109664qtj.126.1606429442684;
        Thu, 26 Nov 2020 14:24:02 -0800 (PST)
Received: from localhost.localdomain ([142.126.81.247])
        by smtp.gmail.com with ESMTPSA id k32sm3999242qte.59.2020.11.26.14.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 14:24:01 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] mm: Don't fault around userfaultfd-registered regions on reads
Date:   Thu, 26 Nov 2020 17:23:59 -0500
Message-Id: <20201126222359.8120-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Faulting around for reads are in most cases helpful for the performance so that
continuous memory accesses may avoid another trip of page fault.  However it
may not always work as expected.

For example, userfaultfd registered regions may not be the best candidate for
pre-faults around the reads.

For missing mode uffds, fault around does not help because if the page cache
existed, then the page should be there already.  If the page cache is not
there, nothing else we can do, either.  If the fault-around code is destined to
be helpless for userfault-missing vmas, then ideally we can skip it.

For wr-protected mode uffds, errornously fault in those pages around could lead
to threads accessing the pages without uffd server's awareness.  For example,
when punching holes on uffd-wp registered shmem regions, we'll first try to
unmap all the pages before evicting the page cache but without locking the
page (please refer to shmem_fallocate(), where unmap_mapping_range() is called
before shmem_truncate_range()).  When fault-around happens near a hole being
punched, we might errornously fault in the "holes" right before it will be
punched.  Then there's a small window before the page cache was finally
dropped, and after the page will be writable again (NOTE: the uffd-wp protect
information is totally lost due to the pre-unmap in shmem_fallocate(), so the
page can be writable within the small window).  That's severe data loss.

Let's grant the userspace full control of the uffd-registered ranges, rather
than trying to do the tricks.

Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

Note that since no file-backed uffd-wp support is there yet upstream, so the
uffd-wp check is actually not really functioning.  However since we have all
the necessary uffd-wp concepts already upstream, maybe it's better to do it
once and for all.

This patch comes from debugging a data loss issue when working on the uffd-wp
support on shmem/hugetlbfs.  I posted this out for early review and comments,
but also because it should already start to benefit missing mode userfaultfd to
avoid trying to fault around on reads.
---
 include/linux/userfaultfd_k.h |  5 +++++
 mm/memory.c                   | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index a8e5f3ea9bb2..451d99bb3a1a 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -62,6 +62,11 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_UFFD_WP;
 }
 
+static inline bool vma_registered_userfaultfd(struct vm_area_struct *vma)
+{
+	return userfaultfd_missing(vma) || userfaultfd_wp(vma);
+}
+
 static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
 				      pte_t pte)
 {
diff --git a/mm/memory.c b/mm/memory.c
index eeae590e526a..ca58ada94c96 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3933,6 +3933,23 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	int off;
 	vm_fault_t ret = 0;
 
+	/*
+	 * Be extremely careful with uffd-armed regions.
+	 *
+	 * For missing mode uffds, fault around does not help because if the
+	 * page cache existed, then the page should be there already.  If the
+	 * page cache is not there, nothing else we can do either.
+	 *
+	 * For wr-protected mode uffds, errornously fault in those pages around
+	 * could lead to threads accessing the pages without uffd server's
+	 * awareness, finally it could cause ghostly data corruption.
+	 *
+	 * The idea is that, every single page of uffd regions should be
+	 * governed by the userspace on which page to fault in.
+	 */
+	if (unlikely(vma_registered_userfaultfd(vmf->vma)))
+		return 0;
+
 	nr_pages = READ_ONCE(fault_around_bytes) >> PAGE_SHIFT;
 	mask = ~(nr_pages * PAGE_SIZE - 1) & PAGE_MASK;
 
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA622F81C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733198AbhAORLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:11:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733116AbhAORLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TcPY6/7za0lNPyDAmKRI/igfmQiWJ8vt53iJjnvvO3w=;
        b=ESQ5hdt+Hn6kvWqWZ8ruczIsowWRIjTzhZwng7qLB8PL4+W+Ig9zPgF3pNyRhlupmCcwxv
        ETN0rDYgDSYhWPNefpwpLHu1DaBLKOxZmfFX5gaK4e2F10N3zVs4L450uLYmdqF4ddPFm1
        QQQaujXPrk82IaMlt988DK9NPOh8Lbc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-r-IlFRTMMdaJ97kCccA-Ag-1; Fri, 15 Jan 2021 12:09:38 -0500
X-MC-Unique: r-IlFRTMMdaJ97kCccA-Ag-1
Received: by mail-qk1-f200.google.com with SMTP id p21so8621268qke.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TcPY6/7za0lNPyDAmKRI/igfmQiWJ8vt53iJjnvvO3w=;
        b=LXuviPqYO5vnjWzLf7+NPgDBs5T1i5emO+YNIoE3b0Gcz4GpK9nqsMslENzxrj+3b3
         oLfolQtmwhAlfFCBw3FTgJK29pXUcFHQbRD2C/htrOHvW9Ok6rRtmmj1uz+SYxU422SN
         S6x+Ev6M1LKY4JtHeF6eqnFPb3+RJIu2K3SbRuJMtvanWvTuRxrJE0AKlo/RhqtgFK9R
         1SYmaVpBy0rSZz2K4/nz4EyU+8Vmi42ZEpTYRW2/vDIVoJcrWhf/8MkGouWxlAVds3vW
         jfRdiEX9IPdFoffhwJKKXffgqI0CXYjai4P7DxnDm4Nx3p1bXrVhE/9/rL0DcUDNkD2F
         VxBQ==
X-Gm-Message-State: AOAM532uYVJPJnP0/cjeSbG60z+Q4rEptUoyws2nG6aBAAo2hREZy+K9
        ri27QXxD6tIq473agiWxWQa+qL4KB+6r+q3+dBqtbZI42d5Yf25jSIZp1awidXNbCUiPasKbpHW
        vL83wZ/VylAohHmvRuXJRE8bLSGzLUmw21cVxidFcwYK5X50QclVm9Uy5l31u6CJvjwZNi18Dbg
        ==
X-Received: by 2002:a37:4bc1:: with SMTP id y184mr13317289qka.278.1610730577674;
        Fri, 15 Jan 2021 09:09:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9hYHKUoizQIDfREFDpOwWL5XviptW/l4PxeLmjUj9Hh/PjW0cghaNlNVKRdMVb7Q0NdxI+g==
X-Received: by 2002:a37:4bc1:: with SMTP id y184mr13317249qka.278.1610730577340;
        Fri, 15 Jan 2021 09:09:37 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:36 -0800 (PST)
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
Subject: [PATCH RFC 14/30] shmem/userfaultfd: Allow wr-protect none pte for file-backed mem
Date:   Fri, 15 Jan 2021 12:08:51 -0500
Message-Id: <20210115170907.24498-15-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File-backed memory differs from anonymous memory in that even if the pte is
missing, the data could still resides either in the file or in page/swap cache.
So when wr-protect a pte, we need to consider none ptes too.

We do that by installing the uffd-wp special swap pte as a marker.  So when
there's a future write to the pte, the fault handler will go the special path
to first fault-in the page as read-only, then report to userfaultfd server with
the wr-protect message.

On the other hand, when unprotecting a page, it's also possible that the pte
got unmapped but replaced by the special uffd-wp marker.  Then we'll need to be
able to recover from a uffd-wp special swap pte into a none pte, so that the
next access to the page will fault in correctly as usual when trigger the fault
handler next time, rather than sending a uffd-wp message.

Special care needs to be taken throughout the change_protection_range()
process.  Since now we allow user to wr-protect a none pte, we need to be able
to pre-populate the page table entries if we see !anonymous && MM_CP_UFFD_WP
requests, otherwise change_protection_range() will always skip when the pgtable
entry does not exist.

Note that this patch only covers the small pages (pte level) but not covering
any of the transparent huge pages yet.  But this will be a base for thps too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mprotect.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index e75bfe43cedd..c9390fd673fe 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -29,6 +29,7 @@
 #include <linux/uaccess.h>
 #include <linux/mm_inline.h>
 #include <linux/pgtable.h>
+#include <linux/userfaultfd_k.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -176,6 +177,32 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				set_pte_at(vma->vm_mm, addr, pte, newpte);
 				pages++;
 			}
+		} else if (unlikely(is_swap_special_pte(oldpte))) {
+			if (uffd_wp_resolve && !vma_is_anonymous(vma) &&
+			    pte_swp_uffd_wp_special(oldpte)) {
+				/*
+				 * This is uffd-wp special pte and we'd like to
+				 * unprotect it.  What we need to do is simply
+				 * recover the pte into a none pte; the next
+				 * page fault will fault in the page.
+				 */
+				pte_clear(vma->vm_mm, addr, pte);
+				pages++;
+			}
+		} else {
+			/* It must be an none page, or what else?.. */
+			WARN_ON_ONCE(!pte_none(oldpte));
+			if (unlikely(uffd_wp && !vma_is_anonymous(vma))) {
+				/*
+				 * For file-backed mem, we need to be able to
+				 * wr-protect even for a none pte!  Because
+				 * even if the pte is null, the page/swap cache
+				 * could exist.
+				 */
+				set_pte_at(vma->vm_mm, addr, pte,
+					   pte_swp_mkuffd_wp_special(vma));
+				pages++;
+			}
 		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
@@ -209,6 +236,25 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 	return 0;
 }
 
+/*
+ * File-backed vma allows uffd wr-protect upon none ptes, because even if pte
+ * is missing, page/swap cache could exist.  When that happens, the wr-protect
+ * information will be stored in the page table entries with the marker (e.g.,
+ * PTE_SWP_UFFD_WP_SPECIAL).  Prepare for that by always populating the page
+ * tables to pte level, so that we'll install the markers in change_pte_range()
+ * where necessary.
+ *
+ * Note that we only need to do this in pmd level, because if pmd does not
+ * exist, it means the whole range covered by the pmd entry (of a pud) does not
+ * contain any valid data but all zeros.  Then nothing to wr-protect.
+ */
+#define  change_protection_prepare(vma, pmd, addr, cp_flags)		\
+	do {								\
+		if (unlikely((cp_flags & MM_CP_UFFD_WP) && pmd_none(*pmd) && \
+			     !vma_is_anonymous(vma)))			\
+			WARN_ON_ONCE(pte_alloc(vma->vm_mm, pmd));	\
+	} while (0)
+
 static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
@@ -227,6 +273,8 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 
 		next = pmd_addr_end(addr, end);
 
+		change_protection_prepare(vma, pmd, addr, cp_flags);
+
 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
 		 * held for read. It's possible a parallel update to occur
-- 
2.26.2


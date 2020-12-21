Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7CA2DFF56
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgLUSIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgLUSIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:08:40 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4AEC061285
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:08:00 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id v2so6890663pfm.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=9Oi8lrhXv/5Abu57ubtpE66M1jalfYjk6u8WuCWIm+A=;
        b=d48Usehigpdf+lkAwC0AElsEImiMghaPoNWOEeoqVRZRi5KFD61UWRJ9LiQEPi/yPE
         C1FHnbJ1aDnvqrprZa4j7StywZYZz/W/DdvOcEcKLSbXKmbgtZbOkewSOEXnL5A40huA
         5WKP9AJvJ4Zv2FkAD77bnFimH1wPlLSIkWs8xYm4vTgNSedDlSTgPKO02jIkPq9cU980
         VsfSzcDa/1e9dK9WinBWu3IZBdHTLoabXXseo5PRE2FCfpwDmKOBRi9LILPLzNlGYnbs
         B7N/qUeXcpwu4joYxNIpyHEp8X58Kcui5moD2cFXIeRuOHUPn9MdKy6xqWgjPj9c9MvU
         1fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=9Oi8lrhXv/5Abu57ubtpE66M1jalfYjk6u8WuCWIm+A=;
        b=TKddr1SAaTLcD1obfJkGN0MO3zor1cUJi+2LgHgDS3GVccdvsBEdkY5CTaojJTfLo3
         Vwja0qNKu3acgXFsDzI8aOAQM+HXsG0lmSrt4dvcLEOitQAIbaB9YjSoObEL75EZ2GHO
         n8TXOZnS0lwr1VjaWzYTr+rg0JVd+Ptq2N3eeWG56Phd+mPILpNP3/6eyWsA3ZsgNWHO
         Ew/zKXuGxJjMqB/Pf3eIZODTuLlK3wiYrJQLit7VUfo95LHzu0xNl59/o5yBoDiGEOev
         oinuXRED1sNBolykx7HsaYPlxQFsuJmpqlYdy/ke8+y2XIPRePhlVRsIQ7LG2R5Ih36o
         jR6w==
X-Gm-Message-State: AOAM531j0WNhmly/no3H68lBnPKcgPYLLX2cPRy+ZWEaT91dbZNhEEkt
        aZM1np3z/35rtH8nxVY6/cG5R4Erqic=
X-Google-Smtp-Source: ABdhPJyW9OjfUf5XM6pDRzTbaEK6TiZuK6JeHqMmkb2+V6kRt3sPIjwRJ07j5aBXUqSLoCnpvwDj4g==
X-Received: by 2002:a17:902:ee52:b029:da:4dee:1a54 with SMTP id 18-20020a170902ee52b02900da4dee1a54mr17139049plo.29.1608568228355;
        Mon, 21 Dec 2020 08:30:28 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id u12sm16070387pfn.88.2020.12.21.08.30.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:30:28 -0800 (PST)
From:   Liang Li <liliang.opensource@gmail.com>
X-Google-Original-From: Liang Li <liliang324@gmail.com>
Date:   Mon, 21 Dec 2020 11:30:25 -0500
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [RFC v2 PATCH 4/4] mm: pre zero out free pages to speed up page
 allocation for __GFP_ZERO
Message-ID: <20201221163024.GA22532@open-light-1.localdomain>
Mail-Followup-To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero out the page content usually happens when allocating pages with
the flag of __GFP_ZERO, this is a time consuming operation, it makes
the population of a large vma area very slowly. This patch introduce
a new feature for zero out pages before page allocation, it can help
to speed up page allocation with __GFP_ZERO.

My original intention for adding this feature is to shorten VM
creation time when SR-IOV devicde is attached, it works good and the
VM creation time is reduced by about 90%.

Creating a VM [64G RAM, 32 CPUs] with GPU passthrough
=====================================================
QEMU use 4K pages, THP is off
                  round1      round2      round3
w/o this patch:    23.5s       24.7s       24.6s
w/ this patch:     10.2s       10.3s       11.2s

QEMU use 4K pages, THP is on
                  round1      round2      round3
w/o this patch:    17.9s       14.8s       14.9s
w/ this patch:     1.9s        1.8s        1.9s
=====================================================

Obviously, it can do more than this. We can benefit from this feature
in the flowing case:

Interactive sence
=================
Shorten application lunch time on desktop or mobile phone, it can help
to improve the user experience. Test shows on a
server [Intel(R) Xeon(R) CPU E5-2620 v3 @ 2.40GHz], zero out 1GB RAM by
the kernel will take about 200ms, while some mainly used application
like Firefox browser, Office will consume 100 ~ 300 MB RAM just after
launch, by pre zero out free pages, it means the application launch
time will be reduced about 20~60ms (can be sensed by people?). May be
we can make use of this feature to speed up the launch of Andorid APP
(I didn't do any test for Android).

Virtulization
=============
Speed up VM creation and shorten guest boot time, especially for PCI
SR-IOV device passthrough scenario. Compared with some of the para
vitalization solutions, it is easy to deploy because it’s transparent
to guest and can handle DMA properly in BIOS stage, while the para
virtualization solution can’t handle it well.

Improve guest performance when use VIRTIO_BALLOON_F_REPORTING for memory
overcommit. The VIRTIO_BALLOON_F_REPORTING feature will report guest page
to the VMM, VMM will unmap the corresponding host page for reclaim,
when guest allocate a page just reclaimed, host will allocate a new page
and zero it out for guest, in this case pre zero out free page will help
to speed up the proccess of fault in and reduce the performance impaction.

Speed up kernel routine
=======================
This can’t be guaranteed because we don’t pre zero out all the free pages,
but is true for most case. It can help to speed up some important system
call just like fork, which will allocate zero pages for building page
table. And speed up the process of page fault, especially for huge page
fault. The POC of Hugetlb free page pre zero out has been done.

Security
========
This is a weak version of "introduce init_on_alloc=1 and init_on_free=1
boot options", which zero out page in a asynchronous way. For users can't
tolerate the impaction of 'init_on_alloc=1' or 'init_on_free=1' brings,
this feauture provide another choice.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Liang Li <liliang324@gmail.com>
---
 include/linux/highmem.h        |  31 +++-
 include/linux/page-flags.h     |  16 +-
 include/trace/events/mmflags.h |   7 +
 mm/Kconfig                     |  10 ++
 mm/Makefile                    |   1 +
 mm/huge_memory.c               |   3 +-
 mm/page_alloc.c                |   4 +
 mm/page_prezero.c              | 266 +++++++++++++++++++++++++++++++++
 mm/page_prezero.h              |  13 ++
 9 files changed, 346 insertions(+), 5 deletions(-)
 create mode 100644 mm/page_prezero.c
 create mode 100644 mm/page_prezero.h

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index d2c70d3772a3..badb5d0528f7 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -146,7 +146,13 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
 #ifndef clear_user_highpage
 static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
 {
-	void *addr = kmap_atomic(page);
+	void *addr;
+
+#ifdef CONFIG_PREZERO_PAGE
+	if (TestClearPageZero(page))
+		return;
+#endif
+	addr = kmap_atomic(page);
 	clear_user_page(addr, vaddr, page);
 	kunmap_atomic(addr);
 }
@@ -197,9 +203,30 @@ alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
 	return __alloc_zeroed_user_highpage(__GFP_MOVABLE, vma, vaddr);
 }
 
+#ifdef CONFIG_PREZERO_PAGE
+static inline void __clear_highpage(struct page *page)
+{
+	void *kaddr;
+
+	if (PageZero(page))
+		return;
+
+	kaddr = kmap_atomic(page);
+	clear_page(kaddr);
+	SetPageZero(page);
+	kunmap_atomic(kaddr);
+}
+#endif
+
 static inline void clear_highpage(struct page *page)
 {
-	void *kaddr = kmap_atomic(page);
+	void *kaddr;
+
+#ifdef CONFIG_PREZERO_PAGE
+	if (TestClearPageZero(page))
+		return;
+#endif
+	kaddr = kmap_atomic(page);
 	clear_page(kaddr);
 	kunmap_atomic(kaddr);
 }
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index ec5d0290e0ee..b0a1ae41659c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -137,6 +137,9 @@ enum pageflags {
 #endif
 #ifdef CONFIG_64BIT
 	PG_arch_2,
+#endif
+#ifdef CONFIG_PREZERO_PAGE
+	PG_zero,
 #endif
 	__NR_PAGEFLAGS,
 
@@ -451,6 +454,15 @@ PAGEFLAG(Idle, idle, PF_ANY)
  */
 __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
 
+#ifdef CONFIG_PREZERO_PAGE
+PAGEFLAG(Zero, zero, PF_ANY)
+TESTSCFLAG(Zero, zero, PF_ANY)
+#define __PG_ZERO (1UL << PG_zero)
+#else
+PAGEFLAG_FALSE(Zero)
+#define __PG_ZERO 0
+#endif
+
 /*
  * On an anonymous page mapped into a user virtual memory area,
  * page->mapping points to its anon_vma, not to a struct address_space;
@@ -823,7 +835,7 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
 	 1UL << PG_private	| 1UL << PG_private_2	|	\
 	 1UL << PG_writeback	| 1UL << PG_reserved	|	\
 	 1UL << PG_slab		| 1UL << PG_active 	|	\
-	 1UL << PG_unevictable	| __PG_MLOCKED)
+	 1UL << PG_unevictable	| __PG_MLOCKED | __PG_ZERO)
 
 /*
  * Flags checked when a page is prepped for return by the page allocator.
@@ -834,7 +846,7 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
  * alloc-free cycle to prevent from reusing the page.
  */
 #define PAGE_FLAGS_CHECK_AT_PREP	\
-	(((1UL << NR_PAGEFLAGS) - 1) & ~__PG_HWPOISON)
+	(((1UL << NR_PAGEFLAGS) - 1) & ~(__PG_HWPOISON | __PG_ZERO))
 
 #define PAGE_FLAGS_PRIVATE				\
 	(1UL << PG_private | 1UL << PG_private_2)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 67018d367b9f..16dfdbfed8d2 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -73,6 +73,12 @@
 #define IF_HAVE_PG_HWPOISON(flag,string)
 #endif
 
+#ifdef CONFIG_PREZERO_PAGE
+#define IF_HAVE_PG_ZERO(flag,string) ,{1UL << flag, string}
+#else
+#define IF_HAVE_PG_ZERO(flag,string)
+#endif
+
 #if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
 #define IF_HAVE_PG_IDLE(flag,string) ,{1UL << flag, string}
 #else
@@ -110,6 +116,7 @@
 IF_HAVE_PG_MLOCK(PG_mlocked,		"mlocked"	)		\
 IF_HAVE_PG_UNCACHED(PG_uncached,	"uncached"	)		\
 IF_HAVE_PG_HWPOISON(PG_hwpoison,	"hwpoison"	)		\
+IF_HAVE_PG_ZERO(PG_zero,		"zero"		)		\
 IF_HAVE_PG_IDLE(PG_young,		"young"		)		\
 IF_HAVE_PG_IDLE(PG_idle,		"idle"		)		\
 IF_HAVE_PG_ARCH_2(PG_arch_2,		"arch_2"	)
diff --git a/mm/Kconfig b/mm/Kconfig
index 4275c25b5d8a..22ac80fb4f4e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -253,6 +253,16 @@ config PAGE_REPORTING
 	  those pages to another entity, such as a hypervisor, so that the
 	  memory can be freed within the host for other uses.
 
+#
+# support for pre zero out free page
+config PREZERO_PAGE
+	bool "Pre zero out free page"
+	def_bool y
+	depends on PAGE_REPORTING
+	help
+	  Allows pre zero out free pages in freelist based on free
+	  page reporting
+
 #
 # support for page migration
 #
diff --git a/mm/Makefile b/mm/Makefile
index b6cd2fffa492..cf91c8b47d43 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -120,3 +120,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
+obj-$(CONFIG_PREZERO_PAGE) += page_prezero.o
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9237976abe72..b17472caf605 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2407,7 +2407,8 @@ static void __split_huge_page_tail(struct page *head, int tail,
 #ifdef CONFIG_64BIT
 			 (1L << PG_arch_2) |
 #endif
-			 (1L << PG_dirty)));
+			 (1L << PG_dirty) |
+			 __PG_ZERO));
 
 	/* ->mapping in first tail page is compound_mapcount */
 	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3beeb8d722f3..217d61092592 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -79,6 +79,7 @@
 #include "internal.h"
 #include "shuffle.h"
 #include "page_reporting.h"
+#include "page_prezero.h"
 
 /* Free Page Internal flags: for internal, non-pcp variants of free_pages(). */
 typedef int __bitwise fpi_t;
@@ -1217,6 +1218,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
 	trace_mm_page_free(page, order);
+	clear_zero_page_flag(page, order);
 
 	if (unlikely(PageHWPoison(page)) && !order) {
 		/*
@@ -1302,6 +1304,7 @@ static bool free_pcp_prepare(struct page *page)
 
 static bool bulkfree_pcp_prepare(struct page *page)
 {
+	clear_zero_page_flag(page, 0);
 	if (debug_pagealloc_enabled_static())
 		return check_free_page(page);
 	else
@@ -1324,6 +1327,7 @@ static bool free_pcp_prepare(struct page *page)
 
 static bool bulkfree_pcp_prepare(struct page *page)
 {
+	clear_zero_page_flag(page, 0);
 	return check_free_page(page);
 }
 #endif /* CONFIG_DEBUG_VM */
diff --git a/mm/page_prezero.c b/mm/page_prezero.c
new file mode 100644
index 000000000000..c8ce720bfc54
--- /dev/null
+++ b/mm/page_prezero.c
@@ -0,0 +1,266 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ *  Copyright (C) 2020  Didi chuxing.
+ *
+ *  Authors: Liang Li <liliang324@gmail.com>
+ *
+ *  This work is licensed under the terms of the GNU GPL, version 2. See
+ *  the COPYING file in the top-level directory.
+ */
+
+#include <linux/mm.h>
+#include <linux/highmem.h>
+#include <linux/rmap.h>
+#include <linux/mm_inline.h>
+#include <linux/page_reporting.h>
+#include "internal.h"
+#include "page_prezero.h"
+
+#define ZERO_PAGE_STOP	0
+#define ZERO_PAGE_RUN	1
+
+static int mini_page_order = 0;
+static unsigned long batch_size = 64 * 1024 * 1024;
+static unsigned long delay_millisecs = 1000;
+static unsigned long zeropage_enable __read_mostly;
+static DEFINE_MUTEX(kzeropaged_mutex);
+static struct page_reporting_dev_info zero_page_dev_info;
+
+inline void clear_zero_page_flag(struct page *page, int order)
+{
+	int i;
+
+	for (i = 0; i < (1 << order); i++)
+		ClearPageZero(page + i);
+}
+
+static int zero_free_pages(struct page_reporting_dev_info *pr_dev_info,
+			   struct scatterlist *sgl, unsigned int nents)
+{
+	struct scatterlist *sg = sgl;
+
+	might_sleep();
+	do {
+		struct page *page = sg_page(sg);
+		unsigned int order = get_order(sg->length);
+		int i;
+
+		VM_BUG_ON(PageBuddy(page) || buddy_order(page));
+
+		pr_info("%s order=%d\n", __func__, order);
+		for (i = 0; i < (1 << order); i++) {
+			cond_resched();
+			__clear_highpage(page + i);
+		}
+	} while ((sg = sg_next(sg)));
+
+	return 0;
+}
+
+static int start_kzeropaged(void)
+{
+	int err = 0;
+
+	if (zeropage_enable) {
+		zero_page_dev_info.report = zero_free_pages;
+		zero_page_dev_info.mini_order = mini_page_order;
+		zero_page_dev_info.batch_size = batch_size;
+		zero_page_dev_info.delay_jiffies = msecs_to_jiffies(delay_millisecs);
+
+		err = page_reporting_register(&zero_page_dev_info);
+		pr_info("Zero page enabled\n");
+	} else {
+		page_reporting_unregister(&zero_page_dev_info);
+		pr_info("Zero page disabled\n");
+	}
+
+	return err;
+}
+
+static int restart_kzeropaged(void)
+{
+	int err = 0;
+
+	if (zeropage_enable) {
+		page_reporting_unregister(&zero_page_dev_info);
+
+		zero_page_dev_info.report = zero_free_pages;
+		zero_page_dev_info.mini_order = mini_page_order;
+		zero_page_dev_info.batch_size = batch_size;
+		zero_page_dev_info.delay_jiffies = msecs_to_jiffies(delay_millisecs);
+
+		err = page_reporting_register(&zero_page_dev_info);
+		pr_info("Zero page enabled\n");
+	}
+
+	return err;
+}
+
+static ssize_t enabled_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", zeropage_enable);
+}
+
+static ssize_t enabled_store(struct kobject *kobj,
+			     struct kobj_attribute *attr,
+			     const char *buf, size_t count)
+{
+	ssize_t ret = 0;
+	unsigned long flags;
+	int err;
+
+	err = kstrtoul(buf, 10, &flags);
+	if (err || flags > UINT_MAX)
+		return -EINVAL;
+	if (flags > ZERO_PAGE_RUN)
+		return -EINVAL;
+
+	if (zeropage_enable != flags) {
+		mutex_lock(&kzeropaged_mutex);
+		zeropage_enable = flags;
+		ret = start_kzeropaged();
+		mutex_unlock(&kzeropaged_mutex);
+	}
+
+	return count;
+}
+
+static struct kobj_attribute enabled_attr =
+	__ATTR(enabled, 0644, enabled_show, enabled_store);
+
+
+static ssize_t batch_size_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", batch_size);
+}
+
+static ssize_t batch_size_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	unsigned long size;
+	int err;
+
+	err = kstrtoul(buf, 10, &size);
+	if (err || size >= UINT_MAX)
+		return -EINVAL;
+
+	batch_size = size;
+
+	restart_kzeropaged();
+	return count;
+}
+
+static struct kobj_attribute batch_size_attr =
+	__ATTR(batch_size, 0644, batch_size_show, batch_size_store);
+
+static ssize_t delay_millisecs_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", delay_millisecs);
+}
+
+static ssize_t delay_millisecs_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	unsigned long msecs;
+	int err;
+
+	err = kstrtoul(buf, 10, &msecs);
+	if (err || msecs >= UINT_MAX)
+		return -EINVAL;
+
+	delay_millisecs = msecs;
+
+	restart_kzeropaged();
+
+	return count;
+}
+
+static struct kobj_attribute wake_delay_millisecs_attr =
+	__ATTR(delay_millisecs, 0644, delay_millisecs_show,
+		delay_millisecs_store);
+
+static ssize_t mini_order_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", mini_page_order);
+}
+
+static ssize_t mini_order_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	unsigned int order;
+	int err;
+
+	err = kstrtouint(buf, 10, &order);
+	if (err || order >= MAX_ORDER)
+		return -EINVAL;
+
+	if (mini_page_order != order) {
+		mutex_lock(&kzeropaged_mutex);
+		mini_page_order = order;
+		mutex_unlock(&kzeropaged_mutex);
+	}
+
+	restart_kzeropaged();
+	return count;
+}
+
+static struct kobj_attribute mini_order_attr =
+	__ATTR(mini_order, 0644, mini_order_show, mini_order_store);
+
+static struct attribute *zeropage_attr[] = {
+	&enabled_attr.attr,
+	&mini_order_attr.attr,
+	&wake_delay_millisecs_attr.attr,
+	&batch_size_attr.attr,
+	NULL,
+};
+
+static struct attribute_group zeropage_attr_group = {
+	.attrs = zeropage_attr,
+};
+
+static int __init zeropage_init_sysfs(struct kobject **zeropage_kobj)
+{
+	int err;
+
+	*zeropage_kobj = kobject_create_and_add("zero_page", mm_kobj);
+	if (unlikely(!*zeropage_kobj)) {
+		pr_err("zeropage: failed to create zeropage kobject\n");
+		return -ENOMEM;
+	}
+
+	err = sysfs_create_group(*zeropage_kobj, &zeropage_attr_group);
+	if (err) {
+		pr_err("zeropage: failed to register zeropage group\n");
+		goto delete_obj;
+	}
+
+	return 0;
+
+delete_obj:
+	kobject_put(*zeropage_kobj);
+	return err;
+}
+
+static int __init zeropage_init(void)
+{
+	int err;
+	struct kobject *zeropage_kobj;
+
+	err = zeropage_init_sysfs(&zeropage_kobj);
+	if (err)
+		return err;
+
+	start_kzeropaged();
+
+	return 0;
+}
+subsys_initcall(zeropage_init);
diff --git a/mm/page_prezero.h b/mm/page_prezero.h
new file mode 100644
index 000000000000..292df4b91585
--- /dev/null
+++ b/mm/page_prezero.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PREZERO_PAGE_H
+#define _LINUX_PREZERO_PAGE_H
+
+#ifdef CONFIG_PREZERO_PAGE
+extern inline void clear_zero_page_flag(struct page *page, int order);
+#else
+inline void clear_zero_page_flag(struct page *page, int order)
+{
+}
+#endif
+#endif /*_LINUX_PREZERO_NG_H */
+
-- 
2.18.2


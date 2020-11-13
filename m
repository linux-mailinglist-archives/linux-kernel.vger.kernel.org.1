Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E35F2B1984
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgKMLDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgKMLCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:02:19 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D67C061A4E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:01:40 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 62so6791180pgg.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tZWBkad1aByik7EPGEdLiaHkKOVuBPryX6lktgLSNfc=;
        b=Sn8J3NHLWKRmNkgu+5kZJsZ6eEiDa5bBIamYqx2NEg/W+sVELMtYnAZdShaC7CRojq
         4Ggn04dhe0mbnOnTEWVOnkWLQI/k8GMQfAUMn0aQL1dEdQ2XD1Yo719jRyFykLauvt/k
         dPx5D1M1qb8ksnmWbVr5si5dwirvEjztDidJCVJQreHxwafHLEjSR9iH8/Amvc3n/UrX
         N+IziT7TTAX2XZJgUAL/W5cskTQKSl8DiEmUSdnRm3te5Jaoa32nyNy6pGe6f9AcUptS
         Dolo3jceYF7i7RJ1mQWjmn6+aEqWcYd/hweF38Ot6vACeYyTtSZNSLqb+deMx6sYAn6r
         amsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tZWBkad1aByik7EPGEdLiaHkKOVuBPryX6lktgLSNfc=;
        b=U983vpjdDY5rgTgX+1qUSSELeEWy4Roy8ldNUKdrt/SKfRzGrAniBve0NRRfHxkIGE
         nUJISMX41JzSulWAURdLsUS06khsFijVVdxPHYxTHWLY2VC/cNjE+u8zl30Ne5NxPj7H
         pBakajlQPwRltXr1DXb0z8DXV0pLnzU8MXol2yEeKg8E2rYOwpkU0i7Z5pchc/+1OrEi
         lSKnR7OJr9QRTov2PJcCQxKWUbsGzkgd+3GEKdkFX8NYKJvH+EB6Z4fdehTPS5Er4Pkp
         P7nGRP7PadqRE/ieBlRrzRwobZiY04G9Tbu+/o25/7woSGEL/skK/jYrWWarBt9kbZNA
         RE4A==
X-Gm-Message-State: AOAM531QX6LyFvY2BDl0knLyAj3AH81ojnAQDH7TDS3Tuf4v0Kx3W0+z
        5+zinvAICmX1+EOpvGO/nyCi2hmG8LsNEPaO3n8=
X-Google-Smtp-Source: ABdhPJxzdkaQ72DWuqPJHJj9pNTlv7mpkg7nsUPfbN7ITv8pKowvZoLXseNg38sfh+U7wDMt+l9VMg==
X-Received: by 2002:a17:90b:154:: with SMTP id em20mr2356952pjb.114.1605265299802;
        Fri, 13 Nov 2020 03:01:39 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.01.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:01:39 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 04/21] mm/hugetlb: Introduce nr_free_vmemmap_pages in the struct hstate
Date:   Fri, 13 Nov 2020 18:59:35 +0800
Message-Id: <20201113105952.11638-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the size of HugeTLB page is 2MB, we need 512 struct page structures
(8 pages) to be associated with it. As far as I know, we only use the
first 4 struct page structures. Use of first 4 struct page structures
comes from HUGETLB_CGROUP_MIN_ORDER.

For tail pages, the value of compound_head is the same. So we can reuse
first page of tail page structs. We map the virtual addresses of the
remaining 6 pages of tail page structs to the first tail page struct,
and then free these 6 pages. Therefore, we need to reserve at least 2
pages as vmemmap areas.

So we introduce a new nr_free_vmemmap_pages field in the hstate to
indicate how many vmemmap pages associated with a HugeTLB page that we
can free to buddy system.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |   3 ++
 mm/Makefile             |   1 +
 mm/hugetlb.c            |   3 ++
 mm/hugetlb_vmemmap.c    | 108 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h    |  20 +++++++++
 5 files changed, 135 insertions(+)
 create mode 100644 mm/hugetlb_vmemmap.c
 create mode 100644 mm/hugetlb_vmemmap.h

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d5cc5f802dd4..eed3dd3bd626 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -492,6 +492,9 @@ struct hstate {
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	unsigned int nr_free_vmemmap_pages;
+#endif
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
 	struct cftype cgroup_files_dfl[7];
diff --git a/mm/Makefile b/mm/Makefile
index 752111587c99..2a734576bbc0 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_FRONTSWAP)	+= frontswap.o
 obj-$(CONFIG_ZSWAP)	+= zswap.o
 obj-$(CONFIG_HAS_DMA)	+= dmapool.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
+obj-$(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)	+= hugetlb_vmemmap.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 81a41aa080a5..f88032c24667 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -42,6 +42,7 @@
 #include <linux/userfaultfd_k.h>
 #include <linux/page_owner.h>
 #include "internal.h"
+#include "hugetlb_vmemmap.h"
 
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
@@ -3285,6 +3286,8 @@ void __init hugetlb_add_hstate(unsigned int order)
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
 
+	hugetlb_vmemmap_init(h);
+
 	parsed_hstate = h;
 }
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
new file mode 100644
index 000000000000..a6c9948302e2
--- /dev/null
+++ b/mm/hugetlb_vmemmap.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Free some vmemmap pages of HugeTLB
+ *
+ * Copyright (c) 2020, Bytedance. All rights reserved.
+ *
+ *     Author: Muchun Song <songmuchun@bytedance.com>
+ *
+ * Nowadays we track the status of physical page frames using struct page
+ * structures arranged in one or more arrays. And here exists one-to-one
+ * mapping between the physical page frame and the corresponding struct page
+ * structure.
+ *
+ * The HugeTLB support is built on top of multiple page size support that
+ * is provided by most modern architectures. For example, x86 CPUs normally
+ * support 4K and 2M (1G if architecturally supported) page sizes. Every
+ * HugeTLB has more than one struct page structure. The 2M HugeTLB has 512
+ * struct page structure and 1G HugeTLB has 4096 struct page structures. But
+ * in the core of HugeTLB only uses the first 4 (Use of first 4 struct page
+ * structures comes from HUGETLB_CGROUP_MIN_ORDER.) struct page structures to
+ * store metadata associated with each HugeTLB. The rest of the struct page
+ * structures are usually read the compound_head field which are all the same
+ * value. If we can free some struct page memory to buddy system so that we
+ * can save a lot of memory.
+ *
+ * When the system boot up, every 2M HugeTLB has 512 struct page structures
+ * which size is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).
+ *
+ *    HugeTLB                  struct pages(8 pages)         page frame(8 pages)
+ * +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
+ * |           |                     |     0     | -------------> |     0     |
+ * |           |                     |     1     | -------------> |     1     |
+ * |           |                     |     2     | -------------> |     2     |
+ * |           |                     |     3     | -------------> |     3     |
+ * |           |                     |     4     | -------------> |     4     |
+ * |     2M    |                     |     5     | -------------> |     5     |
+ * |           |                     |     6     | -------------> |     6     |
+ * |           |                     |     7     | -------------> |     7     |
+ * |           |                     +-----------+                +-----------+
+ * |           |
+ * |           |
+ * +-----------+
+ *
+ *
+ * When a HugeTLB is preallocated, we can change the mapping from above to
+ * bellow.
+ *
+ *    HugeTLB                  struct pages(8 pages)         page frame(8 pages)
+ * +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
+ * |           |                     |     0     | -------------> |     0     |
+ * |           |                     |     1     | -------------> |     1     |
+ * |           |                     |     2     | -------------> +-----------+
+ * |           |                     |     3     | -----------------^ ^ ^ ^ ^
+ * |           |                     |     4     | -------------------+ | | |
+ * |     2M    |                     |     5     | ---------------------+ | |
+ * |           |                     |     6     | -----------------------+ |
+ * |           |                     |     7     | -------------------------+
+ * |           |                     +-----------+
+ * |           |
+ * |           |
+ * +-----------+
+ *
+ * For tail pages, the value of compound_head is the same. So we can reuse
+ * first page of tail page structures. We map the virtual addresses of the
+ * remaining 6 pages of tail page structures to the first tail page structures,
+ * and then free these 6 page frames. Therefore, we need to reserve at least 2
+ * pages as vmemmap areas.
+ *
+ * When a HugeTLB is freed to the buddy system, we should allocate 6 pages for
+ * vmemmap pages and restore the previous mapping relationship.
+ */
+#define pr_fmt(fmt)	"HugeTLB Vmemmap: " fmt
+
+#include "hugetlb_vmemmap.h"
+
+/*
+ * There are 512 struct page structures(8 pages) associated with each 2MB
+ * hugetlb page. For tail pages, the value of compound_head is the same.
+ * So we can reuse first page of tail page structures. We map the virtual
+ * addresses of the remaining 6 pages of tail page structures to the first
+ * tail page struct, and then free these 6 pages. Therefore, we need to
+ * reserve at least 2 pages as vmemmap areas.
+ */
+#define RESERVE_VMEMMAP_NR		2U
+
+void __init hugetlb_vmemmap_init(struct hstate *h)
+{
+	unsigned int order = huge_page_order(h);
+	unsigned int vmemmap_pages;
+
+	vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
+	/*
+	 * The head page and the first tail page are not to be freed to buddy
+	 * system, the others page will map to the first tail page. So there
+	 * are (@vmemmap_pages - RESERVE_VMEMMAP_NR) pages can be freed.
+	 *
+	 * Could RESERVE_VMEMMAP_NR be greater than @vmemmap_pages? This is
+	 * not expected to happen unless the system is corrupted. So on the
+	 * safe side, it is only a safety net.
+	 */
+	if (likely(vmemmap_pages > RESERVE_VMEMMAP_NR))
+		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
+	else
+		h->nr_free_vmemmap_pages = 0;
+
+	pr_debug("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
+		 h->name);
+}
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
new file mode 100644
index 000000000000..40c0c7dfb60d
--- /dev/null
+++ b/mm/hugetlb_vmemmap.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Free some vmemmap pages of HugeTLB
+ *
+ * Copyright (c) 2020, Bytedance. All rights reserved.
+ *
+ *     Author: Muchun Song <songmuchun@bytedance.com>
+ */
+#ifndef _LINUX_HUGETLB_VMEMMAP_H
+#define _LINUX_HUGETLB_VMEMMAP_H
+#include <linux/hugetlb.h>
+
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+void __init hugetlb_vmemmap_init(struct hstate *h);
+#else
+static inline void hugetlb_vmemmap_init(struct hstate *h)
+{
+}
+#endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
+#endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.11.0


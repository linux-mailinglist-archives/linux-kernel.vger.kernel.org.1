Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588BF2EB8B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 04:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbhAFDwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 22:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAFDwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 22:52:53 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756A8C06134C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 19:52:13 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id lj6so893595pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 19:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=YXvVktv0fPXXQzAccQWu9oQX6wR5ZBzr4yUWR5mZn8E=;
        b=E+TqYkQ+vvGm52XKLcj7pzx/AoMoyjmhZionMWvB+iD2nGhN5HS2IXBsK0zsx48zld
         zXcZh0S3wExZQCQ90cZ1G7D/fmDZM3qxk72XPMvMbLoqjpR80jhTBVBuSVpTf2JXoAvm
         TBHyq0uqWJXFIW0qW/ZB9O6FUdO8i3Yj/9EPbaZWrGcZ/SzgCau2KsffScsl9EH/pv3Z
         O6sIpIGdP3opqIhvC8N6Bpxecb4GRYil97DjiX6lGs8SzC5kWmiCW7gf4PIlSmS/gVpk
         JNxtNxehprc5qZftfDr7Ru35WC6Zgp3MygwCulVKZZDxupbc7wvSmNmEbHFsXteaydHl
         sGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=YXvVktv0fPXXQzAccQWu9oQX6wR5ZBzr4yUWR5mZn8E=;
        b=Ti1bUwwnyQHenEzA/IYr0X25yt0ufbrBRTjmcBbdVzWMkYFb+5wWuJih5Tp9MiFvXL
         biyq3XGu+gMBOGQiUci+Ea9csk57qIOaxRwugNq8c3QGv5VxfU/nKPEkLRoOXpoKUHJu
         SEvY0uGn+ROil9gpDJX2nVBBcEuRFE3asAnlXrLGdbDJPXi2nSmFtNnQGURhkGZUtSiv
         jTYLljynDx9q9HmoEXItb0QjxSAjKVM3xxn7AxXKCx3DBYt4UhERrkm5cnk6p835Jb2R
         nUxgxEZp+Y7LygW0nFkoue5/fU0GreUpVyqrYq2vYA5JGjjUGjoWWPDuF/okYbpIOFb3
         BMmg==
X-Gm-Message-State: AOAM530tFFI+uCGRFeZNyxp5czl3iUh7dGw5LeBHi1SuhOXEdSmhW/RZ
        qTt5Rw/3p5+mGG5206nkw34=
X-Google-Smtp-Source: ABdhPJzv1+2srOGnaXnQG0stKz8wkd2+RJLuqGpq6an9LW/JaeXEr9uy1iQyEuOrnTNbFnyUiaJXbw==
X-Received: by 2002:a17:902:a60c:b029:da:e036:5dbe with SMTP id u12-20020a170902a60cb02900dae0365dbemr2616785plq.43.1609905133063;
        Tue, 05 Jan 2021 19:52:13 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id b11sm724605pfr.38.2021.01.05.19.52.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 19:52:12 -0800 (PST)
From:   Liang Li <liliang324@gmail.com>
X-Google-Original-From: Liang Li <liliangleo@didiglobal.com>
Date:   Tue, 5 Jan 2021 22:52:09 -0500
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
        Liang Li <liliangleo@didiglobal.com>,
        Liang Li <liliang324@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 6/6] hugetlb: support free hugepage pre zero out
Message-ID: <20210106035206.GA1183@open-light-1.localdomain>
Mail-Followup-To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support of pre zero out free hugepage, we can use
this feature to speed up page population and page fault handing.

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
Cc: Jason Wang <jasowang@redhat.com>
Cc: Liang Li <liliang324@gmail.com>
Signed-off-by: Liang Li <liliangleo@didiglobal.com>
---
 include/linux/page-flags.h |  12 ++
 mm/Kconfig                 |  10 ++
 mm/huge_memory.c           |   3 +-
 mm/hugetlb.c               | 243 +++++++++++++++++++++++++++++++++++++
 mm/memory.c                |   4 +
 5 files changed, 271 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index ec5d0290e0ee..f177c5e85632 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -173,6 +173,9 @@ enum pageflags {
 
 	/* Only valid for buddy pages. Used to track pages that are reported */
 	PG_reported = PG_uptodate,
+
+	/* Only valid for hugetlb pages. Used to mark zero pages */
+	PG_zero = PG_slab,
 };
 
 #ifndef __GENERATING_BOUNDS_H
@@ -451,6 +454,15 @@ PAGEFLAG(Idle, idle, PF_ANY)
  */
 __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
 
+/*
+ * PageZero() is used to track hugetlb free pages within the free list
+ * of hugetlbfs. We can use the non-atomic version of the test and set
+ * operations as both should be shielded with the hugetlb lock to prevent
+ * any possible races on the setting or clearing of the bit.
+ */
+__PAGEFLAG(Zero, zero, PF_ONLY_HEAD)
+
+
 /*
  * On an anonymous page mapped into a user virtual memory area,
  * page->mapping points to its anon_vma, not to a struct address_space;
diff --git a/mm/Kconfig b/mm/Kconfig
index 630cde982186..1d91e182825d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -254,6 +254,16 @@ config PAGE_REPORTING
 	  those pages to another entity, such as a hypervisor, so that the
 	  memory can be freed within the host for other uses.
 
+#
+# support for pre zero out hugetlbfs free page
+config PREZERO_HPAGE
+	bool "Pre zero out hugetlbfs free page"
+	def_bool n
+	depends on PAGE_REPORTING
+	help
+	  Allows pre zero out hugetlbfs free pages in freelist based on free
+	  page reporting
+
 #
 # support for page migration
 #
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9237976abe72..4ff99724d669 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2407,7 +2407,8 @@ static void __split_huge_page_tail(struct page *head, int tail,
 #ifdef CONFIG_64BIT
 			 (1L << PG_arch_2) |
 #endif
-			 (1L << PG_dirty)));
+			 (1L << PG_dirty) |
+			 (1L << PG_zero)));
 
 	/* ->mapping in first tail page is compound_mapcount */
 	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0fccd5f96954..2029668a0864 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1029,6 +1029,7 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 	list_move(&page->lru, &h->hugepage_freelists[nid]);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
+	__ClearPageZero(page);
 	if (hugepage_reported(page))
 		__ClearPageReported(page);
 	hugepage_reporting_notify_free(h->order);
@@ -1315,6 +1316,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
 	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	set_page_refcounted(page);
+	__ClearPageZero(page);
 	if (hstate_is_gigantic(h)) {
 		/*
 		 * Temporarily drop the hugetlb_lock, because
@@ -2963,6 +2965,237 @@ static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
 	return retval;
 }
 
+#ifdef CONFIG_PREZERO_HPAGE
+
+#define PRE_ZERO_STOP	0
+#define PRE_ZERO_RUN	1
+
+static int mini_page_order;
+static unsigned long batch_size = 16 * 1024 * 1024;
+static unsigned long delay_millisecs = 1000;
+static unsigned long prezero_enable __read_mostly;
+static DEFINE_MUTEX(kprezerod_mutex);
+static struct page_reporting_dev_info pre_zero_hpage_dev_info;
+
+static int zero_out_pages(struct page_reporting_dev_info *pr_dev_info,
+			   struct scatterlist *sgl, unsigned int nents)
+{
+	struct scatterlist *sg = sgl;
+
+	might_sleep();
+	do {
+		struct page *page = sg_page(sg);
+		unsigned int i, order = get_order(sg->length);
+
+		VM_BUG_ON(PageBuddy(page) || buddy_order(page));
+
+		if (PageZero(page))
+			continue;
+		for (i = 0; i < (1 << order); i++) {
+			cond_resched();
+			clear_highpage(page + i);
+		}
+		__SetPageZero(page);
+	} while ((sg = sg_next(sg)));
+
+	return 0;
+}
+
+static int start_kprezerod(void)
+{
+	int err = 0;
+
+	if (prezero_enable == PRE_ZERO_RUN) {
+		pre_zero_hpage_dev_info.report = zero_out_pages;
+		pre_zero_hpage_dev_info.mini_order = mini_page_order;
+		pre_zero_hpage_dev_info.batch_size = batch_size;
+		pre_zero_hpage_dev_info.delay_jiffies = msecs_to_jiffies(delay_millisecs);
+
+		err = hugepage_reporting_register(&pre_zero_hpage_dev_info);
+		pr_info("Pre zero hugepage enabled\n");
+	} else {
+		hugepage_reporting_unregister(&pre_zero_hpage_dev_info);
+		pr_info("Pre zero hugepage disabled\n");
+	}
+
+	return err;
+}
+
+static int restart_kprezerod(void)
+{
+	int err = 0;
+
+	mutex_lock(&kprezerod_mutex);
+	if (prezero_enable == PRE_ZERO_RUN) {
+		hugepage_reporting_unregister(&pre_zero_hpage_dev_info);
+
+		pre_zero_hpage_dev_info.report = zero_out_pages;
+		pre_zero_hpage_dev_info.mini_order = mini_page_order;
+		pre_zero_hpage_dev_info.batch_size = batch_size;
+		pre_zero_hpage_dev_info.delay_jiffies = msecs_to_jiffies(delay_millisecs);
+
+		err = hugepage_reporting_register(&pre_zero_hpage_dev_info);
+	}
+	mutex_unlock(&kprezerod_mutex);
+
+	return err;
+}
+
+static ssize_t enabled_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", prezero_enable);
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
+	if (flags > PRE_ZERO_RUN)
+		return -EINVAL;
+
+	mutex_lock(&kprezerod_mutex);
+	if (prezero_enable != flags) {
+		prezero_enable = flags;
+		ret = start_kprezerod();
+	}
+	mutex_unlock(&kprezerod_mutex);
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
+	restart_kprezerod();
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
+	restart_kprezerod();
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
+		mutex_lock(&kprezerod_mutex);
+		mini_page_order = order;
+		mutex_unlock(&kprezerod_mutex);
+	}
+
+	restart_kprezerod();
+	return count;
+}
+
+static struct kobj_attribute mini_order_attr =
+	__ATTR(mini_order, 0644, mini_order_show, mini_order_store);
+
+static struct attribute *pre_zero_attr[] = {
+	&enabled_attr.attr,
+	&mini_order_attr.attr,
+	&wake_delay_millisecs_attr.attr,
+	&batch_size_attr.attr,
+	NULL,
+};
+
+static struct attribute_group pre_zero_attr_group = {
+	.attrs = pre_zero_attr,
+};
+
+static int __init zeropage_init_sysfs(struct kobject *parent_kobj)
+{
+	int err;
+	struct kobject *pre_zero_kobj;
+
+	pre_zero_kobj = kobject_create_and_add("pre_zero", parent_kobj);
+	if (unlikely(!pre_zero_kobj)) {
+		pr_err("pre_zero: failed to create pre_zero kobject\n");
+		return -ENOMEM;
+	}
+
+	err = sysfs_create_group(pre_zero_kobj, &pre_zero_attr_group);
+	if (err) {
+		pr_err("pre_zero: failed to register pre_zero group\n");
+		goto delete_obj;
+	}
+
+	return 0;
+
+delete_obj:
+	kobject_put(pre_zero_kobj);
+	return err;
+}
+#endif
+
 static void __init hugetlb_sysfs_init(void)
 {
 	struct hstate *h;
@@ -2978,6 +3211,16 @@ static void __init hugetlb_sysfs_init(void)
 		if (err)
 			pr_err("HugeTLB: Unable to add hstate %s", h->name);
 	}
+
+	if (err)
+		return;
+#ifdef CONFIG_PREZERO_HPAGE
+	err = zeropage_init_sysfs(hugepages_kobj);
+	if (err)
+		return;
+
+	start_kprezerod();
+#endif
 }
 
 #ifdef CONFIG_NUMA
diff --git a/mm/memory.c b/mm/memory.c
index 7d608765932b..e98eed1a59a5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5100,6 +5100,10 @@ void clear_huge_page(struct page *page,
 	unsigned long addr = addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
 
+	if (PageZero(page)) {
+		__ClearPageZero(page);
+		return;
+	}
 	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
 		clear_gigantic_page(page, addr, pages_per_huge_page);
 		return;
-- 
2.18.2


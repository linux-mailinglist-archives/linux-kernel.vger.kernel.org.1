Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9C127B8A3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgI2AHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:07:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49024 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgI2AHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:07:31 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id C006720B7178;
        Mon, 28 Sep 2020 17:07:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C006720B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601338050;
        bh=nXHG8mIv43mdzRi0Z8TktkyURZnP1ZRLvJrqqBYf4uc=;
        h=From:To:Cc:Subject:Date:From;
        b=jNSUzwcS+TvHXHg5GsyhAMI6yaAB7XGESL5ni/XQ8vJabiZLc/qxdMe8NtrlvYhcH
         vnvfGaMh7KtViJFItmL8ssSHuxux58hfeEc2VWyyfozUVQNXj0t48qCmhXFeEQlf5w
         DEWBnI7Gj16zXkZDgeJkOK+Sdva8GorZwvABeR/A=
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
        Allen Pais <apais@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [v4] mm: khugepaged: recalculate min_free_kbytes after memory hotplug as expected by khugepaged
Date:   Mon, 28 Sep 2020 17:07:27 -0700
Message-Id: <1601338047-18558-1-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When memory is hotplug added or removed the min_free_kbytes must be
recalculated based on what is expected by khugepaged.  Currently
after hotplug, min_free_kbytes will be set to a lower default and higher
default set when THP enabled is lost.  This change restores min_free_kbytes
as expected for THP consumers.

Fixes: f000565adb77 ("thp: set recommended min free kbytes")

Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: stable@vger.kernel.org
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
v3 -> v4
- made changes to move khugepaged_min_free_kbytes_update into
  init_per_zone_wmark_min and rested changes
  [suggestion from Michal Hocko]

[v2 1/2]
- removed symptoms references from changelog

[v2 2/2]
- addressed following issues Michal Hocko raised:
  . nr_free_buffer_pages can oveflow in int on very large machines
  . min_free_kbytes can decrease the size theoretically

v1 -> v2
--------
- addressed issue Kirill A. Shutemov raised:
  . changes would override min_free_kbytes set by user

 include/linux/khugepaged.h |  5 +++++
 mm/khugepaged.c            | 13 +++++++++++--
 mm/page_alloc.c            |  3 +++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index bc45ea1efbf7..c941b7377321 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -15,6 +15,7 @@ extern int __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
 extern int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 				      unsigned long vm_flags);
+extern void khugepaged_min_free_kbytes_update(void);
 #ifdef CONFIG_SHMEM
 extern void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr);
 #else
@@ -85,6 +86,10 @@ static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
 					   unsigned long addr)
 {
 }
+
+static inline void khugepaged_min_free_kbytes_update(void)
+{
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #endif /* _LINUX_KHUGEPAGED_H */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cfa0dba5fd3b..4f7107476a6f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -56,6 +56,9 @@ enum scan_result {
 #define CREATE_TRACE_POINTS
 #include <trace/events/huge_memory.h>
 
+static struct task_struct *khugepaged_thread __read_mostly;
+static DEFINE_MUTEX(khugepaged_mutex);
+
 /* default scan 8*512 pte (or vmas) every 30 second */
 static unsigned int khugepaged_pages_to_scan __read_mostly;
 static unsigned int khugepaged_pages_collapsed;
@@ -2292,8 +2295,6 @@ static void set_recommended_min_free_kbytes(void)
 
 int start_stop_khugepaged(void)
 {
-	static struct task_struct *khugepaged_thread __read_mostly;
-	static DEFINE_MUTEX(khugepaged_mutex);
 	int err = 0;
 
 	mutex_lock(&khugepaged_mutex);
@@ -2320,3 +2321,11 @@ int start_stop_khugepaged(void)
 	mutex_unlock(&khugepaged_mutex);
 	return err;
 }
+
+void khugepaged_min_free_kbytes_update(void)
+{
+	mutex_lock(&khugepaged_mutex);
+	if (khugepaged_enabled() && khugepaged_thread)
+		set_recommended_min_free_kbytes();
+	mutex_unlock(&khugepaged_mutex);
+}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..ac25d3526fa5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -69,6 +69,7 @@
 #include <linux/nmi.h>
 #include <linux/psi.h>
 #include <linux/padata.h>
+#include <linux/khugepaged.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -7891,6 +7892,8 @@ int __meminit init_per_zone_wmark_min(void)
 	setup_min_slab_ratio();
 #endif
 
+	khugepaged_min_free_kbytes_update();
+
 	return 0;
 }
 postcore_initcall(init_per_zone_wmark_min)
-- 
2.28.0


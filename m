Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7476226AF3F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgIOVNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:13:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48196 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgIOVLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:11:03 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6610F20A086F;
        Tue, 15 Sep 2020 14:11:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6610F20A086F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600204262;
        bh=sJzvJlZ4zynojZ8SIUI8kYZt2Sx+G2WLlV/IWfd5Xjo=;
        h=From:To:Cc:Subject:Date:From;
        b=FllY9g59gu7UmUh/lHgF9hjtPajJ+hkSfpY5IlTQgy4TipVYaREbyg23h5RlD55HB
         0erN8Xqh9fiwncBxst+RMhACTO2LwIOYSPdPDKQFh1MBLYpSEfFOqvySTAYDL6jh4O
         YcIfdhIwi23ct8JH2gpUhML8szMXxvwV15O7+ah8=
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
Subject: [v2 1/2] mm: khugepaged: recalculate min_free_kbytes after memory hotplug as expected by khugepaged
Date:   Tue, 15 Sep 2020 14:10:57 -0700
Message-Id: <1600204258-13683-1-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When memory is hotplug added or removed the min_free_kbytes must be
recalculated based on what is expected by khugepaged.  Currently
after hotplug, min_free_kbytes will be set to a lower default and higher
default set when THP enabled is lost. This leaves the system with small
min_free_kbytes which isn't suitable for systems especially with network
intensive loads.  Typical failure symptoms include HW WATCHDOG reset,
soft lockup hang notices, NETDEVICE WATCHDOG timeouts, and OOM process
kills.

Fixes: f000565adb77 ("thp: set recommended min free kbytes")

Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: stable@vger.kernel.org
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/khugepaged.h |  5 +++++
 mm/khugepaged.c            | 13 +++++++++++--
 mm/memory_hotplug.c        |  3 +++
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
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e9d5ab5d3ca0..3e19272c1fad 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -36,6 +36,7 @@
 #include <linux/memblock.h>
 #include <linux/compaction.h>
 #include <linux/rmap.h>
+#include <linux/khugepaged.h>
 
 #include <asm/tlbflush.h>
 
@@ -857,6 +858,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	zone_pcp_update(zone);
 
 	init_per_zone_wmark_min();
+	khugepaged_min_free_kbytes_update();
 
 	kswapd_run(nid);
 	kcompactd_run(nid);
@@ -1600,6 +1602,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 
 	init_per_zone_wmark_min();
+	khugepaged_min_free_kbytes_update();
 
 	if (!populated_zone(zone)) {
 		zone_pcp_reset(zone);
-- 
2.28.0


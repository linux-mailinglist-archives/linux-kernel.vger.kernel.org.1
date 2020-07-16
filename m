Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3574B22229B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 14:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgGPMj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 08:39:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:35910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728768AbgGPMib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:38:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 498B5B975;
        Thu, 16 Jul 2020 12:38:34 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, linux-mm@kvack.org, mike.kravetz@oracle.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Oscar Salvador <osalvador@suse.com>
Subject: [PATCH v4 04/15] mm,madvise: Refactor madvise_inject_error
Date:   Thu, 16 Jul 2020 14:37:58 +0200
Message-Id: <20200716123810.25292-5-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200716123810.25292-1-osalvador@suse.de>
References: <20200716123810.25292-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a proper if-else condition for {hard,soft}-offline.

Signed-off-by: Oscar Salvador <osalvador@suse.com>
Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 mm/madvise.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 1fe89a5b8d33..dd2173d8f4e5 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -886,7 +886,6 @@ static long madvise_remove(struct vm_area_struct *vma,
 static int madvise_inject_error(int behavior,
 		unsigned long start, unsigned long end)
 {
-	struct page *page;
 	struct zone *zone;
 	unsigned long size;
 
@@ -896,6 +895,7 @@ static int madvise_inject_error(int behavior,
 
 	for (; start < end; start += size) {
 		unsigned long pfn;
+		struct page *page;
 		int ret;
 
 		ret = get_user_pages_fast(start, 1, 0, &page);
@@ -925,17 +925,15 @@ static int madvise_inject_error(int behavior,
 
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
-					pfn, start);
+				 pfn, start);
 
 			ret = soft_offline_page(pfn, 0);
-			if (ret)
-				return ret;
-			continue;
+		} else {
+			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
+				 pfn, start);
+			ret = memory_failure(pfn, 0);
 		}
 
-		pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
-				pfn, start);
-		ret = memory_failure(pfn, 0);
 		if (ret)
 			return ret;
 	}
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7A12EB8AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 04:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbhAFDvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 22:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAFDvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 22:51:15 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B21C06134C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 19:50:34 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id e2so1319497pgi.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 19:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=vjozGeH0DLUu5oDcu6sd/j2j59t7TfqorAS7kIj0og4=;
        b=cB8IknFCHfwQTUc4eD+XI8HFf02mJt83IhhReI+NBrD7IjqJmV0OLeqrMy/t4c+RHC
         U6CgIhtQmjlxEaQSkgbunWFDNBIRUrryYr49JMAem5NfsQDJ3yPvJwYlGhuDaPt6oukB
         NrZCRdkvUQ1iKBusU9sLG8dmYD1wGWgz1jCjsyR2ymzoESR2vugOLhAZxfLTCFzYxNmH
         9siNnxcynZ8tyh1GiH2aFj37kccCVuvaprUTCDj4EDzTzsRI2EJ4EcUvbQd4FdKWDov8
         DOB9u4Pt9gk//014cc2L5tvlwvtozrWAD4WfkF8veQOCfe5y3F9drcsGN1p26CmOeCbd
         eSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=vjozGeH0DLUu5oDcu6sd/j2j59t7TfqorAS7kIj0og4=;
        b=GyRFL0oHkTeZGrIsme2jvqncAIlN7tptABjkPDqVEzPbL9waJD5ZKdTWUF+GXPFSsH
         5C/qYWHw6sMB/YijoBVzgbGWzCbrNAx5KguXrprLm+ZXSRWJ8e82XnU/+Z6bexNMiD1p
         29v8rJ3AKpVwzRhdk1C5m4BXzUbKWetOj9y5YNxEfgKD57F5/lE3Mhjec1UMdm1+i/jX
         y+Ig4ZtWq6C9/hQZUTqTCVdJYCSDlFurREYlPdCoXveyncOI7phjArb8R1GhHQZoqb8m
         ZUqFG/vEG7JbBSovaR4RqQt5Xv6HYzejG2aZZ9zxGLHiYo+zFy05nw/yKr56E6JbZf7V
         4kHA==
X-Gm-Message-State: AOAM531VNJlaZilQrmtouBzl1NL78FM8dYd+rm+zlLFmPcmbxDUIMzHc
        Bq8OFvgvKxolqV5bt+HwiCI=
X-Google-Smtp-Source: ABdhPJx3UVAdnbo3q8qAcpUMRqlMo/+9TS95oG+EkORfpLfFTM4NBjJQnPC+fi+osFhdS8KdCq1qdw==
X-Received: by 2002:a63:78ca:: with SMTP id t193mr2351201pgc.391.1609905034313;
        Tue, 05 Jan 2021 19:50:34 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id m15sm735974pfa.72.2021.01.05.19.50.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 19:50:33 -0800 (PST)
From:   Liang Li <liliang324@gmail.com>
X-Google-Original-From: Liang Li <liliangleo@didiglobal.com>
Date:   Tue, 5 Jan 2021 22:50:31 -0500
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
Subject: [PATCH 4/6] hugetlb: avoid allocation failed when page reporting is
 on going
Message-ID: <20210106035027.GA1160@open-light-1.localdomain>
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

Page reporting isolates free pages temporarily when reporting
free pages information. It will reduce the actual free pages
and may cause application failed for no enough available memory.
This patch try to solve this issue, when there is no free page
and page repoting is on going, wait until it is done.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Liang Li <liliang324@gmail.com>
Signed-off-by: Liang Li <liliangleo@didiglobal.com>
---
 include/linux/hugetlb.h | 2 ++
 mm/hugetlb.c            | 9 +++++++++
 mm/page_reporting.c     | 6 +++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d55e6a00b3dc..73b2934ba91c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -490,6 +490,7 @@ struct hstate {
 	unsigned long resv_huge_pages;
 	unsigned long surplus_huge_pages;
 	unsigned long nr_overcommit_huge_pages;
+	unsigned long isolated_huge_pages;
 	struct list_head hugepage_activelist;
 	struct list_head hugepage_freelists[MAX_NUMNODES];
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
@@ -500,6 +501,7 @@ struct hstate {
 	struct cftype cgroup_files_dfl[7];
 	struct cftype cgroup_files_legacy[9];
 #endif
+	struct mutex mtx_prezero;
 	char name[HSTATE_NAME_LEN];
 };
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index eb533995cb49..0fccd5f96954 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2320,6 +2320,12 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		goto out_uncharge_cgroup_reservation;
 
 	spin_lock(&hugetlb_lock);
+	while (h->free_huge_pages <= 1 && h->isolated_huge_pages) {
+		spin_unlock(&hugetlb_lock);
+		mutex_lock(&h->mtx_prezero);
+		mutex_unlock(&h->mtx_prezero);
+		spin_lock(&hugetlb_lock);
+	}
 	/*
 	 * glb_chg is passed to indicate whether or not a page must be taken
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
@@ -3208,6 +3214,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	INIT_LIST_HEAD(&h->hugepage_activelist);
 	h->next_nid_to_alloc = first_memory_node;
 	h->next_nid_to_free = first_memory_node;
+	mutex_init(&h->mtx_prezero);
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
 
@@ -5541,6 +5548,7 @@ void isolate_free_huge_page(struct page *page, struct hstate *h, int nid)
 
 	list_move(&page->lru, &h->hugepage_activelist);
 	set_page_refcounted(page);
+	h->isolated_huge_pages++;
 }
 
 void putback_isolate_huge_page(struct hstate *h, struct page *page)
@@ -5548,6 +5556,7 @@ void putback_isolate_huge_page(struct hstate *h, struct page *page)
 	int nid = page_to_nid(page);
 
 	list_move(&page->lru, &h->hugepage_freelists[nid]);
+	h->isolated_huge_pages--;
 }
 
 bool isolate_huge_page(struct page *page, struct list_head *list)
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index cc31696225bb..99e1e688d7c1 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -272,12 +272,15 @@ hugepage_reporting_process_hstate(struct page_reporting_dev_info *prdev,
 	int ret = 0, nid;
 
 	offset = max_items;
+	mutex_lock(&h->mtx_prezero);
 	for (nid = 0; nid < MAX_NUMNODES; nid++) {
 		ret = hugepage_reporting_cycle(prdev, h, nid, sgl, &offset,
 					       max_items);
 
-		if (ret < 0)
+		if (ret < 0) {
+			mutex_unlock(&h->mtx_prezero);
 			return ret;
+		}
 	}
 
 	/* report the leftover pages before going idle */
@@ -291,6 +294,7 @@ hugepage_reporting_process_hstate(struct page_reporting_dev_info *prdev,
 		hugepage_reporting_drain(prdev, h, sgl, leftover, !ret);
 		spin_unlock(&hugetlb_lock);
 	}
+	mutex_unlock(&h->mtx_prezero);
 
 	return ret;
 }
-- 
2.18.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA452E90BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbhADHEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 02:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbhADHEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 02:04:31 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F146FC061574
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 23:03:50 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id lb18so9456771pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 23:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pO8eETMUuHslv7dgCvzXTlqPBwMMUJJFuNV+syZPPjo=;
        b=XX9nqxXjuf6vW9b2nopnCN21CK6HjbXrGfgHP1xJ+/xyeFEj6p/6SIm7sD0l2Hkaa9
         d5d9f3VtSdHToGhL8wY1d59oxbbvVzB/U75YqxD5wYLzl7UoKjsqqPMbrNsQ74DyjUj3
         sYAVf4KfRCEFTi7p5/epvifmtzeCTE+b90WhcHZ7DrIxm7ML79c9zaQvO9LS7Vj/pQ6t
         /2Z/4d7zZVOvqIM4HmiOTEiV9b4Ae8PajOlEb5wqC80XzkPvs+U/rBLLcbUS+DU68ccH
         fLm+KTglAN+jpQcbpIyDyJPHAvb6aDfPYtdwHn71sUXuM/ji7QNqh/UISDq11a5NcvEx
         DQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pO8eETMUuHslv7dgCvzXTlqPBwMMUJJFuNV+syZPPjo=;
        b=J2iU06suYAYwU/DD6q0OMCCY1S10Q/vePRc4gIxYxDhd7DeTNKUA9JgEKotMcDlK19
         TE0jreVyxsVr4v0sjQdD9uEH+p2mDCibXIpqJPwdq4Q13DT43tVtBXxXj463kW4YgtJ4
         v/v/MPG8vN8mwtFStNlKp/240W1Q7YkvlYma4PvxvBa102yJ7CASlvoPH/be4463dYI+
         BLKAq8oU9VLm1Po5beLuqSEY1UV0MjzI0uOvp3K4ifY4i4BQjLUuzvVN76LRSGzLAgvc
         YJKrlcHP7VWYG2i7FY5zjUu6ZvVIRK1Jqd3xlnOBzTUPRPNnedbbNi4tjg/HEUN3CQlO
         gvDw==
X-Gm-Message-State: AOAM531pH1v9lm2SxvyG9rX0vsiyoWQzxhIqvEINj+3s0BrSaiqU6/pk
        GC4lRN6I4uhMy8ULf9iJA8JeMw==
X-Google-Smtp-Source: ABdhPJwqbxBxS5PJMCHoPtWr4TCCnEdAuUTeeZ5VgymgtCsqQHhK6TjTED8OZyw4Vu33BJFsAmKZfQ==
X-Received: by 2002:a17:90b:23d6:: with SMTP id md22mr28061594pjb.206.1609743830555;
        Sun, 03 Jan 2021 23:03:50 -0800 (PST)
Received: from localhost.localdomain ([240e:b1:e401:3::6])
        by smtp.gmail.com with ESMTPSA id v1sm36306648pga.63.2021.01.03.23.02.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 23:03:49 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     hillf.zj@alibaba-inc.com, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 4/6] mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
Date:   Mon,  4 Jan 2021 14:58:41 +0800
Message-Id: <20210104065843.5658-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210104065843.5658-1-songmuchun@bytedance.com>
References: <20210104065843.5658-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dissolve_free_huge_page() races with __free_huge_page(), we can
do a retry. Because the race window is small.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 72608008f8b4..db00ae375d2a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1763,10 +1763,11 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
  * nothing for in-use hugepages and non-hugepages.
  * This function returns values like below:
  *
- *  -EBUSY: failed to dissolved free hugepages or the hugepage is in-use
- *          (allocated or reserved.)
- *       0: successfully dissolved free hugepages or the page is not a
- *          hugepage (considered as already dissolved)
+ *  -EAGAIN: race with __free_huge_page() and can do a retry
+ *  -EBUSY:  failed to dissolved free hugepages or the hugepage is in-use
+ *           (allocated or reserved.)
+ *       0:  successfully dissolved free hugepages or the page is not a
+ *           hugepage (considered as already dissolved)
  */
 int dissolve_free_huge_page(struct page *page)
 {
@@ -1815,8 +1816,10 @@ int dissolve_free_huge_page(struct page *page)
 		 * We should make sure that the page is already on the free list
 		 * when it is dissolved.
 		 */
-		if (unlikely(!PageHugeFreed(head)))
+		if (unlikely(!PageHugeFreed(head))) {
+			rc = -EAGAIN;
 			goto out;
+		}
 
 		/*
 		 * Move PageHWPoison flag from head page to the raw error page,
@@ -1857,7 +1860,10 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
 		page = pfn_to_page(pfn);
+retry:
 		rc = dissolve_free_huge_page(page);
+		if (rc == -EAGAIN)
+			goto retry;
 		if (rc)
 			break;
 	}
-- 
2.11.0


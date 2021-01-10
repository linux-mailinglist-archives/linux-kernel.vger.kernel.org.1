Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C422F0742
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 13:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbhAJMmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 07:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbhAJMmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 07:42:49 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD59C0617A7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 04:41:43 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x126so9300973pfc.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 04:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9zrsneMtVXeg4b61BTwnRw2mnUrcLzSuxYCbbaoWav8=;
        b=ECYcoVG48fFW0nt6MIsiwAkaHi2G4EDJ1+2KCQwkSOhBIwXu3PyJGG87/xSzWSefKi
         GMu2prQfnPbOkZ7nBodB5rtI7PrCFTSTz91iSsDjCafbMs3bC8p9jygCAXY4MntDNnf+
         w5mjBkib5igUCLB+g9Qbn6YwzpJ/Y3BBS+snBV5Yg2rKIUa+6Y8dSR6qGkKVUN67djYu
         U5nByE8TlftiWoYt4e0/KTKQDllHu8OY1XLX48S87Wt5Y07PqlxC0Xkub4H2Dwph6M3E
         w+3M9JgCl6t+/ClUI4RwKPrtcCU+taxqJgsjAi9e1bwMv328pODcFhXWYltAsR+3G9sB
         +phQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9zrsneMtVXeg4b61BTwnRw2mnUrcLzSuxYCbbaoWav8=;
        b=tRmHEkZsI7/cJGESd970iVhsWQ+X6JGNmfrbSELvrlWWZSr0hGEJOHhaTX0RrEJ2ip
         RRMyajgOGjNSflZLTQJxfiEb0ngdupWk51oUtrg4AuUFIyg4Q2J3J7eSHtybdD9019/i
         tw4fkd1jdGWSUzqCGXBGyWzYSTJer8rOwKh+wHNOa60loDI+1rdwAMmcm2T+k4GU61ea
         6lwKlBU2PMAJAdiX88ZJOYu1oqsXQczPBc+ytl0GANRte+M5TMM9aeRPAWkrg26x0U+4
         83iIcpz3U0x3GeZG5RJj6T1Bp0h2o3EsoNaIvRHOK6TluVgPCaToAHRu8Ax0r7WjZDRh
         lILw==
X-Gm-Message-State: AOAM532S9o0TPJGU0JLyTXihznNZEMaWWcn6DcQvE1PB+9cgqtJjp6pT
        JmdujwxHcywkFg58LFUPEDcc6A==
X-Google-Smtp-Source: ABdhPJz8VammpoTwnjyKnNe7opIwIAMtj9XxNyBPNM5DGwpJ+k8YsAYnqUEYhJWs/tGCae7TfB+toA==
X-Received: by 2002:a63:ea01:: with SMTP id c1mr15452769pgi.138.1610282503368;
        Sun, 10 Jan 2021 04:41:43 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id p9sm16176960pfq.136.2021.01.10.04.41.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 04:41:42 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Subject: [PATCH v3 5/6] mm: hugetlb: fix a race between isolating and freeing page
Date:   Sun, 10 Jan 2021 20:40:16 +0800
Message-Id: <20210110124017.86750-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210110124017.86750-1-songmuchun@bytedance.com>
References: <20210110124017.86750-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race between isolate_huge_page() and __free_huge_page().

CPU0:                                       CPU1:

if (PageHuge(page))
                                            put_page(page)
                                              __free_huge_page(page)
                                                  spin_lock(&hugetlb_lock)
                                                  update_and_free_page(page)
                                                    set_compound_page_dtor(page,
                                                      NULL_COMPOUND_DTOR)
                                                  spin_unlock(&hugetlb_lock)
  isolate_huge_page(page)
    // trigger BUG_ON
    VM_BUG_ON_PAGE(!PageHead(page), page)
    spin_lock(&hugetlb_lock)
    page_huge_active(page)
      // trigger BUG_ON
      VM_BUG_ON_PAGE(!PageHuge(page), page)
    spin_unlock(&hugetlb_lock)

When we isolate a HugeTLB page on CPU0. Meanwhile, we free it to the
buddy allocator on CPU1. Then, we can trigger a BUG_ON on CPU0. Because
it is already freed to the buddy allocator.

Fixes: c8721bbbdd36 ("mm: memory-hotplug: enable memory hotplug to handle hugepage")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: stable@vger.kernel.org
---
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a176ceed55f1..e7ed30afbb8f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5575,9 +5575,9 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 {
 	bool ret = true;
 
-	VM_BUG_ON_PAGE(!PageHead(page), page);
 	spin_lock(&hugetlb_lock);
-	if (!page_huge_active(page) || !get_page_unless_zero(page)) {
+	if (!PageHeadHuge(page) || !page_huge_active(page) ||
+	    !get_page_unless_zero(page)) {
 		ret = false;
 		goto unlock;
 	}
-- 
2.11.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447712F5F03
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbhANKjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbhANKjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:39:45 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8CDC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:38:43 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x126so3089809pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0cYwNXoL62ufowFhR51LMghCmA8txi2r5XxTjm0v6q4=;
        b=WAckzXA3NYKMKzPO7d3fxmhmFa8XPvuFtpLdTcYJt0gP2l6AyanNdZetxWYn6M6gh8
         EKuAhkJ6BYRwelX6ez+H0e0UwT09Rsu1xybpU2VtIhSNwzQ4q564A5sHSawFcgoY9os5
         aRZU6FJl2PWqX/JDf7WGYUMv6bB57KPfWNlRn5mAAwJ4TbBZjzwFRwyh+fKQFrlN9HMc
         AvQvmaLzm4gORcjnaSbXJ8kNWYLsxPdqFhs/H/MNrGp7PBz5QrXC8MhkbZ1saUcpzFhT
         28eZaFI5C/HuYjZZMBu5/YFIV5rta7rOuHR6JMNWnCGh2KIUhh/mpFuG8LKNOD1QzfZ+
         KVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0cYwNXoL62ufowFhR51LMghCmA8txi2r5XxTjm0v6q4=;
        b=Uhjye7qGZdZRiosBkUUTDjovH+nh7BXTiJg186CdGmtByLTWjIlgIUlc0mIMjAAHlM
         eE/ONoYVeWHLm/7bVWNiKIp2Mx5VKA7sWMlaET5pgLErTC9f/jySojg9Gz/OX98E1AIL
         NO0sJYBfiPrbmz+YpbgsybAhtkNca/ekPqJoaq4CbJ2+ASYCgPEr0oz9aYY5R3QxN26I
         33iAMiRpl0dYmg3/6tZbephnGqDKFKAeltTnSQxy1tm/iRI+VNUz7ZjG60sys14A2WIj
         y+VMPZ3uWCMFG/rbC8BR4c28v1/GriOsGXMNVnjk5OC7iGGOQhZZgFJZsb4uF//zEB4K
         gWNQ==
X-Gm-Message-State: AOAM530NpJY87RJtf1poYSaMhw43s6K+fMY9pfQpYyBKFyR4Fxziwmfk
        AsWBD8gAxPeP/kxVJ7eIjSmDPg==
X-Google-Smtp-Source: ABdhPJxXNYBJ+M1mhSEdHS3f5xG3SEV5dk5DG3dTkVKcMRSTqqZO27UWtQjHKdl0bxjQxbvpmqv9PA==
X-Received: by 2002:a63:1c09:: with SMTP id c9mr6887350pgc.185.1610620723225;
        Thu, 14 Jan 2021 02:38:43 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id l12sm4970112pjq.7.2021.01.14.02.38.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 02:38:42 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Subject: [PATCH v5 4/5] mm: hugetlb: fix a race between isolating and freeing page
Date:   Thu, 14 Jan 2021 18:35:14 +0800
Message-Id: <20210114103515.12955-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210114103515.12955-1-songmuchun@bytedance.com>
References: <20210114103515.12955-1-songmuchun@bytedance.com>
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
index 1b789d1fd06b..43b7a044f248 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5574,9 +5574,9 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
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


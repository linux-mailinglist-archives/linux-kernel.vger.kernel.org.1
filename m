Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CCA2F43D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 06:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbhAMF0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 00:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbhAMF0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 00:26:52 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AAFC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:25:53 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 30so766560pgr.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7IILliy6HAELOAf2o6Y4OfnqFvSJBzlwsRQjJedxot0=;
        b=dJSU9wJz/3rQWPdMgFSeLg9iISXgA+mrG+M6gt+bsIjssGtFTfPEsERPEUS/5t83/a
         LUUhWWNg/MtzqsN1Kcpq3X30J5yof6IfmScrbd2duBHq6YKTHipysgbq0GgU5xk6pS2e
         zjsxPKhbFQ3aQpWwXgTAKahmN+gYTipJrmzzMWPn1qre9ExAnmti5MKJc035HZOxbRYj
         iHy8ulllb0ZqY2Um8SLjP+3fu+8cZOBSSgRpFiASO+QylIjnslUNIoap6l6hYXze4wgD
         w4WSsWwgioG3c1Cy6a1OJW3JNITIUff9+LHkCpsmdjVxblAQrvZnTkHGQvdlc1TgFK6d
         1KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IILliy6HAELOAf2o6Y4OfnqFvSJBzlwsRQjJedxot0=;
        b=uVfNmQUmID/1q1K8X+ZcQsR/+eZ/pr/cb+aR9Xk1KHom8swI1TVnkmkhFmtGgYqPSH
         kJpfko4Cij3FdvkMPsPrt+/52EsLNK7jy50he+h8roX2XdrgaigUiuR+BDNMQrVnE4cI
         ppy1CsYGwLq/fyeNfUyrQKyvbJhDi7v09VxO6Epd7wIeZXMUiBPeh4vM+J5RAjiLT1xv
         RElSYA1aOBoUoYfydMjqjKosb4N6vwi7CC3g2VcGoB+Ecv5SMPM3C4gnB+uPTCRJR+ZG
         UUyTOTesUT7hNVZa0pUrwUTw/UNOi/Rr+ot4Zhz5FwWkSEZVnwUuPKnpKCbaKh4ExNNr
         JB+A==
X-Gm-Message-State: AOAM5311Cw/MRs/j1ClCrnRviymFMWmNWKe2bK7Pemsmb578Tj1lRuna
        TQIdTirgvFQzR/WPMWw+OQVOgg==
X-Google-Smtp-Source: ABdhPJyzBXCuQ9SD6Bb7oZ1eb4Ev3kY+H2KEd84rW3RSKql2lLp9DD8eqP0VXQA4l2FJ/CVALwQ2ZQ==
X-Received: by 2002:a63:1110:: with SMTP id g16mr459913pgl.357.1610515552956;
        Tue, 12 Jan 2021 21:25:52 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id x15sm893081pfa.80.2021.01.12.21.25.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 21:25:52 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Subject: [PATCH v4 5/6] mm: hugetlb: fix a race between isolating and freeing page
Date:   Wed, 13 Jan 2021 13:22:08 +0800
Message-Id: <20210113052209.75531-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210113052209.75531-1-songmuchun@bytedance.com>
References: <20210113052209.75531-1-songmuchun@bytedance.com>
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
index 898e4ea43e13..a7ed22811672 100644
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


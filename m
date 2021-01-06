Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E2D2EBB53
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbhAFIvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFIvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:51:04 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211AEC06135C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 00:49:59 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id s21so1306934pfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gaj9ZStUW1Kcj7p4H5CS7rdzKDeUaqkavvNxRg/B5lU=;
        b=uz+8u529Ju4Davf4ms3sZJcBtnV2a2dvUB9ZF74eLw3nZbjez+6lgG/ipr5t2GVRLJ
         +8DXAWfRC+zJ3/C1eLukbnCdEnSehR2D1xe8cCGv1KbMcjSaTCAEu0WspHVlSBn7v1g6
         bEjQBxpJZ3x8u9qPS1EXoFf/oyBJoRTzjbG7bikMJKUOa2eO+D4DIT7eVQwiQltoLs8q
         Q4K6+YvpxgHcdJA4FFN6Xk7Y2nVZm7PxPX6kxUwF/xKU7ktOilebxRvUPGVLheS003tX
         EFY3N9OpSc09x94kEbYXiysL48mE5x4eUVMNWQYF+U4B9iktfHoBFC+SgrLOB2+VL/tY
         px3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gaj9ZStUW1Kcj7p4H5CS7rdzKDeUaqkavvNxRg/B5lU=;
        b=FM8iosM86D3Lq+RIvzY+uJAG0EQFvWxwG9pzJsLYBwLG8iltFqU4oOp9l15lrloSxd
         pXwuCOHG3wjrxy8/eL7/biAKte9vw8/ab6MTXaoF3oc3hfNDjdWqeb4NN1KapIoxjxbQ
         4HxLXDdkrwjy7zrk/S3OdGXXCvrjotxvNR9yfVtjzzss07KXFHCmXQuEEOcjsG/N3qoA
         q35GZzkzntFQobLiZVbXuDLbIpww1ku78KjmFuw2Xdmep9Oc1x8Nkl0KYpnAB+mQ6oEV
         J6+K1+Y5JBJOetrCGZt4H+GNvtbywFhJSvDd8Y72XdcxlnfrEoVKoG4jPU1em5edcicG
         bg/A==
X-Gm-Message-State: AOAM5321fslVJKUjFcay00yO6nd2+//fm/KIoEV3FE5WKrylPrBJUNoi
        y0bYKSgpcp8fhc1tQHjFmrYISQ==
X-Google-Smtp-Source: ABdhPJzi9OJPuY3J1ix6rvK+ht+c9cNIMgTTmC4RoiVzCxv+LwiA2oLfrLqS4wTl/lcsDyO5xsT+ug==
X-Received: by 2002:aa7:9046:0:b029:1a4:aa3b:1f31 with SMTP id n6-20020aa790460000b02901a4aa3b1f31mr2777943pfo.77.1609922998700;
        Wed, 06 Jan 2021 00:49:58 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id h8sm1851806pjc.2.2021.01.06.00.49.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 00:49:58 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 5/6] mm: hugetlb: fix a race between isolating and freeing page
Date:   Wed,  6 Jan 2021 16:47:38 +0800
Message-Id: <20210106084739.63318-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210106084739.63318-1-songmuchun@bytedance.com>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
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
---
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bf02e81e3953..67200dd25b1d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5587,9 +5587,9 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
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


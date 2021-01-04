Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF0B2E90BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbhADHE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 02:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbhADHE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 02:04:56 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3F0C061793
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 23:04:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id lb18so9458266pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 23:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cdofCMrJggOBDwndwOMcw9p8TURVKPl7TRF1bXWpuHc=;
        b=aO/iHhlqeDxAdcVAauKRuxsfxa53axv5jXOjkx2H1E3acuFc1j0hmtjQIyKCHBbHdq
         3FIJJEqknwwg8BkrSycQgeqDvwp6qVqUX6uIiXxWA4lnz31JaswTjCfX/EHb4n4eH96T
         Sw15jb0AqfnZrj5Hp9nOj+CKl8N4nCFojlYELfu1OW9QbQt1PpsiJ0b01i2L4rOzIzWk
         eYc7nqGoxtraxVFZpSZk0pjL1mmbJ2Hk7ur555woz7092ZnKLnxi09UTfO3ODpu2BbUt
         QjLHKTWg9i/F5S6zxsbN4oiM4aQLFz9YrO2Kd90hDv8Ua4JCnpTcnUXVlA2UXZcUu1id
         kzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cdofCMrJggOBDwndwOMcw9p8TURVKPl7TRF1bXWpuHc=;
        b=d4IULlSUqO0aLilnA07B5fjzWJ0mKHA/pnFY5qj+PgSReYkHYzVvfH0O8bJIHAf6+g
         Gz6u9NhcVdymgBtzg2KoRtHKwZFS0kUSI8p26lZBS0OsqsfvqiQAyYX03tcGX5Tt9O1Y
         Yj1olWM0MFMb4j0G/CWoR2f3g3xZw/t5644oRdl2d7KuSLUTVCGAfasaJIihg4VkCkD8
         ZVyjwTC76lTXJ68DFKyeLgDmkYnsEnobVTWzQSsO5TzLS2hsCFG1gvG4tc3EUo2LvQEG
         c0yH7malvyh351hSuuLUoSeUJR1HsXjw/xCEUoFVG6UZhl0f9/M+JzdKT3HzaULa1Qz7
         1P+Q==
X-Gm-Message-State: AOAM530RT/9zxTa//r07f4gss4jyBCttr1AsXc8TwjULYjNBJoZL4XQP
        hpgAp7YhcPh7blz6VJjMxSxJ/w==
X-Google-Smtp-Source: ABdhPJxzEpkaSXh/zCVLNlge5Wt3FV4tJQi4XZyc7KdMDbLQNQ845ylTEScxlIBO4YlKMLmldQpMYw==
X-Received: by 2002:a17:90a:df81:: with SMTP id p1mr29396285pjv.158.1609743855735;
        Sun, 03 Jan 2021 23:04:15 -0800 (PST)
Received: from localhost.localdomain ([240e:b1:e401:3::6])
        by smtp.gmail.com with ESMTPSA id v1sm36306648pga.63.2021.01.03.23.03.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 23:04:15 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     hillf.zj@alibaba-inc.com, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 5/6] mm: hugetlb: fix a race between isolating and freeing page
Date:   Mon,  4 Jan 2021 14:58:42 +0800
Message-Id: <20210104065843.5658-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210104065843.5658-1-songmuchun@bytedance.com>
References: <20210104065843.5658-1-songmuchun@bytedance.com>
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
---
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index db00ae375d2a..5c2f64f53177 100644
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


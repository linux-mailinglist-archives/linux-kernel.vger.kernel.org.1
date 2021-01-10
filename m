Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E1D2F0743
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 13:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbhAJMmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 07:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbhAJMmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 07:42:53 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13D0C0617AA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 04:41:47 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b5so8782913pjk.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 04:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q2v5mrrSjESraNqHDwGVpPTSDpsByCOvtLmUTzZt6g0=;
        b=YVg4gth6O1BgEX5TXwXspQm27uCViGy7IU0/RmDe2i8CR9p4G0fXQW217eoFau69+I
         bcl/d5PDS+T1DBTddzhv7AVOPPvxtHJuE4NLYnjqVW/0n5js6XOdAT8nIdO3C2dc8emE
         O9WiwNqcJ6vM1ZfRlDiOocrbOoBMp2DVvN5kIPA6BATPRJ/CcI24qXY+NoBib7jrcsVA
         ap5aPeNdarr1Mp7cskUk3Lym7v7p0xERycNHqBeTH8TJsXETmlV23rndVerXw3okmV7O
         wvHn4OVoHXtrtEjhk/2bjHta7Ae9R3C8ZittrFvRrBGa9EvFuTjPnot7FHpfbZgaSWLf
         Jpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q2v5mrrSjESraNqHDwGVpPTSDpsByCOvtLmUTzZt6g0=;
        b=Svd+1UjgQvEpgVq/CUX20BUm8j8wqNiykVLzgPenaUucGfFOPq/LyAZfVDOUz965h1
         LGqGQjkmyQDAoQJ5wIvktO3LoNzc38O04mot8RSMX/K0aX+jIUDAyUMFOc4ailgaWWzo
         vIYe5xnszFSWheUCUmyElNBSspXAXukb1akghUdJJ+s4T8VaGc2d4guAlFMJwhzN9gQ/
         qOlxZGcwmkOTcwecNWjoug9elX9+vm7kuPvTZoAkE0qMybreXf4yVtLzyXNGrmqtf0Ix
         b1vxQ0VrvqHmoUcXU9MDN00pxjJJ0NH05xg7nXcg7mlZNmJ2sR56U91qUhqJPvm38LQg
         FYBQ==
X-Gm-Message-State: AOAM533qVT+k4aqU19mMDj8kSOphq3EkxrsEoRlKs0yhazTx+f4f1K63
        auiQ0GCNssSkyo1VplQiRYfF3Q==
X-Google-Smtp-Source: ABdhPJzl17pIIRw/wPQcY4D0IaWNRYplQXvDOcoTJCykKdxrbXO1sPO/EXGH5SNXKhzi6llVHPNJ5g==
X-Received: by 2002:a17:90a:cb84:: with SMTP id a4mr13213004pju.50.1610282507382;
        Sun, 10 Jan 2021 04:41:47 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id p9sm16176960pfq.136.2021.01.10.04.41.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 04:41:46 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Subject: [PATCH v3 6/6] mm: hugetlb: remove VM_BUG_ON_PAGE from page_huge_active
Date:   Sun, 10 Jan 2021 20:40:17 +0800
Message-Id: <20210110124017.86750-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210110124017.86750-1-songmuchun@bytedance.com>
References: <20210110124017.86750-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page_huge_active() can be called from scan_movable_pages() which
do not hold a reference count to the HugeTLB page. So when we call
page_huge_active() from scan_movable_pages(), the HugeTLB page can
be freed parallel. Then we will trigger a BUG_ON which is in the
page_huge_active() when CONFIG_DEBUG_VM is enabled. Just remove the
VM_BUG_ON_PAGE.

Fixes: 7e1f049efb86 ("mm: hugetlb: cleanup using paeg_huge_active()")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: stable@vger.kernel.org
---
 mm/hugetlb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e7ed30afbb8f..5940bf0c49b9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1360,8 +1360,7 @@ struct hstate *size_to_hstate(unsigned long size)
  */
 bool page_huge_active(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageHuge(page), page);
-	return PageHead(page) && PagePrivate(&page[1]);
+	return PageHeadHuge(page) && PagePrivate(&page[1]);
 }
 
 /* never called for tail page */
-- 
2.11.0


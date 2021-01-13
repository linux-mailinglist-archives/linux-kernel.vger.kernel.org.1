Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDDC2F43D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 06:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbhAMF0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 00:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbhAMF0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 00:26:52 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12B6C0617A4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:25:48 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b5so441776pjk.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=df+OSfZ6Luc35Oz4+SS0Ts5oHiC9zu8mWZ+1lvg6xFY=;
        b=wBRMJy+2MZVtfgvXnwW63ZbQjCCWkgb2dOMUynxH9HAzryqJzMWO8hX3hUebpvrjPo
         46M+sxORf5F6Z9VDNvKGgxBsXVzdJCpJYijbRpEPg9GwZjjo0hbNKzIqT10ABwAcz9jr
         ybrk4dJHUZr8fk+ZzwAbiMXkwOB97p4K4FIgDk6YJCnScgJMrRMl53HLrCUM2wIIiq88
         YsEMOjimlLmRxhj+6UTzRrq8sdEbJThESelLVqg+a3pAp+1TB3PLfvuBP7Kyu2UsJcOv
         d5b8KYUgqK6GJgTBDmXCHG1edYjugzk/IP061E9C2RfgM/4GpT2x9V83wtXV20FY39QG
         uvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=df+OSfZ6Luc35Oz4+SS0Ts5oHiC9zu8mWZ+1lvg6xFY=;
        b=bjO2bA4mQjmRZ4JDqVBbRCrKR44pC2n9rf3QEbXXTiDywH0no4YK+EY6mX3nvIqO0f
         3HL2RVEg0E7oCb6wUYMoT9FnNwaNJ/2qXJDdjG6jpeRu2U9x3axJoc4+8TDW1oJo6BEv
         NZrkTC5CgvfGLf4jTd6gUBqOzOUOYddxdLGAt3b2UDTVhQrFHVcirWNkO/wSM+y3mdv1
         QIklNeLFZFgxpsokECJ0UpTk0d/s3WSH7q2HB/tQ2nBr/o5gI5YvlUiUedTUnPEDNTRz
         uJNVNqvud+/DI5WWja4Uh2EEqKGFLo8Qr+5pL3R2XrVV5myPVbZSpo9LhEfWjfXo387y
         qrOw==
X-Gm-Message-State: AOAM532fe8ktNr9aTf9JlC07/tDK27sSIhTY4L2tV4bH6Pf/uYymraH/
        VKZz4BP4BM8UIbBZQd1vB5fPLg==
X-Google-Smtp-Source: ABdhPJyKl1cvK6NkpSmYZQknrW7MZ4B+txOHVft4CSpdorPAXL1OO4sVsWZKeOvhYqOuCHE1W/qd3g==
X-Received: by 2002:a17:90a:4208:: with SMTP id o8mr386094pjg.224.1610515548247;
        Tue, 12 Jan 2021 21:25:48 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id x15sm893081pfa.80.2021.01.12.21.25.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 21:25:47 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 4/6] mm: hugetlb: retry dissolve page when hitting race
Date:   Wed, 13 Jan 2021 13:22:07 +0800
Message-Id: <20210113052209.75531-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210113052209.75531-1-songmuchun@bytedance.com>
References: <20210113052209.75531-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race between dissolve_free_huge_page() and put_page().
Theoretically, we should return -EBUSY when we encounter this race.
In fact, we have a chance to successfully dissolve the page if we
do a retry. Because the race window is quite small. If we seize
this opportunity, it is an optimization for increasing the success
rate of dissolving page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4a9011e12175..898e4ea43e13 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1772,6 +1772,7 @@ int dissolve_free_huge_page(struct page *page)
 {
 	int rc = -EBUSY;
 
+retry:
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
 	if (!PageHuge(page))
 		return 0;
@@ -1793,8 +1794,23 @@ int dissolve_free_huge_page(struct page *page)
 		 * We should make sure that the page is already on the free list
 		 * when it is dissolved.
 		 */
-		if (unlikely(!PageHugeFreed(head)))
-			goto out;
+		if (unlikely(!PageHugeFreed(head))) {
+			spin_unlock(&hugetlb_lock);
+
+			/*
+			 * Theoretically, we should return -EBUSY when we
+			 * encounter this race. In fact, we have a chance
+			 * to successfully dissolve the page if we do a
+			 * retry. Because the race window is quite small.
+			 * If we seize this opportunity, it is an optimization
+			 * for increasing the success rate of dissolving page.
+			 */
+			while (PageHeadHuge(head) && !PageHugeFreed(head)) {
+				cond_resched();
+				cpu_relax();
+			}
+			goto retry;
+		}
 
 		/*
 		 * Move PageHWPoison flag from head page to the raw error page,
-- 
2.11.0


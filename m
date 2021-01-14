Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4672F5EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbhANKjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbhANKjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:39:15 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E21C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:38:30 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y8so2696775plp.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wusSjLYakm6+Z6kCpNRodcZYujbXCjpbVczSV3qSR3o=;
        b=TeiTKCMIOIJRw17QVnoSIfYza5zvzuJdQpuxOI/464cijUjiNyu9mYgydAdL2B4UTe
         iQsMS6mFYA/efN+W5hnMZNG8aMj4JvuHTV7zw6AQKNhNvs0V4QgCd2+KxV625KInYCvg
         sav6A4SdKh+/IXh4Rr0xQlxguGV5TgalxHSfo1UKCd/mt4Y7kPluOLu2gC/6KBSu9ApL
         S5w6wcKuli5Jq3UOCcpxq8d2jeKdawel/SjY9qoL8gnZVy9R03OXV5Atof1m2f/Grey+
         crisfJEUxwDLr5TjQ2mNuvgbbRKT1TnEkyPaxMMF9HlTXV63JXWnd0Ci+vemx6gbqoME
         27Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wusSjLYakm6+Z6kCpNRodcZYujbXCjpbVczSV3qSR3o=;
        b=e+MUf5CDL7LlpChjfSeqEmVzAsU0mbZi/53Lj3k6tNV1gELg//VoC7JKzsXd8Wjzi5
         TX82+Bd6+U2aA1bU5ruAEHaAZTCzt/nn8Ul0KlZPZ1EPKsDm7tCIx44WJIsu6CO5jm0R
         zZPuUeHhOkkS7mcy9b8VMeiwtvdPqDnLfzTQE1c6bzPvtQuvHymnwUlPa2pXu6xLVIjg
         Ezxt+ghGv11OraX4uNnJNyhKGXzxAGzQ5UiISVLUClg2NSqwQ2CPxFozO9wxS48d68fy
         QNMgjkiTxrLawWGJeKmBjHWLMrfx6GfxWiaDiq2t0ALhNuwCSDLG/1y9rrz/onhEsbZl
         ohUw==
X-Gm-Message-State: AOAM531SmTHeYTd8iWiOPUy3Tl+kV+lLCACQgxBBQ9j/K6lJ72GTVpY0
        GYbeIpRa+RSavFiWwqvB3JpRrw==
X-Google-Smtp-Source: ABdhPJxZ8FcQdJ5BlixmjzNl7BHRg+e95EAUD1OOhclQznhvVWpOnMMnx+m4cvx0MnAtDvcX89YDGQ==
X-Received: by 2002:a17:90a:6c22:: with SMTP id x31mr1617999pjj.196.1610620709633;
        Thu, 14 Jan 2021 02:38:29 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id l12sm4970112pjq.7.2021.01.14.02.38.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 02:38:29 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v5 1/5] mm: migrate: do not migrate HugeTLB page whose refcount is one
Date:   Thu, 14 Jan 2021 18:35:11 +0800
Message-Id: <20210114103515.12955-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210114103515.12955-1-songmuchun@bytedance.com>
References: <20210114103515.12955-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All pages isolated for the migration have an elevated reference count
and therefore seeing a reference count equal to 1 means that the last
user of the page has dropped the reference and the page has became
unused and there doesn't make much sense to migrate it anymore. This has
been done for regular pages and this patch does the same for hugetlb
pages. Although the likelyhood of the race is rather small for hugetlb
pages it makes sense the two code paths in sync.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Yang Shi <shy828301@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/migrate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4385f2fb5d18..a6631c4eb6a6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1279,6 +1279,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		return -ENOSYS;
 	}
 
+	if (page_count(hpage) == 1) {
+		/* page was freed from under us. So we are done. */
+		putback_active_hugepage(hpage);
+		return MIGRATEPAGE_SUCCESS;
+	}
+
 	new_hpage = get_new_page(hpage, private);
 	if (!new_hpage)
 		return -ENOMEM;
-- 
2.11.0


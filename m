Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01F42F43CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 06:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbhAMF0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 00:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbhAMF0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 00:26:16 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B19C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:25:36 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g3so438463plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YM0v4j/Vw+PE0j0qtyYxkInLgfChRzFtd1IYXVhtaBs=;
        b=UMBMQFjAJ/KleNdrCLc87puq8f82M8nlP3Nlp9Htg8u8SfL+gDjlPEqAOMUsZRA/w5
         QrOVLDLG5hbF1ZaqfQA/mitoaGSUq1xnqtF0D0VRy1Vy6BR6fk1y3FuHmYKD67VJTN12
         g4OQbOdhAYdQQKfuUvvVRWQJqUquk/cSSyhf5/RafWb6WWGaLqAORg6SQ1PsTOpioG5A
         y5xY0rFuv3pZD/P4JCT39VRYlOb4zqh+i/D6m0IV4+hy8VZOnYjanvBnASOIeJggxtxv
         mKd/C7VH6yzziINWeIMJBpBH6nOU/SS6SL3ee5Rxy0Id2T5C2R1bemu+l06tCvPOo4Ib
         FqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YM0v4j/Vw+PE0j0qtyYxkInLgfChRzFtd1IYXVhtaBs=;
        b=FP/7xLa2+5jDV9tw6V6NWfE+g30SQSeVUOS64w8gA+bUV5RTrWgdTtAvIkzXfOtHPG
         gus1dOff/qQKOYFpygDHGcXE6MTRoH34dCrRKD9z1sX4jAyIM23ytUFGvFqMUUyQJtvg
         l+dytbh10IBm4twLx0hyDe+ZHbLtO52fk35Rusa1220e0w+vbCjGEmD4K5E5rz6s4pOI
         jwitl59gb8pLMkmvLwDOzKrGuAYhQoDMUZb3rteIybkm/XYeU/PjnJLdF+k+5/RqVW48
         SvzJF1kenW5HOcSy81jcIi3jR+ly/HBxDMQFp1X03j+S5LrMlsmBq7NaF2tI9FLG3H03
         iCNg==
X-Gm-Message-State: AOAM5337MWzX4NHBzjV3/BUWIWrLQa8zLkXX9Oi3qVI2zLnMlBeofqEH
        BL9Dh21C9TR/8ra4KRJb2dzVWw==
X-Google-Smtp-Source: ABdhPJxHkGLvnYePvtJVAinVs5t2rPLGqeF5cswjO6y60ppYk2XM0JruFQuehDmZQ5o6gWa3rkMO2w==
X-Received: by 2002:a17:902:848e:b029:dc:b38:98f0 with SMTP id c14-20020a170902848eb02900dc0b3898f0mr622492plo.82.1610515535725;
        Tue, 12 Jan 2021 21:25:35 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id x15sm893081pfa.80.2021.01.12.21.25.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 21:25:35 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v4 1/6] mm: migrate: do not migrate HugeTLB page whose refcount is one
Date:   Wed, 13 Jan 2021 13:22:04 +0800
Message-Id: <20210113052209.75531-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210113052209.75531-1-songmuchun@bytedance.com>
References: <20210113052209.75531-1-songmuchun@bytedance.com>
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


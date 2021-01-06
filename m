Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEED2EBB4C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbhAFIuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbhAFIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:50:23 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C88EC06134D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 00:49:43 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id m5so1236755pjv.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EFKJSs8Uw2qVkTfChSTguLsyINtR2C6KwmPPD3vJNks=;
        b=QzxUz3LBxD+LD/LGS4gpuONiFu9PnmrSYsvkGbjhKmkC0fdySJgrgsYNQv3nFsJebo
         bx4ZKaHKV2z0UWknW0n1ym6XrnwJKBaQdvIHyKZXlf+G74/SrbpSBaqDLvkLqrsRHquu
         Yb5StZdj/bzOJxEaJzoXfqaKI/SmEbyiouldh1715V8vizroo2STwOpl3kIHk4lGkdFH
         eKAofVYlGutq5/36516cYdj7QZ2HP44H5eU8k/EgffGlxfRMLmFXd0hbMsZ81QWL9uYb
         EF2XOODsnxnNAFph2UbvKRYBGWyCV23dMBuOMq3bpwa/1uGecxzOGPo4CCyoz3gcj2FB
         PRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EFKJSs8Uw2qVkTfChSTguLsyINtR2C6KwmPPD3vJNks=;
        b=jUJ1vmtdKBYGuzsmJDRPlyhFe5Ra2DCyAAbqcwi8wN3ywAqQHayZjnan7S4WDcD/m7
         3qbReHuXNH4UVCvu0yeqauS4v6hxtLIq5afNGm/8ruGV0Sb3fKdhan2ZrFoCh7YOKwmY
         Ps/El2tg1rb1TFv7/8yl3NP1qHeR2RAu2GQ1kbaPl+IM9vJTwHeXRoo30oyuroMlCVgr
         3mz5CzWTnAh+fBwi/cRcyeyBtX8prJUWpYFtjtVaXhBZdzJjXVz4wOZiRThSxmIqgZ44
         UI8Q3gXpIntHVr1GEmKk3QGoOwBUaXdAif8HY67gt3IiBZdqHfSywaB5c03P4pilqCw/
         D9uQ==
X-Gm-Message-State: AOAM5316NcFQXN00BWyZ6y7cVwoFi013fxidWPf5hTpFjFhl1ZZJwgbY
        EDKNFDV5Txbx9HG6eW7i/2iiYg==
X-Google-Smtp-Source: ABdhPJzITf3AUbohjO7HdzweaiVQS+Z3gBxO7k/zuZ+qw6GyYiCTZN5Voph+bWWIdBlBn4zEEtPVqg==
X-Received: by 2002:a17:90a:6587:: with SMTP id k7mr3379913pjj.154.1609922983278;
        Wed, 06 Jan 2021 00:49:43 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id h8sm1851806pjc.2.2021.01.06.00.49.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 00:49:42 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH v2 1/6] mm: migrate: do not migrate HugeTLB page whose refcount is one
Date:   Wed,  6 Jan 2021 16:47:34 +0800
Message-Id: <20210106084739.63318-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210106084739.63318-1-songmuchun@bytedance.com>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the refcount is one when it is migrated, it means that the page
was freed from under us. So we are done and do not need to migrate.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Yang Shi <shy828301@gmail.com>
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


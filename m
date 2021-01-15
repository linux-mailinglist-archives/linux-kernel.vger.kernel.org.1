Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418892F7AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbhAOMwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388465AbhAOMwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:52:21 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0A6C0617A3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:51:16 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c12so5418263pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wusSjLYakm6+Z6kCpNRodcZYujbXCjpbVczSV3qSR3o=;
        b=b6lkShudiFwH3nXVrpZX+gqStufxvurJdvxqDVcsPwjtLMN2djbpgCbGywiWqyrga0
         M+gaefZbiLj+89pB2Ym76UEVbWAtzoIKFtD9vcTv29FSbXO2UNvefzDUeC5iGKY/o/Zv
         MFDBbzHCxL4A2Po1RducNPu56GgVGipGd0fA1OchQLbycyi7LY+WPaQfd5ntlO0bwOIV
         AH6hPW1wqlcg4Wi/nrhzdDWzT1SCAjciK6n+CUEGiuyeET5sIJmZrS19/hpDoL125GAy
         77LHlv69plegW8wOEDThn4B2DE2SL7hw1wb2rDt7Xeuv1vmmGCUt8YDIJRKHzEOTUmJ9
         v55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wusSjLYakm6+Z6kCpNRodcZYujbXCjpbVczSV3qSR3o=;
        b=P3jW88uqMAGpke9S7baJe4e8zq4bK3j3wLLcJ+v0G5krAm6u3MCZwdff9/aIZS4VJZ
         eA1FBpTgpOoRX88rpKuwSqWRFnSilcZww0ffbelQeXkA3rwBu+C3DKeAS1+Db2L+lhZC
         SV22ljoTJOGbyYVW3iPO/CCcOIIm+K3F6/e+/4oeANZPuI1Y3tIrpNsSV6W6fKJzHZxb
         r9bsuWdFTnaUY5vhzQqPFjEVUdyn5sykKOXWFpEFDTHF1Jf7YaFbt3wwfsdZkCg1Wx1u
         hXIT5L/5pkXyalP5KOuil5t+a20xYG2OocvLyurQbOWXpokSd5vLtoZCTpsS3/T62qQl
         HB+w==
X-Gm-Message-State: AOAM533bSSCV+8yxQKdoSJh0VIP6pcTl7OwN2PnEIRpsC7znv2JMNtbm
        +shRWKeycYZUsdL0/8lC6N+e9A==
X-Google-Smtp-Source: ABdhPJxGSYg/GU3hqllaplzUHovQRCfeeWtqx+DxFm1YmqgDcB1pUCRHVxptmFPNYm9/Rr6pzhq4hQ==
X-Received: by 2002:a63:5fcf:: with SMTP id t198mr12329283pgb.226.1610715075683;
        Fri, 15 Jan 2021 04:51:15 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id c5sm8193600pjo.4.2021.01.15.04.51.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jan 2021 04:51:15 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v6 1/5] mm: migrate: do not migrate HugeTLB page whose refcount is one
Date:   Fri, 15 Jan 2021 20:49:38 +0800
Message-Id: <20210115124942.46403-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210115124942.46403-1-songmuchun@bytedance.com>
References: <20210115124942.46403-1-songmuchun@bytedance.com>
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


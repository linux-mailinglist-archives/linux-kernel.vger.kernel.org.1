Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046DB2D1CE4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgLGWLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbgLGWLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:11:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1413C0611CB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:10:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e74so6741121ybh.19
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Kf9dTc+9mbcjPQrEvILlWLhCJdkwYGqBYb+/1iUw0zE=;
        b=fSSoLvefvFm3BrkZIbU4dDZtvcdRjAbXGzkjbBOWFvbteEjxfMfEe3atbDOlGPpCal
         FEHCiJlJRf7w6/pYh5y4rTOykCqMEaML2dFZjkMKxxJ5FkYQyaJAHzvjroaBd87owmpE
         kudzsHm17VQAsY2OiJXmTUh1mif77MvhegWi5Sm2voaEhwXng3qWQZEfZtZmPOdR9l9W
         GggqxJbGNB/skBYYM4PMsGeJD3aPJo6pQ9HzAcqbssmf9HwXBEOMQ3m8z1rTmL3zAFEf
         1mawzw3XWZuFgj6NgueTNj7LUy/Zl+l/vh7z7/FrSNXEUW3VpLZck59vzoTi3XzgGXZG
         uzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Kf9dTc+9mbcjPQrEvILlWLhCJdkwYGqBYb+/1iUw0zE=;
        b=bKTTwFVVDE6L1YEVB/3GtmSnkhUtMXVidLzewmK6qHr5NGL3xR/duD/2tn+s2jXzPF
         ZoS+Vt781KtPRgdVngIvGJBZ3Ka+rHqRJqEsQWG/CFicXb2o02FqNZNviiMTnHJ0pAnz
         bPeV8dMfSBMNRhegCnE/TlM33HKUK7tB46C0mMsxQHyragUsTIdZpBdCKySL71ee/imH
         qPmXpxJkFIpaMSouvihUUR4ZXIh3wvhvp8wXbAEtxcukwpK0n60uSKXymHXh1kPFTPTx
         hCxQNQmh7o+olb0JHxn1LqNrUFZRdyNultvsNkPBq2q4dQbJwARlsYMrP/SANzFIye7a
         thsg==
X-Gm-Message-State: AOAM533XZRsG51xW0shRmlyH1PBZKcQRulZ4OaF7HD+Nt+r3/ScAFKuT
        8XDmxzMu8UBlQF4lgYMJr0M8nT7ocVM=
X-Google-Smtp-Source: ABdhPJxbDdiXhRgZfRl/qZ9cRUyAS3tHwdQh9kxPcNbivuTcOuJWGJfVGb6Wpd+AhWxop71Knc8AuAp1I8M=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a25:ac25:: with SMTP id w37mr12499169ybi.522.1607379014242;
 Mon, 07 Dec 2020 14:10:14 -0800 (PST)
Date:   Mon,  7 Dec 2020 15:09:48 -0700
In-Reply-To: <20201207220949.830352-1-yuzhao@google.com>
Message-Id: <20201207220949.830352-11-yuzhao@google.com>
Mime-Version: 1.0
References: <20201207220949.830352-1-yuzhao@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH 10/11] mm: make lruvec_lru_size() static
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other references to the function were removed after
commit b910718a948a ("mm: vmscan: detect file thrashing at the reclaim root")

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mmzone.h | 2 --
 mm/vmscan.c            | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b593316bff3d..2fc54e269eaf 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -872,8 +872,6 @@ static inline struct pglist_data *lruvec_pgdat(struct lruvec *lruvec)
 #endif
 }
 
-extern unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx);
-
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
 int local_memory_node(int node_id);
 #else
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 95e581c9d9af..fd0c2313bee4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -310,7 +310,8 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
  * @lru: lru to use
  * @zone_idx: zones to consider (use MAX_NR_ZONES for the whole LRU list)
  */
-unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
+static unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru,
+				     int zone_idx)
 {
 	unsigned long size = 0;
 	int zid;
-- 
2.29.2.576.ga3fc446d84-goog


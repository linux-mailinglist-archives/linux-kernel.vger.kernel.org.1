Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B7F1B039E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 10:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgDTIAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 04:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTIAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:00:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B714C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o15so4099761pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=52791mAUB6suGZo+tXBAHs9ubgU/UiPptwuGuey0HWA=;
        b=bkoHMPSlvqVW/xIixrvQlW7MbpVixhIaJq0vY5WKIHElzYLLQgSSuswqnD2GJjG37v
         hDYUKCpT5HMeLWz8SJG2A45HSv7coWTC6M+IqY4iC6YTxlEB1/tcbUJe3BzNGq/NJO3F
         WQjbjEmK5je2oi5CqvrgQ/jccvxhhyjSbyMPQWnPO1fGogVu6JeMyCdDLyvr/utL1uo5
         TNgcZkFGtMq3LcPUL4nowaQLIbG0kYwpGen491ED2+LJL+UxxkI0EDbF15ZPDvb7kY3E
         YvSZdoFkLpTZGDzxoYQpPX7Y6e34wj33q34RV+fw1iItvM8Gb5jin7SvaU25G75ZhZb7
         2ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=52791mAUB6suGZo+tXBAHs9ubgU/UiPptwuGuey0HWA=;
        b=FJeUMeENDpTKHzVGExTexUrS8T2dJ+RbjubSrY5gTAUR2zct92bYmQuv/YAKM9Za6F
         jiDdjrulq/rZhO1udLkxrdUrK5w9Swy25yQ0ObA/tGWjUOLluI1IiBJn++QnghfYMP6h
         auWe2tcRPsV384i4S9DFCwHRahv4kNCQLB0IC3S/UVK2c+qz7VvRYUjv9q2tE/u2o8jG
         ZpQSMC5QLsaxQ5mQCP5XtJ992g8QUGLjlkb2EMOyOj73jva6xNP08flYGFZn3zDwWViG
         v+my4DlthRXUYxAaHyJQtUV1k3gA4AD+HeS4F29INgOwelhqJkaj2DbLuG3eKAKEg1p1
         7aIw==
X-Gm-Message-State: AGi0PubAl8nsBgffsurQ4B2/kTYV4rMEnla7P19mj2WKPbuwmB5x97Ow
        uGc1wHFmtmxqv64jKY88wug=
X-Google-Smtp-Source: APiQypKIqxDuVLDfanElVReNdt0lDoBqnFlIavFkF0s5oVkkFlBVHvGOtxlIwVQfMUK3NLD1WhwOwQ==
X-Received: by 2002:a62:14a:: with SMTP id 71mr14794311pfb.33.1587369639755;
        Mon, 20 Apr 2020 01:00:39 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id n9sm314947pjt.29.2020.04.20.01.00.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 01:00:39 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH 03/10] mm/migrate: separate PageHighMem() and PageHighMemZone() use case
Date:   Mon, 20 Apr 2020 16:59:35 +0900
Message-Id: <1587369582-3882-4-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Until now, PageHighMem() is used for two different cases. One is to check
if there is a direct mapping for this page or not. The other is to check
the zone of this page, that is, weather it is the highmem type zone or not.

Now, we have separate functions, PageHighMem() and PageHighMemZone() for
each cases. Use appropriate one.

Note that there are some rules to determine the proper macro.

1. If PageHighMem() is called for checking if the direct mapping exists
or not, use PageHighMem().
2. If PageHighMem() is used to predict the previous gfp_flags for
this page, use PageHighMemZone(). The zone of the page is related to
the gfp_flags.
3. If purpose of calling PageHighMem() is to count highmem page and
to interact with the system by using this count, use PageHighMemZone().
This counter is usually used to calculate the available memory for an
kernel allocation and pages on the highmem zone cannot be available
for an kernel allocation.
4. Otherwise, use PageHighMemZone(). It's safe since it's implementation
is just copy of the previous PageHighMem() implementation and won't
be changed.

I apply the rule #2 for this patch.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/migrate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3e546cb..9a57766 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -47,7 +47,7 @@ static inline struct page *new_page_nodemask(struct page *page,
 		order = HPAGE_PMD_ORDER;
 	}
 
-	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
+	if (PageHighMemZone(page) || zone_idx(page_zone(page)) == ZONE_MOVABLE)
 		gfp_mask |= __GFP_HIGHMEM;
 
 	new_page = __alloc_pages_nodemask(gfp_mask, order,
-- 
2.7.4


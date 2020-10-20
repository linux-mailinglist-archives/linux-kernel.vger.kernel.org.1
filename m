Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9492941CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408884AbgJTSAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 14:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408870AbgJTSAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:00:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28E4C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:00:12 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id r7so2376075qkf.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvI9nFVOm89huMNWCRfBwT5OD9WDOvwN3RZaYD6afks=;
        b=P3N/QKgurREQ+ofcDVlF/8l+2DCDJjzx0/IdzkZzogfwF2BTLRCtlwVtyrrOif6nEe
         3xUGE6lSdiufsOrH4IkLoGN7bXqrgwXle4cC+1QsVJI/0Ye+v3mYp8dAv3SjvcAt9jzM
         sFmisp2CGKNSVes8HdBPouJRXcKeeRQSjOdvbOxudJdk3lzDPPvh5lXFiYTu9X+Kggk4
         qcfH6ELidHELA0eKKNNR9mVZ0umexKv/my+a3dyaR71KQrUEO/IJTRRahyIJFd6izQO9
         fo5ztebX0HS+B3K47q9PKApNvl3R52BYnhMQfFqC6olR238Sgozi48l+jmJoJ5vdFFzx
         nDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvI9nFVOm89huMNWCRfBwT5OD9WDOvwN3RZaYD6afks=;
        b=Kb7RiZjbelJw4Gnl/csUCIWGlElalURf9WFWaoahtcZRYW02nC185TiIBTkpfWOZ9M
         ix6RNMyXrY6Kc0JbOdTUnjX2QPqdtyLGd9JbCEKSYrkTNDLrlFNBb4ywL+9ijJy2IeBA
         HIcGtIOLLPX/ZLvAL218PjKygXvRwTWjoFPS9V6G9ggyX+nEgHCtxCXT/bl4jI/Hs0kd
         Kt2Is8HifUUPEwrOt3vN06+WkZqiPr1UkOcDK3s+wgk6F4mfUvjqY+lvSyBRSMzUx+MA
         2YU3VBdJo9HIYjh/2JTki7wkxRERXq/nYSWby/y2f4D8NEI5C9hzNXwZzyLGhxi0zX+K
         aM+g==
X-Gm-Message-State: AOAM530i1BZHQrrlyGaNrqvDhxY9+vlO4iP5vGfPwVxXcg87NA3htWWQ
        oVMMGxrhPtc00bHf78B3t7FFNA==
X-Google-Smtp-Source: ABdhPJwUkrBa1MGge2vrjozAEedOWNjrgytgUIe84AyFVRKo4yzY23tbVNh6JT+4HyJezXLif2ECYg==
X-Received: by 2002:a37:a74e:: with SMTP id q75mr2003716qke.277.1603216811818;
        Tue, 20 Oct 2020 11:00:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:c52c])
        by smtp.gmail.com with ESMTPSA id j9sm1046697qtk.89.2020.10.20.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 11:00:10 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] mm: don't wake kswapd prematurely when watermark boosting is disabled
Date:   Tue, 20 Oct 2020 13:58:33 -0400
Message-Id: <20201020175833.397286-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2-node NUMA hosts we see bursts of kswapd reclaim and subsequent
pressure spikes and stalls from cache refaults while there is plenty
of free memory in the system.

Usually, kswapd is woken up when all eligible nodes in an allocation
are full. But the code related to watermark boosting can wake kswapd
on one full node while the other one is mostly empty. This may be
justified to fight fragmentation, but is currently unconditionally
done whether watermark boosting is occurring or not.

In our case, many of our workloads' throughput scales with available
memory, and pure utilization is a more tangible concern than trends
around longer-term fragmentation. As a result we generally disable
watermark boosting.

Wake kswapd only woken when watermark boosting is requested.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e74ca22baaa1..4f9d9f7e910c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2470,12 +2470,12 @@ static bool can_steal_fallback(unsigned int order, int start_mt)
 	return false;
 }
 
-static inline void boost_watermark(struct zone *zone)
+static inline bool boost_watermark(struct zone *zone)
 {
 	unsigned long max_boost;
 
 	if (!watermark_boost_factor)
-		return;
+		return false;
 	/*
 	 * Don't bother in zones that are unlikely to produce results.
 	 * On small machines, including kdump capture kernels running
@@ -2483,7 +2483,7 @@ static inline void boost_watermark(struct zone *zone)
 	 * memory situation immediately.
 	 */
 	if ((pageblock_nr_pages * 4) > zone_managed_pages(zone))
-		return;
+		return false;
 
 	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
 			watermark_boost_factor, 10000);
@@ -2497,12 +2497,14 @@ static inline void boost_watermark(struct zone *zone)
 	 * boosted watermark resulting in a hang.
 	 */
 	if (!max_boost)
-		return;
+		return false;
 
 	max_boost = max(pageblock_nr_pages, max_boost);
 
 	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,
 		max_boost);
+
+	return true;
 }
 
 /*
@@ -2540,8 +2542,7 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 	 * likelihood of future fallbacks. Wake kswapd now as the node
 	 * may be balanced overall and kswapd will not wake naturally.
 	 */
-	boost_watermark(zone);
-	if (alloc_flags & ALLOC_KSWAPD)
+	if (boost_watermark(zone) && (alloc_flags & ALLOC_KSWAPD))
 		set_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
 
 	/* We are not allowed to try stealing from the whole block */
-- 
2.28.0


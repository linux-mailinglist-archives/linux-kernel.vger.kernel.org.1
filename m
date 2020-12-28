Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB402E3B46
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 14:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405803AbgL1NsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:48:10 -0500
Received: from m12-14.163.com ([220.181.12.14]:33038 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405782AbgL1NsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Hn8Wvp/QsUvRFZb55Z
        p4Gj1oHIPv40h++nyJtbG3Wbw=; b=WlfOgH+7nMPdrgRrTMBVBVyr7GCFOkJOGB
        nexkvEtwQ0vrEpTEHCxrkyCDZ7kVKWXsHSxRc0wTs/yaKu3Wn0c/AYp+Ibtbqfg+
        p1Ns4mFwk15xo2/2QQp8DcIWFRtRcQuVkUBNKsS55F0msAJ56KKaHdxYUbMZ++fX
        Rk6H1ozvQ=
Received: from localhost.localdomain (unknown [117.139.251.214])
        by smtp10 (Coremail) with SMTP id DsCowACHnjLK3elfVAIXdQ--.31837S2;
        Mon, 28 Dec 2020 21:29:47 +0800 (CST)
From:   Hailong liu <carver4lio@163.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        liu.hailong6@zte.com.cn
Subject: [PATCH] mm/page_alloc:add a missing mm_page_alloc_zone_locked tracepoint
Date:   Mon, 28 Dec 2020 21:29:01 +0800
Message-Id: <20201228132901.41523-1-carver4lio@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DsCowACHnjLK3elfVAIXdQ--.31837S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw1rKFy3Wr1xWF18tw1DJrb_yoWDZwb_ua
        1Svr1fKrsxKry7uF13C3WfJFyftw4rur1xJr4FgFnxta48trnaqa1UJ3Z3WrW8XF17uFWU
        G34DZ3y7J342gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnOVy7UUUUU==
X-Originating-IP: [117.139.251.214]
X-CM-SenderInfo: xfdu4v3uuox0i6rwjhhfrp/xtbBogsJnVaD+OLJ-gAAsF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong liu <liu.hailong6@zte.com.cn>

The trace point *trace_mm_page_alloc_zone_locked()* in __rmqueue() does not
currently cover all branches. Add the missing tracepoint and check the page
before do that.

Signed-off-by: Hailong liu <liu.hailong6@zte.com.cn>
---
 mm/page_alloc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7a2c89b21115..8cfa58bcf21a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2871,7 +2871,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 	    zone_page_state(zone, NR_FREE_PAGES) / 2) {
 		page = __rmqueue_cma_fallback(zone, order);
 		if (page)
-			return page;
+			goto out;
 	}
 #endif
 retry:
@@ -2884,8 +2884,9 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 								alloc_flags))
 			goto retry;
 	}
-
-	trace_mm_page_alloc_zone_locked(page, order, migratetype);
+out:
+	if (page)
+		trace_mm_page_alloc_zone_locked(page, order, migratetype);
 	return page;
 }
 
-- 
2.17.1



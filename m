Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919782B4608
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgKPOln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:41:43 -0500
Received: from m12-15.163.com ([220.181.12.15]:40173 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgKPOln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=TW24U
        61+H3s62LaaCwaMn+eQvhUmC8wBlcrQhJZp8w0=; b=b1amDDC35moQmF/MIi4J9
        GtAbOGGd1gElbKHPz/PjLQjwJdG3His/3uDP5ZNnFN/NWlNWtNZ4kKH7+l6kkUiQ
        XmlKz/woHCTl89Y4uJTwLviVz0iGQdLWVzmM4ZQHTFNpxnM1L/8Knd8OPiu5vOoq
        mHDEz33RHE5e9uVd1p5erM=
Received: from localhost (unknown [101.86.213.176])
        by smtp11 (Coremail) with SMTP id D8CowACH8DGRj7Jfo7uxBQ--.37360S2;
        Mon, 16 Nov 2020 22:41:21 +0800 (CST)
Date:   Mon, 16 Nov 2020 22:41:21 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] mm/compaction: move compaction_suitable's comment to right
 place
Message-ID: <20201116144121.GA385717@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: D8CowACH8DGRj7Jfo7uxBQ--.37360S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr4fGr13CFyktFyDXFWfuFg_yoW8Wr4Dpr
        1093yDJw1FqF13CrW0yF10q3W5Kr4xKFyUJw1kKw1kXw1Yk3Z2q3WktFyUCFyUX34ayr4j
        qFWF9Fy5tFsrAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UveHkUUUUU=
X-Originating-IP: [101.86.213.176]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiORHeX1XlvdzQwAAAso
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 837d026d560c ("mm/compaction: more
trace to understand when/why compaction start/finish"),
the comment place is not suitable.

So move compaction_suitable's comment to right place.

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/compaction.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 13cb7a961b31..8bfd6e089511 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2070,13 +2070,6 @@ static enum compact_result compact_finished(struct compact_control *cc)
 	return ret;
 }
 
-/*
- * compaction_suitable: Is this suitable to run compaction on this zone now?
- * Returns
- *   COMPACT_SKIPPED  - If there are too few free pages for compaction
- *   COMPACT_SUCCESS  - If the allocation would succeed without compaction
- *   COMPACT_CONTINUE - If compaction should run now
- */
 static enum compact_result __compaction_suitable(struct zone *zone, int order,
 					unsigned int alloc_flags,
 					int highest_zoneidx,
@@ -2120,6 +2113,13 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
 	return COMPACT_CONTINUE;
 }
 
+/*
+ * compaction_suitable: Is this suitable to run compaction on this zone now?
+ * Returns
+ *   COMPACT_SKIPPED  - If there are too few free pages for compaction
+ *   COMPACT_SUCCESS  - If the allocation would succeed without compaction
+ *   COMPACT_CONTINUE - If compaction should run now
+ */
 enum compact_result compaction_suitable(struct zone *zone, int order,
 					unsigned int alloc_flags,
 					int highest_zoneidx)
-- 
2.29.0



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7D91FAB24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 10:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgFPI1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 04:27:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:49358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgFPI1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:27:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1F720AE2B;
        Tue, 16 Jun 2020 08:27:15 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     vbabka@suse.cz
Cc:     akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        liwang@redhat.com, mgorman@techsingularity.net
Subject: [PATCH 2/2] mm, page_alloc: use unlikely() in task_capc()
Date:   Tue, 16 Jun 2020 10:26:49 +0200
Message-Id: <20200616082649.27173-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616082649.27173-1-vbabka@suse.cz>
References: <b17acf5b-5e8a-3edf-5a64-603bf6177312@suse.cz>
 <20200616082649.27173-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh noted that task_capc() could use unlikely(), as most of the time there is
no capture in progress and we are in page freeing hot path. Indeed adding
unlikely() redirects produces assembly that better matches the assumption and
moves all the tests away from the hot path.

I have also noticed that we don't need to test for cc->direct_compaction as the
only place we set current->task_capture is compact_zone_order() which also
always sets cc->direct_compaction true.

Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48eb0f1410d4..8a4e342d7e8f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -813,11 +813,10 @@ static inline struct capture_control *task_capc(struct zone *zone)
 {
 	struct capture_control *capc = current->capture_control;
 
-	return capc &&
+	return unlikely(capc &&
 		!(current->flags & PF_KTHREAD) &&
 		!capc->page &&
-		capc->cc->zone == zone &&
-		capc->cc->direct_compaction ? capc : NULL;
+		capc->cc->zone == zone) ? capc : NULL;
 }
 
 static inline bool
-- 
2.27.0


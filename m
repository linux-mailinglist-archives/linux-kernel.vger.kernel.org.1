Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80FD2CDB25
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbgLCQXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgLCQXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:23:40 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A33C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:23:00 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f17so1695018pge.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 08:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBYfpG4YLx+bPEVhdMCEtM/1Z5BJXzgEmATHplf72ms=;
        b=OQ3F4Pvyn0v5hFBCX4+xk0ra4wITd692JiulhGTnKo6dLHNpMAa9Lbww/pZf9f+nao
         +UyVMh9ETgDfp89UiwEv0j7oYGloR6TvGERk+PDDSy07/obSU5r+EksUs/fYEifMhC1z
         WTXpblLnP3JHfbWb/Dh9aUFjMUKRsb45Z0u+NifhOLShl6Mfw60WFKr+YjIatVLf4Nsj
         3DG0VWr89J3s5CauJ8ga3WpUz5L/KPpRPfCLfqt6QCWbeXvEmLIfgijmLg/vdEsySkLf
         P3uXY8VCPtAiIboXtYz2eZhfHns0ucLFFoHSOTzfNkq1ywmtX26MGfUCGrey8o55UocY
         lf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBYfpG4YLx+bPEVhdMCEtM/1Z5BJXzgEmATHplf72ms=;
        b=dlP8am+eQX9H6GJFSMCpCEsXTQr0DASd2PcxxcAfw0DmST/niWoUZnwnj8fm/5SV44
         AQtX6W4mWac/rQP1aHq0kUCRuohqkTvphvPDPWySqx/oR/7pOXkEjg2iDC/b8QAOJskj
         W4yzQ345QspJUdr627QVLG5+tfnmd+huB00ZiMaMaRVXQG4Oye5dIF3xMV16UQKBrBFg
         TUCgGR8fcx3Altxu3MPU/+PMAvwUNjZjMJOa5KMC1jwH9YagdGnE8lEH80BN4ddiUA1W
         J1PPpOAgFuAutatytkEw9a68MOuEvRoh+3zCXu0h+5p3niV7plWZOuBH8xyRwwon7gP7
         pSJw==
X-Gm-Message-State: AOAM533fl/ToS6oV6yi/VdaYmDUTc3aAbgPCgYMO7CVilgD9MzLJAtET
        Q57riHGhZ3GxsiyknlZomEG2kw==
X-Google-Smtp-Source: ABdhPJxL6sIIXBJTQoJVVOD/yVtcARo1F14xpNwxRqBHV3kxUe3mpX7mwzCv43YbLpmc+wPf2Va97w==
X-Received: by 2002:a63:982:: with SMTP id 124mr3677673pgj.280.1607012579786;
        Thu, 03 Dec 2020 08:22:59 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.220.106])
        by smtp.gmail.com with ESMTPSA id fv22sm1999614pjb.14.2020.12.03.08.22.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 08:22:58 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2] mm/page_isolation: do not isolate the max order page
Date:   Fri,  4 Dec 2020 00:22:37 +0800
Message-Id: <20201203162237.21885-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max order page has no buddy page and never merge to other order.
So isolating and then freeing it is pointless. And if order == MAX_ORDER
- 1, then the buddy can actually be a !pfn_valid() in some corner case?
pfn_valid_within(buddy_pfn) that follows would only catch it on archs
with holes in zone. Then is_migrate_isolate_page(buddy) might access an
invalid buddy. So this is also a bug fix.

Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
Changes in v2:
 - Add Fixes tag in the commit log.

 mm/page_isolation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index a254e1f370a3..bddf788f45bf 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -88,7 +88,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
 	 */
 	if (PageBuddy(page)) {
 		order = buddy_order(page);
-		if (order >= pageblock_order) {
+		if (order >= pageblock_order && order < MAX_ORDER - 1) {
 			pfn = page_to_pfn(page);
 			buddy_pfn = __find_buddy_pfn(pfn, order);
 			buddy = page + (buddy_pfn - pfn);
-- 
2.11.0


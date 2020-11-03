Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306A02A8865
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbgKEUxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732120AbgKEUxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:53:44 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242CBC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 12:53:44 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id r10so2172764pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 12:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QB12Dnq0Zqx+BHwKjUtFB3CjUxaGHX59xb2vUzz59zw=;
        b=nDFSc5E0ytVh5sWwE+6Z7ZN80uS6oRNCypDUlbFYAm77DAooRLVaQOVIh35SBU8tc/
         DnRlZPcsuryFvi+aWJkcU4sMZO9UnOkDPh0Ju5YdzaxZOBOQs5IyT+m951zdA3Z6/8W7
         rSEB5hRQGxQF8aRwKlBnixUhE5e2nKAdnGMlS2EZwOnxARgpVsA/cWXDKsz/l+QdTU1G
         VUNLndDxC9jB40ulu4gOTrRDJ33XYWuCCxCXl9haCnm45m5Tsx0lFaRu8zi9e4pOiGYY
         J2GesAbE5cLRq1osjCMJq/9aayz5A7lIMMXPoO9z6/ZuZtIeQeKKJuRSecjeR52570Ts
         o0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QB12Dnq0Zqx+BHwKjUtFB3CjUxaGHX59xb2vUzz59zw=;
        b=PJ3qVpH/MwqMX5+D8DZ7c3y7JsaF9iNDfv26E6aEwInuZZWdpTMFaTJBw3lYZqDYxy
         zakG1/lJWYa/t9z9pqKnsqjH5VILXzX/6uV1O1YIwRkf3dCkIwjB9VZq8jgoMYCtfKmd
         apfkiPVF2TwBOvqJ6ukaJmbbXRFAb019uFmeIW2p1SUj+dLDsR+w6sJGIXIkT2/1VUIW
         xXv27IoHbodriaAewzDWFwcw1XYHLcT3HDUQh4T823vMMW5PETtuWmNngvPAgy47X8oI
         3d2hS2YUvY6hT99KqOkFCqY4Sdr51mnmTT1ojzE8/kILTNlYpk1HPEONtBpFg9B9luuM
         fuAw==
X-Gm-Message-State: AOAM53118lhrdJ3QvAtlZVJKN+Ulq0xQqHUgiPe2yvPYpiNRebrReTmd
        zPzUPWxdNMO4bPFbvqRr3i4=
X-Google-Smtp-Source: ABdhPJz40G2S/CGCQtwBbJtpMNoorkNydyinaIkS/Ezn6FTP4Z1u1hRFVNX+FpEDhrGeYK6RFe72sQ==
X-Received: by 2002:a17:90a:a394:: with SMTP id x20mr4135807pjp.213.1604609623788;
        Thu, 05 Nov 2020 12:53:43 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id u22sm3265528pgf.24.2020.11.05.12.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 12:53:42 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] mm: truncate_complete_page is not existed anymore
Date:   Tue,  3 Nov 2020 05:03:30 -0800
Message-Id: <20201103130334.13468-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103130334.13468-1-shy828301@gmail.com>
References: <20201103130334.13468-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 9f4e41f4717832e34cca153ced62b4a1d7e26c0e ("mm: refactor
truncate_complete_page()") refactored truncate_complete_page(), and it
is not existed anymore, correct the comment in vmscan and migrate to avoid
confusion.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 2 +-
 mm/vmscan.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 5ca5842df5db..8a2e7e19e27b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1106,7 +1106,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	 * and treated as swapcache but it has no rmap yet.
 	 * Calling try_to_unmap() against a page->mapping==NULL page will
 	 * trigger a BUG.  So handle it here.
-	 * 2. An orphaned page (see truncate_complete_page) might have
+	 * 2. An orphaned page (see truncate_cleanup_page) might have
 	 * fs-private metadata. The page can be picked up due to memory
 	 * offlining.  Everywhere else except page reclaim, the page is
 	 * invisible to the vm, so the page can not be migrated.  So try to
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1b8f0e059767..165cca87edc8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1393,7 +1393,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		 *
 		 * Rarely, pages can have buffers and no ->mapping.  These are
 		 * the pages which were not successfully invalidated in
-		 * truncate_complete_page().  We try to drop those buffers here
+		 * truncate_cleanup_page().  We try to drop those buffers here
 		 * and if that worked, and the page is no longer mapped into
 		 * process address space (page_count == 1) it can be freed.
 		 * Otherwise, leave the page on the LRU so it is swappable.
-- 
2.26.2


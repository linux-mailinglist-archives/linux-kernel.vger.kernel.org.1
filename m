Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43782ADDE6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbgKJSNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731052AbgKJSND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:13:03 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BC5C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:13:03 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id i26so10919149pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/nTuHNenKI3mByfAmKMfGl5XsKGSrafuSBjeTgSoyg=;
        b=IW9ttFO9e6hx5dU8vtwmKHMgFGrf2wc3Frkmon8dAAoTdHNJrxrbbKScyAWE2e0mJ1
         EU8pheNXLzIIXe/ThlR0xFVbs1CRK6da4/qT1Dp0s8rh8wQxmpVlT9PArNT4BWjgIC6x
         NIeTwBU14tyFWpC/jpaNg9IVixusJptWjug2HO+amO8SVLsdNEvBMJBPKdChz4Av9R58
         9Hh/VZi8t8dhuBOoqLw7Va3nnLdWO0Edh6Z/NP1bXUit5fXAnM+WjrXd0ndYaIsm+l32
         QsyOufxigN1PzwbTcA7+7aI6RtSh6ZtemNcE1ZYen8cJ9R/rEkb2ELWHt+YNq+zvwMCA
         pPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/nTuHNenKI3mByfAmKMfGl5XsKGSrafuSBjeTgSoyg=;
        b=SC2ixPLw6PrDCEIAK7ZlnfWvkSh1b8BhoBEnVMtdzCbgpA3nSxC6kugVdT6l1gWQwe
         WEaqOLNxxEQTdyQNHl+oVGMwAIs1CW1mquznVoPLm3C+RfarQ1kWN+1QF6txvA0N05y+
         pvl9L399EpZ68XBHLTu41hJZnydPUburinrDZI9Z3GDZwqAsUEm4UOE1yLYYvg34SCLE
         ixzXid98mYOlZNJ+tpz9vC2qnbmtEId0Jqu3JV4IN59qGIFo1TY2+oPUo/Og8l9PvMv0
         jlh1ntMy35c9gfTspE+Nt8e0E465AXXJLYN6JuP8etvLpn+mczNnEJrmak9viBten3eG
         DPaQ==
X-Gm-Message-State: AOAM531gEanASIwuPIRe8GmcSlDJDyvQ3ja8lR4VA7hoaUT1sFq/R8B7
        9F7AzEnY7+vZx6TWjhqv9qI=
X-Google-Smtp-Source: ABdhPJzDLli+GB2R9J7uCGeYP1eOQbrUR08X6qU11SHG9RToER/J/I4Lnn3AhnuoDAntaaaywb0yOg==
X-Received: by 2002:a17:90a:67c5:: with SMTP id g5mr368182pjm.13.1605031983399;
        Tue, 10 Nov 2020 10:13:03 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id k5sm4157369pjj.37.2020.11.10.10.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:13:02 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 1/5] mm: truncate_complete_page is not existed anymore
Date:   Tue, 10 Nov 2020 10:12:46 -0800
Message-Id: <20201110181250.264394-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201110181250.264394-1-shy828301@gmail.com>
References: <20201110181250.264394-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 9f4e41f4717832e34cca153ced62b4a1d7e26c0e ("mm: refactor
truncate_complete_page()") refactored truncate_complete_page(), and it
is not existed anymore, correct the comment in vmscan and migrate to avoid
confusion.

Reviewed-by: Jan Kara <jack@suse.cz>
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


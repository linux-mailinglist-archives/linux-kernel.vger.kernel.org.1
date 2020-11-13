Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877F72B25F2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgKMUyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgKMUyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:54:13 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40C1C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:54:12 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id z3so8626448pfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/nTuHNenKI3mByfAmKMfGl5XsKGSrafuSBjeTgSoyg=;
        b=Xr05ke3tOLLPVl+BARViF3JhHDLwIb2OSdP08973SloTne2Xdl9b6A/CEO2/0PtwjY
         QfC+jBjv9t8T6d/GMJkQKwZoCWsVG++8MfuKIKDEr4QabdG3bIVs3roI57YNjGuKvjYF
         eonqGSJzOkPTgHMFl5JsrVgiE8E2JWnJ7TruDimoJf50MxhE0TZntcotn3022aXm0beI
         /KN/+F4e1fuuHRk/M2yMf96VINJs+pKIe4Xilxk2pXtf6xRhSrc7z4g9nuz6RBccoq8d
         Qv6fVGIy64mUGkrpxGYhyYXmFPjsFULgi3wpol3+S2ajz4X7PLE/XhSfP7JiTBIiMyUM
         ZJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/nTuHNenKI3mByfAmKMfGl5XsKGSrafuSBjeTgSoyg=;
        b=eBcAHGk5/YTQXqDGbFcgsvnZLYFTiunr46O4BdRi4db/VL/kG59dSmTOuP5vWgnREg
         HvHtCrY+3p1pmZpN1vBV3vBamTTNtJlCT4NZUX5DS4HDq+qw9piKn3ACtIh4BHlzsa8X
         L+plScUoo7+2cyLS8KMzRLUNUu2jGuvmga75OlXXNUblf/Ua/yJ+OML6LWkDTQHDNquP
         uq7GpCyEMHnnPXKESMk/k2rNe+/7l7Nfn5zJvwUjsCspVPB2ybGD400EEjc+sspziW1O
         FEJrc0KQzBx9gsMzrwGTufvhHE/dKaSduJIXunBlFPG8OKZ0ZF/mbC2oH7E1jWT/1CL3
         1t+A==
X-Gm-Message-State: AOAM533pyo7RRJslntsb5gbm9VwvaUv5e8X/6hiRhPZWhS8HFFuIIURY
        Ke/rHVOfrZhVavVeXhltr8Q=
X-Google-Smtp-Source: ABdhPJyMe77z4yunKaYCWv6Bp8CSJ31Rk1HAnMM/wc13YFGNMjfkEwpOonLXqdLdp3hzCGklAA8p9g==
X-Received: by 2002:a17:90b:3512:: with SMTP id ls18mr5167558pjb.70.1605300852525;
        Fri, 13 Nov 2020 12:54:12 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id a18sm3780234pfa.151.2020.11.13.12.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 12:54:11 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, willy@infradead.org,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 1/5] mm: truncate_complete_page is not existed anymore
Date:   Fri, 13 Nov 2020 12:53:55 -0800
Message-Id: <20201113205359.556831-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201113205359.556831-1-shy828301@gmail.com>
References: <20201113205359.556831-1-shy828301@gmail.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8871D2CD4AC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 12:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgLCLgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 06:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgLCLgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 06:36:49 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C05C061A4D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 03:36:08 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id p6so996181plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 03:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=wqd6B3MGg9FU3pSe+TUt1wCgmmcknZUopdwCUSxaGrw=;
        b=guM1o5Y6XAw7IphxI5qXSTe0jGqIc10MncBmcXcjxH8b1fRlicsuQdbzOwICJHy+Bi
         aEcJM8QxU0srioGSh9WB8pliTssXUkmNcrvZ45yZaMwas12tKu/0d5hdf7gwH3Rh0KjQ
         hakt7IjgtSc9hs2vfAvbf88qSQFdUv9eLT23WOysdX+Or9kmNf08ikGr9//0EQcTkAaZ
         MR3yFv+JroEaox/qJnWcO1yVOIKFoZvLq6SqfFDjBpxTiLdQyqWBkOPAX/0v48rvinEn
         Fvq2RM+/PXwyZYrWys7rPAEw0nCrR593R9inQsNOrwttWkFbA+jnHPUz05HAzLsStO69
         a9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=wqd6B3MGg9FU3pSe+TUt1wCgmmcknZUopdwCUSxaGrw=;
        b=hnmKbsyzGQGListn0E+v6fa61zyhk0dGYLcmxgny2a23V5WtDi/ssbRaprZG477707
         X8yMa383Br+/wQd0/g7MoOWPepTIKvcWXEHijl+WuoHGrmEpO0SE6zHnV9R0jUXLzMQd
         vkHkIHexu0xnCf/nJKgdyXUbX7G35sxZVnnxLp9g99rmaX5E3asLycMOs0CqSrtEffuo
         m87vnE8baLRmlP+rs9O3GWettyC/smCFP7VhgjMupWgCw0IUo6a1tDNpGRMvrW7PpE0u
         aft9sQzAJMa3PHKpa9JtLxg2wM68OkKuJQQ2dXtllppPZc+1+gfc2F6woD85NGD9SAzw
         /TJg==
X-Gm-Message-State: AOAM53092k64kLKA3fgG2Q/NqLWOIEBiJR4iATvyGGRhdXNJ3vIL+I4R
        9k3DwIVUY3FmHV7LAwL7DZ4hD5Mku/8=
X-Google-Smtp-Source: ABdhPJx46Y2bHQRP5Q9sMsDoVEb7XeWcubw21qfiGoH8CWJMxbcrxY9HCu1UGQ0LqNWsBHsLSk2BZQ==
X-Received: by 2002:a17:902:b28a:b029:da:725c:14db with SMTP id u10-20020a170902b28ab02900da725c14dbmr2683231plr.72.1606995368488;
        Thu, 03 Dec 2020 03:36:08 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y25sm1554665pfn.44.2020.12.03.03.36.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 03:36:07 -0800 (PST)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
X-Google-Original-From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
To:     Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: fix a race on nr_swap_pages
Date:   Thu,  3 Dec 2020 19:36:02 +0800
Message-Id: <1606995362-16413-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scenario on which "Free swap -4kB" happens in my system, which is caused by
 get_swap_page_of_type or get_swap_pages racing with show_mem. Remove the race
 here.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/swapfile.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index cf63b5f..13201b6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -974,6 +974,8 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 	/* Only single cluster request supported */
 	WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
 
+	spin_lock(&swap_avail_lock);
+
 	avail_pgs = atomic_long_read(&nr_swap_pages) / size;
 	if (avail_pgs <= 0)
 		goto noswap;
@@ -986,8 +988,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 
 	atomic_long_sub(n_goal * size, &nr_swap_pages);
 
-	spin_lock(&swap_avail_lock);
-
 start_over:
 	node = numa_node_id();
 	plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
@@ -1061,14 +1061,13 @@ swp_entry_t get_swap_page_of_type(int type)
 
 	spin_lock(&si->lock);
 	if (si->flags & SWP_WRITEOK) {
-		atomic_long_dec(&nr_swap_pages);
 		/* This is called for allocating swap entry, not cache */
 		offset = scan_swap_map(si, 1);
 		if (offset) {
+			atomic_long_dec(&nr_swap_pages);
 			spin_unlock(&si->lock);
 			return swp_entry(type, offset);
 		}
-		atomic_long_inc(&nr_swap_pages);
 	}
 	spin_unlock(&si->lock);
 fail:
-- 
1.9.1


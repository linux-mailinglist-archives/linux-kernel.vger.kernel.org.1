Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BEF2CE5F8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgLDCxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgLDCxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:53:08 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB28C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 18:52:27 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t18so2320941plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 18:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=9yoTAkzlTrHVucyW+2c6nj5iiSRSPcc39rk34imqDjQ=;
        b=dpssYGWzzQYoAO6rwOZaXRmG3s21o5XP8gnSgw2V4/CygNQCn8nAzlNEnWDIaxygUd
         I16d0KpdxLtIXgdqTHdbfgeQoD1RxFLAf59+s8vH1Y2d2KVLjbNqFcGnmdCoCM0T/qR3
         eNO7nOjx8AjjyWqCdPthIPKIRZPUj/gFN/2+dC7lw7wzWYBN7tAd5ksiC3wwliNfW2kZ
         7evMS9DTmjq5bC4SaHTAOlo/VHNkjOcNQAg1dD/QoSl3qtqOLwOr58/vbL9XSBYHri2I
         b5Xd8Z2pRR9H2z50kyjMb7zWVLY7YsQPf4WSPXIzVTdks8+E4EgbDI93U7qWhjk3rJ/3
         Oh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=9yoTAkzlTrHVucyW+2c6nj5iiSRSPcc39rk34imqDjQ=;
        b=Yat+PKU5hUi4oG3yeTvmkAAst0tdX/QNGKuUWm5GnuclY06aLmYaxEfWYK1HpyYxai
         BDgaoW/MsZwLVjsLxBBZG62/sy+LGf+Hl4AH1jk05U/fhPSJ+eirotalHuogaSvV279E
         p0qNkLrWOdHGDwqaBH9veNdN9DTvmyo5QHrpI+++6+X7J144MtFkc0N+erghSqJVTe9d
         MY3mWSHBWhdauaH5dDKVZN7I5xBXMkzkhBLbZPlKsrTedyD48+YVOsq5oLYoT/lJ6Ejx
         IbL+/z3/FPT92jAoBsFL+9UrjbCtsKGBoMVJWX/TNlFoU0UPKjWkIbYENuA5rRp373J6
         9MGw==
X-Gm-Message-State: AOAM5338Qp9t5iSoUYhgPh5gC6/QL6q4Kj64zt/qGBPuXaqJlXbF7mbp
        j5s75IzLiQCP6Bw50y8/gF4bsm87ySs=
X-Google-Smtp-Source: ABdhPJyDW/IMuaTHv4k8S/2xfuDKsJyQYf5NNZE+ECk2HqemCduDyBwiZY7gid6ffPfhTDfitsYb/A==
X-Received: by 2002:a17:90a:2b0b:: with SMTP id x11mr2052721pjc.65.1607050347603;
        Thu, 03 Dec 2020 18:52:27 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e14sm2156455pgv.64.2020.12.03.18.52.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 18:52:27 -0800 (PST)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
X-Google-Original-From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
To:     Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: fix a race on nr_swap_pages
Date:   Fri,  4 Dec 2020 10:52:20 +0800
Message-Id: <1607050340-4535-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scenario on which "Free swap = -4kB" happens in my system, which is caused
by several get_swap_pages racing with each other and show_swap_cache_info
happens simutaniously. No need to add a lock on get_swap_page_of_type as we
remove "Presub/PosAdd" here.

ProcessA			ProcessB			ProcessC
ngoals = 1			ngoals = 1
avail = nr_swap_pages(1)	avail = nr_swap_pages(1)
nr_swap_pages(1) -= ngoals
				nr_swap_pages(0) -= ngoals
								nr_swap_pages = -1

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
change of v2: fix bug of unpaired of spin_lock
---
---
 mm/swapfile.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index cf63b5f..1212f17 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -974,9 +974,13 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 	/* Only single cluster request supported */
 	WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
 
+	spin_lock(&swap_avail_lock);
+
 	avail_pgs = atomic_long_read(&nr_swap_pages) / size;
-	if (avail_pgs <= 0)
+	if (avail_pgs <= 0) {
+		spin_unlock(&swap_avail_lock);
 		goto noswap;
+	}
 
 	if (n_goal > SWAP_BATCH)
 		n_goal = SWAP_BATCH;
@@ -986,8 +990,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 
 	atomic_long_sub(n_goal * size, &nr_swap_pages);
 
-	spin_lock(&swap_avail_lock);
-
 start_over:
 	node = numa_node_id();
 	plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
@@ -1061,14 +1063,13 @@ swp_entry_t get_swap_page_of_type(int type)
 
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


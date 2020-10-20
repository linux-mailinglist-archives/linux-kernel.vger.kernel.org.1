Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF112831B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgJEIOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:14:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57856 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJEIOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:14:31 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kPLdc-0001Hm-Na
        for linux-kernel@vger.kernel.org; Mon, 05 Oct 2020 08:14:28 +0000
Received: by mail-wm1-f71.google.com with SMTP id v14so537038wmj.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 01:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YOOKKc/NsxErESy/u7hg3zhXpqetp++Zy7NLfv5ic88=;
        b=DB3LXbd8ZWXMlgAT25oGlfnhmtfsUKM9efPxvL69zVXUWlYGajxLhJrqSzLOo3B6xR
         e3EL+wpWJHy/HvEp9jyYsNbkHHeHYgbocgq7N5y727dcQ1AbSiL+peWhH2gi82Omr7mD
         bbDB6CUNHHhB5Ibs1CJ/cDYNQyzhASbg7YIqLYlvgD2ILWmlAfpSXqIteqQtmRgjMTLm
         iiWk4Vsjyjc0VOce+jIFNYh29Uu6RUQKf3kd4pWBJPdMevDK0ds9aouYn1EkpnxDkVSv
         XB4x17RchJMINhQxzsaWXtrHvYspcX0Fo+pZzieWP98EYTevxq8+hVv/750QlsDQYYCn
         nxfQ==
X-Gm-Message-State: AOAM533kiok/KpJjUtDlK7maCzohQOZEhypsHg8bNvyS79E4Y+vuHC1b
        t2m+lJ73eWZ7Gz09xi5R4gVuLZsmf6/B7OvnXybJvoCWT1Hex4a83rHWyRLbE7BvVBEg7sHcTDh
        tQpxLdWzugYob+IKqMsG5J7KhVau+262lLImt4ycBvA==
X-Received: by 2002:a5d:67d0:: with SMTP id n16mr17497454wrw.198.1601885668391;
        Mon, 05 Oct 2020 01:14:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtKOpH0FCV6s7xth+z5GIgfZ6KMfLvYYR4CHJf3bHlkFzgc8Y/X0OX+gbrjhuJR5dAK1ORUw==
X-Received: by 2002:a5d:67d0:: with SMTP id n16mr17497429wrw.198.1601885668147;
        Mon, 05 Oct 2020 01:14:28 -0700 (PDT)
Received: from xps-13-7390.homenet.telecomitalia.it (host-79-36-133-218.retail.telecomitalia.it. [79.36.133.218])
        by smtp.gmail.com with ESMTPSA id a15sm13168855wrn.3.2020.10.05.01.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:14:27 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luigi Semenzato <semenzato@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH RFC v2 1/2] mm: memcontrol: make shrink_all_memory() memcg aware
Date:   Mon,  5 Oct 2020 10:13:12 +0200
Message-Id: <20201005081313.732745-2-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201005081313.732745-1-andrea.righi@canonical.com>
References: <20201005081313.732745-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to specify a memcg when calling shrink_all_memory() to reclaim
some memory from a specific cgroup.

Moreover, make shrink_all_memory() always available and do not depend on
having CONFIG_HIBERNATION enabled.

This is required by the opportunistic memory reclaim feature.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 include/linux/swap.h | 9 ++++++++-
 mm/vmscan.c          | 6 +++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 661046994db4..1490b09a6e6c 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -368,7 +368,14 @@ extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 						gfp_t gfp_mask, bool noswap,
 						pg_data_t *pgdat,
 						unsigned long *nr_scanned);
-extern unsigned long shrink_all_memory(unsigned long nr_pages);
+extern unsigned long
+__shrink_all_memory(unsigned long nr_pages, struct mem_cgroup *memcg);
+
+static inline unsigned long shrink_all_memory(unsigned long nr_pages)
+{
+	return __shrink_all_memory(nr_pages, NULL);
+}
+
 extern int vm_swappiness;
 extern int remove_mapping(struct address_space *mapping, struct page *page);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 466fc3144fff..ac04d5e16c42 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3986,7 +3986,6 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 	wake_up_interruptible(&pgdat->kswapd_wait);
 }
 
-#ifdef CONFIG_HIBERNATION
 /*
  * Try to free `nr_to_reclaim' of memory, system-wide, and return the number of
  * freed pages.
@@ -3995,7 +3994,8 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
  * LRU order by reclaiming preferentially
  * inactive > active > active referenced > active mapped
  */
-unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
+unsigned long
+__shrink_all_memory(unsigned long nr_to_reclaim, struct mem_cgroup *memcg)
 {
 	struct scan_control sc = {
 		.nr_to_reclaim = nr_to_reclaim,
@@ -4006,6 +4006,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 		.may_unmap = 1,
 		.may_swap = 1,
 		.hibernation_mode = 1,
+		.target_mem_cgroup = memcg,
 	};
 	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
 	unsigned long nr_reclaimed;
@@ -4023,7 +4024,6 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 
 	return nr_reclaimed;
 }
-#endif /* CONFIG_HIBERNATION */
 
 /*
  * This kswapd start function will be called by init and node-hot-add.
-- 
2.27.0


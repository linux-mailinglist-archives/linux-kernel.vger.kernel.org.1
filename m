Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E1B2D6F36
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 05:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405337AbgLKEZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 23:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395382AbgLKEYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 23:24:42 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D9EC0611CB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 20:23:39 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id x12so3495207plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 20:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQUFW73mdqeVNnWmOCUXrriPRd8OoQbYZkReps7lWmE=;
        b=IjskIXxMWCN/ytFBKw+DiAXxwBYCNKF8JYU6iVwQmlV4cOw6vNaY1P3GrQ1tyoaM9Y
         LGNX7hCXCHbchH5rP4RRe4V9p2J6KNK5d+n6pNqTcWLgaQl5e6zgcFFXn26pC5V98oKH
         ChD3XxNRpjpFKsRgxoWhrRl3CJzYll1nkGHxrs8VD5kbyoR5RDageIyV/Pdrr5APQ0Hm
         fD0x2O/ifiMYM1Ztriz5/eDvN9WjdQ6SYLXPN14x7R2j3v8AGb3gRuChTUYnqUWV0/pV
         KX51x3M9Zsv6f1MvSNxvn/1/c4Y4CM9Ne7pKYum2xNsYxOizOxI1ztLeDsH6gWgq/tEu
         EYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQUFW73mdqeVNnWmOCUXrriPRd8OoQbYZkReps7lWmE=;
        b=JSmRxuTxn6XvxZlaV2MMDfF+uRBmPQtzu7YNIxbz2YFE2lb46shdrgZQmQyW61PF2k
         4iHTqpIe3U7NlWCdktn6oY9OMFgLU0j0jRgDL6+uw9XZOmUn9uJApel8yNYE6h/qDjPE
         1q8G/4nNkg0a1XITeEPHdQJcKGT0fBBNDeDBJYxl4RRUioKbiMtPVijbw8NgcqEv6f8D
         V4TM27BqfzGRJhcU+DF0C12XYDHv3osVV0UxUG6cSQQaO5tNUwW6VyfvReBTdChCWwh1
         lKJ4ro6b6tKU6Vnang40+UI1OPxN93K6rFsQNzY4jRY+w40AHVLsz/qpoWs+O6c9IK5J
         diVQ==
X-Gm-Message-State: AOAM530YHCAfMRPSKmCxuxpPNA2rSFr77ipD3LQyN0uUf/HrMa7tTewn
        SUfiPE2n0rKXF38k0dO4ip0+jA==
X-Google-Smtp-Source: ABdhPJzeiQSfJfIhgFUu9W2wTkNi1XOhkEXOXCWkca4m+6vxOOnVMFAG744rfQkyKjRaEl4HhunhnQ==
X-Received: by 2002:a17:902:b213:b029:db:3a3e:d8ad with SMTP id t19-20020a170902b213b02900db3a3ed8admr9494640plr.73.1607660619419;
        Thu, 10 Dec 2020 20:23:39 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id 19sm8623352pfu.85.2020.12.10.20.23.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 20:23:38 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 5/7] mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
Date:   Fri, 11 Dec 2020 12:19:52 +0800
Message-Id: <20201211041954.79543-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201211041954.79543-1-songmuchun@bytedance.com>
References: <20201211041954.79543-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unit of NR_SHMEM_PMDMAPPED is HPAGE_PMD_NR. Convert NR_SHMEM_PMDMAPPED
account to pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    | 3 +--
 fs/proc/meminfo.c      | 2 +-
 include/linux/mmzone.h | 3 ++-
 mm/page_alloc.c        | 3 +--
 mm/rmap.c              | 6 ++++--
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 6d5ac6ffb6e1..7a66aefe4e46 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -463,8 +463,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     ,
 			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS)),
-			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
-				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
 			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED) *
 				    HPAGE_PMD_NR)
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index cfb107eaa3e6..c61f440570f9 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -133,7 +133,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "ShmemHugePages: ",
 		    global_node_page_state(NR_SHMEM_THPS));
 	show_val_kb(m, "ShmemPmdMapped: ",
-		    global_node_page_state(NR_SHMEM_PMDMAPPED) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_SHMEM_PMDMAPPED));
 	show_val_kb(m, "FileHugePages:  ",
 		    global_node_page_state(NR_FILE_THPS));
 	show_val_kb(m, "FilePmdMapped:  ",
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4f49af38dced..d6b13b9327be 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -217,7 +217,8 @@ static __always_inline bool vmstat_item_print_in_thp(enum node_stat_item item)
 {
 	return item == NR_ANON_THPS ||
 	       item == NR_FILE_THPS ||
-	       item == NR_SHMEM_THPS;
+	       item == NR_SHMEM_THPS ||
+	       item == NR_SHMEM_PMDMAPPED;
 }
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 720fb5a220b6..575fbfeea4b5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5578,8 +5578,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_SHMEM)),
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			K(node_page_state(pgdat, NR_SHMEM_THPS)),
-			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)
-					* HPAGE_PMD_NR),
+			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			K(node_page_state(pgdat, NR_ANON_THPS)),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
diff --git a/mm/rmap.c b/mm/rmap.c
index f59e92e26b61..3089ad6bf468 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1219,7 +1219,8 @@ void page_add_file_rmap(struct page *page, bool compound)
 		if (!atomic_inc_and_test(compound_mapcount_ptr(page)))
 			goto out;
 		if (PageSwapBacked(page))
-			__inc_node_page_state(page, NR_SHMEM_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
+						HPAGE_PMD_NR);
 		else
 			__inc_node_page_state(page, NR_FILE_PMDMAPPED);
 	} else {
@@ -1260,7 +1261,8 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
 			return;
 		if (PageSwapBacked(page))
-			__dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
+						-HPAGE_PMD_NR);
 		else
 			__dec_node_page_state(page, NR_FILE_PMDMAPPED);
 	} else {
-- 
2.11.0


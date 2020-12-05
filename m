Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABCF2CFD62
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgLEScY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbgLES3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:29:16 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AB5C09425E
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 05:03:52 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p21so5058685pjv.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 05:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FtP7qi7mK1L0PfFz3nd+UCw8YfODDif7rcyX5iGzCy0=;
        b=YBqE9JIpZZHp59F2B1fcdbYxWsPsKLsDcStvI6zVPyor7Qvy6DPn+rQUINr+d2lrr4
         xPUtcPPYHneb4wBbmPXr94aIzyBHQ7s06HpUtYiINlmoL0Z9oSXqzyz2b8usnRFtG8WX
         8/xIK4F8m/q/JyZxdQ+wzyn3+xrk1F/Nb8P5zcWAz2qcvUvsoLk4pRTF4PzYe0q9+/Sj
         OjpvPukcqXmtU7DA7WYe9o5kUelIpmxnRsnIt9T/Vk8LMUk2fsls8CUUTbcaClLy/AO7
         iTdJmEw8xWDYF82QC/sshrA+U9zeszVwAh8YxD682t9P0lFeQmroJ+4MTEjqGahXpBRV
         kqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FtP7qi7mK1L0PfFz3nd+UCw8YfODDif7rcyX5iGzCy0=;
        b=gA9z///DbGdPLkFFdFLRc+jWkSVfFSE2KuiAsopwUAe/viWAjF9B3g/rsWzFWyheut
         Hxyamx7K6/WRCLPGD9LMo/YXLw+Dg6DDK8sJvlrVddh5FmAk1wj12Bmmm9G8lYRcG+9I
         GYcnuF9BewHm5+mmTfibg2rTzNPD3K+hc8XB5BSpCn3h2Q2JHYNDZEx1xTJvaTLQyGZp
         H8fUnuKID1jBvopLd57qgzwpUlLY/yjsHLrPYwIy8inmjOIkn2FiVe2WiiK3oz1nTv0P
         nvzSFkYzbXhlWkz+JNtLA8l1l0TgIFZDHI25O4IyQD95FIQCz5jMcJwuiouMnfeCiXUq
         nSWQ==
X-Gm-Message-State: AOAM531SRj2wQ6MDU3FEeaN+F2V7Sokkmms3wD9gVDSl3KFZaYRC3NyD
        BgDNMgQbdlaHJyoF+hwPDVXhrg==
X-Google-Smtp-Source: ABdhPJxUntSBpIscnDoUmmMVMARNsl+XmN2HuKXM1HmNHVZCkOQBbP+bouFyJZkLYx+IaQCeb/ju+A==
X-Received: by 2002:a17:902:7297:b029:da:861e:eae1 with SMTP id d23-20020a1709027297b02900da861eeae1mr8308288pll.8.1607173431888;
        Sat, 05 Dec 2020 05:03:51 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id kb12sm5047790pjb.2.2020.12.05.05.03.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2020 05:03:51 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 8/9] mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
Date:   Sat,  5 Dec 2020 21:02:23 +0800
Message-Id: <20201205130224.81607-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201205130224.81607-1-songmuchun@bytedance.com>
References: <20201205130224.81607-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert NR_FILE_PMDMAPPED account to pages

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c | 3 +--
 fs/proc/meminfo.c   | 2 +-
 mm/rmap.c           | 6 ++++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index fe90888f90a8..679215cdeb87 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -465,8 +465,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
-			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED) *
-				    HPAGE_PMD_NR)
+			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED))
 #endif
 			    );
 	len += hugetlb_report_node_meminfo(buf, len, nid);
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index b2bff8359497..a0828df01721 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -137,7 +137,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "FileHugePages:  ",
 		    global_node_page_state(NR_FILE_THPS));
 	show_val_kb(m, "FilePmdMapped:  ",
-		    global_node_page_state(NR_FILE_PMDMAPPED) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_FILE_PMDMAPPED));
 #endif
 
 #ifdef CONFIG_CMA
diff --git a/mm/rmap.c b/mm/rmap.c
index 3089ad6bf468..e383c5619501 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1222,7 +1222,8 @@ void page_add_file_rmap(struct page *page, bool compound)
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
 						HPAGE_PMD_NR);
 		else
-			__inc_node_page_state(page, NR_FILE_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
+						HPAGE_PMD_NR);
 	} else {
 		if (PageTransCompound(page) && page_mapping(page)) {
 			VM_WARN_ON_ONCE(!PageLocked(page));
@@ -1264,7 +1265,8 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
 						-HPAGE_PMD_NR);
 		else
-			__dec_node_page_state(page, NR_FILE_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
+						-HPAGE_PMD_NR);
 	} else {
 		if (!atomic_add_negative(-1, &page->_mapcount))
 			return;
-- 
2.11.0


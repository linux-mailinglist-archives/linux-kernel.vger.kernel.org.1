Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A962D220A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgLHEWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgLHEWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:22:33 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D540C061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:21:36 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c12so5554605pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2/ZiqpsepZIKX1SS9g/oGWRoEH2RxsiZeFtxG7E1hY=;
        b=S8M0B/X4Ja/6hprP34VU2OQyUfKlylvqpIPM6XSSxRwqhRjKKLpZJOl0k6OEp+xaYM
         mZ2X4yVhKR6L/pN12zw2Kffg4h2R5TXsaSxK64AkNIV/pqAL2H6TDD3E3Uo9Gx68AhzA
         HutJNM4eV9CpjbgsgUvgPLLi7RszFvMHaOZU8sSio5P3BRJ8T7HRjO4OtanKlh9daBRX
         MoP/XcIJ6ymzAuMIQ0BcfLyS6eEw7pB2ttIGnhB+4WZVZC9vkxWdAdvKJvU+GC2sgr8B
         HfNcRSzFzYPba9SXniBut3LclEGo4j0FShH6TiKAk1eNJCFfKs6d6ZcuCSUwUgEAjO/L
         FYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2/ZiqpsepZIKX1SS9g/oGWRoEH2RxsiZeFtxG7E1hY=;
        b=a+/fSa6hUe9vXrgk8Svg0h5m/iSoUF40IGcsasfx34M2IlfQikb/QIaI0MkSBXQvES
         jDS6DRxA2zO/An8Pv4fqIeoCFbNZPEXvR9feRz8C1moHJ24lax2nhyiCyF7lTIn9BTQx
         QwSdLIJ210jtD4wjZaJMD56tqYzOCk4JRykQFjdJL0EmPStilDUPTobLtaVml0AiWE+y
         UMAfNHkIgk8NGmdyL0eE8fr+SpzLBRRh8CxFyaHHIxi+JOrV3jK7W+nnhFBDnHUoi+Ey
         pfhpKS7p+M3rEMF8GilxWEaUTEWwjYi0ZxPM/CqHAKmU+Ye8eudbs4tWhyNGbqfNoPE9
         b0Ug==
X-Gm-Message-State: AOAM53084/+L7jmasOGlDFi/UAnd0e7iInsivjR4l9gLRl9E5O3dOjqP
        RqO9dNJ7oT68Q0Z0tpe/WawLLA==
X-Google-Smtp-Source: ABdhPJymx+vIWOX3gvWNwXYz6IZpIemiL3RX0BEW6eUqRsqAvsi7ntancYcLOEluQuMi/s75zDV16g==
X-Received: by 2002:a62:5e81:0:b029:197:baa5:1792 with SMTP id s123-20020a625e810000b0290197baa51792mr18804110pfb.80.1607401295606;
        Mon, 07 Dec 2020 20:21:35 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id mr7sm1031166pjb.31.2020.12.07.20.21.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 20:21:35 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 6/7] mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
Date:   Tue,  8 Dec 2020 12:18:46 +0800
Message-Id: <20201208041847.72122-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201208041847.72122-1-songmuchun@bytedance.com>
References: <20201208041847.72122-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unit of NR_FILE_PMDMAPPED is HPAGE_PMD_NR. Convert NR_FILE_PMDMAPPED
account to pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c | 3 +--
 fs/proc/meminfo.c   | 2 +-
 mm/rmap.c           | 6 ++++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 45293084bb19..04505beca104 100644
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
index c61f440570f9..6fa761c9cc78 100644
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


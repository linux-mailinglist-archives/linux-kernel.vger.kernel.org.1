Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5C52B25F4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgKMUyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgKMUyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:54:20 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D98C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:54:20 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f27so8079542pgl.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1P7rD6yvIgCZ2SrjtB9V6g8Qq2F/GDvh/5dKEAS9Os=;
        b=hNK0lFKC6nrx+tBMO9lk+1vmT9F08322YNvttvN+TBDGtouldHpOscthUXqKDNVHVr
         39ysPpyqSm1lDQ93/cayV8KFIA+qKqhyRdhhTSxcUqi8co2gH/vwOPdp/zXd2QHwYUgH
         S/V1npOa1IuvYQLFjzpZ273DTPRBdw7njr6pv0MHUYyehwq9mgKYnoQFqPg8kEhX5z2f
         xYbo+wrPYW2GVrqIk4tv9pWoWTsDomBKvMFjQCEPZM+uRCPoXQizEPEPZxwIDl9lMzsO
         zu/3yGs1KR+vLxypceipMjRyW3flcp1OT4yC+sNZZGJtXwA6o9df/yUtjibB2CuSvKsC
         cugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1P7rD6yvIgCZ2SrjtB9V6g8Qq2F/GDvh/5dKEAS9Os=;
        b=l8BHpaxq3+RMOldACXzlOXa8WcJkP5oWFNun6FIRjyRo0lmEa6WEg8AeBqJcZPJpbo
         DilwtpGczQRuux1QpRj6G3mOTK8D70HEhK2s8FG9YuIV5pekScInKqRpDazI3tqkeZdP
         2Ly4WLxXoVqMNrwSHpyu/OhUSn81hQtk0j9gKLt/+zPdsfkprgA81RD7HX/WvcXU9B/g
         pdO048qDaRq+9fgd2LaF5VRq13w9R7cnIdi1GXxun0Hgrf4d8A4cUfGeWtDhE39s54oB
         549556GyRlWcXRXZFbBmZgJ5ruBQhuYN84aR7YFKPtaA59TBKVrYO6DGGaH954dBJyOJ
         ACzw==
X-Gm-Message-State: AOAM533sOiqsf7TgGBXzIMHzGHyIGFcf+F8DLhF1nANl00gDjGoBx4f0
        ID59hEKsCPsHETosi/rVhSipZCadt5hXMQ==
X-Google-Smtp-Source: ABdhPJyvFIGq1ULa6iDB24RGSIbicOzPOjE2He5AGIoNQnd8H5VxYQovwey2oBqWJlwIH2HJQi6RZw==
X-Received: by 2002:a63:f951:: with SMTP id q17mr3208392pgk.199.1605300860028;
        Fri, 13 Nov 2020 12:54:20 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id a18sm3780234pfa.151.2020.11.13.12.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 12:54:18 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, willy@infradead.org,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 3/5] mm: migrate: skip shared exec THP for NUMA balancing
Date:   Fri, 13 Nov 2020 12:53:57 -0800
Message-Id: <20201113205359.556831-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201113205359.556831-1-shy828301@gmail.com>
References: <20201113205359.556831-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NUMA balancing skip shared exec base page.  Since
CONFIG_READ_ONLY_THP_FOR_FS was introduced, there are probably shared
exec THP, so skip such THPs for NUMA balancing as well.

And Willy's regular filesystem THP support patches could create shared
exec THP wven without that config.

In addition, the page_is_file_lru() is used to tell if the page is file
cache or not, but it filters out shmem page.  It sounds like a typical
usecase by putting executables in shmem to achieve performance gain via
using shmem-THP, so it sounds worth skipping migration for such case too.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d7167f7107bd..18cc1ef0e447 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2069,6 +2069,17 @@ bool pmd_trans_migrating(pmd_t pmd)
 	return PageLocked(page);
 }
 
+static inline bool is_shared_exec_page(struct vm_area_struct *vma,
+				       struct page *page)
+{
+	if (page_mapcount(page) != 1 &&
+	    (page_is_file_lru(page) || vma_is_shmem(vma)) &&
+	    (vma->vm_flags & VM_EXEC))
+		return true;
+
+	return false;
+}
+
 /*
  * Attempt to migrate a misplaced page to the specified destination
  * node. Caller is expected to have an elevated reference count on
@@ -2086,8 +2097,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	 * Don't migrate file pages that are mapped in multiple processes
 	 * with execute permissions as they are probably shared libraries.
 	 */
-	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
-	    (vma->vm_flags & VM_EXEC))
+	if (is_shared_exec_page(vma, page))
 		goto out;
 
 	/*
@@ -2142,6 +2152,9 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	int page_lru = page_is_file_lru(page);
 	unsigned long start = address & HPAGE_PMD_MASK;
 
+	if (is_shared_exec_page(vma, page))
+		goto out;
+
 	new_page = alloc_pages_node(node,
 		(GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
 		HPAGE_PMD_ORDER);
@@ -2253,6 +2266,7 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 
 out_unlock:
 	unlock_page(page);
+out:
 	put_page(page);
 	return 0;
 }
-- 
2.26.2


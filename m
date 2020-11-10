Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6A02ADDF0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbgKJSPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731309AbgKJSNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:13:08 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075BDC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:13:07 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id g7so12169979pfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wzTkN8x60Q0XiW8/C8IsngN4jAgjA+AlmtZ3C3KQcFM=;
        b=rMAhKmz2stnt0OpVWI6QWLFxn/frb0pncgv+GV3PkKEKdC+qq81GLDHnQj6s1cISfg
         7tbs7uTQ7qP5lVTVOMNcs7we8EfQ9a3knrthROKacF0iCS4pF5XeFxgbZrDpG8WuXErQ
         61lolt0ZG+qJjRyqn7pVHenNxdszmg4JizQFfiYEsf3resqysh/T7Hw7BXC23CGH6PPE
         fD0VeNXrPG3mvJAvqsxEpTn7g3M5I+C7F5IIMgL2CPmB6XW0lSkgRzlvEh7fB0whTsLx
         lr0StdAwIW5GEkh49kanqDjL6T8B8amgBl+wMBHMQJpHjzLb8rdWIJaJMRL/UP4QFt+O
         BGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wzTkN8x60Q0XiW8/C8IsngN4jAgjA+AlmtZ3C3KQcFM=;
        b=nWOgkSKODNkL9UpzbLgj2xTb+MZZVYlc0ryG9n6l4Rak1Hx9ZWAH1bBMvd6XRb2kIH
         NFjN1E1nL2Xxq+KmHOI74h+52T3P+1T8Jtx1Cx7g9pTH0JcXzQmf0U51KPJOCd5l12Y/
         uZodfTXRY6wwsnFAXDSrrEddB5n+MGIZrVC3HoQE8aYq1J08VNdjEeW2epXaDNf59CvE
         P9pnQ8ylsbafN6/qYY3/+QwY8M4HTSTqvSwVbyixL8IWivdAoIr0XOyAiidYNK8TscxF
         3JDM1phjzmyfDqm+NLqLln13Ikgj83balBJcEYMlaBFH44pPSOSvhGFUEmCoUNDxmS/s
         kSqw==
X-Gm-Message-State: AOAM530Zq9728JwR9Zjlv0o/2mQkJDWGD1zjNYczW/j5SGn8XBPKhqrf
        abJEPK5/cr8aXPj02K2stKE=
X-Google-Smtp-Source: ABdhPJz9D38r5ZlM0UCBJXLFJsDSccwf+fHgs+pPgH8XmWGxY4AeJC3hVCEadRPQImntasuJMlolaw==
X-Received: by 2002:a17:90a:df8f:: with SMTP id p15mr367490pjv.29.1605031987645;
        Tue, 10 Nov 2020 10:13:07 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id k5sm4157369pjj.37.2020.11.10.10.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:13:06 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 3/5] mm: migrate: skip shared exec THP for NUMA balancing
Date:   Tue, 10 Nov 2020 10:12:48 -0800
Message-Id: <20201110181250.264394-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201110181250.264394-1-shy828301@gmail.com>
References: <20201110181250.264394-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NUMA balancing skip shared exec base page.  Since
CONFIG_READ_ONLY_THP_FOR_FS was introduced, there are probably shared
exec THP, so skip such THPs for NUMA balancing as well.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d7167f7107bd..1b103e801fe4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2069,6 +2069,16 @@ bool pmd_trans_migrating(pmd_t pmd)
 	return PageLocked(page);
 }
 
+static inline bool is_shared_exec_page(struct vm_area_struct *vma,
+				       struct page *page)
+{
+	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
+	    (vma->vm_flags & VM_EXEC))
+		return true;
+
+	return false;
+}
+
 /*
  * Attempt to migrate a misplaced page to the specified destination
  * node. Caller is expected to have an elevated reference count on
@@ -2086,8 +2096,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	 * Don't migrate file pages that are mapped in multiple processes
 	 * with execute permissions as they are probably shared libraries.
 	 */
-	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
-	    (vma->vm_flags & VM_EXEC))
+	if (is_shared_exec_page(vma, page))
 		goto out;
 
 	/*
@@ -2142,6 +2151,10 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	int page_lru = page_is_file_lru(page);
 	unsigned long start = address & HPAGE_PMD_MASK;
 
+	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+	    is_shared_exec_page(vma, page))
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


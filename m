Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E403A2A8867
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbgKEUxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732400AbgKEUxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:53:52 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4362C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 12:53:48 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t14so2199030pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 12:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/qtr9tzhjtOBdYsDnn5cndcKy8GoT20c7Eybegwt5Kk=;
        b=N04RTqweYUFrqnV9gmhke51hG75fIh7p4gQzA6MwJPqIaC2mKQ3CzsQEx5z/IzCjDz
         G4QkNnM1CeDqPXGZj4jywlCmDW5xVx5pMSVWwTLvQ+ZAcKxkQv9IifxUEDqB+bh6hQ3s
         PSTC4hO6cT2myU0l+PJTqeO9OED2FCBWf1yF5Jj9cZCvFzxUHPcqtdFwxyswwJLPmC2R
         0P3Y/mVDtvDQrgA2g/rnAxnc9TKfeRmSrpuI0DC2peCMtkQk+9XI7N6fpAGKAD2gIBtk
         fhXl4UxagPZgmvJdhghG8XDXVhrSBIIXC6fcG4Xp4u6QGWT1bKsp8fJ56OobRzWwICvs
         r4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/qtr9tzhjtOBdYsDnn5cndcKy8GoT20c7Eybegwt5Kk=;
        b=Yo68YX00PPXStmZ09UBc6JN2LQwf3JLda7erKwSXEaqfLyvj5jpcxPwGW/6hIUCpAJ
         mL3d+PqGXA5p1sO1WpnbIHeS/Jw20d139vNjC6dBof2oiq5hEIQ4MGMNBJMfiJ8oXZpq
         MbA8D6eEDxXUOGgGgNVXNXuJf9iBSgby5HLnfqVn/NLfqZcEV+ge4kDsoSQ61B4sEmqf
         2QhlHp3vz8PYJBJTtwBOuzhDR3IeGG4wbWtwXCLeJRMZCZopQszdnUPz4LFU2JE5hGd4
         e8u5Rx5CrANOQL2zVdUMdaKXKHfj+zB088ht+l+W8b8sROioXN4NvcxS8jbp2ugLKZwQ
         acYg==
X-Gm-Message-State: AOAM533W+4LiwbAHx8TgJSb7yVOv/GtbU5GnwIJlUKYlXHSvQsIpLzCs
        nRyT+TRK2+NSjg0lRHw4iKg=
X-Google-Smtp-Source: ABdhPJyU8XB5H0ovDjvdw4jXwbLqGN5AhkJzXvc3653T26+Rg5FqPVlkgLslhxXhoXQoKSONpx8lxA==
X-Received: by 2002:a63:4866:: with SMTP id x38mr3994157pgk.228.1604609628372;
        Thu, 05 Nov 2020 12:53:48 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id u22sm3265528pgf.24.2020.11.05.12.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 12:53:47 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] mm: migrate: skip shared exec THP for NUMA balancing
Date:   Tue,  3 Nov 2020 05:03:32 -0800
Message-Id: <20201103130334.13468-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103130334.13468-1-shy828301@gmail.com>
References: <20201103130334.13468-1-shy828301@gmail.com>
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
index c33c92495ead..9a32bb128f31 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2061,6 +2061,16 @@ bool pmd_trans_migrating(pmd_t pmd)
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
@@ -2078,8 +2088,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	 * Don't migrate file pages that are mapped in multiple processes
 	 * with execute permissions as they are probably shared libraries.
 	 */
-	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
-	    (vma->vm_flags & VM_EXEC))
+	if (is_shared_exec_page(vma, page))
 		goto out;
 
 	/*
@@ -2134,6 +2143,10 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	int page_lru = page_is_file_lru(page);
 	unsigned long start = address & HPAGE_PMD_MASK;
 
+	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+	    is_shared_exec_page(vma, page))
+		goto out;
+
 	new_page = alloc_pages_node(node,
 		(GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
 		HPAGE_PMD_ORDER);
@@ -2245,6 +2258,7 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 
 out_unlock:
 	unlock_page(page);
+out:
 	put_page(page);
 	return 0;
 }
-- 
2.26.2


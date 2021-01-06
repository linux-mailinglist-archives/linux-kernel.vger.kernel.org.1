Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B775F2EBB4D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbhAFIu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbhAFIu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:50:27 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A519C061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 00:49:47 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 30so1782615pgr.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2O4sxrXuT0FCcMIizj5iDb7GOKunPmY/8SboAcivvpk=;
        b=tL0RH2+wEpb73hSGTr5n++pp7wHB2R912i/VX7pZGK9rTl/lStD7TAjFG+sgUhhd2a
         6wvTSDvLPhx0zh+TOBbOhqULN6HmKhMB0f/qBHf5RBy2rJGRnuHTNQFtRU85OJADmqyM
         alj3qkG58MjGF5GCE8NWdQ1GHaWl8/94FO7aQgewbux+bWT+qXTQlyvirheOHevKsdZz
         Ezd2upXDgd4c3OdEeVcbUGgQY6niBMHT79fesO+VUV3kN/kc5UNdJPF8cj0ZpzQcnR7e
         NyYfHcEjO+zz01i5tYKAsXFQUTHwuVpWGT49BLEgdi/coidjeZtAkioyu91s0lHXW35t
         AWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2O4sxrXuT0FCcMIizj5iDb7GOKunPmY/8SboAcivvpk=;
        b=QNX648LYRIyv7YQqhUyUnf073flVBY/zz4DiKngxWfiB76nJD0yObVv+Fydw2+Hkmo
         obfC63/BVswWMJDWNQc38NjHpGOmJ8XfPG/pQBAHWq/J7Fi1b2B/g3IvFKFw9fxYpjtG
         9JyLN3VLMPMxSPYarAwa0ihsGqw9tZbA9hbrZNUsGXPa2Y9/rpIn+pvROOzx8wPiTepe
         LgDIKVhYnjQycM4AWzJJ+64kUmx+F3JXfOPFL39bH818lhFtcUwgnI4hptSR4ucZ8DrN
         n4VUiVOWt1FbtAssx1abirJCmBeO3ZCSR+zO3iaj4DaM6DTRjUnLH6pNaTlT95aJ8dmJ
         Fe2Q==
X-Gm-Message-State: AOAM532r8u/NF07Qyo6mBb3XVajFveS1uecpnr1TRX/3FL0tldr/uKHa
        kflFkAsZqA1rZaI9VtZM+fppTA==
X-Google-Smtp-Source: ABdhPJzMj0ckWNNfDTFqbQ0rHX8F9/Up1U2wEFuSO1s/Se1yI95wuu1Xwl5VTX8hRXrSbpZ9nqsSew==
X-Received: by 2002:a62:7ed2:0:b029:19d:9461:2b30 with SMTP id z201-20020a627ed20000b029019d94612b30mr2914866pfc.14.1609922987055;
        Wed, 06 Jan 2021 00:49:47 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id h8sm1851806pjc.2.2021.01.06.00.49.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 00:49:46 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 2/6] mm: hugetlbfs: fix cannot migrate the fallocated HugeTLB page
Date:   Wed,  6 Jan 2021 16:47:35 +0800
Message-Id: <20210106084739.63318-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210106084739.63318-1-songmuchun@bytedance.com>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because we only can isolate a active page via isolate_huge_page()
and hugetlbfs_fallocate() forget to mark it as active, we cannot
isolate and migrate those pages.

Only export set_page_huge_active, just leave clear_page_huge_active
as static. Because there are no external users.

Fixes: 70c3547e36f5 (hugetlbfs: add hugetlbfs_fallocate())
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/hugetlbfs/inode.c    | 3 ++-
 include/linux/hugetlb.h | 2 ++
 mm/hugetlb.c            | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b5c109703daa..21c20fd5f9ee 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -735,9 +735,10 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
+		set_page_huge_active(page);
 		/*
 		 * unlock_page because locked by add_to_page_cache()
-		 * page_put due to reference from alloc_huge_page()
+		 * put_page() due to reference from alloc_huge_page()
 		 */
 		unlock_page(page);
 		put_page(page);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ebca2ef02212..b5807f23caf8 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -770,6 +770,8 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 }
 #endif
 
+void set_page_huge_active(struct page *page);
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1f3bf1710b66..4741d60f8955 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1348,7 +1348,7 @@ bool page_huge_active(struct page *page)
 }
 
 /* never called for tail page */
-static void set_page_huge_active(struct page *page)
+void set_page_huge_active(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHeadHuge(page), page);
 	SetPagePrivate(&page[1]);
-- 
2.11.0


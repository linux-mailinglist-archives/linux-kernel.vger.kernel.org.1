Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF6C2B199F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgKMLHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgKMLFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:05:49 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A34C094242
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:04:08 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id y7so7306989pfq.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fI+ffyIJ/lWFcSPqbFf/SmboYz3zeHAfd7luhLQKQ2M=;
        b=QulP4xf/F6bZj2Zxu1813MvOIxpc2rFiP4TBkEPNGz0cA8cZfezugMTjZ1JRHyAQPK
         +YUUWrYNgbVdX27QXnFjI6qj01jwtydS7G7T061gSxs//krrWqRIAABtWkIYNR0lykl5
         TdLs0L4qv6nPhkfMKYbDMbbPWCIHbDIohnT86/1voKVq0HpLeRh49n5lPp4FwnlRjWhy
         qM+1w2MIzt6mat1Ecs5s8/gbvmVB3nSl3JyAq2dMBiV187YaVB+wTY+OFHRBNibHqweP
         ztz7ULVEjVJpEVz5+uq+rgoj7N1H9erXAjIw1ObKzX+WeTY033M2B0NZRD5OWfuRcTGQ
         hp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fI+ffyIJ/lWFcSPqbFf/SmboYz3zeHAfd7luhLQKQ2M=;
        b=SodqWuv9zbdHXLHu4+BGOtwn7Yi8wCcflw+PptuK2gKe7bYcAWY9c2UEn/ZC/SImZ+
         vnKTxMj/YzhLAQnEaZOgYQWhyjM++ByQc6+HERq3QxjPJYo5+ATZVme4q755eOHxjUme
         HIyKkxegsuZk6UporkKb+Isb+DuE029ff31RMtFJ2ls0M6rjZkJubIzTR8nbi+FTfHUI
         vfAAXWu6DbamcILFrsJzyMtRqOiMkOc494NaZrD9mBhbcUq5z2C/9Qlpg2B90xI8AziQ
         SybIqrTSc12UYPFgViSszM9m9UF4M8xGKAKbeAbt+Su4Rvvru9C3v3JHVrlv0bHsYLRp
         YmfA==
X-Gm-Message-State: AOAM533yrnmOEdpIOpGYV6PfsYMemJ4d7iIBKHexXzV3q/AihocaYjqb
        SBVCde/t2QJc8MvTv4lshySvJw==
X-Google-Smtp-Source: ABdhPJycK8Y8+LhZZx+UnepZGWXv3ZrX0BXb/re7wsijJy2j7WEjgUHiRaeIGY1XCDVXSaWuN3Ls6w==
X-Received: by 2002:a65:56ca:: with SMTP id w10mr1741133pgs.204.1605265447958;
        Fri, 13 Nov 2020 03:04:07 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.03.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:04:07 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 17/21] mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap
Date:   Fri, 13 Nov 2020 18:59:48 +0800
Message-Id: <20201113105952.11638-18-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a kernel parameter hugetlb_free_vmemmap to disable the feature of
freeing unused vmemmap pages associated with each hugetlb page on boot.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
 mm/hugetlb_vmemmap.c                            | 22 ++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5debfe238027..ccf07293cb63 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1551,6 +1551,15 @@
 			Documentation/admin-guide/mm/hugetlbpage.rst.
 			Format: size[KMG]
 
+	hugetlb_free_vmemmap=
+			[KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
+			this controls freeing unused vmemmap pages associated
+			with each HugeTLB page.
+			Format: { on (default) | off }
+
+			on:  enable the feature
+			off: disable the feature
+
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
 			Format: 0 | 1
diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index f7b1c7462991..7d6129ee97dd 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -145,6 +145,9 @@ default_hugepagesz
 
 	will all result in 256 2M huge pages being allocated.  Valid default
 	huge page size is architecture dependent.
+hugetlb_free_vmemmap
+	When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this disables freeing
+	unused vmemmap pages associated each HugeTLB page.
 
 When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
 indicates the current number of pre-allocated huge pages of the default size.
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 47f81e0b3832..1528b156920c 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -118,6 +118,22 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
 }
 #endif
 
+static bool hugetlb_free_vmemmap_disabled __initdata;
+
+static int __init early_hugetlb_free_vmemmap_param(char *buf)
+{
+	if (!buf)
+		return -EINVAL;
+
+	if (!strcmp(buf, "off"))
+		hugetlb_free_vmemmap_disabled = true;
+	else if (strcmp(buf, "on"))
+		return -EINVAL;
+
+	return 0;
+}
+early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
+
 static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return free_vmemmap_pages_per_hpage(h) + RESERVE_VMEMMAP_NR;
@@ -505,6 +521,12 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int order = huge_page_order(h);
 	unsigned int vmemmap_pages;
 
+	if (hugetlb_free_vmemmap_disabled) {
+		h->nr_free_vmemmap_pages = 0;
+		pr_info("disable free vmemmap pages for %s\n", h->name);
+		return;
+	}
+
 	vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
 	/*
 	 * The head page and the first tail page are not to be freed to buddy
-- 
2.11.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078672BA29D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 07:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgKTGsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 01:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgKTGsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:48:54 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F473C061A04
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:48:54 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c66so6942284pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eD78AzWQVV1uAAuXAFqLOGFAQosJqi4Yg9b3koUXsus=;
        b=lcwWZUVWnsQa5LT0KgaEjI0iwQ9Zy5KTdkDwdkaYkIYrx0sageBcgcvZ02a8P7IinQ
         cH5lrqUx09ERWxttsalm94SKQsQY0j6YCySKE/qz+9qixGVDly1/Cm5JbHmwcIDBD7WL
         qtkr0vBPhTrsvRVOh3aJI+DhhOqf+WOwZwne/kV3PDRrWDacby9e6XbuOJjfECG0xIhY
         rMH/tVXPlloLTOHZI44HQN35LHMa+2J6nR1JL8jBr+E/4YTbzBFNHhM59vHTB+3J+PB2
         l6ZJRCDsJJ0nRZmFn+SzJpi7oN3oQhm7q0KA10Asz0SBMEKJBD6xgv+9zezxopyUkfdG
         mYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eD78AzWQVV1uAAuXAFqLOGFAQosJqi4Yg9b3koUXsus=;
        b=h78tUX0aj3gMCrTu8S376lVUOdf9NiJB3qRElpaAIqoHu1usD2WGaTlliByWjCWupI
         I8enkf43KaRt+pAkfKNov066vfE9uVbfb0c+GJkf7XfdZw3YmW4eDHFh7tMa7xK8EvLz
         hsAtYRB8eJq1WVhPqIayh92DmW3njgOLXbH/hw5Ms7A+qWuR6yZz/pnlffnRs6xrFucE
         +08IB27Wh9FKxlbLlaTdQrbn2ABqVLAennhxc/6SEa6y+0EQxYYkn9D2f8r8me2HOIiW
         UvbXXdhqEYWs0uk+5CZ5BQBGlUmYZvwpQ4QbDA6JiJXIkFAdkSgeLzn1Pi1MMxzkm7fO
         TC3Q==
X-Gm-Message-State: AOAM533nub85MAtA037oHxIUAK2x2X2kCBljXFCWIC1QecD3q+6sis+2
        t7ixbjmLe/BuQl1QCHxEhIZNGg==
X-Google-Smtp-Source: ABdhPJzVi5Mi23xJ7xuPD8J+lf/CK5R/RCg+2yoXfUf7ZH72VA+vSBnxOfiz+7uMBS0fZyuYnbVoyA==
X-Received: by 2002:a63:5826:: with SMTP id m38mr15569054pgb.240.1605854934100;
        Thu, 19 Nov 2020 22:48:54 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.48.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:48:53 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 17/21] mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap
Date:   Fri, 20 Nov 2020 14:43:21 +0800
Message-Id: <20201120064325.34492-18-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
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
 mm/hugetlb_vmemmap.c                            | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+)

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
index 3629165d8158..c958699d1393 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -144,6 +144,22 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
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
@@ -541,6 +557,11 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int order = huge_page_order(h);
 	unsigned int vmemmap_pages;
 
+	if (hugetlb_free_vmemmap_disabled) {
+		pr_info("disable free vmemmap pages for %s\n", h->name);
+		return;
+	}
+
 	vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
 	/*
 	 * The head page and the first tail page are not to be freed to buddy
-- 
2.11.0


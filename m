Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34392B19EC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKMLTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgKMLCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:02:05 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A59BC061A4B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:01:28 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id w11so4384786pll.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOaBoYHHig9NCQlC9kF5etq1J+Bfm3eBMm2Sx+lDC9A=;
        b=0FY1bBXsIYcDLc/vtlAVQoYH27ooDuEQbD+06g/beLVBOPdjhnMLVU9A/kqlh3T4zl
         ceOcdEHMd7WPwYNlvCwKyXK3/lGyDAta5zW2W9/T1YPP7AmWjGIqKoMJHqDzYFG5NYgx
         48rJfq+iaKiXGwo0UEtYiIJDOrmYnVAAhZbgcFQnC1EiNO+H6MT1suV+4KLEp3Ukst3O
         F/u2klHTmOG0GE4nDr9v3APIKvxlg14w4EHblZBmghIuyLjktJwVIOEy9x1PTca2okZi
         1iINOZ6Pxf/fKwPfuQTLBv7tVGOp83hbbljCAlC9d4qm42/gxUdPPQlFIQM6141JpSG/
         e4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOaBoYHHig9NCQlC9kF5etq1J+Bfm3eBMm2Sx+lDC9A=;
        b=Bv1gN5cdf3aQqhlNOFhloS3ZZf/a1gjljQ4OI1r5sF6+O7ZC2DTZVKuYJfJLH05bmw
         DM0yczuoQgTnJoN/ZIB7gQi4qctSBvNnMjOiAsCYd/+h+Q0rBdJXwRIYAcIm9IXIFZme
         nz4JH3yBY3Teiw6VVIRiDlXRSkH5+SYOtvy9RAYqNiMrcwAtk6M3lo7yyGQtvIYf6l1T
         metmQpkyvq/QMhzjKCNEJ2rhoE2O25aJ1uGG+tPrFzE5Y2exghFTp91z37LNySY4NDzn
         +zimbkRvhvTNJ7jpDvvE8pb9VE5+PcUR2DCNMiTG1qJHnwBiaWnlmoRK7kLLmAWdixNJ
         7uig==
X-Gm-Message-State: AOAM533vP0SFLjYwIdw0i/k9wqluO89J+0zMj6YQBHzSi+5M41J32UZM
        Te2wWO9Yl4qKWDFzuKpoqXXjuA==
X-Google-Smtp-Source: ABdhPJwxjMYztWRHjZezcYZqZHmla6x+5SMEjoB0WH1+Uuko6Mf4T0NnhsjY85Bi51WHYWPsZ8jUNA==
X-Received: by 2002:a17:902:7b90:b029:d6:ad06:d4c0 with SMTP id w16-20020a1709027b90b02900d6ad06d4c0mr1545505pll.35.1605265287351;
        Fri, 13 Nov 2020 03:01:27 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.01.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:01:26 -0800 (PST)
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
Subject: [PATCH v4 03/21] mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Fri, 13 Nov 2020 18:59:34 +0800
Message-Id: <20201113105952.11638-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
whether to enable the feature of freeing unused vmemmap associated
with HugeTLB pages. Now only support x86.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/mm/init_64.c |  2 +-
 fs/Kconfig            | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0a45f062826e..0435bee2e172 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
 
 static void __init register_page_bootmem_info(void)
 {
-#ifdef CONFIG_NUMA
+#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
 	int i;
 
 	for_each_online_node(i)
diff --git a/fs/Kconfig b/fs/Kconfig
index 976e8b9033c4..67e1bc99574f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -245,6 +245,20 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config HUGETLB_PAGE_FREE_VMEMMAP
+	def_bool HUGETLB_PAGE
+	depends on X86
+	depends on SPARSEMEM_VMEMMAP
+	depends on HAVE_BOOTMEM_INFO_NODE
+	help
+	  When using SPARSEMEM_VMEMMAP, the system can save up some memory
+	  from pre-allocated HugeTLB pages when they are not used. 6 pages
+	  per 2MB HugeTLB page and 4094 per 1GB HugeTLB page.
+
+	  When the pages are going to be used or freed up, the vmemmap array
+	  representing that range needs to be remapped again and the pages
+	  we discarded earlier need to be rellocated again.
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
-- 
2.11.0


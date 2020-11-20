Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441F52BA274
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 07:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKTGqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 01:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgKTGqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:46:38 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DA0C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:46:38 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 131so6921474pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HbZE3hLPN+y4fZ+XDemkVZGrMn++MM+PXc+bcKxkyTw=;
        b=ddlgsc9aJsqPVq5fGeJt+X/ZQDQwAN5aZciP0XGHarhI6Nw/kv2uYbf8pALflOPDng
         NlHcU4f7e6w+J7m5KV07mvu6AWmk3bFVO2ZiH13JRIR04zcMF0SYwHKCN+48MZj2d+6X
         CFRtJzAwC9PpdgLDHOzJsVovdSdoByQtLk3NuNZY8tSHaBjkFhnCSBiIbgIZytARMijD
         +TEAHTXGjLuO8DrcIfZZQsESQXaE2wlc76W0xFNwSnh0ntthmym0fyZWvgYm4iBxkevy
         Ly6rL9wS7cDAvGp6z05ix/wjT46BCMjRj9a43QVrQ01leZmx90byJCQ+Qe74wu6mFqZp
         Sdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HbZE3hLPN+y4fZ+XDemkVZGrMn++MM+PXc+bcKxkyTw=;
        b=BIGImJ9Xpj16q2An8JmOjum6kp6TH4I1/hHhHmS1fNld1+WOiucpWMtDYo1xzN511v
         RDhYktj8hzo3NEemZDJXB//Hqc31BANW6XtarwhS5nw0hVE2KOHOtv4Tbd0T545vk7GB
         uG74LWKVnDOXihc30KhF+fXxSj/UcYLA+1jFBVhHuyu3TZuFiVsGLqs583lnsL1r3/oJ
         JRgUERurD20m1XbTYqdu22H2loSP5jOfFRwC9i7yKdX9F2wWQE4QO7wkjL8DcPtG8eCl
         BWpNJc+pa6kwWpdGHFZFf6wOmMPiW7EOft9k72l5G5VenXe6JY57lDk8LzsRRAoHDC33
         4G+A==
X-Gm-Message-State: AOAM5329crRyri8Y0ETgC9a5AEFCqwC9Ozzw2K2mQjYcc17lJx4dINOv
        LETOGoGX7jlhgiIualyahaHsyA==
X-Google-Smtp-Source: ABdhPJwrv3QKWbdRQidbZcDMmub+4jw1ViBixLnsgA9kLSF0wXLcGC+wV5JBbDHtGxKTMQPT1ZHxvQ==
X-Received: by 2002:a17:90a:4dc8:: with SMTP id r8mr8278165pjl.1.1605854797793;
        Thu, 19 Nov 2020 22:46:37 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.46.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:46:37 -0800 (PST)
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
Subject: [PATCH v5 03/21] mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Fri, 20 Nov 2020 14:43:07 +0800
Message-Id: <20201120064325.34492-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
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
index 976e8b9033c4..4961dd488444 100644
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
+	  When using HUGETLB_PAGE_FREE_VMEMMAP, the system can save up some
+	  memory from pre-allocated HugeTLB pages when they are not used.
+	  6 pages per 2MB HugeTLB page and 4094 per 1GB HugeTLB page.
+
+	  When the pages are going to be used or freed up, the vmemmap array
+	  representing that range needs to be remapped again and the pages
+	  we discarded earlier need to be rellocated again.
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
-- 
2.11.0


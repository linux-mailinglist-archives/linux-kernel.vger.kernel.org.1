Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CDC2C87AA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgK3PU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgK3PU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:20:56 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11387C061A49
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 07:19:53 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b63so10583880pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 07:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s5A1WGxjr1FnragMjsAXSXENwZtbX/VCL9QpT/2OWj4=;
        b=2RhaWzxGXNZnya4RQPVLYlTnC7p3ZJDfJBjoHJOKw1nuorEtEwtoefBftJvHjLcflk
         kPYdC5SwmiucMjvq4oiRjhYikOhX9BF1E3oNIf4x4Bv7w5n1dCgtIQvu/hrOYoDK7RMT
         pa0Klx+p9AdLAk69s5ykJFlLNGtySFPARC3mdi2/ty3Y0cpML7NB7/97SK6lXtcLBPM+
         VALfqV8XVPl9DbXTj7k3Cr8vvTU/pmX9IEiwDsSU76BJllQQ5cJEtCdAKtYzWYuDDq93
         PW44EpYKpW9tEG2fQqZPNlefbJ0r/rX48FObKp8vOJOw+QM8Suyx4kejZtq54Lzl8KGU
         awLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s5A1WGxjr1FnragMjsAXSXENwZtbX/VCL9QpT/2OWj4=;
        b=ns5l7+IY0vrdf6MaJPKj1kHe1IqfCW8yAYavKGAyaxITVY1d63yia9tz7hEbE6Vm88
         PzqsgkVjREB3yGEa7+ZHTuccET+hR74aue2Nq81mMMbSAi70qH/GioUJ44LkF+CSxyG8
         yYC/yXbDd6VNgmlI27J+NzR3aq+4OAY1Y9LOkEDBEDI3QrhxXqKC+AJkn+hgaYCtxeqi
         fIPCcuTGNFnpI618d6c6/OtObODZginipZuZukpxUYAF7ouhTyDwB0E/iy17fs04X0eW
         GNG/7yMhTZOUR4hgJWcppo47l0K2ASR8PY4d+icOG1HWMLrv+NpCaHDkpNKrMFxvRcZ8
         HKgw==
X-Gm-Message-State: AOAM532nAcsE4nYkq6KNfkiMhQJOc+HeBaMiqC5joQs0sZRB0O+MuKVI
        P+9WRQry9w20T9ZQSTA3QkvGng==
X-Google-Smtp-Source: ABdhPJx9gSDS4GWuDavFvp1c4l+QTjvwTBoXyiVDOJlXic9chR+sTx650tLab9Bjlxv0+Rv8nxRWQg==
X-Received: by 2002:a62:ce4c:0:b029:198:1f1:8743 with SMTP id y73-20020a62ce4c0000b029019801f18743mr19245889pfg.79.1606749592623;
        Mon, 30 Nov 2020 07:19:52 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id q12sm16201660pgv.91.2020.11.30.07.19.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:19:52 -0800 (PST)
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
Subject: [PATCH v7 03/15] mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Mon, 30 Nov 2020 23:18:26 +0800
Message-Id: <20201130151838.11208-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201130151838.11208-1-songmuchun@bytedance.com>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
whether to enable the feature of freeing unused vmemmap associated
with HugeTLB pages. And this is just for dependency check. Now only
support x86.

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


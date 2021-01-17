Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1662F9363
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 16:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbhAQPP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 10:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbhAQPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 10:14:20 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D3BC0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 07:13:25 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q7so9334532pgm.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 07:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ntojA21L7AWHHQRUBdhZHwBioWXg1bVrcDP2ArBhkkY=;
        b=Ea92toZH/1l0FNhx1nYmpPDeMydz/IKBkjQNccA4JqlaQPi/3Hu7gQ+VMm6zzsAlvz
         AEPxfJbUcsBRQ/K72F17e5DJy+XSBlPDcFg+yOHm9bZCaxpwuGmq7436uQ3VgxPB6b7F
         BcGJ7sVKe1WKZbF34ZFO80YezkJaRfz1IlIUL5QduSqo7EI5ifnDybPjYy6FMoMCs0TN
         DbWgBtJnx8ZU04vNOUTtdXotGgWbbzZRb5jIVaoukR8rnv6/p/9+pwVgJNNKulSFr1/a
         hcA8Lxw1XnfXxzP0tExT7KFk9sqmACYVhZRtBblbQ8fe0Qcczny3sVq4hnxCmxdSO3+/
         PP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ntojA21L7AWHHQRUBdhZHwBioWXg1bVrcDP2ArBhkkY=;
        b=WK0gQ5pTKKd/NZYtn0nrkbuGFD0yEGMXtH3LXP096Zb2Md7+QD3DvNlWIlwBkyYJjK
         2pDdG+J8H4l5yxJUTRnNDL6SFbqIwOWRl3YUMfP/uWvqC7Ukvwfg6eFfp4ZU3xWDYwp2
         viHXZzPQmGPwpuWyj2x/h/Br7eeKXoO86EY+r3D5QvvRzZzsrRAv5M/Bp7u9B3p3JTL+
         2NwbL9ClPq6o732kFfBmVBQJA9cWD7ad4x08o46icBL2WgvdVotYj+OHVV3FX3jG9yTT
         8fZrgkSbUcxgDL4XNDfenXwLEJ66dccRomZpu8gl9pV4Bc9SpB6Se9Xs3IaEdIehAkCQ
         N+Ag==
X-Gm-Message-State: AOAM530JnvmZxAbEJzegHV4Bt0If3LAB9s1rJahFrOw9V9KoEBSCcQvx
        Kd8OdJTjjiu4m/P8yzvwCt9WyA==
X-Google-Smtp-Source: ABdhPJylD4KONe3SPQrZ2L10bXdihiwZcjTG3YitmaxUO2lbiyLsg5iYrSq+a5GgBs8/6xFFDzNMFQ==
X-Received: by 2002:a63:a804:: with SMTP id o4mr6213615pgf.67.1610896404686;
        Sun, 17 Jan 2021 07:13:24 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id i22sm9247915pjv.35.2021.01.17.07.13.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 07:13:24 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v13 02/12] mm: hugetlb: introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Sun, 17 Jan 2021 23:10:43 +0800
Message-Id: <20210117151053.24600-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210117151053.24600-1-songmuchun@bytedance.com>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HUGETLB_PAGE_FREE_VMEMMAP option is used to enable the freeing
of unnecessary vmemmap associated with HugeTLB pages. The config
option is introduced early so that supporting code can be written
to depend on the option. The initial version of the code only
provides support for x86-64.

Like other code which frees vmemmap, this config option depends on
HAVE_BOOTMEM_INFO_NODE. The routine register_page_bootmem_info() is
used to register bootmem info. Therefore, make sure
register_page_bootmem_info is enabled if HUGETLB_PAGE_FREE_VMEMMAP
is defined.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/x86/mm/init_64.c |  2 +-
 fs/Kconfig            | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

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
index 976e8b9033c4..e7c4c2a79311 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -245,6 +245,24 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config HUGETLB_PAGE_FREE_VMEMMAP
+	def_bool HUGETLB_PAGE
+	depends on X86_64
+	depends on SPARSEMEM_VMEMMAP
+	depends on HAVE_BOOTMEM_INFO_NODE
+	help
+	  The option HUGETLB_PAGE_FREE_VMEMMAP allows for the freeing of
+	  some vmemmap pages associated with pre-allocated HugeTLB pages.
+	  For example, on X86_64 6 vmemmap pages of size 4KB each can be
+	  saved for each 2MB HugeTLB page.  4094 vmemmap pages of size 4KB
+	  each can be saved for each 1GB HugeTLB page.
+
+	  When a HugeTLB page is allocated or freed, the vmemmap array
+	  representing the range associated with the page will need to be
+	  remapped.  When a page is allocated, vmemmap pages are freed
+	  after remapping.  When a page is freed, previously discarded
+	  vmemmap pages must be allocated before remapping.
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
-- 
2.11.0


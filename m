Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48122DD138
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 13:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgLQMQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 07:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgLQMQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 07:16:45 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B67C0611CA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 04:15:51 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id r4so15041826pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 04:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uMWaylOLwrhQO+0qPcTQWOqk5IVfd5cW+XnB4Y3UJOM=;
        b=HP32Wirp0xJy8F8B53MO0WJ+iP1j1h5d5guVaV+dyEaqPHsJ0HtA78GwwPulzLqmhA
         9Hya+1z+TDZDAhQNXwHc8v1HtvdxEzRf+upBJuGl22ePI/8v4KnK2cUXhPD+6ugbG/tf
         eZYDpkTd5ExtlnHsc8Rw9Cgti3GFsz9Ou3rALkoibuRclS6EKsTvdJavl9dg8niz0Lho
         8h+mWxlzSO7fV+oLsL0x4M36s1/swIv1SlSlyQpGK6NkQ1a06FxW+BaQwGX5ssigwser
         M8dRxJCk4Oa2yQ1taaSKbXE/LzPGBZ+CtoxWjkk6mxuLCP6T1NrReAj16bhWSEPTdwl9
         CRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uMWaylOLwrhQO+0qPcTQWOqk5IVfd5cW+XnB4Y3UJOM=;
        b=QFpH8B6ZsPrn3v7kfVMQGHIYeHLRsPbTdgWz1pw2zDbf9KwanQsdWrifqdzPbkuh9X
         U7CcY8a2sYs26fIiceyrBDSh74tA9k7Q/VRKxu44kHvmvrflzOe9nIFngo1ZfelAztqI
         K/q7BZBlb6+t22wEqjBeXNPa8zGoCPSbHdnOZr/BYELWEzdZh1OqoXrnyhOXJ/Ucx+Yo
         4/apDbbWqLFThPweYM8BtUo4ps3g1FbZlNv/lwLai/EbAFTpoQ4B/Oyyq9AlNn3GLde5
         i6DOiS4CqKVhYJJABjAkVFokcjjBC8W14/iydPPoksEjpc/wxoIDf8Gr0mv3u6ENUwHX
         PqdQ==
X-Gm-Message-State: AOAM530GR6gRhSaHLJzEdEPlfRebiKRwEdt17dpqjLkfb2lB977jLemh
        6dYZP9s9GHXw1eZEw/IQ1jpdFQ==
X-Google-Smtp-Source: ABdhPJxTZ/B0obsJFYqu5Nkao7Nm5q+V7wC3rvQeBm1ZiFOsx5R6gfzFUeZHk1BZE9qpSgsUJnYymw==
X-Received: by 2002:a17:90a:c70f:: with SMTP id o15mr7617385pjt.40.1608207350845;
        Thu, 17 Dec 2020 04:15:50 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id n15sm2775691pgl.31.2020.12.17.04.15.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 04:15:50 -0800 (PST)
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
Subject: [PATCH v10 02/11] mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Thu, 17 Dec 2020 20:12:54 +0800
Message-Id: <20201217121303.13386-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201217121303.13386-1-songmuchun@bytedance.com>
References: <20201217121303.13386-1-songmuchun@bytedance.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4472D8E6F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 16:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437514AbgLMPwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 10:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406484AbgLMPrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 10:47:40 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633EFC0617A7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 07:46:41 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id hk16so5144263pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 07:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qsAVJu/9vqouKcThrGhG8OM4QgmEtPOs8IzBVJC9Eg=;
        b=bcCqwkwnJlHPPNe4wEpW5hjoTWMM+1oRkxutnuCbTtrmGvuy15sSG1xKY2/ayuRD36
         QfiyN5tXQ8iGvdNERtKYMTDpzmQa/ldlrTr4OW1Fzf2LmtD4UrcFyR2u02xJX7cnHClz
         pfwOe1qOqFY3zrBEbJqfghpMX5rA1zGA9Wa/5aSEKIG/7kFgGF1WPwVR2mcI6D88NidF
         Ta+hwRMvhCv4dk6a/h1VI/xRv91DG7oK0kT7ENQ9et5wWTxBtQze/pnnwKulTz2/xulH
         Vumpi3lNg4/0RCY7rfLqcgd/5vMzFVnS+yNY6sANV2Aww7az8eiWjw67kkA35YRdqZW9
         fQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qsAVJu/9vqouKcThrGhG8OM4QgmEtPOs8IzBVJC9Eg=;
        b=G1jUIO70NT3ERJAoGl495ktinDhbPZg0HZqAe1tB2V+ePyyw0Ovj1+0wGNzUTd/KIz
         ir/J1iCVmTOjJP32YJFFYb861wsCKrOPAv4KRhAeDXKWFz4Y5HC9XqrE9WYNAW3Y750g
         rXj77k/PR7Tj9R2mIOi4R5s+OMckqlUniqtW1Hzu4JL1jj3ljd0p7aT78n6UpeisIeDu
         u7ZAIgYTcSNQrQRofE63WqqZViV388OyasduCWZ9rSx6Qg0emSVDRGUtlGeSh22sxC72
         R6l7QSZdtkkUf6Mpxj/60aszAIkEC7aA64l2Z1fydZXYKQlM5+B5E0eMclxQAJE1szeC
         rcsQ==
X-Gm-Message-State: AOAM532Fj0LA/F/HGVJivQbbft/mDMc3WrWPjKBMPPhH3c8KrGF79Rl+
        m8Qw9BL4xWix4XiPNDsBOAKf2Q==
X-Google-Smtp-Source: ABdhPJwPhF1kEZCNrZ52wXqgSJ5X0GJE2c5s27DHWYT+jpGXu3QnSrBZF6KISGYeD2zuJBx1zYnGaw==
X-Received: by 2002:a17:902:c395:b029:da:9aca:c972 with SMTP id g21-20020a170902c395b02900da9acac972mr19420371plg.32.1607874400964;
        Sun, 13 Dec 2020 07:46:40 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id e24sm13113753pjt.16.2020.12.13.07.46.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Dec 2020 07:46:40 -0800 (PST)
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
        david@redhat.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v9 02/11] mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Sun, 13 Dec 2020 23:45:25 +0800
Message-Id: <20201213154534.54826-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201213154534.54826-1-songmuchun@bytedance.com>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
whether to enable the feature of freeing unused vmemmap associated with
HugeTLB pages. And this is just for dependency check. Now only support
x86-64.

Because this config depends on HAVE_BOOTMEM_INFO_NODE. And the function
of the register_page_bootmem_info() is aimed to register bootmem info.
So we should register bootmem info when this config is enabled.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/mm/init_64.c |  2 +-
 fs/Kconfig            | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

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
index 976e8b9033c4..4c3a9c614983 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -245,6 +245,21 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config HUGETLB_PAGE_FREE_VMEMMAP
+	def_bool HUGETLB_PAGE
+	depends on X86_64
+	depends on SPARSEMEM_VMEMMAP
+	depends on HAVE_BOOTMEM_INFO_NODE
+	help
+	  When using HUGETLB_PAGE_FREE_VMEMMAP, the system can save up some
+	  memory from pre-allocated HugeTLB pages when they are not used.
+	  6 pages per HugeTLB page of the pmd level mapping and (PAGE_SIZE - 2)
+	  pages per HugeTLB page of the pud level mapping.
+
+	  When the pages are going to be used or freed up, the vmemmap array
+	  representing that range needs to be remapped again and the pages
+	  we discarded earlier need to be rellocated again.
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
-- 
2.11.0


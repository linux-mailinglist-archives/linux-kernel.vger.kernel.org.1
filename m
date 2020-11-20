Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361B82BA2A8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 07:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbgKTGt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 01:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTGt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:49:26 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BA3C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:49:26 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q10so6954449pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZS5213ZHM0b8+f9VjLOiz+1LLqtvqurjNhuD3Z1QgXw=;
        b=IF1543fDtb+kWKsmeCbYQJE2RKvL98vTCrDCvCNTBaznuoXtdRoONmgowwM077EA1r
         D1ImG20rzchmyhXqIqqQl53pDl81FzaCOANREsMX20Bi7my3JSv37VpMcPo1QyGhIC/W
         kjfxyOme9/t0QUXrphAihullLYJaXkDZySzXMhDSBQvRjmeANFmzXuAMUQd4VO5Eg0cX
         zqAICNAblp8DQIt5wYJuW3S84M82AYFj9qGqTx0bj8pyiBqhsIlfrFd+0NqTblPnHo68
         dOWR+79BIzlGrP7e0lvS7TCmkXC4ENFNlq3FoNoiYne32Hm7nCVaWDfJw2hnCO290CeN
         VWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZS5213ZHM0b8+f9VjLOiz+1LLqtvqurjNhuD3Z1QgXw=;
        b=hJPkmVyFML/VvG7wmcZRUWCWFOHB0OdI2zW+FZvIUlz6AnDmjTNG7ptXC2bzW40PUV
         5zQ7plMxmSz5UYygLvxpvnIp5N9+PRCTPOM81K2DfyNV3DY6YK5VlO3lDXKCcep6KD6E
         LRMLfFUhP2d7TmaJ/jGI2N/5WQQeNIMfiqoQi5OSCHiFZ5yi4ZzxXAmsIo8jW9DJlBby
         +DMkTmwN672rragDDct/Pa6USLKZC2dBztZOAD++9pjJsY9nS7ofwPSSjZ521dT6nCgM
         QbkDjXFfb505/z1lc/MMnSkTjAweMN4nVsBJcJKc9FjeBLuBFQkexeyPtnypDeMKoFRE
         Rs0A==
X-Gm-Message-State: AOAM531qTyzT1nBVnB7l/S1y5czqLWVE2ilDuz7ZSV4huKAiTgdu+X8J
        ssxtg2Pfq2Jqx5pRII6QjKPU0A==
X-Google-Smtp-Source: ABdhPJy/oDjOsfTURQw/n8WyCu22EFp43ZL/0t48CLQVCDRZ8hdfpHxhDoWHshVvTsOfv6IeLOJdAw==
X-Received: by 2002:a17:90a:7101:: with SMTP id h1mr3714686pjk.26.1605854965992;
        Thu, 19 Nov 2020 22:49:25 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.49.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:49:25 -0800 (PST)
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
Subject: [PATCH v5 20/21] mm/hugetlb: Add BUILD_BUG_ON to catch invalid usage of tail struct page
Date:   Fri, 20 Nov 2020 14:43:24 +0800
Message-Id: <20201120064325.34492-21-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only `RESERVE_VMEMMAP_SIZE / sizeof(struct page)` struct pages
can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, so add a BUILD_BUG_ON
to catch this invalid usage of tail struct page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index bf2b6b3e75af..c3b3fc041903 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -750,6 +750,9 @@ static int __init vmemmap_ptlock_init(void)
 {
 	int nid;
 
+	BUILD_BUG_ON(NR_USED_SUBPAGE >=
+		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
+
 	if (!hugepages_supported())
 		return 0;
 
-- 
2.11.0


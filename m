Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781FF2C2269
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbgKXJ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731779AbgKXJ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:59:30 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E7DC061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:59:30 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id v12so17968974pfm.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bynt/1YGSIdeJG2cOcgImXpzmEpwnUEaY6/7f6Ae/g4=;
        b=fU4syUhxdPJXkfQh34bMos1Y3zr1DCPrRNdijHklOltKrH8VvpAXtOADs20QwQcEjW
         A2lK/GIaljVc1gKpKY+vWKXPR9OX02jV7LL2OxqKTKdW4TMY9bWP+fnxOuc6z68yESqq
         gPQsJIyUY3JrkeRY5zHkeN2Y8rM6TmLsRERR3l+Scp4P6MJ+uxijHnXpyVuclcExnT3i
         gzDQQIfKE2CNH1P5PIdE0F04T9wEPhqMpEHIzsrjT1bfyLdmVV1Yc+Rcj7e9TKtK/A6B
         43CvqdjuVYMGBrGRpCljlvKSDsJaaJr0BCU5Ev8i5DzEfhLX4j3RvZAfincG31o5Ls53
         GL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bynt/1YGSIdeJG2cOcgImXpzmEpwnUEaY6/7f6Ae/g4=;
        b=K9gWQu1BzVjDC1h3ICVDPwEcHmeJVgrCd+zPfqEuoxCb6GZ0aEAb8sWlOaPPCfohij
         dZJGiKQBOlJ/WdI1eAM2YIHWErjkwDDNShELIy/XhrEBrNBhHAZyAukbNdR8tRkb5A6X
         s1drygKcSOJlewlGqeGdjSbsd5eF6DuqjMOIKdo4ddlxp9US6P6YlHkgN9nDdqfG/W7E
         1clh4UWnzsWR2jEFTe9pyxqSO7etOk7YDf6wkI6BZhjM+6vsNGgiybg02By7/8+BAqF3
         217g/qJ03r8+4tusYXf0Ze6Gx2grw1joZbGE0Y+zHZv9+vNfPFZtb/Qc3rbsqOVkiXik
         wX3g==
X-Gm-Message-State: AOAM5307Ts94poDQ9fozJ7pC2yWR5t4+Usp5t8Txeb79Z305BCmG1x+o
        PjCzttcCOA3RTsF2w6jHNARuPA==
X-Google-Smtp-Source: ABdhPJy1pVteQcfd7t6pUTOEaOSYXhdcK1qTpL/2aKqFlzz5VS2SYxybBYu983LImuXmPOsDkOMJAQ==
X-Received: by 2002:a63:f857:: with SMTP id v23mr3071328pgj.174.1606211970431;
        Tue, 24 Nov 2020 01:59:30 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id t20sm2424562pjg.25.2020.11.24.01.59.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:59:29 -0800 (PST)
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
Subject: [PATCH v6 16/16] mm/hugetlb: Add BUILD_BUG_ON to catch invalid usage of tail struct page
Date:   Tue, 24 Nov 2020 17:52:59 +0800
Message-Id: <20201124095259.58755-17-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201124095259.58755-1-songmuchun@bytedance.com>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
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
index b2222f8d1245..d2c013582110 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -338,6 +338,9 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int order = huge_page_order(h);
 	unsigned int vmemmap_pages;
 
+	BUILD_BUG_ON(NR_USED_SUBPAGE >=
+		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
+
 	if (!is_power_of_2(sizeof(struct page)) ||
 	    !hugetlb_free_vmemmap_enabled) {
 		pr_info("disable freeing vmemmap pages for %s\n", h->name);
-- 
2.11.0


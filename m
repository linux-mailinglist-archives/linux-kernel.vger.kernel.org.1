Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B272F7AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbhAOMxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbhAOMwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:52:53 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD91C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:51:34 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id be12so4657805plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+oq/pZri5P5cicdjvF/NV+dEw2QpXHjaPU5Z1WvWQMU=;
        b=QiizyrXVk9Caq+Dq/aCAmt2FvbOtK/UvO/5SMwa1kR6eOjgvONO+R+p4aPkgV5Chcn
         XwSrin4YYDiDHBwfPVC0heYZFWV11c1+egr7bUEKOLvd1AL/RU30tDvj59CvxDhwbm6X
         WIB+TJYvCG5p+282nlra7vHDx26nXfgS6Tuh4w/AAnl2tBE1nXAwqP763dvTzkk+EX/R
         nWCfyNU+vcdrWmaH8wZNerSs2GQsxiG7AG2MDWoZ4yZFr1ShDrN2ciAqTyqhw9bhEvS6
         ZdZ8pXTfu4/CWCGDAWVoWN0Xq4EIx3p4N3h96/G4MiCk9ZhhX6Jk9058TPQr9uChUwaw
         2nKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+oq/pZri5P5cicdjvF/NV+dEw2QpXHjaPU5Z1WvWQMU=;
        b=cYlz1Sn+xIUa4pvHYtM2ahNJpFjwrdbDXNvhWIHkWajo3uUEIZMTeT2WnKuqKHkkuK
         XjSxHYUCd+A5dHZhJQZpamCyzsid7uCdelAAB6dqVU6gPiXoKMUBKQFbzBWYkh6F1OCi
         MXdb66zNo9Fnrx0IDTDn3WrhlkCCOcNXx/Wt6G619aAPLpmo+3drMGUd/yYSQVgDfvxl
         1u2qgD7FKKyXjqwspcwuHqHg//N8W8IfSHIJV3Nt9jfnsWLPr3KoJHef+dBDCmQi9/WP
         TDGdr5Pamt8G9yL5xdoTF6aju3G/6bNrcHqDj0UjT4N1zR5FLcLi4w6XJFIdcBBV3zKW
         Kb9g==
X-Gm-Message-State: AOAM5338Wl5/Ah3+xa3cuj/ebt70fpYsZTaaFEMjOB2FXj1kCtp7FFwV
        dPNWGGlmed2RQDITXhPJ6ESzGg==
X-Google-Smtp-Source: ABdhPJxod0INgeZhKzOkKfmLTxzpi/GXYx3l8jx7/eCcpACoBmjkXMvDlVhC3XFVyekI1Ig7/077gw==
X-Received: by 2002:a17:90a:b296:: with SMTP id c22mr10718986pjr.142.1610715093829;
        Fri, 15 Jan 2021 04:51:33 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id c5sm8193600pjo.4.2021.01.15.04.51.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jan 2021 04:51:33 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Subject: [PATCH v6 5/5] mm: hugetlb: remove VM_BUG_ON_PAGE from page_huge_active
Date:   Fri, 15 Jan 2021 20:49:42 +0800
Message-Id: <20210115124942.46403-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210115124942.46403-1-songmuchun@bytedance.com>
References: <20210115124942.46403-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page_huge_active() can be called from scan_movable_pages() which
do not hold a reference count to the HugeTLB page. So when we call
page_huge_active() from scan_movable_pages(), the HugeTLB page can
be freed parallel. Then we will trigger a BUG_ON which is in the
page_huge_active() when CONFIG_DEBUG_VM is enabled. Just remove the
VM_BUG_ON_PAGE.

Fixes: 7e1f049efb86 ("mm: hugetlb: cleanup using paeg_huge_active()")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: stable@vger.kernel.org
---
 mm/hugetlb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f2cef3cf1f85..2d671f3743f5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1360,8 +1360,7 @@ struct hstate *size_to_hstate(unsigned long size)
  */
 bool page_huge_active(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageHuge(page), page);
-	return PageHead(page) && PagePrivate(&page[1]);
+	return PageHeadHuge(page) && PagePrivate(&page[1]);
 }
 
 /* never called for tail page */
-- 
2.11.0


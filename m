Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A43D2E90BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbhADHFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 02:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbhADHFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 02:05:18 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9088C061574
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 23:04:37 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b5so10261023pjl.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 23:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EISNFuU48YmH5mVT0GE+4yn3CQnSse+shUM8yzbBpaU=;
        b=Xmgjt/nOSUnyWkfS8V2b6zGYX7FQPWtZlXXQ7l8c1xqvRCoxP1WJyxx6yRZgHZrNW9
         FKgtJ/N/l8uSXO6qVfmgrUa8iZGRMmnithwfYa7bZ/vmHcu6QYCD+ksPXncP0yNug6eY
         UV3Gf7fJfNBcBQpmN9xaNylvpe/6bxIYLrW4cKsg7J0OmLio0Ipyuzl6zGnCddM2wDSo
         UMidatDFEY9JKZgpquEhsuVdTG7WVm7uIwkXPUqhA09KItm3Kyhoe1keIKuZJGjd/Q4J
         Z5TxBks0c6M/mnN+AXgvJk1/m1UqJ4s/Q/hPRtwKPFVVM1bPPIJeP1xmKwtpZ8PwtoT1
         5Esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EISNFuU48YmH5mVT0GE+4yn3CQnSse+shUM8yzbBpaU=;
        b=ioRes5DoBk7BF40WKVnHRA66nmWG6C3e1eCKLnR+CJtI3rOCkbhTmE4k5Va1gzawgU
         8fP7cBLPcWVDan71YzCNxx2CG3xflkOTGArYYWpFhbTFGhr1GfPNl1G7T039gykPOv/Y
         eRpEXj2Si+mis5aJXOU/gvYohwALw8BTQvdBDqszaThFUx8gqIVQrC0EQLA20yFn5q+a
         toz72MtMd98ToaD2RBjPCK4vYgZiiJuqMNJCjPkYCfuEPe5I8NtnOyE7VGzXH4nyJxMw
         cJZeUzvYl0VBgL34UbGrDOu2+Q9FiCBMvfQq7T6W/HOoeWj00hvAIJyVNDCWBJPFUubo
         5/xw==
X-Gm-Message-State: AOAM5302Dc2UJjBxeKtEXK3/JdOmObuoccuTrCvIMq1AEl1CeeC7Qddx
        kOA4jX1HLC/9ng5zAi1x35LBKA==
X-Google-Smtp-Source: ABdhPJzXfcHe/DNDgrNLYCLPvvRR9GsslU5gGbg4vZuATckt8jlYAfPJ+tgaqY3zitTmNw/PBZ+wDQ==
X-Received: by 2002:a17:90a:db4e:: with SMTP id u14mr27912006pjx.184.1609743877588;
        Sun, 03 Jan 2021 23:04:37 -0800 (PST)
Received: from localhost.localdomain ([240e:b1:e401:3::6])
        by smtp.gmail.com with ESMTPSA id v1sm36306648pga.63.2021.01.03.23.04.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 23:04:37 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     hillf.zj@alibaba-inc.com, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 6/6] mm: hugetlb: remove VM_BUG_ON_PAGE from page_huge_active
Date:   Mon,  4 Jan 2021 14:58:43 +0800
Message-Id: <20210104065843.5658-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210104065843.5658-1-songmuchun@bytedance.com>
References: <20210104065843.5658-1-songmuchun@bytedance.com>
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
---
 mm/hugetlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5c2f64f53177..4c8631114e88 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1360,7 +1360,6 @@ struct hstate *size_to_hstate(unsigned long size)
  */
 bool page_huge_active(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageHuge(page), page);
 	return PageHead(page) && PagePrivate(&page[1]);
 }
 
-- 
2.11.0


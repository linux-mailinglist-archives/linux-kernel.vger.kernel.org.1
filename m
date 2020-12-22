Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD23A2E06F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgLVHt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLVHt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:49:56 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7410FC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 23:49:16 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id g15so2960716pgu.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 23:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=EteXygXMCMIuOH65MtjowE2DhA9SwUq1uE5SG/8bUGA=;
        b=LGvosuLiYLgn1b5YwdnJwfvCqo3XbN555xW2S/pLyAc8CuUqtZAGHNlX5OhLPeQRO4
         C9wIUC7lj+M+iU2FFT1wsEhktcwBwq76j874fWliVKllFErvCXfAAxAKVekLKJ0fPuX4
         w9BPNrCcyE8RLp4U32xhMH4/yOciZ7ZmUVQsi7kvByf34AwsJf2PEPp8adJg0WcVurN9
         y91b1qv/triV2c+4b/y4HigHiL/Sk+sYpuqdkd4PTNVp0q5YaDIas0IN7YMD2gFHzTrx
         eV/AGLh5tP8pePBFiPGWjo4RlSKftL1n+xJaqNVLxg/eXbhAbpkDrS1x2L8CHRsIt1/n
         D+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=EteXygXMCMIuOH65MtjowE2DhA9SwUq1uE5SG/8bUGA=;
        b=bf9FcA2GYusaSnFzjW+AmUnsJsrULVSBRt2P+1sRmAxgSkpokoQNUph1A/fGPwBWSn
         KpmNCJNrhHslcTPsKKJxll3wXthJnwIOolkAhcgmscQ8z6MTKotcARQHg7ino5B/8RVT
         6ECL3MJGBzgHWSeuVZg+1v9Jj+jBntHhvaxX7qtDZ+PDr9XXomfOba6Xdjf5BslfHU4l
         3S3MBdnpuqVqI8MAaX6pgYu+7fr9WQWCRBquZh+HLlVw58k7nQYNF73cvf2XhxQJt/98
         71f8ja65AxjWVYJTfMkM0yzA41TrT5ArvbDNQg4Dzj53v4UPD7nej8Rkd7VbQImDbbOO
         GBpw==
X-Gm-Message-State: AOAM532ahgfY2D8CBOnpfjiOmnOBdqMC56f4SE69V8TqDWTIJ1T80pC9
        +8ksyNy6qFOYMhbeybyjLFs=
X-Google-Smtp-Source: ABdhPJzBJLHkMIuEbtGr1+LpiBstQirZrxRohNTninbGDYKqZqqMHLh/V9kjyaXQ/gbGgwJskKjqfQ==
X-Received: by 2002:a63:445a:: with SMTP id t26mr18659351pgk.402.1608623356116;
        Mon, 21 Dec 2020 23:49:16 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id b189sm19198904pfb.194.2020.12.21.23.49.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 23:49:15 -0800 (PST)
From:   Liang Li <liliang.opensource@gmail.com>
X-Google-Original-From: Liang Li <liliangleo@didiglobal.com>
Date:   Tue, 22 Dec 2020 02:49:13 -0500
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liang Li <liliang324@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Subject: [RFC PATCH 3/3] mm: support free hugepage pre zero out
Message-ID: <20201222074910.GA30051@open-light-1.localdomain>
Mail-Followup-To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liang Li <liliang324@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support of pre zero out free hugepage, we can use
this feature to speed up page population and page fault handing.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>  
Cc: Michal Hocko <mhocko@suse.com> 
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Liang Li <liliang324@gmail.com>
Signed-off-by: Liang Li <liliangleo@didiglobal.com>
---
 mm/page_prezero.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/page_prezero.c b/mm/page_prezero.c
index c8ce720bfc54..dff4e0adf402 100644
--- a/mm/page_prezero.c
+++ b/mm/page_prezero.c
@@ -26,6 +26,7 @@ static unsigned long delay_millisecs = 1000;
 static unsigned long zeropage_enable __read_mostly;
 static DEFINE_MUTEX(kzeropaged_mutex);
 static struct page_reporting_dev_info zero_page_dev_info;
+static struct page_reporting_dev_info zero_hugepage_dev_info;
 
 inline void clear_zero_page_flag(struct page *page, int order)
 {
@@ -69,9 +70,17 @@ static int start_kzeropaged(void)
 		zero_page_dev_info.delay_jiffies = msecs_to_jiffies(delay_millisecs);
 
 		err = page_reporting_register(&zero_page_dev_info);
+
+		zero_hugepage_dev_info.report = zero_free_pages;
+		zero_hugepage_dev_info.mini_order = mini_page_order;
+		zero_hugepage_dev_info.batch_size = batch_size;
+		zero_hugepage_dev_info.delay_jiffies = msecs_to_jiffies(delay_millisecs);
+
+		err |= hugepage_reporting_register(&zero_hugepage_dev_info);
 		pr_info("Zero page enabled\n");
 	} else {
 		page_reporting_unregister(&zero_page_dev_info);
+		hugepage_reporting_unregister(&zero_hugepage_dev_info);
 		pr_info("Zero page disabled\n");
 	}
 
@@ -90,7 +99,15 @@ static int restart_kzeropaged(void)
 		zero_page_dev_info.batch_size = batch_size;
 		zero_page_dev_info.delay_jiffies = msecs_to_jiffies(delay_millisecs);
 
+		hugepage_reporting_unregister(&zero_hugepage_dev_info);
+
+		zero_hugepage_dev_info.report = zero_free_pages;
+		zero_hugepage_dev_info.mini_order = mini_page_order;
+		zero_hugepage_dev_info.batch_size = batch_size;
+		zero_hugepage_dev_info.delay_jiffies = msecs_to_jiffies(delay_millisecs);
+
 		err = page_reporting_register(&zero_page_dev_info);
+		err |= hugepage_reporting_register(&zero_hugepage_dev_info);
 		pr_info("Zero page enabled\n");
 	}
 
-- 
2.18.2


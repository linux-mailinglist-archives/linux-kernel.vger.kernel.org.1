Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BF2292552
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgJSKRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJSKRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:17:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCF2C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 03:17:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a200so5719578pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBgUGqAsec7qTzYBCwd44M5Bggj7329Sl4ThqGqVzJM=;
        b=r/hMWlZ4hVnBC2hqLPzHYZgF1TNMYUt3GXbZTY8LUpvdzb3UeH/58LdOQAF50BrPSu
         ot3W4Pka1heK0dMFCEVwy+ec+8DwZ0LAstnAzI7O3zL2GamUBZ/wAn3KYPon+XqiL5Iu
         EHZ2WbzC0V6fTUTVlUuWNkKGEYrzskzNkmNLZiaea57qknUyyJKZo4qkx/VOWGFIrP2m
         1kHWq/Nak/x7eFhuTa8hwn01pzhufsMDXpFe9Zeg4ZNH+JLLnbOmJqS1QiK3+6eBJ57o
         P1IuJuK9EYSUErL6KYAVlayxNb3zQ6VY+dPn3ap6fh9+AplcqqX37WwwwnRhcpAzRLCE
         VQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBgUGqAsec7qTzYBCwd44M5Bggj7329Sl4ThqGqVzJM=;
        b=N/rUp5rxLrM2geACN8qCpw8ujJ29e9l7Ns1RaWMwrKfYQWCD39ZRMwJxlii4TorsM9
         hgrK02h7cidiicxopLpZkvhZQ3ntik1QO9UEvRisDMGpBFQsd+N1iJMoHJWa9TAWn1yU
         xjXRNLzjuMxfMjEa/riTMAu0HZzRAxJMU+f4JAoyS+FDJ8Yju3GXgXjlfR5ug3wJr+ii
         mMC3m3+wo3Yfyffzt9fabukRo8CcmyT/8wyzuyLZEpLecjWt+1mPNmZH/2pSh1GyEYDF
         V4zwcDDXv3B3Chh6A24UL/dQwJu69qlOE3kcPif0e9pOuo1FLi/UOuFn5oHshprg5S3e
         T/dA==
X-Gm-Message-State: AOAM5322TLtKZ9z6aL4/YkVO+rAeqTakhOwKti7iryYitDkFgR8PcD4I
        0rJzl+RjO476fQIPUF4j9edPzg==
X-Google-Smtp-Source: ABdhPJzpaqsa0RbT5sEashXu9M6QUhoszt2eaPXIsUdeL0oyZG+MPVMN8ttZ0H+dYoeNEhvnCMgYSg==
X-Received: by 2002:aa7:9e9d:0:b029:152:5ebd:42a with SMTP id p29-20020aa79e9d0000b02901525ebd042amr16038190pfq.4.1603102649670;
        Mon, 19 Oct 2020 03:17:29 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.99])
        by smtp.gmail.com with ESMTPSA id g85sm11427520pfb.4.2020.10.19.03.17.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 03:17:29 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, osalvador@suse.de,
        alexander.h.duyck@linux.intel.com, mhocko@suse.com,
        yang.shi@linux.alibaba.com, david@redhat.com, hannes@cmpxchg.org,
        hughd@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm/memory.c: Introduce non-atomic __{Set,Clear}PageSwapCache
Date:   Mon, 19 Oct 2020 18:15:20 +0800
Message-Id: <20201019101520.12283-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the exclusive reference page, the non-atomic operations is enough,
so replace them to non-atomic operations.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/page-flags.h | 2 ++
 mm/memory.c                | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index fbbb841a9346..ec039dde5e4b 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -401,6 +401,8 @@ static __always_inline int PageSwapCache(struct page *page)
 }
 SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
 CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
+__SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
+__CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
 #else
 PAGEFLAG_FALSE(SwapCache)
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 2d267ef6621a..02dd62da26e0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3128,10 +3128,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				set_page_private(page, entry.val);
 
 				/* Tell memcg to use swap ownership records */
-				SetPageSwapCache(page);
+				__SetPageSwapCache(page);
 				err = mem_cgroup_charge(page, vma->vm_mm,
 							GFP_KERNEL);
-				ClearPageSwapCache(page);
+				__ClearPageSwapCache(page);
 				if (err) {
 					ret = VM_FAULT_OOM;
 					goto out_page;
-- 
2.20.1


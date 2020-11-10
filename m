Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0402AE33B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbgKJWVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732404AbgKJWVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:21:01 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D758CC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:21:00 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id e22so6649761qte.22
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JVfCx5YoVAhsMAMzq5Ib4xNDNXTPugCAXEdF/9ZfK1c=;
        b=Sorzbxjl434teafjW3faZG7zFZzfm93UE5ni1XpfIncUp10ibp8jpLYD70flrD0+2/
         /ZaY5ksYh6XtmAQzE15CeAKLXWStbYLxHdCNnUebaCqUpyj9z4JlZq4J3u8IfE10A5Lq
         Zr3qjbG+frRqzlU2wYjRNGXaopuLOQnurA51QAgFYIIrikpen/tETHXDcodSPHKR/9By
         HM+aXQXai3muVVFES7+dvfTZwk3Q1hnpbedVcj8nRXP8nq6OW22Mr8dJd3a/ILVJSdD3
         So1MJMa8xAODLMxUsWoHgul0P/PCAhB0ZKwHZbNh8Nu2VglU+Jp9Lss9YGFtCDcHEgIE
         Xc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JVfCx5YoVAhsMAMzq5Ib4xNDNXTPugCAXEdF/9ZfK1c=;
        b=oaQ+8B0gOsqOW+jDB3OzUG/NyZJvw4HiydcmBzwy5CTug4Q3sDcADJtn3g65cBi07z
         eUyDSQNx8yUMMnvGRgXdamJiydaQQBoBA2eHh9jTqHT71sT1WJFiQ+IhWEl9laUnN8fg
         FAYQnDsyAdsWcXjOp+UBnDk/hRe1JRMi1oNRZn/Omnx0WeRf85EhfR3gGRKZMZVK61X6
         10y0W13m6W5SivsOiGJNNyEx8Kgoh/t+xO00lmBTnVRcuhfsZ5UkiOyTGn34MCbWTPE+
         lDusyjWPz1iD+r9SLCmKfe1TB1aFdxilbfN/uxQ1a9xJyIJfEUCODkP/swAgz2+td/SG
         Z9lA==
X-Gm-Message-State: AOAM532G3Stf87JqZ4ETOaMsC9LV+gilCjJwq3MRPFBSJwrL4hUvSSbS
        Phx8m6x8WLiVqOoZrPZzyi1yoEge+3jCnrFN
X-Google-Smtp-Source: ABdhPJz9X4I0fQKQ6rAPw02HsIflV/nkdacrsdfDSd0mERCmB5vYjtdDNjyd6StrpyBIrGYzVfJD2gDIvmTN5dGg
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:e790:: with SMTP id
 x16mr12244792qvn.21.1605046859712; Tue, 10 Nov 2020 14:20:59 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:17 +0100
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
Message-Id: <a1c57043fb19effce240355e7c57b0d9a58d389e.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 13/20] kasan: simplify kasan_poison_kfree
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan_poison_kfree() is currently only called for mempool allocations
that are backed by either kmem_cache_alloc() or kmalloc(). Therefore, the
page passed to kasan_poison_kfree() is always PageSlab() and there's no
need to do the check. Remove it.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://linux-review.googlesource.com/id/If31f88726745da8744c6bea96fb32584e6c2778c
---
 mm/kasan/common.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 385863eaec2c..819403548f2e 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -432,16 +432,7 @@ void __kasan_poison_kfree(void *ptr, unsigned long ip)
 	struct page *page;
 
 	page = virt_to_head_page(ptr);
-
-	if (unlikely(!PageSlab(page))) {
-		if (ptr != page_address(page)) {
-			kasan_report_invalid_free(ptr, ip);
-			return;
-		}
-		kasan_poison_memory(ptr, page_size(page), KASAN_FREE_PAGE);
-	} else {
-		____kasan_slab_free(page->slab_cache, ptr, ip, false);
-	}
+	____kasan_slab_free(page->slab_cache, ptr, ip, false);
 }
 
 void __kasan_kfree_large(void *ptr, unsigned long ip)
-- 
2.29.2.222.g5d2a92d10f8-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5062B2865
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgKMWUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgKMWUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:39 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A66C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:37 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id v9so6608763qtw.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DB+H7HqoS0BsRTXGNuAwKRf0LlfChpk6LpCcjRkDvbU=;
        b=F7pTXHrBRZyanjUreyw5h4KDyLv+NRf731NUD0LblbQHl85fHVhh2SMtDJdjbhJ9l1
         V1a34qWAYst3ZvrnchN55jYNpbeKhVPN9nhWrO7QdljcZl/3+SnQrsTqVpQMZAEC/Ypl
         xY2vfRSeYdsyYSzD6VNprwV9REKHfVTvTd3/wEG3VBwT+e4mXCdawCl0lC/PR96ce9wE
         IOey4TzXaA0dCARaAJ0JINK44loqjAWJje7Uhc+dz8SCJxp53GVxit3+LRu/rRUZlAlD
         N9o3aBrKwkxkpj2OUzLEBtTHi8snIk9nPlbNFRaIy/mrBGYqTvTe8u4cUOu0cB7UJgdL
         2iPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DB+H7HqoS0BsRTXGNuAwKRf0LlfChpk6LpCcjRkDvbU=;
        b=n57wIA7GqTwoKvufBAUt6uqZCxFx1AopLnzgTmV7AgJ+gSs0KvAi/3npwtOOxBkh1N
         le7DpSyTA/zELEMx8vArGtcc4tVPV/oIQ6ezLgw6VKWQ1EgV2LS6f78b38swGZ/mcwxp
         xY/rXDrVlrjZ1F95tN3WmV0/HlUbrEA8maRZpe1SRWnw5BY7FoM91pKrX8Q1tGrru4Ur
         ajCwe9KRItoTKL9zU6ayIu4j+efUmVncmC+SVYjCYqt6aYhOAn5hBYrqa/7A1I5hqZ7u
         I3CT25sIMImitD5Xlf9tEetcEvuNENgQyNj7ePZMZx4YjmsaSWFY/yjFqCCJGPnKy+yG
         k2sw==
X-Gm-Message-State: AOAM532bLNZqOPBRICSjx/s/4+ralMd9bd2rDgp6LHoHJMFZzacTiI/r
        ppVTkTvUNibcOW4g4fW7RfvV0mXiILNHC9SU
X-Google-Smtp-Source: ABdhPJzcA8hQOxnSs80NVqCkReYj+UcQZlyg4LV+//1yN70ab39PQ0at237VgPxvdUPLib1Hm1Mg2FxPUtFHEpt5
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:12ed:: with SMTP id
 w13mr4550130qvv.23.1605306036643; Fri, 13 Nov 2020 14:20:36 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:19:59 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <4d64025c647190a8b7101d0b1da3deb922535a0d.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 09/19] kasan: open-code kasan_unpoison_slab
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's the external annotation kasan_unpoison_slab() that is currently
defined as static inline and uses kasan_unpoison_range(). Open-code this
function in mempool.c. Otherwise with an upcoming change this function
will result in an unnecessary function call.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Ia7c8b659f79209935cbaab3913bf7f082cc43a0e
---
 include/linux/kasan.h | 6 ------
 mm/mempool.c          | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 1594177f86bb..872bf145ddde 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -106,11 +106,6 @@ struct kasan_cache {
 	int free_meta_offset;
 };
 
-size_t __ksize(const void *);
-static inline void kasan_unpoison_slab(const void *ptr)
-{
-	kasan_unpoison_range(ptr, __ksize(ptr));
-}
 size_t kasan_metadata_size(struct kmem_cache *cache);
 
 bool kasan_save_enable_multi_shot(void);
@@ -166,7 +161,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 	return false;
 }
 
-static inline void kasan_unpoison_slab(const void *ptr) { }
 static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
 #endif /* CONFIG_KASAN */
diff --git a/mm/mempool.c b/mm/mempool.c
index f473cdddaff0..583a9865b181 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -112,7 +112,7 @@ static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
 static void kasan_unpoison_element(mempool_t *pool, void *element)
 {
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
-		kasan_unpoison_slab(element);
+		kasan_unpoison_range(element, __ksize(element));
 	else if (pool->alloc == mempool_alloc_pages)
 		kasan_alloc_pages(element, (unsigned long)pool->pool_data);
 }
-- 
2.29.2.299.gdc1121823c-goog


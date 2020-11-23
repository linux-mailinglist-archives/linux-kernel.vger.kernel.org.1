Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824782C15F0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbgKWUJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731416AbgKWUJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:09:41 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B7EC061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:41 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id m3so4114700qvw.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JqOdOudIAs6fCsGoOMJBOXRAJ4nBM51Q9IuLvpe9X7o=;
        b=vkxW6RZNeiKt3uDXc9cHATR3yMNcOPJqStPkUehbC/zuvJcXUjcLUlqnCHiChMMXOM
         c71zmtYoiGl5xy8iIG7mT1M1VQucOQvK1LAC5ywznp2VK69TDjuYjE4jSsbKaRpiUm8y
         sM6M/LJaplFV13/x/OJvNqf/icVGsPo2tG/Lf+RwL6jkzxr7ofjAqqsanPWI677zjgYP
         lbRjaTr3RXJWAWEbSbifTQIYdzFOZ9607IvrKeoWsbPXMOJQyh/MOW++TV1RAnTyiBD0
         rGAzeg91KocpdVKgKspqM96WumykTFfRxbnrlu4hk2QablCk2YfVGGBB8TQ2fNZAYkRT
         bJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JqOdOudIAs6fCsGoOMJBOXRAJ4nBM51Q9IuLvpe9X7o=;
        b=J921//56Vnr0OECNayinQyWXQCD6PB1+S37gQrjDxce0zbqUMOGuqmdfvKZ5SgksGI
         gLvnARULuAEVdsVFQBCUlG0Ieg0RT78AURsQ6HYaSe5Sy2h5Y4Hw8DfdackorO3FNiPZ
         vhGIVXHvsXo6MwExgEMoGR1NPXdimIjarQibkLf1Wb3bNtysBkXWoRyFGpAjYBtyaEj7
         z2otU3RzGYdb0jrrz+ulxWFqjs7fMMxHJVwiiCTK9Mp9lzViJJqB0b1CU8VpdKLegZb8
         xDPbvD/50MYwj1el8T0UI1LBN8XvyXxzU7Nt/RBZMakw/eIpVYcBj/p+w6kFnVlxjN1a
         Calg==
X-Gm-Message-State: AOAM533PRNcxotO2gxh0pAs0LD0QFUQa6FAEpd6WT0C82rNProxGdmWF
        C9us/nGXJQ5GrAmXKwsmPHRhVvUqwUt50bsX
X-Google-Smtp-Source: ABdhPJw73/jwZg0RlewlvU4441kNk0gTp+b0T2ipYrKP6rHNENxFPnemmxMhgs3u5M7bN/vqoeTq/VUwN6Xwbz1I
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:a8f:: with SMTP id
 ev15mr1201051qvb.20.1606162180614; Mon, 23 Nov 2020 12:09:40 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:55 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <ebef6425f4468d063e2f09c1b62ccbb2236b71d3.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 31/42] kasan, mm: untag page address in free_reserved_area
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

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

free_reserved_area() memsets the pages belonging to a given memory area.
As that memory hasn't been allocated via page_alloc, the KASAN tags that
those pages have are 0x00. As the result the memset might result in a tag
mismatch.

Untag the address to avoid spurious faults.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: If12b4944383575b8bbd7d971decbd7f04be6748b
---
 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 42c32e8a9c5d..236aa4b6b2cc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7659,6 +7659,11 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 		 * alias for the memset().
 		 */
 		direct_map_addr = page_address(page);
+		/*
+		 * Perform a kasan-unchecked memset() since this memory
+		 * has not been initialized.
+		 */
+		direct_map_addr = kasan_reset_tag(direct_map_addr);
 		if ((unsigned int)poison <= 0xFF)
 			memset(direct_map_addr, poison, PAGE_SIZE);
 
-- 
2.29.2.454.gaff20da3a2-goog


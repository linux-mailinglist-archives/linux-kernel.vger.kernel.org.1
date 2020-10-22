Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493B1295FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899699AbgJVNU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506559AbgJVNUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:20:06 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17515C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:20:06 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t13so1001461qvm.14
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=82GpDRN2bzlSEUUIs0zjPg3hV7sJu2/XktKPfbK22J8=;
        b=tWtwnKynPkzSOrG+zSy5kc/FMphMTKm2dq/9iFU7e1/dkaF/2JuWYdipjcobDjyBwy
         wIQC4feJr5dILPBZ3dRT/nrzycw6f57z1xZloihNJ3+gK7ipusk77GKQhcI3aKBQ2ZSR
         N/1r26kJcMOOQd2aXSW9ltDFysrTwSD0D7KAuzJ0nLq304E7w7cf++Vt7iYZclqE2hra
         w23JnppKE3gOCzKNb8lOXAgrDXBnu984Jp8yxvgvA9MRE1Xzc8XPn00MqRBYydbd/Vvf
         nMS4+plzVke/OgKnlh9IgvUUOrfSISvb3eiI+QxNns8PEhwTX5Dsqtizd/LGoNYa9mnt
         M3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=82GpDRN2bzlSEUUIs0zjPg3hV7sJu2/XktKPfbK22J8=;
        b=ZWlmLiqRtkUNlbRwOarf4FITDHjG3hElEWoSwu+eaNPbVLkKiyh0cb6BxEm2TAC0iI
         OVkmCS+rsu0IzUCP5BSiYQyYu1zrqR2/HJ91U7MoA29rkO/tJg3mfdCUE3Atg3gF3P1h
         Ca0sjw5g9ElAmrIx4zeGltmqqEC2UUo7+6bpcx2AgK8KCeLhf4RS6TmwxpK1WsTyagcp
         j98iQZQth9C9srIXHzIVfZ5KEfdx3xjRGHq/WiOhrJLyK9A6pKS5iokk+W7rzW4P7YZB
         kCW9o2NX9F7DJk5GGPMYIc/umLrxhE771cdha68rg7WXstmGc3n7n1SeJ7i3EuPoF/Qv
         7smA==
X-Gm-Message-State: AOAM531jutTgao+9t8fSVy+a+xXZrUn0y5f89akRJgNunddw5WganA0v
        ebuxod7HNBZ3+1pBoNgxxqwKh+tnr9EN6LjK
X-Google-Smtp-Source: ABdhPJzTohZHh5HournX+riNqfWMMNH1faYgSuMJ/kor6Kn86pEMP35j+/Fvz9Ycg0Qh5XDdJzsdAhfctEmFzy3g
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4ba8:: with SMTP id
 i8mr2334507qvw.59.1603372805117; Thu, 22 Oct 2020 06:20:05 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:19:09 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <f7b6b3b784e80d3ff82012295503def6164be657.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 17/21] kasan: simplify kasan_poison_kfree
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
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
need to do the check.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/If31f88726745da8744c6bea96fb32584e6c2778c
---
 mm/kasan/common.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index a581937c2a44..b82dbae0c5d6 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -441,16 +441,7 @@ void __kasan_poison_kfree(void *ptr, unsigned long ip)
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
2.29.0.rc1.297.gfa9743e501-goog


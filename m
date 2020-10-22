Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4821A295FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899524AbgJVNTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899491AbgJVNTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:19:33 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54585C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:33 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id l23so346718wmg.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5q3U4VLFNuW4Say/+COEa9cSd+BCTb/gfYzQFqbrIt4=;
        b=s9oM5iH8DyztpJ3yei2iELfje52kmUcHTd8eyzbMwAQSbqFtWHjatQDduusnEXcBlF
         dRcEZe7WUb2zjkKKb+HrmDJii0fH3LewAeHtE4bfLxfxNB0awQTKOED3tKnrbtywAlmZ
         RJsxxpdAFtW5V3dmIz/CVR+19BKDULMG6qzSLXojtBknlRQx9kN4tTCncVdHJPA8VUw+
         ntbNj4QyHwsTBqXjJyzC4GHrQpK32UiA4tB+hd9+MQf5vqF/urDWATHcyIIPeqmLx/5g
         KDMHT07LfkP+rVyJQx5//13B01/a4uwGjMKhjHmZSq1H44/nxYNmf/RuVz3Hw+mGHk0B
         ozkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5q3U4VLFNuW4Say/+COEa9cSd+BCTb/gfYzQFqbrIt4=;
        b=t3zkCZgRelubaPfKR8n5raUp9M5PK56XEj/8wtjtTvfatRFko+3nTTUfCxUWaK8ipo
         ufQo7kUOiQW1/EjzsdgyutHRQ9fFePb0yeMHOYW1jcMSIXXwYvstI7SFsexc2MlI0bSE
         GmiACWUn+DO0y3y9VR080vVHLIUvCugp1PMYmkeMIV5nvdrij9J2FiyzSFQ9V0aY9q0H
         3s6RoeGh4atfiwaRMOaNX0BFU+liWcDM0T0PiZiIpRv4bBbPEmTUrzJyZXGd9nfJglKF
         lGnEKGioKWARnNiPXtmZI5q/cwaGdt4B/mETVLBpWOwLCCRJKSZKOdWKxsstvUs/8uS/
         R9dw==
X-Gm-Message-State: AOAM530l94PctdemVkfucctgP1/HpREAehqPYh6gIiRdDjbdP6L9nWiO
        tBTMbypyV5B0zSyx7+4O63eXXC56PhSOaQKC
X-Google-Smtp-Source: ABdhPJz4Ufp39mZeum3PfjjYho0JpryDj6izuaC9cJUX07BIT7hBs0Dfy/fZBFj7FE4zj5eQxQAoPX94JecMHeSF
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:4fcc:: with SMTP id
 h12mr2880700wrw.132.1603372772026; Thu, 22 Oct 2020 06:19:32 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:18:55 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <595f9936a80b62ab89b884d71e904eaa884a96c2.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 03/21] kasan: introduce set_alloc_info
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

Add set_alloc_info() helper and move kasan_set_track() into it. This will
simplify the code for one of the upcoming changes.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/I0316193cbb4ecc9b87b7c2eee0dd79f8ec908c1a
---
 mm/kasan/common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 8fd04415d8f4..a880e5a547ed 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -318,6 +318,11 @@ bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return __kasan_slab_free(cache, object, ip, true);
 }
 
+static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
+{
+	kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
+}
+
 static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 				size_t size, gfp_t flags, bool keep_tag)
 {
@@ -345,7 +350,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 		KASAN_KMALLOC_REDZONE);
 
 	if (cache->flags & SLAB_KASAN)
-		kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
+		set_alloc_info(cache, (void *)object, flags);
 
 	return set_tag(object, tag);
 }
-- 
2.29.0.rc1.297.gfa9743e501-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587C32A7393
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbgKEAEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbgKEACo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:02:44 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA77C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:02:44 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id h11so85225wrq.20
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vCuap+Z40WCfgwTrVBGRXx2rimwF3+Nybx2YvcmvQUo=;
        b=TKDRruDc0EPKdW5qP5kZx93U6ILuVOKa9NRxOsJBSbrsNehB2La/XSXsAe/9hQyaMk
         yCK6FVozl9zmqc2IUI/9cYSE7LNyU/0mpvnpHD2T8bl7AVgkRNS2UNY1OunTzaHIAXdt
         FE91Mn1bMT+89GiGiG+pSKXKCCCi7QTzrqooRDTGgQ6Ctjnx1U3rrYtD1VR4mL6FgcFK
         c/85JUoGFBsSf4jLoyMoeAlfhJucBZFp+w6YrIBmmw+RbFgil2rQH+u6WqYjog3CXg9X
         fu8SkOWMFfLel2sGmtiWpsbMBhumZ52ebQMgrd624Xe4e6DKIvYVbygT2KF7gS/efkdd
         Cm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vCuap+Z40WCfgwTrVBGRXx2rimwF3+Nybx2YvcmvQUo=;
        b=H4lgqCh9RA0QVknp/7n1ix2OhWAU1a8ho5n1jSnfPCP+QXTdI900iW9nyDqm12AJiD
         3QLHFgDWFa9br/MgLjWT7bi5eHo7Gc3dLautNUMZ16cQ4LMqbJ1lEQ4ztT5jtjsoJT6q
         PYKrnPqQU3x25unQAZiWcU+svYQIykapNSJASaCY/PVeh8vcgGLudbuGOwjEiZlALhpW
         r14PwQEuZ+T758nTN9pQpKB/FSFvcOm86daLOzcF+3zOP3HgN8l+Aoc8bkkhZcgynY14
         Kx2FhTNxeG1eganaxSph3prIvW7i97YgaOlnJ4j/chvDwAMwZ9RgkIW6s9Lo8IpXRLFl
         3JkQ==
X-Gm-Message-State: AOAM530lqfUpRZpWl4lM4bloN95O7PbKhP3t3pCfCVn0aweIN4qME+Hz
        04//DLndFtjgt5qcVvct4cf0rw5P9zweWfpD
X-Google-Smtp-Source: ABdhPJwuuyHLeDdD+KHqiqHb6fDGG/rhTQChDK6P5WB9OmWfgwhMcOyy6D+DkRkEMkd2PMl1yMhO3tDZC6Em3M7m
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:4d0d:: with SMTP id
 z13mr477608wrt.23.1604534562699; Wed, 04 Nov 2020 16:02:42 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:13 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <4a32aecc6761e93d792cb2b78af86689025627bd.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 03/20] kasan: introduce set_alloc_info
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
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

Add set_alloc_info() helper and move kasan_set_track() into it. This will
simplify the code for one of the upcoming changes.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
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
2.29.1.341.ge80a0c044ae-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE3529F51B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgJ2T1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJ2T11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:27:27 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E394C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:27 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id f11so1673405wro.15
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mhlSkARMRob3d2hNT3T2VG0Irjtu7J9HetujXqVGCGY=;
        b=qQoHRGYTvDDhx8CPzlR8rl/Fv7YnCG4mvzMtHkFnrvAxXnlEQM68LuBN8/KN3GT9ZY
         85dUBgtCXyTrJNZMKONrEcUBpxkT5NPzQesOolp4nrj75QSWF+KDGRW7U7Aw0eaPU/9L
         8rvPAEgR9vr/gR6UUhmLgfiz2xvGijofjHGRD29jhBzdHHufpCWuWtCoJ7En+gMq8X/A
         WK1deW9td6bZYICS4q22i6zyq+JU+jAgBy1nvcrnAWrW70zOBSj2nfQS9q2OMg3vS9O1
         1J8pzvefuWluYyMSpG6i7Ec0R9ElzYDCTAAwWYZ82E0lA6SZuY8qzl6If+OUJRo5x4+r
         6fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mhlSkARMRob3d2hNT3T2VG0Irjtu7J9HetujXqVGCGY=;
        b=icwJCtMPsHA97aoz0bCdDxDLuSCooSxW5sTWl0aUxYcG8w76byXJc/56WATL2aQvXI
         4TYeVOBazBVKgC/aK7sF/T4/E52XBAJsA3zz27BFoh8txn32sLO+0fuLGZALnWCDV2AY
         MUwKCl6gVJuoq0BK3itYgYC/xldTy3hD+wV348mIOF+sO4HCwS19eDBEMA21FFkn0GRI
         G6QOgXwlgREuiglkMcBGTmLXF4PHmGVl91bq4FDhEPvaWT1m6OM4jLqmoytmDSMkSc1z
         JdwAKzVhaqIPMZubQfrocZ5tFZSHNYKCa/+RpS0ymPPBG6ODz9vj9t1YE1ECJ5IVUBv4
         fHCw==
X-Gm-Message-State: AOAM530vEFjktomZWM3bT51TpgP0DniHnYc9uFzddlQ1BVYQsFAJHrGR
        eEjqnD3q5CpiiWPPquLSckdQldYRiI7pji+3
X-Google-Smtp-Source: ABdhPJwsRXaK5gp9sAQ7lSICeJgN1XM0oCRK3u1jy2e5C96/zpeF9KkhGSZNT2VhLKqEN6alV4B22KG5v9NOz3AD
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:5a06:: with SMTP id
 o6mr749019wmb.181.1603999645776; Thu, 29 Oct 2020 12:27:25 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:53 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <1baff3a8f85c510057fb58e9628d670c224df8ff.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 32/40] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware tag-based KASAN has granules of MTE_GRANULE_SIZE. Define
KASAN_GRANULE_SIZE to MTE_GRANULE_SIZE for CONFIG_KASAN_HW_TAGS.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I5d1117e6a991cbca00d2cfb4ba66e8ae2d8f513a
---
 mm/kasan/kasan.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 0c1cb0737418..a4554b19022d 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -5,7 +5,13 @@
 #include <linux/kasan.h>
 #include <linux/stackdepot.h>
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
+#else
+#include <asm/mte-kasan.h>
+#define KASAN_GRANULE_SIZE	MTE_GRANULE_SIZE
+#endif
+
 #define KASAN_GRANULE_MASK	(KASAN_GRANULE_SIZE - 1)
 #define KASAN_GRANULE_PAGE	(KASAN_GRANULE_SIZE << PAGE_SHIFT)
 
-- 
2.29.1.341.ge80a0c044ae-goog


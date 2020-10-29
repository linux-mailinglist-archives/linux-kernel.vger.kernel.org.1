Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D5D29F4F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgJ2T0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgJ2T0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:26:32 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EB4C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:30 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id m20so1675816wrb.21
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qrrYQwa9ShIhHuQejhOGo+FpOBNOJz6qtkpSS2d97D0=;
        b=noqYF0LR7VN+7A6vENToUcTeHqyCDa+7yeltCLE7Z97VO7slahsorWSwAZBvMKfD50
         EIROSwX6CYh3o9Lcg8VVc1eeuGa94J+kycQZM2rXFdm7AeB0gNpT1EHbgTG/7wW7pcO1
         AHk09sv0dg3Epj1M/i4NGTI+duorac7Hvg7LL6DlFZ2nzo5avqabJD5UhGkw8knEW4WQ
         OEyEpqs80tpQmiCbf3NsTZg1JkcEnCnb1vNddXPbVuZEKjVCHm+auVWXMtxU+s14Id1n
         D9OOZttyaO6FZrZrb1Cnuylp6St0DuP5h0DIGwEihYUwyFJ535Z+CfGkaMWQkVPIEKzP
         SdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qrrYQwa9ShIhHuQejhOGo+FpOBNOJz6qtkpSS2d97D0=;
        b=JhoYuGlf73WgAPU/fmHfuAYAG8sXpK4/tU0FstR/yHGvM4fTve44elK0Z36lodXuIt
         Cz25g54YuzjMnBM2WeCOmQk6TJNYxQXvSxNd1rWN3agJvhunZf5SyenupAUB2RjiSZ9K
         K7rb5D2ZUhAyltcadzsttiZfS/ETiaBm8Anp+5oIuFpoFfS/wQ2+GMRVekHJjbL55I3n
         TNQ8ylRYHG+6GXF7jAS+cngO9wigEXaO3AMeF0NUR7UczvaFFXc6Dh+DFmoS0yiMVuqR
         HxhiLWzRZTqgOD+vRjiap5a5Uzng10grxDSXWLlFPHsfJBxkugyy2SOCAwTmluD3ve7k
         znVA==
X-Gm-Message-State: AOAM533Cqey+YWpLOONyocdkvNN7VYMI3tq8CdIVqKuIjOfk8U++lyle
        xXgqVE3U/RHPh23NgrFdwZiGuu7sL2VQoIe2
X-Google-Smtp-Source: ABdhPJzL/bdhZTjywBtpun2TTlIIelNv1ZD0FybZ0KEFFcFjHNjRjZpQvQg8xvlQSKsFkGjCeILiqzDYw3AcM3mF
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:7e4e:: with SMTP id
 z75mr749584wmc.55.1603999589356; Thu, 29 Oct 2020 12:26:29 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:30 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <0cddd36c904f3e5d6c51a1aa10f218b3f81d2064.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 09/40] arm64: kasan: Align allocations for HW_TAGS
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

Hardware tag-based KASAN uses the memory tagging approach, which requires
all allocations to be aligned to the memory granule size. Align the
allocations to MTE_GRANULE_SIZE via ARCH_SLAB_MINALIGN when
CONFIG_KASAN_HW_TAGS is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: I51ebd3f9645e6330e5a92973bf7c86b62d632c2b
---
 arch/arm64/include/asm/cache.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 0ac3e06a2118..84a8e25b0234 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -6,6 +6,7 @@
 #define __ASM_CACHE_H
 
 #include <asm/cputype.h>
+#include <asm/mte-kasan.h>
 
 #define CTR_L1IP_SHIFT		14
 #define CTR_L1IP_MASK		3
@@ -50,6 +51,8 @@
 
 #ifdef CONFIG_KASAN_SW_TAGS
 #define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
+#elif defined(CONFIG_KASAN_HW_TAGS)
+#define ARCH_SLAB_MINALIGN	MTE_GRANULE_SIZE
 #endif
 
 #ifndef __ASSEMBLY__
-- 
2.29.1.341.ge80a0c044ae-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59883277C00
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgIXWwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgIXWwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:52:08 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBB4C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:52:08 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 16so691394qky.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wHymNihP2cmvV3L+Sm6JVmAu1rhIBofqol5fTdU44eg=;
        b=JeM/b75Yz4vtsSpUoXIkVhHEK2UmRKfSzDF8tDiV0svk/SQQvkdRlOIUuh5XrezrVO
         D8GP+rtwyL7DLqtJqZnEFSCifzLV5ZHjIznfR+V3fdrvh6oLoYe+qG1a9yDqaG5O7dMb
         LJXn71dUYDfIGcOn8DOT4VThpwpS/HGA9qCRP21wHtlrF2Sax4rrIxwuQwkEVH+h5CwG
         1Ft8h3Fo12k2K8xB9dmsFqJsqA/ZDX0cSkW2Fe9zUv5fkCqkMeTU1OZY1vxhbNP2UnjO
         NR5sur7k5znV7ASaz35/4H/ICZYO91ncqOayXH1Kwv11JyfNWvkaRGvpE/sX1Ot85Mjm
         ajNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wHymNihP2cmvV3L+Sm6JVmAu1rhIBofqol5fTdU44eg=;
        b=cg8oKPqH1a4Pk8iKFEz9aSZZBypRIo+KEorHkujD7nxKdGXbtXbp/dLi8CBJmje5JA
         GfsJOF30ekt7VE+rCHIqZCbYDwaASZLfgUhj2QCMykPBeOJbebpZ5qvEeR1KRJTW7qSa
         D/jQ8mpui7pb7qdhzay/+rJz92nOtvk3IRoZFsdzfFwfaPJ4jC/JXI0ZZRb+jIYviOPP
         y06jV/aJmodTZARIDfVH8zsab3HmRjsXEx5hk51Tsq/ZZ1PxdhaFkw07/ny4BgkHMjNK
         IlkfDMDSbRI5Rcl881DDaqct8UnL4jVdZBKRv9rOPUkyyz2a1keo6hCZq9K5UTfxnm1o
         7vnw==
X-Gm-Message-State: AOAM53129yKuA7dA643r6lqMBV/+qaMdXE4foJOlfJkBDexllIEzK7/x
        y5MMZSdjA/hAoXWwttXPysR4D/XyNVN7pBvx
X-Google-Smtp-Source: ABdhPJx8I9zcdeQs79Q6VCzskVq+c8Vo8fkjEk5YqlgGGh9FbiSdwKkm4WYjYWYgctnVTC2zSHXq+lhC47ne24cr
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:a203:: with SMTP id
 f3mr1482755qva.33.1600987927725; Thu, 24 Sep 2020 15:52:07 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:38 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <42a4409413858c47677134b55c49d447bf9a8e87.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 31/39] arm64: kasan: Align allocations for HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
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
index a4d1b5f771f6..151808f1f443 100644
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
2.28.0.681.g6f77f65b4e-goog


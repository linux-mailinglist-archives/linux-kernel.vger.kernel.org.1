Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD552A2F16
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgKBQEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgKBQEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:04:50 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5F4C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:04:49 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id u12so6284048edi.17
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=G92npUQrDAzWi0FLCRrGsDUgO/xYzB+b9yo7BatUrLQ=;
        b=pVFQxBGu09AktYQjGsUevuiZuIp8P2uc/Rpm7nB+HDrnBUFO+j4DH5TvoZ9zgREXH3
         y4SZyXQWlBxpzqIkIMZoU+stzzpZV8IniPwc4BuB9vJo809BfgfqIfYwLWvaNaiRSAwK
         L9pEUEjzBBF+FE/v7xF0yuigdwpt2rhEXTYSXc1gmQjPCLXc3VxImurzeWNyfG8yJTpJ
         m56oceueeUP5vJzJpij023CAKuDum+01Ze+MgnmqsHg0ah5XqFxEJAn1ifFvOw6ahk+d
         48gnuFiIQy9hBTQT9wuBaaXCsmXLTn1HNEcshgV8RzIjdRVLYeap5lGJt3HGn2ZUd0yh
         6FBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G92npUQrDAzWi0FLCRrGsDUgO/xYzB+b9yo7BatUrLQ=;
        b=Ohr7MGTm4rZeMjDrKLyfTbxfyHNGEdLX5vOHtUHHR9kmBUIEVuPp1ofShLWur9O5hE
         K9AoEb8U24GDjkNbswcFgjpoNcGYj5nymhriDURqwubvW9YzyyyqTg8uVfCPRTKjg7al
         YxRroHBfs99yJtO4PNxRxwkvzJH/8CSo+0s+4I/xGCD00HSpwKTMfPiZZtfrqe4srHQ2
         i3kHwDv5IbsP4rIyD0cm+ddr1qGuazLPHIlZH26V5/rYyU9G7R1VQ4y/d8tZVKhKbRGE
         XyZooIk4mI6LSlYW5XG4+lqNVTCIFqAEWhxlSZ8ae8EX9ybk4Drj8zRNaJVh7XMVF8Ig
         ZeZw==
X-Gm-Message-State: AOAM530lduRW7+AaCnSkqnwP5iqoWKrHqH+C76RMqL+kTnA7+HiJLWWI
        +B6v0tVV1rlMwZPvu0E+NSUyi0pafrfCUfRU
X-Google-Smtp-Source: ABdhPJynNapDQa+98oKFs1UEEnhM037/oSJpIpMZ7UZ8DRdegNxgG10b/E2rJbftBz4QFi6fw28i4NYRT+57N4AT
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a50:ff02:: with SMTP id
 a2mr16764112edu.364.1604333088410; Mon, 02 Nov 2020 08:04:48 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:03:49 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <5d790812e7b0e8fd6747b0f2cb38de52c686de32.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 09/41] arm64: kasan: Align allocations for HW_TAGS
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
index 63d43b5f82f6..77cbbe3625f2 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -6,6 +6,7 @@
 #define __ASM_CACHE_H
 
 #include <asm/cputype.h>
+#include <asm/mte-kasan.h>
 
 #define CTR_L1IP_SHIFT		14
 #define CTR_L1IP_MASK		3
@@ -51,6 +52,8 @@
 
 #ifdef CONFIG_KASAN_SW_TAGS
 #define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
+#elif defined(CONFIG_KASAN_HW_TAGS)
+#define ARCH_SLAB_MINALIGN	MTE_GRANULE_SIZE
 #endif
 
 #ifndef __ASSEMBLY__
-- 
2.29.1.341.ge80a0c044ae-goog


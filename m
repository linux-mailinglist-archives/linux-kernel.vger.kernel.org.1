Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3FA2A714E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbgKDXUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732851AbgKDXU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:20:28 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4D1C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:20:27 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id l16so11129wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=G92npUQrDAzWi0FLCRrGsDUgO/xYzB+b9yo7BatUrLQ=;
        b=mCfoY2cp4+45Yg/2GkgKRvfDnEDWNJpvWB12xTWK0vuTdueKWw+4z4wH/YMCFxT/l+
         Hv0xXY68/PFpfZTv01ziNJVGtDfv6QocTWuS8UhH1dEoLhGPjM4NC57IoonaZnv5R2WJ
         bdglNw2z26/HvPcCEZcTzjRegrgJm1WqegqASbvaI7bo4AznNU0HAyhU/h9/rK9MQ4r7
         gnjWEDF6WvGFU2MMKwwF98nI3nailfbDiLeIVR2MkSI/4Epug2ksDDJeSB38qHs02aPD
         X/N0+CmLAvsvFNgtpwoGlIo+Dq9vDdn0FtCqeHYwM0uK2EuJLUrKQL/32w3MME18HLSE
         QNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G92npUQrDAzWi0FLCRrGsDUgO/xYzB+b9yo7BatUrLQ=;
        b=XOft+duxYC2teSlp8K3VnuwR6mMg7oQ6lIIgb/ulM+Ehc+BL96oQRaT+jEfwW+Zs7h
         td4nM/g+Eg3FXrwO2y4B8Uh6/5XG3MFARyoAsiaiBh9yqtTkfJdQX2JomABxlUAGRDvY
         Hs7czc3zQBcIqqkFAGsM43s68jJWb8zLQVTyh6kw82BByrK81WPdXjKjeZVb4vabqBTz
         N0Rd3hsDZjWlBPH7NNfbSe1ACsOW8/hKCchtobwKRthCe8oyoPzxuNvGV1LO3AnBndmL
         q/N2YdAPzgwa2wu8JxZGdqXRJVsmtrR54qcT1BiZXl8mcUPwGOmXZBPHTTCl0eoAl/mD
         JImg==
X-Gm-Message-State: AOAM530jL7juR2qUt+kukVv4R/o8YulBLXh6MxAeArGxcquM9rReihpt
        AaA9GOqbmU4gucd8FmTqbS19BP1DQXPhjl2F
X-Google-Smtp-Source: ABdhPJx59gSlNtnljRSf78Gs8PUkWDU/z1CEhdhhdjWGvP1/TZFGc547IHN93oLb7XLzSvMvsn8pTdlZNiT3UTMi
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c772:: with SMTP id
 x18mr38926wmk.185.1604532026477; Wed, 04 Nov 2020 15:20:26 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:48 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <3efc77f8b7ea2f0820524fddd4caf1a14fda94b9.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 33/43] arm64: kasan: Align allocations for HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
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


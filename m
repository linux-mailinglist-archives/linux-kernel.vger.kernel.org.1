Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349652C15F6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbgKWUJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731538AbgKWUJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:09:44 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552D1C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:44 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id c131so162322wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=npUOT2sfAgaDvlkN46GsxTaKsomnY3H/Y0C/GfI83qM=;
        b=cDTXlXdO/vb6GqH2AwfijuMT1JYrpDmbZtJdOxCsUahYeRESOZazEwfL2QDPtQuJrB
         Z5GdgKHhBfsbtSQvGsnUnIBG1CC/irD2nxMHInKgpxlli72UTlAtJczt6bIY/EJuIMZv
         p2KdpNbSwCXIZgnskmu6aw6m+FacrQ08R4hpJ7rXQdlRbJt8t4bT7O2C8ve/Ia+tHEXY
         JRP4rglI1hNFkKmuGYnEhTeudT4eP/l0buo+xuvYm77PQ/T5jdtEgT0DMQqWFzAY6ISJ
         bVtjDp/F4fsITeajL9hrQ3z8FC5qgGetFpMzANV9L1yUjEPuYtmgsQ1h+jhW4zmyDTVS
         bSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=npUOT2sfAgaDvlkN46GsxTaKsomnY3H/Y0C/GfI83qM=;
        b=NXX7gDWsifh0J1zanhdR2jd4VNmzcc7NnQR6/9VZM9Pi6WgHU5o9gvR5CmtB4HVVVg
         TungFxOJFbJm5/3kgnmlwA3Z7gvQ3eGw6bul8TPcXdVtMhg6g6TKA0sIziOdkEMa4pXj
         oNJPAu9q4YCk0ReHFXupK50rmsy57D9dLlSQbLhqvo9pkJGJR1lBIfQczz4JMIjh/4lN
         3QeQsvejAcY35OB6lEIKvb5MDbdn7nGlCDoHGNy6989OAasX7x58qmJ9U+AinXPNQwxf
         l2djDHoFMJxqgA3ed/2eOhpH5+E2VahwSzG/pu6KnvSiC0MqB7p7lAE0ykFFgAetdO1G
         dBQg==
X-Gm-Message-State: AOAM533eb1r7hdLvVCTdmaeb6k0mRlZo51ZGQCwBKN/4a84jP2IMSX2F
        DQ+Hhn2PiY27rKH8EjcsYiTQ+ucKUMpp9e16
X-Google-Smtp-Source: ABdhPJwxMLqE2NZJqFIp+jaTrGYPBNL1b2AKQeMMzDyq/h8Fv7lSH2IM5pKIBr9QQlVBq9KLlMMxWz40k7moM3q8
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:90d0:: with SMTP id
 i74mr1449685wri.288.1606162183048; Mon, 23 Nov 2020 12:09:43 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:56 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <fe64131606b1c2aabfd34ae99554c0d9df18eb19.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 32/42] arm64: kasan: Align allocations for HW_TAGS
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

Hardware tag-based KASAN uses the memory tagging approach, which requires
all allocations to be aligned to the memory granule size. Align the
allocations to MTE_GRANULE_SIZE via ARCH_SLAB_MINALIGN when
CONFIG_KASAN_HW_TAGS is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
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
2.29.2.454.gaff20da3a2-goog


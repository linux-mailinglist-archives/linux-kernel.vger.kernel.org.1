Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F3628C307
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388538AbgJLUpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730818AbgJLUpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:45:15 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5490CC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:15 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ec4so11432410qvb.21
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FuufsF1x9ec4dgxq8sKlKc4MR/gScIEfRdtwwlGog8A=;
        b=uvBp3SV/jryGDaqxOATb9bs/Xd1P/njw3Cq6lyzdIppKujjGEYNyzMLs9fjDtpuqF8
         DaDg1zJrPSxvQqBPgsIpWRV00Vm09Gkbm2VIduBwy/kHF21yKg9YwiKDPCeIL549VzIq
         Cu24/gXJidqfD4Njn5nN6VSe6ahqHF0x6G3pzXRcMh3+Rk9cA2Ue735XrFt652RMIbge
         uKYBbehhuONRR24pex6s81V+SUtBqeUcDyjNX4fFxEVfGPnRdXIlKNjisXtt5HJhO6uC
         DdFONL79A3OLve+FXk3nLl7CX//cRNDgnUV9H23cZSjUvsPH+ePs5HskHPzzk81HXrRy
         apsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FuufsF1x9ec4dgxq8sKlKc4MR/gScIEfRdtwwlGog8A=;
        b=PN2EHB5cZneFMzX4Rw/5NmLBVeYpg48PIEXKazR+DNzRrFIUfYm+Ri4uaDNrNNVivc
         mMKPHTzXgnzxFzaQiC2bNQdFf0q+1KsoSXYn9l6QS6tj8d3F9+I6H7Aut5wxbBz0KduP
         GJPcKwbeScZBIh0qCMYMlO2cmVFZMJtPWfNOeWIWcFtzJRBNQoRlDgRJBZRkm/9kobu7
         xMuaZ4hFiOoI++DbuXfWywOzIx5HM7jj2ZP5fZ9O96ZrLnzYL6A7613dvtj3jA1sjoNE
         xtNOrk8SFzPeSS/23TcYupCQ5MVVuhqrRWPmzhdY9y3omXIMvrdHmc8c3fS2g3fmeu0E
         wkTQ==
X-Gm-Message-State: AOAM531/EWjY8iQkIIxhT5MLC4ebVWsGr3ZbuPxIOeo/nLZuPy1CNk/T
        P33IWMxER3GGdq24atwMAIqLG4naj1kOpiMx
X-Google-Smtp-Source: ABdhPJytdyhvhpYG0DjsuY7msRRlmnxGW1P5unA8SWK1MlyUcgA96ySfWuO4LcU4zEZrKHe+tU2F0mkirmhey9kp
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:192d:: with SMTP id
 es13mr18205918qvb.27.1602535514492; Mon, 12 Oct 2020 13:45:14 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:15 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <67dc921f4720fdc5a33d747c9419a1fefb33e201.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 09/40] arm64: kasan: Align allocations for HW_TAGS
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
2.28.0.1011.ga647a8990f-goog


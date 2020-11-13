Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A9E2B2858
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgKMWTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgKMWRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:51 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5FCC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:33 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id x2so7548189qkd.23
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8wuQS8Ui6lRxf4z6N6Fb3Z17fSYd+0q/Aq0OIY0oU2o=;
        b=nmTDGdvSIrwGYCxUGHaPrQAsQ2W2CBwqJryIGskg+mWj65n2WgSj2IFrfL2X97+0Mn
         6475+IfrtPqiOf5BCkXNOtKoBeqqFoPC/pnd3b79iQRoSCj2GiDrsVpJnPFi+i5GMVUk
         DdVqXzISQaXLCYMqPf3W+z1iS6OxRF5TF45k8DGwfoNHsbRR9beC6FvUQS7ioxxrmnHk
         3bJMgxuKzw2UYDKPz12ZcAISVuCaM++4QzdeUC7LY1Av6ht1uqoK9jp2d6KEbHGo1hOX
         9L6Y5vsSboEdPLpy9ABKyUxvu5BQvzyPYGMK7hKJ5OCheKNwPh59OCdZYnts8heG0Fpr
         LjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8wuQS8Ui6lRxf4z6N6Fb3Z17fSYd+0q/Aq0OIY0oU2o=;
        b=cabyq5ro+pUmF++HUYOu7B+HRwIU7546PFhUsfQLKuIhItuWeurXQU1YcqtzkhSzkf
         dHuCoBVFc2prbzkqAWTAk062ZpQznCohcbTvUPPcSo7oI/cmfKsjYScTwXKlXuYKXsUb
         ybVGyADdvkcgcZDWHLK2Sb44LMMOzOkpXmrZ3/fibQ1zJ+5qyfgwhQrY8Tp+8RaYVbbW
         c0QQ+KE7+Lx/AkiwwK2djO+H9zb4mcV4p2XLmdFQpX34vThlZ4W/EABBP+TO4ETdY2fE
         ebkQs0GmwZ+5CZMuD3gijPgOVDtpP2BMX7T5vYbQbXkrrffqLcNBB6iU3hDAjMoSmk6P
         yY9A==
X-Gm-Message-State: AOAM5325/wgvmTXdszXJWuGepFsDocGMaGkEFwjRRcJlhH5n8E5EBQ7D
        EitIxXIzCwRJeESs4nybPLJz+lhw2zReQPOm
X-Google-Smtp-Source: ABdhPJwm0ivH+1FvXBRCkLSjJqA80NsTUMDVrQFeZWypxtKlsu/0LKPofR4Agm76uPBYpptr5KeWeCLyPe7q6dQ9
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:c709:: with SMTP id
 w9mr4788537qvi.50.1605305852387; Fri, 13 Nov 2020 14:17:32 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:16:00 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <3d2ffcbffff7cdfe60d10493081f82205c181ba7.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 32/42] arm64: kasan: Align allocations for HW_TAGS
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
2.29.2.299.gdc1121823c-goog


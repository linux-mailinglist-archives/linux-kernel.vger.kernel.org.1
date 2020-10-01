Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE73F280B2D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbgJAXMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733222AbgJAXMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:12:00 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8BAC0613E5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:59 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id o6so133952wrp.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NeJpwcUoiisJbm1IU+MKWZ9xhPH4pDihjUaOi0iEgto=;
        b=aGW3CnkbCkBd4mrgfpp33M7Dfq5DJBZR8bDKf9WHW80LAmKH1wU0HKSs9OTGBzqfXY
         4jzvOdsPuHNLxeWpYb30RrLjn3/m9h1J0mHQGPzcjTGQHFf/2jSCH9ORpxQLvKqeoa1c
         Zkk9DVDs0Vms53txO50aSgZdG8Ikt0Y7BixytGr/JkgpkAqMtS1zFA9ih9VZ2Xtgh3Jf
         zITus9QBwsUrnJ+Ff8GR8yjIeM4pEw5EgstCGrBe8HYUKYfie4jf/ill3fHRvJWDif68
         UzP4sBQnDKZkNfxkqLKlmOuIDlBPaMY0TpyvadR8/f9PGNoFapOHwXAI2kxboW8glQcA
         WZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NeJpwcUoiisJbm1IU+MKWZ9xhPH4pDihjUaOi0iEgto=;
        b=Iwsj+uAf/BDCdpzV4KJlhQa7ru4Dg/LsTP0Kbmb6hkfR19RkZnkrsHkp3a9qRNVW7k
         a2dAaeS1/fIHyBba5V9VpKvwtfTDTEdB06KcdrLBEuRIZfHbW6KxTMOM4rnASDrpwYqB
         ziwam87dXsuUuEO5RCyvMHQfVd6UN0X/2jUP77T+ovlsRdB/1llpQ/x0kfv/4JjqnoUG
         iGLIueSGQGybazZy9clxR05/Hp92HvRBDn5qxSkuA8WsIENjc283WWA4VwEDzXlliwfS
         pEzn/Z6uXAxCxKbQxI+KqSpOlQelbSBNppXwSa50JfWWR8w/cjzalC8u35lqWkIJ44Uo
         fP1A==
X-Gm-Message-State: AOAM5302+G7R0TLE00pug2IoouFtwjg5P3lKd8zFOJVxvFqhEqnMBp/p
        67H2cyK0TH4YsZpwWzeS3mv7P6RsE75WGkDu
X-Google-Smtp-Source: ABdhPJyn80+O1CQMSOze+9Xqz9K+dDTmBuD7Qqm/K4dshb7TGH8p3xJ/3xcsBvuhwsf4kj43OFEyO1m5MtH2nBkD
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:22d2:: with SMTP id
 18mr2181468wmg.145.1601593918669; Thu, 01 Oct 2020 16:11:58 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:32 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <def198b749be0c3b6065cc853a7013afac45316b.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 31/39] arm64: kasan: Align allocations for HW_TAGS
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
2.28.0.709.gb0816b6eb0-goog


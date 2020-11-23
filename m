Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52182C15D4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgKWUIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbgKWUIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:08:47 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A605C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:45 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id n12so14441752qta.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OXazw0I6oeLRK+aCYmOjFIB4MLt2eUKUeL0RxFWmIM8=;
        b=uY5LZg+UwdiqaGPDeNSvDU26KQ8vIKer+TEuj37rMjsEmiRCRkqQ6q6tYpGMekWxVt
         Kz6Ti1mxjCfJY6wtwnDD1Ynm8jH43l4mZBVPvIbqoOa3ciRd3Qx3HtxGE3GV1o2hYR+o
         3zo4KBsUptvfOKheP5TEUNfl5HEaMCmgD8d7zS2cJV4qndA7qtsuV3jUNgAAAMQLxTnU
         Eiky53BjqPsH0zvqdNSb0Z3ogXlXsLpkyxdfyEZ+7Puw7dJY0N9H8pbTMLwMAmkkexnn
         r4/Y1FyXS6JYPzpnC6Cd3mI3RzL/L2r+oEHHexFPuB40z/9uz2N3kiEN52Qq0t4hfFRR
         kw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OXazw0I6oeLRK+aCYmOjFIB4MLt2eUKUeL0RxFWmIM8=;
        b=d8A2DcR0BFKzQ3stk2ZzcDEEYoQ/ngbvvTKWruYHTUajikfOhC4pjwJh5z35Dft4n5
         KLChZK1mtVOYiHYbIAiJ0YM9qwitpZA80Fp2+efPRv0H0GRsV1xINxzOz887o337UkRl
         FikZomDOET+IRJEjXXjKHGbhpey1KShgDPspaznouHBs/kuGu1ENJ1ibrZIKdx9o8m65
         K+R11n/fUkUncK//BfRie2WVaYCHgh26jozpznYWYX+nVyNiMpyq2VOh6LTgrOkuWCY/
         Mzo+SW2XV36Kv1y5vnuRkoniJH5aAgpUmYhrLwsehKjCSh3FDMBxn6vBuN2PVMKZ7xrx
         JrsQ==
X-Gm-Message-State: AOAM532fNulqqfhAJ8U/ZRnzq5shPWljv/UP8Joa30uI6BiX7ApQWSJS
        bFTZK8fUG7hKluo5hc8zn80b1H52mV1O0mio
X-Google-Smtp-Source: ABdhPJz22ud/PXO8phnLko2cHn56ep4euY5DeHkzZKbHlVpubcW966v4DWRQqWNvzlvRK9Fagsf98npD01lzyt6/
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:366:: with SMTP id
 t6mr1124442qvu.58.1606162124786; Mon, 23 Nov 2020 12:08:44 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:35 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <c1cc0d562608a318c607afe22db5ec2a7af72e47.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 11/42] kasan: don't duplicate config dependencies
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

Both KASAN_GENERIC and KASAN_SW_TAGS have common dependencies, move
those to KASAN.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: I77e475802e8f1750b9154fe4a6e6da4456054fcd
---
 lib/Kconfig.kasan | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 58dd3b86ef84..c0e9e7874122 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -24,6 +24,8 @@ menuconfig KASAN
 		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
+	select CONSTRUCTORS
+	select STACKDEPOT
 	help
 	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
 	  designed to find out-of-bounds accesses and use-after-free bugs.
@@ -46,10 +48,7 @@ choice
 config KASAN_GENERIC
 	bool "Generic mode"
 	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables generic KASAN mode.
 
@@ -70,10 +69,7 @@ config KASAN_GENERIC
 config KASAN_SW_TAGS
 	bool "Software tag-based mode"
 	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables software tag-based KASAN mode.
 
-- 
2.29.2.454.gaff20da3a2-goog


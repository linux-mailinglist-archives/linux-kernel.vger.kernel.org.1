Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACF2277BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgIXWvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgIXWvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:51:18 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C98FC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:18 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id y53so528026qth.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=it1AK7tfxDHGBKnxx2DLY0hRUu4OKaOHj6i7en09YKs=;
        b=ALi2C5kOqkl/OJRAqsulcEdcFKGun0cgHqBtYtnF7CoZ6IzGfEqOeuPh+rRh0aasWl
         UBvXSIBuGS0GUoUW0lkyDopiz98Tl4rWLVi+dbQ8DNjPJebFR+6Bu8XC1zaF4MZ1NEvg
         UYwyhVeyXLta2Kr6HhgOcAqMKeQ5rjXtXzpPDKin6ZDyVjDYe6tqjHG+KQbhiX1mE0/G
         4J/FPR+xoWKEHNSbXdgSztp7NC6Bbej1i1VxJOfR2QeetqQDzNYHYK1YJCvkLOODROJL
         JmsB7UL0Y8WH7QW6XcCXmrwUddUrG9jVy1KLdCUPwjYNPeTSgwLOqB9Pm++fO5Fakd3w
         HIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=it1AK7tfxDHGBKnxx2DLY0hRUu4OKaOHj6i7en09YKs=;
        b=ZZE77odv5hXKw264I//Jqg1OaxxwhBdnhfNvEEXbhiw+VoQvWOqybZ8TPiiVTSP8Vu
         /1F7TDTMIbJNYOS0FNVrp4TfdRT23/9flUMyHsPakujqE3Bg+iWC/e05NwBOm8iQ9bAE
         CM0W+suewmqIO9XaGpTMc/eAYj3zPNIBofyH6ZO0aHK0BzTMkjVzuq6PRz4L/a1ZBEV8
         gvK4mShUh+ygkeT9utqF8yKE4dB0i6Q9io4w3JzknW5GHhXvO/1VNisrigICAL93ayI8
         j+uCiMUI7raBOpS6G3glyedaY9qGzpa1sVCnxrNe6qiCSMBFITam7Cx82pD8IphnQ3ID
         f4eQ==
X-Gm-Message-State: AOAM531HXyKB+50drK7ADfMo68ZaAKI8Fk0Ha1yxGv/Kx0e+fPYfrkWY
        fIPOA5gKAAL6epP3dzrk0qHxC3PxIiouqLRQ
X-Google-Smtp-Source: ABdhPJw1mPsBqvnTly5uEUo9UZOPr/SBw4BYLoKJFV8N0XtTrQHO+QodTG8/EqrEuCZQRq+ys+3yD30P3jSqaPs4
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:43e5:: with SMTP id
 f5mr1567528qvu.12.1600987877306; Thu, 24 Sep 2020 15:51:17 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:18 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <728981bdedbca9dc1e4cca853699b6a6e8f244e0.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 11/39] kasan: don't duplicate config dependencies
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

Both KASAN_GENERIC and KASAN_SW_TAGS have common dependencies, move
those to KASAN.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: I77e475802e8f1750b9154fe4a6e6da4456054fcd
---
 lib/Kconfig.kasan | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index e1d55331b618..b4cf6c519d71 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -24,6 +24,9 @@ menuconfig KASAN
 		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
+	select SLUB_DEBUG if SLUB
+	select CONSTRUCTORS
+	select STACKDEPOT
 	help
 	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
 	  designed to find out-of-bounds accesses and use-after-free bugs.
@@ -46,10 +49,6 @@ choice
 config KASAN_GENERIC
 	bool "Generic mode"
 	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
-	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables generic KASAN mode.
 
@@ -70,10 +69,6 @@ config KASAN_GENERIC
 config KASAN_SW_TAGS
 	bool "Software tag-based mode"
 	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
-	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables software tag-based KASAN mode.
 
-- 
2.28.0.681.g6f77f65b4e-goog


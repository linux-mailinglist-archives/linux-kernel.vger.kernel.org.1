Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03ACD2B2813
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgKMWQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgKMWQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:16:43 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26E9C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:41 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id e22so6598439qte.22
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DZs6bFexaQy6yZkAFEYlodVB+nboZ2AhHoU7HLOcEg0=;
        b=kVmEhB1R5T68qrqH2PCIT6I5z8rEfjQuVHTq5q7U8l81DHwSIZEsVQgZzDi3Lfxubd
         gLWqAgzUmXrd1yfnWchIW4l56Mig9Gepc/i62Qc+zuoD2cES+pyW3eSWDLtHJACB/Arf
         vf9920bMd4Ou9/bL75uVZcZLQwYnzwo/YL7C47ijPQ6X2lwvoj4s7fSuiAaUaKWzq2/f
         YaAB3TR637XDcl2pShdoLoHjzs+dAm+MMIuBqg+xTqn5rEqt+EH14C9k3lNbfkLMovbm
         JQnsDc2Vf6PsafFF0QdXnHUspBfIM+xfgxALHcMIKV/wZhSNs8NfpfOl/Yn7Vo/be8ML
         WFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DZs6bFexaQy6yZkAFEYlodVB+nboZ2AhHoU7HLOcEg0=;
        b=kZCnIcIPIIX09oChks0c4csdMPsA+ThJxJ2RkUDKLjTzBl4L4j9HCAJuniFMlWrpeF
         +Qo4kpHv2Ii2NJNcSzns+K78wm5tOD4w41QYxjmyyl+tvLUhLRQTuKyOGgPXTHJGgqKM
         tqLFuzchcFHlpXxEhJIfYpwuz89aDsR6uLWGAWrODvATbP478XXRoK62ni9kZNjDtAQD
         k8dAm/PyrhvULkk+xaGshKRXKIZ5tPNx6e0J2n4Ai7WUT8c15PdZM5z0Fp3sg08P9epP
         YJZtDiF7GMMCgCcKMZiuk3DEEzN1e1K+KgGCCPjBP2hIDEj2VuIbnIP6yBYxr+Hbz6j7
         fRVQ==
X-Gm-Message-State: AOAM530P2v+h1lNFFGEyP0rK1lsqgUGvAkvyiC9r1U+LKBse86nReF7e
        jO9jxiyMsfIdAfK2/C9lAZdM978146/WSj44
X-Google-Smtp-Source: ABdhPJw2QKz7xJKJVr7+hZNeS2r4GFhBSesJcVBc6VZYBvJAw/C5eajSCZzQapV+YlR/EQO3beeBj0zFVtjBdtJF
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4d84:: with SMTP id
 cv4mr4847839qvb.14.1605305800860; Fri, 13 Nov 2020 14:16:40 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:39 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <7a90eb85cf1f3bedcefa74bbbd73f9b532bcdd46.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 11/42] kasan: don't duplicate config dependencies
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
2.29.2.299.gdc1121823c-goog


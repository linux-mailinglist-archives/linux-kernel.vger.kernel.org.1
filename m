Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB66D280B37
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbgJAXMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387628AbgJAXMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:12:08 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB15C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:12:04 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id de12so238371qvb.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=avhnvpcdCzsaNfGYEey/eQHTKDiaKIA9undXAy55Bw8=;
        b=KNwdqefk36p2HEpaZfVF5DhKCghwtU0IgELgXy9QnRwa8c+Lnl12IZ6fpscnRyFniv
         HUGR1zCI6BQ9Q9FRZBzbVWUohRmJbl+7Gpu6TA8NHaqNpUgiiJnEWNMPM74O084V8cXF
         +au8LuqVHVRxZHwtT6sVCZALTzAClLeqOUNhVjTzXXoHrdYbptMb6fJK6eUTjgvKb9pI
         Jxg4iir5BfEYC8enud0IzEDMHJ5HNH4nSISa+0do3PtkFOQ+FLMoRAQsezFdK52NtgBD
         vs3qqdkRaaeVlixCpdnU4AVPV1MMZCVuNmQlX6CAaJnFjA2lyalX/K3uUKwf2/hXJrxE
         W1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=avhnvpcdCzsaNfGYEey/eQHTKDiaKIA9undXAy55Bw8=;
        b=kcp3VExSZ340vG/Uj1C0jbg/YDOc3rSYUoufF/YicUvttwHbN5SoFty+hDgg8l1MWM
         fe1OeB8+Wtf3Jx039kXq3dWW6vdrkqqxsH8TS9a25Nr+f/N9lpnBvqU3nTNS24aTJaTP
         opgOeAPntTAw/W8KKLqG3mhgNK25fryrW6gauHVvTJZNbBOYc/sYwbUa2FLDukfxemH7
         sfDleRb27ZvsOWbchoCemJJ/H4CHM9N/mT04YFKAwQROmtmUTTA79z0x0qegvITLMkRs
         hzTLeWYZOzkWTDihNXx7w0yMBRL2ua8v3RsqOFbOCVNItdB++66CrCJdHJa5153iKXXr
         OSCQ==
X-Gm-Message-State: AOAM531sBoRGxsEA+PR6NmfZSPaBT/JlOcmJ8ekXk1Q0ilksmV0WwCQa
        LxRozbBQ2C/JlSxpXaNs+Z+u+uKu2GQO/yiO
X-Google-Smtp-Source: ABdhPJyCth9eK0vr0tDXn0cfgf0UsvDJmV1T+GmfvGSUaT4Yj1JF25ThMIrEu6N+Ro1lRthByohDgq2+g6EnxSdi
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:a899:: with SMTP id
 x25mr9459301qva.46.1601593923500; Thu, 01 Oct 2020 16:12:03 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:34 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <21a9da4e730050d421eed7fcefda2db508c730a4.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 33/39] kasan, x86, s390: update undef CONFIG_KASAN
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

With the intoduction of hardware tag-based KASAN some kernel checks of
this kind:

  ifdef CONFIG_KASAN

will be updated to:

  if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)

x86 and s390 use a trick to #undef CONFIG_KASAN for some of the code
that isn't linked with KASAN runtime and shouldn't have any KASAN
annotations.

Also #undef CONFIG_KASAN_GENERIC with CONFIG_KASAN.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I2a622db0cb86a8feb60c30d8cb09190075be2a90
---
 arch/s390/boot/string.c         | 1 +
 arch/x86/boot/compressed/misc.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/boot/string.c b/arch/s390/boot/string.c
index b11e8108773a..faccb33b462c 100644
--- a/arch/s390/boot/string.c
+++ b/arch/s390/boot/string.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #undef CONFIG_KASAN
+#undef CONFIG_KASAN_GENERIC
 #include "../lib/string.c"
 
 int strncmp(const char *cs, const char *ct, size_t count)
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 726e264410ff..2ac973983a8e 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -12,6 +12,7 @@
 #undef CONFIG_PARAVIRT_XXL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 #undef CONFIG_KASAN
+#undef CONFIG_KASAN_GENERIC
 
 /* cpu_feature_enabled() cannot be used this early */
 #define USE_EARLY_PGTABLE_L5
-- 
2.28.0.709.gb0816b6eb0-goog


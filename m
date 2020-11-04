Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DAF2A7150
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbgKDXUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732884AbgKDXUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:20:35 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3344C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:20:34 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id z7so17015wme.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7ejNZAMa5/1JIms2ONCukWsDh69PgCTWliqLjQNgQ+A=;
        b=OANIlywW0h+etUqkMvJcuxZ3OuQuc0FWR+2EY7sDDa2J4qYPs/EOi2qPBH5yWF/4h4
         MDg7mZ+2i/a0GONk70Rod9wKNyIzgKbv0SwcpyA2jnHPIyGVP0NaXFpp9d4w3Of3ZOJ+
         Ond0JaaMErwVbx8ixmBT907DBmgt85JJ2j3lnA++zynBfLtWZmhEK8EPP4ocJ7MXmO3W
         iKz7NrpJqkT75IuVLBvdPnlQ63Uw/NyRITsvGVA9bj9/hPp06xNJ+jW5APlMYBuiP5WO
         3SfTsodwzUsVxmj0wgEdveNsYGIqHcMKjW6wxkcJvlvyXbHZf4dDUWPEF2LQ/KHORxn2
         cZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7ejNZAMa5/1JIms2ONCukWsDh69PgCTWliqLjQNgQ+A=;
        b=kHitUhkGk5oYhiqK7rGlYJZ/HO6RnBFqRHWFWy5aprfoDZRaJ7ks5E01VgQrXCa4cT
         Elw+RMmL7Z5xc01lXe4cmHdIGsfN8Q1FsWMacKsP87FpLH4bqZWD5BmbXDUIOePxCjit
         QqTSu8OSp5AU0j71mrWLM4rT8ldVM4m9jpf30SPkxNRoFROCUp8HVTkaQz0kWzdndnOe
         LjflsB0A9hRwfPza9wcqOO+eTOZ5QeuGOjNqRTaKWwe5Q8+hx9HGb6iiOXb6fp++InTD
         xikX0yBxGVV3QXdlv4Mvlke0rCs4sPv+GlaR/vy36+tlJ90PKq+bINblxYk27/D6cHzH
         /7aQ==
X-Gm-Message-State: AOAM531O8ikM4hCkxkjbm4F71FpNu7ldczVt3MOvYJJ6ymZtuhPhK5+y
        igVhxDPo6lSPCxp3dEXsPTiebTT8Wwz92oXa
X-Google-Smtp-Source: ABdhPJxt5Cgh2slN/TZHFEWjdksv3wvZX7iIDYDfj3fp74hQ3jBFqoeSWK+4bs4wFYhCSdoLLTba1d510zbvrN3B
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:2252:: with SMTP id
 a18mr46162wmm.139.1604532033584; Wed, 04 Nov 2020 15:20:33 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:51 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <610e97ebe0d46531ca2c988ebb26dd04d08d96c2.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 36/43] kasan, x86, s390: update undef CONFIG_KASAN
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
        Andrey Konovalov <andreyknvl@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>
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
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
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
index d9a631c5973c..901ea5ebec22 100644
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
2.29.1.341.ge80a0c044ae-goog


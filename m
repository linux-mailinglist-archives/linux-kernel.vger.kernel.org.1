Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68659277C02
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgIXWw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgIXWwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:52:14 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8CEC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:52:13 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id h4so296030wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=9ix+4hPu1M5tbLN/A8rv1MdksQ02QT73msi6Zomooco=;
        b=Ma0reHmgRrXe7ZEFQXfx1d47BhbGRVFFVtLMNpKIYkroh/WsoH0zzb9vEX7PJNsBZX
         MvoRg8PhC3h+BOqW+llmls/8hbRbbZ1Tq7hRXZwSSjNkxw0JMGaplX2KLB1oDuhJRLvI
         hCMJ1cNXRLgZTTH4f/Trf8hn0aYiQWGjy7Ya8VA8LgFuPL2232Etv3fiNtJ5s114AV+p
         Ogyk3XIRMBf7tcixqmZXZ4TN7VY9s6zZtwQinnL4KXQyYsb8IP8S730U/VRR6YDrZhgF
         PE+yY6ngqt4YmRKwMU5cWxrMqXdOYgaIOZiNWmHs7U1+wOVAe6JvnGCRMsO7oiwqmgqi
         MHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9ix+4hPu1M5tbLN/A8rv1MdksQ02QT73msi6Zomooco=;
        b=ZyNxkHp/TlnqBWeKeAhlu/gG+qwFYJMYohwz/MwBqL+tRP4mF8z1Or6gZJYtMD6LJS
         ok3/JpzjxZWMbgtH+PP28yeqvbi7qGYiC/DyI7cPERyP2V/ASLPkJz7Pj8g9304Vqety
         N3/fy7b90D3ykuTYBOELiv2E2Or3HH9N32GpZJUfzeeH0S5Nr670+Ix4RUJQZHufVeXc
         Jn5cpMYHq9KnWoyU/uwSLTHZ/gMgVGR7IhTAgEhKQR6IUq7Rz2SFKukacdWjPuuXll6L
         iI3kPof9HYHWmu99j01VRYa7lx/Kk10xmRwgfvaav5vJbAXVYOpBbMKmHDydL5rltHoc
         kaMA==
X-Gm-Message-State: AOAM53030mkath3X/r0cRk01v/mDK08SaJTDOplGEDkqkstnvwNsz0iB
        sHO7IolQtb57OXLwMEHeY8+yPuUHgGJShJsz
X-Google-Smtp-Source: ABdhPJxD5l1Q0TmL1dhuQR7JNlClvYF7rOwx/IOsuADQHKRA4bUqy/l1UAdUOuvc5I4Hi3CYk0rlluYvwfinvhIe
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:f619:: with SMTP id
 w25mr852343wmc.62.1600987932419; Thu, 24 Sep 2020 15:52:12 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:40 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <78ebf3bed0458172fec9e1e32f2d29d7c8c37341.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 33/39] kasan, x86, s390: update undef CONFIG_KASAN
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
2.28.0.681.g6f77f65b4e-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F16328C336
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbgJLUrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbgJLUqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:46:46 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A782C0613DB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:46:12 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l1so8626939qvr.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=l835kVUvCOUPQzymSXPKbaJ+1+IzaMSz+0eMBwoZxjg=;
        b=P9NNpy9dyG4xgSS3UXXQBW6aomwI9fWyu0eoy9UP6zW6edmATRzRQPiYWtxkQ1l3nL
         YiUXzZDo5KcnWkhKyEOHWbIMctd4vIZ/eYRDGuekSGkWe9tRFYscf6bvBMaUMh6IgdI4
         ov1Y1sqML/XKYdhGtHSlgWS2uoMFqII+xXJnht6Ysozqzoxz2bo7UsmspHLtKGeEH8kl
         DULV+fpDAePsEtAtC/yJI36x0Ajlxoz/YUnj7EJEIEc/1hY7rFU6V8yJrKkbOHan/Lqy
         q0PmBAbwia9t3ZJFgHRfs9ybZaBaZJTDTh8Bwq760eSbLDiBgpAtSjsqB6TrWZJeCE/x
         g1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l835kVUvCOUPQzymSXPKbaJ+1+IzaMSz+0eMBwoZxjg=;
        b=swJyglKbHXeKbYUUbKgq1nS/4BlxX/p2ydoXeLquM+qwtlm515AqTPn4NfFxEmu72e
         cWzXxuQwIFbMtfXz6mMbPaPCxuD3qVS+aQt0jINxvtUwM+Za0EjHr7k09OIBJMHbxFLS
         jZAeBVVsojXQmSFKn8Jr3HraIPcZRrsdy+p4dP9W6hPe1ZdLDFl337sA4uY0T1UWx/K/
         D7S203DT+yR/kKyqvN9UGjw2YXzo2frpk5DS8qytwiNq8k2MhJymE3vAh7HXfhABQu9u
         6EOSv0DOZMtiwK1o98wxZERVpKprIjK1aSyymBiDmB7BTdEhTHXveNsfZxpWHhGyxRV4
         ZUSw==
X-Gm-Message-State: AOAM533cN3rB0xXEtcLisTRruw5ddiJwgRfEWntXhKp3hNiPKkhizK32
        98yVLs4ajk/FIBm9ih8TL/yKl8eT1PCCc0Xr
X-Google-Smtp-Source: ABdhPJzriFS55L6xKMv/Xyq/Kc3KnRkr2c32tQ9gtgqYtff5vp7Fhn5x5/DQY3yF4qx+DQMd3X0jDXvhaZFiU0V+
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:b308:: with SMTP id
 s8mr27714655qve.31.1602535571727; Mon, 12 Oct 2020 13:46:11 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:39 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <d42cc8d9227bf37eb88a7068addacfee13b36104.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 33/40] kasan, x86, s390: update undef CONFIG_KASAN
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
2.28.0.1011.ga647a8990f-goog


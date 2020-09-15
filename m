Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1059226B008
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgIOV5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgIOV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:29:24 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A69C0611C2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:39 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id k13so1724085wrl.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gJaj9HJzY/xay7XUoLkj6R2OGJl/aiV7rlwVCZ5wZTg=;
        b=gGShhG9RfzxUJORAJUGoVV6FU0vEowbn6auu7yKf41CX89p6/5xtaqWfZfXtwdZseO
         ZZkWleubVSVVwvcV7jdnoJqptNYV+oLuntmAJqV8koLWbiNMEzMMeiBZLrXD4AyJdKlV
         QAdI2WRzVXOEXSqdulCZ22bdnCSfJlMn+TSKTjmlwBNAFLWjBb4QZ9nUDXs/geDhodZF
         lHdn/CMNBDNzl6HPU3g6w5p110DUQ4p6Q3/NxDbK5DQ5dFZSe3FkhOBElojem+jjPsqq
         Vf2OAk+IONfZnGJx+bpkcYWy8P79TampsVQtbxCtLDNbAJD1++c+8rwz1LKrIQwGojKw
         KgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gJaj9HJzY/xay7XUoLkj6R2OGJl/aiV7rlwVCZ5wZTg=;
        b=nlQ9HJ6D1LvOIMZf9k7U+nwrVjTT9P6cMA9wRt+Xx7vN2MJLEnR7Q6YTm+wnzv+hVL
         pEKQrTyW7Le/mP/J2JhiK1+ZOG2hYd2d6jovsZ7rO9/o5d+KiDCarcDI6T6sP6paO0Yx
         Ds2QYTZBEHfq3itVX0+MNDJW8SVo0/G8k1UBQwzLWvIelBP8nvK/HnpCR2+pVrD6ON/P
         SJPc2aisVwUQ9MDa1oeyDVo59Th6naIcNk+Y+6V//axYw6pRZP/kk/ftJvNlc04Bw6fK
         BsvIkmAof8nnVEX1AnPLl5A2oRXSMRxTD9rFmXwdu1oeFhGsh37R905GU9/+RpDdu/UE
         S7Rg==
X-Gm-Message-State: AOAM532nakGrcVhOIZh994auBKJDFvq3PbF3jv9sclXYW09Ho5DrZ3x4
        BUlGEjGlSQZt+0MTsBwNTdTTrHwJoJY0/whJ
X-Google-Smtp-Source: ABdhPJz5Xohf4ARkglaPkRRJQxL2SqgjcqjnN5AC/Am00hGW5Wrd6XlIFiWLgi6EalEXv6txBloeoUIiPWUmpXXK
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c14f:: with SMTP id
 z15mr181253wmi.1.1600204657873; Tue, 15 Sep 2020 14:17:37 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:13 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <0a35b29d161bf2559d6e16fbd903e49351c7f6b8.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 31/37] kasan, x86, s390: update undef CONFIG_KASAN
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
Sender: linux-kernel-owner@vger.kernel.org
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
2.28.0.618.gf4bc123cb7-goog


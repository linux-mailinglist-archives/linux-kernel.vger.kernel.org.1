Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0978F29F51D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgJ2T1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgJ2T13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:27:29 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019C8C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:29 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o15so2530282qtp.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NNmCWg3uUJkm97N9bODpJVOfWoCAwpfkACCfjKkMoC0=;
        b=uX8trozfZ5T/PGKXw+5x9UYvkHItGS8lAIvxwjEC1OzF0iJZxYGFlTJkftTEGo39Jr
         bX8rwz1SCcCkMeOcwT9ZrfQjWHfjewz8bPk+if6Zb1lbLZjvRP/biDCGqGOgJssqFG8l
         mNUUJEJbTijY6g9aAOf6Q8LWD9eZQfcfsbI9c1QRSvFf8QB1c2AfbZHWDw6LzLggUuFu
         NU8tEbKnJZdRX9Fh8Fzh8eSct3kGrMR78tZqyQh1jpkwDWijw+7TLtIhyPmoeYbM54pc
         w4vWUGoYY9771MF8570mZTCUieeGJRLcmcaS4Rc07WvlPFoognulhQRLYd11YI8Za7aC
         GGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NNmCWg3uUJkm97N9bODpJVOfWoCAwpfkACCfjKkMoC0=;
        b=VlWSTniymFsYWs4tNsvkRQVo1pT9QoSYr4gc8GF++O8ZTPCvtdtzk3cnDAVhrsdkde
         dnGNHtdobkLyr1AogfVXWWkxLKPmpc4je8JewO0RWAEh7OHm8jLbNjHmpykgty+tLb8p
         n3NAWdfRmVR4dQjeGODvX55ELOaGMi7q2moHh2YZ42NF2oyiy1kTxpkr5QYCRmpGCfGl
         lZIZ4e3pOVt8z2xI3Cm6tb1Yq8MgBsiuKWQTxC5w8m0CUorp6j+YS1nm1MzVhmfeWM4y
         iKdnsxbx9RdI+fZu8HZK/yhU7Bmb0FC9umo1TkwpVel0U3WQqrVQkGyb5ebzpRKnQv3p
         Re+Q==
X-Gm-Message-State: AOAM531K577BrVZmaGQOflE5wGQpfp/10o/JKV/aqhrZ2lrJ9GUTLzrb
        z8r3QB0+Ip0YBTMb17s9ENczLjS1M3F2901U
X-Google-Smtp-Source: ABdhPJztzgvJEe8ecNJNOfrwAfwDcd7c90KXuyblNpcKlM6b4rjPG+XlMfOAQ2Bom0xxwAtTzK4au4p0jllT6/w1
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:1192:: with SMTP id
 t18mr5862530qvv.49.1603999648113; Thu, 29 Oct 2020 12:27:28 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:54 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <f8006477b50e3d77005046a83a067a295c680327.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 33/40] kasan, x86, s390: update undef CONFIG_KASAN
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
index 6d31f1b4c4d1..652decd6c4fc 100644
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


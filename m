Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3012A711F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbgKDXTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732634AbgKDXT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:19:29 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51A5C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:19:26 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id p12so49603wrx.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Sy6BvWdNS0zjXQiflbFd/HmI5xZS6ylM1lYk0zN7bgc=;
        b=oVOf4hGd0AFUpYHuVm2bbign6nHRWolcZwyLGwFgY79eiGA40WA026JsLxFYnaMRE7
         7Qem6yGDs0EHmGnM6hkyMzEZRilHhE4uuoTGoNFI8kk/PWDT3yde4UScHLCdSurvd0q0
         PTjbFlCgFa1xinn/DonMGmZg9d7ox7TjjC2ckWrFCXprqFFkcqatr0L0ezoe6qUJqbZh
         /cbDHfQ3hOdkE4KA4ND1K9oqEpcDGgiUND1+0+5V3MK1p7sVvMmsZSzZh8e1MjDx+Ela
         Kt9TS7lx5nG+ua/Ca7UbdTEz6mPxPjgpJW9u9r9i4Y7KO5KjqhmfHOlpJVlVTuKZV5Ld
         s8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sy6BvWdNS0zjXQiflbFd/HmI5xZS6ylM1lYk0zN7bgc=;
        b=HzIIFoBbet0iij2EKp1k8a2mT7TnngpOjyzG1pcHNt375OI7gUKEu3/WZ+aEXWuAel
         D7NLLi9nDP/EDGJJPDI/MnSVu8JpkS281jH0GnoKo4bUq6DPM86P31AjRaTOV1Bbf/z3
         85sF2hzEDzdaikXhQBB018a2y7lOiQh1NTJMazBVR7hLiGtEGucCGcDe2vk4Luynrlfr
         +KZF369Q/+NLHHFFcc434cdBjmCvJJdtKXFNsNE4x3fAL44wtQDLKBjzhBFZ/SxpSboz
         7zOLPvA3CLycqcZqHRMHu+qugiaT2erORYG+m7XuMVo+Fh1AE488uV6DKRWlFss7QVhk
         lo1w==
X-Gm-Message-State: AOAM53145j0OXQnOjLeOlUndHn2yaRE/GyCOdO3Y3RAgeih2zkScIM7H
        Ez058VZzDhTg0GJZ4e+/RmiPX8ZiUmQ4j3nc
X-Google-Smtp-Source: ABdhPJzZ9KOcFwhWSCq7ThJthNaAtBBIIUJFB1KG0jE/KHPv0qGyNAKK4rhNYpc/h459aUe6dxs9fGZqdihpkt/y
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:309:: with SMTP id
 9mr83914wmd.80.1604531965449; Wed, 04 Nov 2020 15:19:25 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:23 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <88fb34d65d1ff22472a9a2ba6758203ce1bcfca9.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 08/43] kasan: only build init.c for software modes
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
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

The new mode won't be using shadow memory, so only build init.c that
contains shadow initialization code for software modes.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I8d68c47345afc1dbedadde738f34a874dcae5080
---
 mm/kasan/Makefile | 6 +++---
 mm/kasan/init.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 370d970e5ab5..7cf685bb51bd 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -29,6 +29,6 @@ CFLAGS_report.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_tags_report.o := $(CC_FLAGS_KASAN_RUNTIME)
 
-obj-$(CONFIG_KASAN) := common.o init.o report.o
-obj-$(CONFIG_KASAN_GENERIC) += generic.o generic_report.o quarantine.o
-obj-$(CONFIG_KASAN_SW_TAGS) += tags.o tags_report.o
+obj-$(CONFIG_KASAN) := common.o report.o
+obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o generic_report.o quarantine.o
+obj-$(CONFIG_KASAN_SW_TAGS) += init.o tags.o tags_report.o
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index dfddd6c39fe6..1a71eaa8c5f9 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * This file contains some kasan initialization code.
+ * This file contains KASAN shadow initialization code.
  *
  * Copyright (c) 2015 Samsung Electronics Co., Ltd.
  * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
-- 
2.29.1.341.ge80a0c044ae-goog


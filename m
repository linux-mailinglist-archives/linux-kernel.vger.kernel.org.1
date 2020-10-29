Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F1729F52C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgJ2T2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgJ2T0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:26:48 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D38C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:47 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id x85so2438505qka.14
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Sy6BvWdNS0zjXQiflbFd/HmI5xZS6ylM1lYk0zN7bgc=;
        b=OW/hMHsOZ0adIHS2LRlrAUjGHayhf2Zi6X2Qq/iT51QqJ73q4yiP0XsdaLKeQMRFik
         K8l49sp5s44JOy02Nga95Ioxh4RFk6BsOFzNJ8vw/PIw1a191ki52IwBcYULuMVJZ/Be
         xBFYrhBN5RNaqjDaxtS+HKg2K0yGkYL08sq38zNpxUmME10qqU63EuCCjNgs94eLTYzC
         l50znZoxpTQZqoUWOYpWRoyI2vB3z6tQG/S05xpEsCBdl2VqherUR8JlutZiV1WvybHx
         WmUPGf0YonXq+tw4lo7DTAoiePEzQvyKxuFlvZngGUEQFd6jHEGfhXOGGcWFX6IoTdeE
         1IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sy6BvWdNS0zjXQiflbFd/HmI5xZS6ylM1lYk0zN7bgc=;
        b=bGwDX/bSuylL4G16+73IUYgBewuvUA9u6xT8OUJTcMA+gDQvjzpOaPTBArCUtfmgZq
         X1SA2uOyJR8QRyTnFp2vGTiTMnMMt1wjRfmJrvcYLQtVjHSJp/giMvMGX2Q06m7aGYV3
         kMzWsJkhDTrOBzGFw3/Ij6cLMjp88S0uoUsYZ9tCyfy07hcz8SnqUIKM7MQzUHZSxhro
         h3jvYQhoAeMezQylwnugE/raoWcpQlhf/+izhhSNtthETfPp6e1Y85uH6sfRXbVZvbuO
         CRXF0c95RY8jDldeRQ7nZlKtHyPMmqmqeNwYXQDQDye9ARSWGQ/0f9zVrEpGsKlikbHj
         bNLg==
X-Gm-Message-State: AOAM532OQP2KCTMG0xMTjeeBwgF6Lg5mQmEKqB3Axs/4YJXiz+CeREhq
        74eVToaPnsORwkdVtjglp/67+CAA+TS0WsTu
X-Google-Smtp-Source: ABdhPJz944jCjazxHDzCdJN2EhcUY88WV5UHKhoVawW7KB77krmq68SzNc+6gTHrLd+wSkLIlI+SpCkHvd8b8asS
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4770:: with SMTP id
 d16mr3853281qvx.61.1603999606977; Thu, 29 Oct 2020 12:26:46 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:37 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <a3625b33aa83c107820f241b3acc4e30a155c0f4.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 16/40] kasan: only build init.c for software modes
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360F7277BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgIXWvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgIXWvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:51:09 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5BDC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:08 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id m23so686748qkh.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DufyUr3VDNtonx2hPCICVW4qjhSQO8Lbag8i7ReKhm4=;
        b=Tq4lK60XhwA6r8z47xs6/tLjMiMq7uXH5zEunwC8TmFzV8zfRbxWDfB1h+rOkoMLrc
         LUS+VVJIIHLY6D5jUOyUJ+ao1/EHV7xpjxkZGAWXm/u4vxHKqVqMp0VLEwa4DR1hQJLg
         0lCVM0kusPwJSaN6PONOBuGteQx7fmR0pWPYBctv9qz/0PZFRS0V6bCvMdjFeQE4uWHW
         tO/b1AQeST4/Rc1YrywyMqTlGSN/8Aij7Odg9xsUm2paG1o9mcKWgVyFiOs6o9D6UTX1
         R5fM7J4e/dmSfHMn4ItsRrueiiqIYeTHrziuFeIYL6GfY0OAgyOXWp7fk+fFetKnGcnB
         DBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DufyUr3VDNtonx2hPCICVW4qjhSQO8Lbag8i7ReKhm4=;
        b=Y2VuU/09r2Y4u66ydKMMQRhvHD0LVKA2ReSU69pkAGxReb5yS0rZoRrA/zEdSkv7Jv
         eE/3YegJI4bzXFLKr7gC+7aGJi3lWiGS+A+CeY/Oi4s2z8BhR6jXs5BN7JYfF1ZfVU/a
         2EjEh8ERNaRSMS+oclwAwG+/XkAb00ZaJEfurZnpvYWKiswKou0GY3wDlgD3rF+hJF+2
         4TLNuGCAjsbY0ONRgm3RBILRajUSCfF2GmHeN0LUX/YtTbZEVEi9fOC4myMDRW8z8Sj3
         QglP6EH1Ke2OuwDq8mghplpFUE1ERsxMNM1K7CvT8UO+QoECTLkbmU4TqKgZcryhk1HS
         4O1g==
X-Gm-Message-State: AOAM530Lfx0EcUNVjRKi1hyQO+GA/ASWcAOmP/c3pPKzyrIGUJeivcqn
        PQKbwJs9rKQKRFW34NANaUzgnMtjczYr1cA1
X-Google-Smtp-Source: ABdhPJyuSGecUOKg6Byl2rnxjDbt0du65/xn34f+JJEjgJqwxbZi16nIfFWRik6igwBkqq/Lgtj83xgKTLhfxDPy
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:500c:: with SMTP id
 s12mr1591817qvo.7.1600987868036; Thu, 24 Sep 2020 15:51:08 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:14 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <3ecf44f226dac37eb35409dc78568a99343fbf9e.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 07/39] kasan: only build init.c for software modes
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

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

The new mode won't be using shadow memory, so only build init.c that
contains shadow initialization code for software modes.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
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
2.28.0.681.g6f77f65b4e-goog


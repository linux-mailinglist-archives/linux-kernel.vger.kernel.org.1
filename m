Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4C32C15D2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgKWUIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbgKWUIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:08:44 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDDDC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:43 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id p16so6283632wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SaAeiXzxxrxPHQMFzx8S9oOteptS8gJenWmnYcdr5qo=;
        b=MMrmJNG3bws5+CEeIHXs7nxD7xON5EovFoXXXgka3SfTQvPEHARepMiPjuW+l16Kqr
         iG+lh+kEWtADMqPaVvVk6ifJpUSMVHkaPUwz2fGwWIzEpU/6w2LSOPwri2gsOFKsRg45
         Uk3r5YiwF0U5uweWyNt9lbvV0otd4Gc3tU0mx2ce2hWW9/YYH3CMDs4PrvpeFJHxJ1/m
         jhrQslsXYRcUuJAvdnT8KhcWh8STc4o3zPDxyN+mFbe1fgQXoEmV96mc+4D+g4l4/dh2
         iqCa6WhSS5ocOZ3Ni1PVrXy0hbTg1/v/beE62Iw5A0iLUwUxCtE6GhnGjBt3ywLZx+94
         MfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SaAeiXzxxrxPHQMFzx8S9oOteptS8gJenWmnYcdr5qo=;
        b=uTVoAiE9en17K56AQ4EPWeIvSfMmgj98dIbCCFZMtgPwggWvsUWDOIHG5rhfGwYhq3
         0oVdw8j6hUl6l4/FjHXFUhW0IO6w6VXcHjUppkRDITRwJvd7X43V0yE0ti6/i42rVPn+
         fEjLd7RbhfNBh2GK+WqB4moxqxX1TqVhG0qgReqZjROer05U2UWHPtfkf+bEz4EUnQqB
         Y5sCrweU1vQyF9mGcE5yf7TIfH+XZhYLOrCBpl2O2nelNGhTZIg6u8MuI9W21WSI8UFj
         N0q6Tk8rVkB78GcIk1p5KNAYLJzFgwzW1i4NPQmUUDJKdK+TcCNcZqz06Ozml/1CRRAh
         8ssw==
X-Gm-Message-State: AOAM531wUCIcIaWqFYjdqxzkPh7ycrlLRRymvLDDllbDXrx528ySoovb
        d+b02WIyRD5lpnJIHfM7ka57D6kr6nrAx5wt
X-Google-Smtp-Source: ABdhPJw9c1OeGH5RBAbYZQqMka1C5Agvrdc66u0avOEshWwN5H04D45TnOJhHMO40aCfLyPDf2EJ8478UW8d/TBz
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6000:1cf:: with SMTP id
 t15mr1483556wrx.92.1606162122457; Mon, 23 Nov 2020 12:08:42 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:34 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <a6105d416da97d389580015afed66c4c3cfd4c08.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 10/42] kasan: rename report and tags files
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

Rename generic_report.c to report_generic.c and tags_report.c to
report_sw_tags.c, as their content is more relevant to report.c file.
Also rename tags.c to sw_tags.c to better reflect that this file contains
code for software tag-based mode.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: If77d21f655d52ef3e58c4c37fd6621a07f505f18
---
 mm/kasan/Makefile                               | 16 ++++++++--------
 mm/kasan/report.c                               |  2 +-
 mm/kasan/{generic_report.c => report_generic.c} |  0
 mm/kasan/{tags_report.c => report_sw_tags.c}    |  0
 mm/kasan/{tags.c => sw_tags.c}                  |  0
 5 files changed, 9 insertions(+), 9 deletions(-)
 rename mm/kasan/{generic_report.c => report_generic.c} (100%)
 rename mm/kasan/{tags_report.c => report_sw_tags.c} (100%)
 rename mm/kasan/{tags.c => sw_tags.c} (100%)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 7cc1031e1ef8..f1d68a34f3c9 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -6,13 +6,13 @@ KCOV_INSTRUMENT := n
 # Disable ftrace to avoid recursion.
 CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_generic.o = $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_generic_report.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_init.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_quarantine.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_report_generic.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_report_sw_tags.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_shadow.o = $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_tags.o = $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_tags_report.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_sw_tags.o = $(CC_FLAGS_FTRACE)
 
 # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
 # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
@@ -23,14 +23,14 @@ CC_FLAGS_KASAN_RUNTIME += -DDISABLE_BRANCH_PROFILING
 
 CFLAGS_common.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_generic.o := $(CC_FLAGS_KASAN_RUNTIME)
-CFLAGS_generic_report.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_init.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_quarantine.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_report.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_report_generic.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_report_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_shadow.o := $(CC_FLAGS_KASAN_RUNTIME)
-CFLAGS_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
-CFLAGS_tags_report.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 
 obj-$(CONFIG_KASAN) := common.o report.o
-obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o generic_report.o shadow.o quarantine.o
-obj-$(CONFIG_KASAN_SW_TAGS) += init.o shadow.o tags.o tags_report.o
+obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
+obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_sw_tags.o shadow.o sw_tags.o
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 7b8dcb799a78..fff0c7befbfe 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * This file contains common generic and tag-based KASAN error reporting code.
+ * This file contains common KASAN error reporting code.
  *
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
diff --git a/mm/kasan/generic_report.c b/mm/kasan/report_generic.c
similarity index 100%
rename from mm/kasan/generic_report.c
rename to mm/kasan/report_generic.c
diff --git a/mm/kasan/tags_report.c b/mm/kasan/report_sw_tags.c
similarity index 100%
rename from mm/kasan/tags_report.c
rename to mm/kasan/report_sw_tags.c
diff --git a/mm/kasan/tags.c b/mm/kasan/sw_tags.c
similarity index 100%
rename from mm/kasan/tags.c
rename to mm/kasan/sw_tags.c
-- 
2.29.2.454.gaff20da3a2-goog


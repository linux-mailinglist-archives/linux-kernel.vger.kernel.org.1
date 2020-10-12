Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AAB28C323
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbgJLUqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388754AbgJLUpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:45:40 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00736C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:38 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o25so10388371qtt.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=41Vl357/MnuT0PAxoBH3hjpV8+7JFQ9o+WDzcoWDr24=;
        b=p/7hfliVajbdSZWYJp3pCD9NIoo92UiVgVT7e2EtFhgWezE7KH3LnYSCqbWyNLT2E6
         x65ifbkdoGI7fXq+uQM0kSFZgA/Ona7So6CcNbzNqz2vyTxN/X6hubyeG0MptWQqXNGo
         LuFVAdJQa+Cy+PJo+Mk6uuN6cCO1asKKQvepCa2kloxKUtenFk1EOiB4WiQDSSj5MoMV
         kp5QaV6u9sCDwLMKJAkYk00i7hKbNfBBQiyvS0l1cxFtkf0+N2XJObUiPA9KoDmm+nQI
         dBr+NniSnDQ8wJFPu3I7vHdBPCpMcSYZ+1oNiMRhYdSB8mIr2BQcTMqmB2XS9wFOOVrA
         uUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=41Vl357/MnuT0PAxoBH3hjpV8+7JFQ9o+WDzcoWDr24=;
        b=fOo1zMvXn6HlCJ/ce+we+y8VTp0Z6Jsqao3p/KQHo/WPe+KLoTzNOZJ9pp48l6ITRo
         O7bKsj6XBugwnq+BQhnJTVjZYV3mOjsVKtkVtwV1D28a+whAwaDPjslGFl7PW6+j/jla
         sP6ORdicWRXoERVtM2Dpln/W/HX4iUykHghfRwnPwHn3Onkt9kFDNSaaBiXTNGBuBX9Z
         sUiNzAOfHN9tElwpT3c8r1SvNqHezZBrQg4E0dQwUW3AcPB68oy31PZXpiv/yMx1dK0y
         2AcSjQyn25a3k2xwYLNgcN+HrGkMKrUSMLyTLtPRpq7ZPV+Y/3qvzHI85s9usd44jc8P
         X1vw==
X-Gm-Message-State: AOAM533aAKWEG7KY5aMvAJZ5QcyfgxEvMdsd50nikVGIq98tpJcaDiVd
        1EQiaAGn/nTyYLK3BzMUn3J0aG+FVwDcNPxK
X-Google-Smtp-Source: ABdhPJyQNRuVks4t7YHFwFXgiZCM6jNC+RgupjFlHPy/Sya5rZ2yAU0GOS6Nb2M4KS/AvFwDz1qvC87JWd4PUmk6
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:8e0d:: with SMTP id
 v13mr24646235qvb.51.1602535538096; Mon, 12 Oct 2020 13:45:38 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:25 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <9a603d75bebe17810dbb5e6e5e001f3243be8052.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 19/40] kasan: rename report and tags files
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

Rename generic_report.c to report_generic.c and tags_report.c to
report_sw_tags.c, as their content is more relevant to report.c file.
Also rename tags.c to sw_tags.c to better reflect that this file contains
code for software tag-based mode.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
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
index fc487ba83931..5961dbfba080 100644
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
2.28.0.1011.ga647a8990f-goog


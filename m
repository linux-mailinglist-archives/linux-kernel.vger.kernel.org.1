Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05C826AFA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgIOVdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgIOVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:16:47 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24B2C061353
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:42 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id y53so4039086qth.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lWHaJYmPEYXJBP/uBzeOe/Zb1P7kD+TOmnHXvVDLg6g=;
        b=X1G6wMyZnS0lFwntgqQ3I+0XIixMw148p5tbu1Ca6n2GwNII42i1iBjxsCHJ8bLWEJ
         brbOGV4PIS1Mcw3TfpsrgNLfQWcuCIQzUJp6f6nciACXJz9boNIsBAlbCC8OyLXJSFyH
         rDDwtuz3J04t0BH/IxWmJTFa7xsdSGeULeEQFiSjvX9vqXI/YxpHK0hwzfJfHIzdLmLP
         Xwk+JPV5ovdJuVAA66KoTuD6R0X723FVzVo9zgSHwXCD8b/Hi39h/A+tpvWab2kk8WoT
         KTO5x+ZN1f60CPDjPwmgKRz8X0x//OW+xCS5sM0WaeBCIR+C2agcD0lHuQmWYd0yZBlU
         hrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lWHaJYmPEYXJBP/uBzeOe/Zb1P7kD+TOmnHXvVDLg6g=;
        b=jGa+CnQp6v62V+sLrAhnhfIOs9jkebWTzgp2BIBIPgyBiVUmchg7jdxQyucXNVK0r3
         LKle1OwtKKomfr2Ts/Tboiih6Rr6VuTum/93Cwd6Mv/gtW8XDZLUZdEcOUfBM+w/N1Uy
         CiDApQHAmYZ0lgzIyIMv6kKv605XLSga5esUAWx0wje7K6SlvZbzu35zVUibtxQoUOB7
         JoQntkeNP1QTnAbw3QY4jYaUvAG+UG5BqkPYmPTN/ONrfGpVMoyrqHQLbRIVj8P27MSM
         BX62Ups5P/jKaQH5nhT5CPyW+QMniM98TLtMq1DYT60/kep+oBUJPiFdcs0Qzai/mJ9C
         ko2A==
X-Gm-Message-State: AOAM530KFt2wJA3q4Hp11yXFZaBhR2k/ky3WsR2Cnqx3cR01gziZ524t
        DDRj24ePf+XMqE4cEUKzC4kskjhwSl+keleD
X-Google-Smtp-Source: ABdhPJzqx2nBY54AKA197aaxoxbVynCv9f/Nxd6C3jrVPdy9Fw9LOLQht1+nWsZCHmX9VM/m02HSqlFAfZiI/P4r
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4891:: with SMTP id
 bv17mr20207397qvb.27.1600204601843; Tue, 15 Sep 2020 14:16:41 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:15:50 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <fab8d524fc2dc5d01c9dd047c497f3e9cee483cb.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 08/37] kasan: rename generic/tags_report.c files
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

Rename generic_report.c to report_generic.c and tags_report.c to
report_tags.c, as their content is more relevant to report.c file,
then to generic.c or tags.c.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: If77d21f655d52ef3e58c4c37fd6621a07f505f18
---
 mm/kasan/Makefile                               | 12 ++++++------
 mm/kasan/report.c                               |  2 +-
 mm/kasan/{generic_report.c => report_generic.c} |  0
 mm/kasan/{tags_report.c => report_tags.c}       |  0
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename mm/kasan/{generic_report.c => report_generic.c} (100%)
 rename mm/kasan/{tags_report.c => report_tags.c} (100%)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 7cc1031e1ef8..b2596512421a 100644
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
+CFLAGS_REMOVE_report_tags.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_shadow.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_tags.o = $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_tags_report.o = $(CC_FLAGS_FTRACE)
 
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
+CFLAGS_report_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_shadow.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
-CFLAGS_tags_report.o := $(CC_FLAGS_KASAN_RUNTIME)
 
 obj-$(CONFIG_KASAN) := common.o report.o
-obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o generic_report.o shadow.o quarantine.o
-obj-$(CONFIG_KASAN_SW_TAGS) += init.o shadow.o tags.o tags_report.o
+obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
+obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_tags.o shadow.o tags.o
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 7c025d792e2f..f16591ba9e2e 100644
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
diff --git a/mm/kasan/tags_report.c b/mm/kasan/report_tags.c
similarity index 100%
rename from mm/kasan/tags_report.c
rename to mm/kasan/report_tags.c
-- 
2.28.0.618.gf4bc123cb7-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9712A2F21
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgKBQFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgKBQFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:15 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4380CC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:05:15 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id i20so2126656qtr.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=m4Rd6JEchDCdHagjRChT+nQsGKSwHG57Cfn+FHFZG50=;
        b=H4N1zniDiSLSuhWj3O/H2DjiZDJNdTSjxTpq2NEr8Cmysp/qGO7i5dIlXjUZJNPV5c
         DnvLBlCf8uFSchwSEmWVX+uJ4+wg7CfzoGEcychJ3nBhchFfl4YYGUDQw/yA9xcd1htn
         3EGWXFuf5aJ5dqBuKBtq8+l4Ifm6vbDAFTF64y28jPr7gVRo+2zrziKktmJvZD8/W6Jt
         4CUMECRT6wQysAhlf+kks1sXwqLu/5L5yHeAZGUPr6sKN7OWaJ30vK4skkA+wbC4fta3
         UI+rnQg/+IY+DRJhg5Og4UoNotUNFOMOrURTCsUfYv7XDMpufvJ0aDkrjhMIqewKS3uC
         F7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m4Rd6JEchDCdHagjRChT+nQsGKSwHG57Cfn+FHFZG50=;
        b=avGyHCUQAhZsdUEGb/I/2FoQGwN8gREE2iteldnhQBO1u7clZXiV2hK6VkpnhdFIca
         T0mDr5SE+wxPoYtqh469jx1GtVzFA/plMv9f1q2PrS0DsMobEv0wB4MSwYZdbfMR//lA
         UIC1aWoQeIFy21i1L4V5EkXpkaxhJ6V8pPTDWEb3H2xEHjyywWRWmMiM+jfLuOHuz8Zm
         OX1A3ForoyHricvtGyQWAWA6+h5sThBrp6vCvY34S+qouKI2SYRhS/FxyskwIwo75zvf
         4MPnqzSYGvXXCPC91QjES3kr0dzigpEzl/sOcbPRJ3C8ZenULJMyHXzB8gW9TupfvIpf
         12fw==
X-Gm-Message-State: AOAM530wC/lUnL1VMirVnUW7Fosfqht4trmz1mh/km9CJdCWe+LgPk3l
        ZWl2hn3SgD/F/6kxpSXE42CmaCPaWz3209oZ
X-Google-Smtp-Source: ABdhPJwvS6MApLKZJqQ3sHqdXFF8blF7V9zZ88xh4ydAoMOPmmGJ1T4thNX3W21X0gvGUB96H0mhKzSGAqpXnISb
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:e70d:: with SMTP id
 d13mr21887401qvn.45.1604333114420; Mon, 02 Nov 2020 08:05:14 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:04:00 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <11c5c70b6c365cbf6a02e326b07e0f088544670f.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 20/41] kasan: rename report and tags files
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
2.29.1.341.ge80a0c044ae-goog


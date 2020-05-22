Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987571DE14F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 09:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgEVHwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 03:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgEVHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:52:24 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131C5C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:52:24 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id p126so10286301qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=V3kv+xBmjrIeYzeByZn2jZ0q0fngGgBM343mBftKcUc=;
        b=YyyrLMAuNFxnPyLpcPTr6sz5EROrTRmWUbKvuXv+P9s7/RgUmBoTYNOBB6CHRgCzwB
         7dCe/3nenT/OHaMlqB+tioLHT7G9nHkN7WZ95TRdnJ+8JcnhZyzUYuxF760OlxfgQOwr
         S8SSAgObJcLoQfvFkDMAayvzByzwmlkj11yndgkntXL8dt24bc5wA4CjHFfy+4mtMeRY
         POp3f/ReqWwACAbLP9Xdqk5l9JS9feCpGkPBEvqRuwaXxRV0hfE93gxXj0LF++CcGBxf
         xMNcUyxM+5j1kq+iwn7n+dvInijxFPfXhRGl1x6hxyibMnq8tBi75/F7P+JKfFxq9olI
         w5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=V3kv+xBmjrIeYzeByZn2jZ0q0fngGgBM343mBftKcUc=;
        b=O1knA1vPd+yODU7PxjpvbDSiUtFrjwVg9vo+vnDHa5HDI3RlytYkqObxfiKUfuoxQj
         KSByKmt2Oj2x7R/fjPVzlvZ3YiHN715zLkqkRzJXE2EA9XauhJ5jMuZmLfll4H7IOg2D
         GR8nqyOyvSX79v9oX8ABj42a7LUmstGC5/OXappwC9ypV3vBxGF3mDoxKcqxiqoAHNTL
         aUNG/o/ZOFonduYxeXnVgHFrJ7h0T+j1AklhHe/bf2le1PLevf1M+uQOyB1/sVfL/yDP
         9D8REUi/HMWjHhl+LORCehwAuvfT5SXVWMZsRlLvpykR/6VIEQnt7jb2q/sTlTYMgPg+
         hGOg==
X-Gm-Message-State: AOAM5329hPtPV4VtdZgYpJSGjyutXWj1Id26favumpRDwQmmPGUJkF/e
        FMTxwIMnfFLsBPGF3sMGHkr6jtD6Vw==
X-Google-Smtp-Source: ABdhPJz7VxJDn9AlnO31BeEfLlm2ECE/+eRq/NBPi9fc3fTjVsc/UN1YsxmsN2WBp9ZDYm2R2cTGMvqPZg==
X-Received: by 2002:a0c:eac4:: with SMTP id y4mr2480760qvp.39.1590133943257;
 Fri, 22 May 2020 00:52:23 -0700 (PDT)
Date:   Fri, 22 May 2020 09:52:07 +0200
Message-Id: <20200522075207.157349-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2] kasan: Disable branch tracing for core runtime
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, cai@lca.pw,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During early boot, while KASAN is not yet initialized, it is possible to
enter reporting code-path and end up in kasan_report(). While
uninitialized, the branch there prevents generating any reports,
however, under certain circumstances when branches are being traced
(TRACE_BRANCH_PROFILING), we may recurse deep enough to cause kernel
reboots without warning.

To prevent similar issues in future, we should disable branch tracing
for the core runtime.

Link: https://lore.kernel.org/lkml/20200517011732.GE24705@shao2-debian/
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Remove duplicate DISABLE_BRANCH_PROFILING from tags.c as reported by
  Qian Cai.
---
 mm/kasan/Makefile  | 16 ++++++++--------
 mm/kasan/generic.c |  1 -
 mm/kasan/tags.c    |  1 -
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 434d503a6525..de3121848ddf 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -15,14 +15,14 @@ CFLAGS_REMOVE_tags_report.o = $(CC_FLAGS_FTRACE)
 
 # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
 # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
-CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_generic_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_init.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_quarantine.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_tags_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
+CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
+CFLAGS_generic_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
+CFLAGS_init.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
+CFLAGS_quarantine.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
+CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
+CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
+CFLAGS_tags_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
 
 obj-$(CONFIG_KASAN) := common.o init.o report.o
 obj-$(CONFIG_KASAN_GENERIC) += generic.o generic_report.o quarantine.o
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 56ff8885fe2e..098a7dbaced6 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -15,7 +15,6 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#define DISABLE_BRANCH_PROFILING
 
 #include <linux/export.h>
 #include <linux/interrupt.h>
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 25b7734e7013..8a959fdd30e3 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -12,7 +12,6 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#define DISABLE_BRANCH_PROFILING
 
 #include <linux/export.h>
 #include <linux/interrupt.h>
-- 
2.27.0.rc0.183.gde8f92d652-goog


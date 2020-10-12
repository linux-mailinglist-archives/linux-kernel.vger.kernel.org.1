Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E97F28C329
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbgJLUq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388280AbgJLUpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:45:19 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B186C0613D5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:17 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d22so3068860qtn.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+SIWGAmnbEnD/Uogp4huNIPUvtkTtEb0B2WGWuwNKsg=;
        b=dcwMlfIwQDeh/mSnDtusDG6HJpRIIwXZIaaqutDMYGxvIUN/TYtEuWurPjdYs6mmZK
         3rzyUtsnYenZREJ1E4Js1nixklu91ya8gH2vMO883umgjxETfPI/rCtQx3IwSzhqY6Jo
         2sOSg0HA44kZa3iXo3PCZQ3LDg6uho7e0Og6AaimgyBXy55jzw29BrZZlAFoB1JDEbyV
         ONtgJc6OKIhfYw1Bm/VoRFYwifuY3+ULxn10U3vo1isQPjoVsOuXzn9FgC0FXTArHlWY
         O0QtGS4Qn0FHBY4qnkDP6kYaWHDrIDBga0JS0NiqJZ1KV8vtO/O2JEGl29FKVOr2Ehsb
         8D/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+SIWGAmnbEnD/Uogp4huNIPUvtkTtEb0B2WGWuwNKsg=;
        b=Jph8DonLVXAxoW+5ZEFbbQbvjoIouW71eHOkPMF/D2FNGw1cM5RcMUiunBSvLH00VS
         GBYihn5bpHUANwnCKUdfzpi3BFgnfO6sRFzfM5YXGebYFH/pZ8imbCAdKCTBH7/oxAA7
         mJvuEdG7rsA2Nfq1pED1WFjiWR9fy2nF//S17fgVq4ODCtAugtU2NfsU92evxvYdveOJ
         rYE+3tRQIyr3nIGh9noAyBtfP1n6mz2YNH9N2BcCzskfyRSN1G5N2FdxREt/hGdXhD7V
         58IuUavRar0ff+SRyzXnclpsPM86E5smK6AdafAbRyPYfDmcSbG6rSbsO5Cv820G5iEC
         rJiQ==
X-Gm-Message-State: AOAM533mkGkEKXNqbKwY+wwuZfDMebsfPBItJEvtQeN5t4XC/WMunwWJ
        dEWgBn/A+/9ovBq5gLOx4EjrykbIQQLFS62C
X-Google-Smtp-Source: ABdhPJxAs4tlCnAMdBUktxaaC1IWQdh80tYAL8/t/dtwYvgiFEkufGgqLFVOhmI8h4hU+7mVs0XCscWMKHGcZvPp
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:192d:: with SMTP id
 es13mr18206058qvb.27.1602535516736; Mon, 12 Oct 2020 13:45:16 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:16 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <e345a60b2ad8c4b7ea37d5b2d7186437a20ba99c.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 10/40] kasan: drop unnecessary GPL text from comment headers
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

Don't mention "GNU General Public License version 2" text explicitly,
as it's already covered by the SPDX-License-Identifier.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: If0a2690042a2aa0fca70cea601ae9aabe72fa233
---
 mm/kasan/common.c         |  5 -----
 mm/kasan/generic.c        |  5 -----
 mm/kasan/generic_report.c |  5 -----
 mm/kasan/init.c           |  5 -----
 mm/kasan/quarantine.c     | 10 ----------
 mm/kasan/report.c         |  5 -----
 mm/kasan/tags.c           |  5 -----
 mm/kasan/tags_report.c    |  5 -----
 8 files changed, 45 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 950fd372a07e..33d863f55db1 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -7,11 +7,6 @@
  *
  * Some code borrowed from https://github.com/xairy/kasan-prototype by
  *        Andrey Konovalov <andreyknvl@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #include <linux/export.h>
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 248264b9cb76..37ccfadd3263 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -7,11 +7,6 @@
  *
  * Some code borrowed from https://github.com/xairy/kasan-prototype by
  *        Andrey Konovalov <andreyknvl@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
index a38c7a9e192a..6bb3f66992df 100644
--- a/mm/kasan/generic_report.c
+++ b/mm/kasan/generic_report.c
@@ -7,11 +7,6 @@
  *
  * Some code borrowed from https://github.com/xairy/kasan-prototype by
  *        Andrey Konovalov <andreyknvl@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #include <linux/bitops.h>
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index fe6be0be1f76..9ce8cc5b8621 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -4,11 +4,6 @@
  *
  * Copyright (c) 2015 Samsung Electronics Co., Ltd.
  * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #include <linux/memblock.h>
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 4c5375810449..580ff5610fc1 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -6,16 +6,6 @@
  * Copyright (C) 2016 Google, Inc.
  *
  * Based on code by Dmitry Chernenkov.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
  */
 
 #include <linux/gfp.h>
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 4f49fa6cd1aa..c3031b4b4591 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -7,11 +7,6 @@
  *
  * Some code borrowed from https://github.com/xairy/kasan-prototype by
  *        Andrey Konovalov <andreyknvl@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #include <linux/bitops.h>
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index e02a36a51f42..5c8b08a25715 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -4,11 +4,6 @@
  *
  * Copyright (c) 2018 Google, Inc.
  * Author: Andrey Konovalov <andreyknvl@google.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
index bee43717d6f0..5f183501b871 100644
--- a/mm/kasan/tags_report.c
+++ b/mm/kasan/tags_report.c
@@ -7,11 +7,6 @@
  *
  * Some code borrowed from https://github.com/xairy/kasan-prototype by
  *        Andrey Konovalov <andreyknvl@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #include <linux/bitops.h>
-- 
2.28.0.1011.ga647a8990f-goog


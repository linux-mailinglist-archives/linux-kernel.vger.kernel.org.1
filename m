Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBADD277BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIXWu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIXWuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:50:55 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FC9C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:50:54 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id t10so268447wmi.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZswYQO9674cQoHqiYfyFJDWx/WiHAi7fsHoF2eA/GXo=;
        b=GbSvhSb8annFLt7AWoy0Tc+vsTtHcGs/kXvpZbG3vTCsMXdOO9bdn9JLfb0/tLsP6Y
         q2ZdzYAaMjlYYELiFeaXOs2niK0OZFIhRtYS9n2/osWYOLuxuhbg9p+2jdGCa8mCstTl
         lVdE9uY9LhakwmgKpm3+wv4P8J8B3rWslWfOp5mGyTSjteSnfKAkfdLc+1JhOLQzbHIq
         storQppb+UTqC3WXkUaJsYyoOEr+y9MIHnFIsy1voeCVJU3k53RM7v2C/8UJ4KqyOXJV
         hYmNWrHr/GOPnnSgdFHyvjr9EeXP4wEOHvHErGdRK2YqsmdZG9mxm/4KSDUG9PRurzuA
         tJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZswYQO9674cQoHqiYfyFJDWx/WiHAi7fsHoF2eA/GXo=;
        b=mJJKW6uaLlGdHvUzWSaQGSGvMeGcG0FEsKqkfFXslufvhxPcCLU5H1YtKqWMntGq07
         1V8tf2MdiNKJEVatla2lCI2Fbp61ySEyigk2c2bRp/VfkIVcy+u6goxW3HjHl0NT+a85
         mkGgmmG17HfHjxT+Vg/TzsQz0LQK5xfc7zuaUO0AABwp9k78ANrK5FZXdX7cOMB5zN13
         pA5dZgxcxrCZgPtxWt5b/fTv904GB2rnBilS32FWslZAVsKHFZrCvZe8qlDlkxgu/Jeb
         VNHzzXruU9O20c7Xku5OjiGqDbMUrwvwZ81dIomOQuW1hjXi5Cw3v9CRdBvgmy+DCSdQ
         R+aw==
X-Gm-Message-State: AOAM530naq/ZKcLpnAdS4baTAoyHdH6TowoJDbZgyKkeUHFrExNyRdgq
        RGA8vmF4VKXh9PPd+MxjWvFs1yflSekCYwr7
X-Google-Smtp-Source: ABdhPJydffaCTciB3KSwPNm0WyIMKneSRt4qe91mG8iuBCJ2pMt6rty+FLoWyyExsEHMpnZ8DtY03mGxKVd68qbZ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c4d9:: with SMTP id
 g25mr844467wmk.15.1600987853482; Thu, 24 Sep 2020 15:50:53 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:08 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <56eae03b7b8112b5456632f0c00bd42e7337966c.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 01/39] kasan: drop unnecessary GPL text from comment headers
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

Don't mention "GNU General Public License version 2" text explicitly,
as it's already covered by the SPDX-License-Identifier.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
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
2.28.0.681.g6f77f65b4e-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89042C15CE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgKWUIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbgKWUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:08:37 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043B4C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:37 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id y1so149920wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=L10tW/D05wNgm0snGrZ8GYs8HuV/uyjC1rIZlpL/xjk=;
        b=WY7HnayGjrG5u9kXKk5PhUzHTMXeXMBMMScYuxT/8DAoQRcVNeZljPfUVoz6rdJ4rG
         YP0LpimBcAhWWBzNRkoff7VZnStZrCdCr5fj9YFZmhpVg6GONpbuR2LP18Lui5aI13Ny
         HAVSxOIhdJcyWVH6UE+Au3IoID371wrixzkFIXK0kApB+hFg+r6v4vIHkmSb/HgEWFqb
         sLiPB18/Ikq0UNm8WGs1mKy/zg2/NcJsXJ7mYTauaCRn3fpZuQczNRYbl4lhD/CwmUUh
         2P0rwvTmj35KW603PdUSux3zlw91dxbEIVTMZOa0su8773s56+IjuZ5BjZ8vvYwRXFUA
         xJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L10tW/D05wNgm0snGrZ8GYs8HuV/uyjC1rIZlpL/xjk=;
        b=opeRE7G/3rdmq/PBDnoSk67qDktkT0nAlps0OmHC97aBdRA+XBsQQ8aNuuO2RP4FjH
         M7Rye2fDGLJVxWoG+eyfojazKmiOhcvPHg4RjdAqfNIFqZmkkNMwgFptGkqdZCfjRQwW
         e051iftPFdkdWaA26ZhO5Y29wRbFh6Lmk5PvCWpVR8znihIuh7qOh724FSkMfWvuCFeK
         8EfaTGZIcjOgGoJsCT5TYqX4sKKKaUfyEkfao6bd0SBMmICon2sty4uXUJoIV/BVJ5lP
         //PpKFZI/2AfFLcNAp3o6dhYYiNfuzKfTJ4A/PYkDHQ2ONH0hxHErNEmKnsAuaLWnePO
         zuAg==
X-Gm-Message-State: AOAM5326Ac+CMg3lgyt/sa67X61kMHX5kneA/j+tJHCc5beK+RLRTpp/
        2qgOfEWNQSogX0bmd5fsLdvCHIq5z+Nkb6Gr
X-Google-Smtp-Source: ABdhPJzFbkTHYUXQ0AP1nUCkphIhjdFvzvHYBHe176dhuCRGDAPitBMRBsT6EO3FxUUsC9ksOQie6xmDPlpQhyt5
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:4086:: with SMTP id
 n128mr617585wma.68.1606162115754; Mon, 23 Nov 2020 12:08:35 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:31 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <bae0a6a35b7a9b1a443803c1a55e6e3fecc311c9.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 07/42] kasan: only build init.c for software modes
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

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

The new mode won't be using shadow memory, so only build init.c that
contains shadow initialization code for software modes.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
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
2.29.2.454.gaff20da3a2-goog


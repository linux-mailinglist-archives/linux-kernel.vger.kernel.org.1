Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C3226AFA2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgIOVem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgIOVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:16:47 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4208C061351
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:38 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id de12so3088105qvb.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rBEpAT9/SFMGCMSd5Os7EsFNXqLe39zVSJtjGGUatVU=;
        b=dSJTHqOZiuuDXKvtsDQ8oQ1PqjUxDy7pC2eYouUYa/AFSAuodkr6j/TZ2jO5NgNaAc
         g7YofzhuPIXWqXGAttfKHdujHDCWUY1lgj8UQWTG+rsmQYy0rl997KUAGV7Dsmnv1SOm
         rEnBBrKjBEb3+9EL1PxJaDOkTUUwqdUTCY98t15qBwyJqlTJ8qCncGTw29O5PD3gDUMY
         WaoaiAZLu+iktghDPpg4OCF7suInLAbvgvxlQ5D36dLCsOCKOWCa8mV8FjAOEhEObaNn
         IOu6FRq2u1BojQwe6vsGpGw10jJ/Diw2orJidd+Bi3EgKSzbpa7fb2iHxoKCAW35Mbvr
         JYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rBEpAT9/SFMGCMSd5Os7EsFNXqLe39zVSJtjGGUatVU=;
        b=Ph/f7HiLxvToOZaHHR7qiB9uUthdZ3e99nrodn34/lUDRvJutk7AsArOzs45Cr4JIT
         7luOqxR+xZBiNIWq83wzoZTGQmSkuYw9+Enm66gGvWATygUoTjnDug7MF82+7dAEF9AT
         Ydb6z+QyWo1z+0XYkXn/KAiC6gODY8ZzaV+bpjJNUTE/oBC7+bK6uzoKToZUF9xRzj61
         vuQ79CBbIp+m+B8NtnbeVwNkOsyFvyTxvJLn0cGxmJyd+JHxqIldUKON2jABVvW9j9Nv
         /DI2BpN3OVl75A4R/fsL6vdg0kN7LNbS8+ZWdBAoWGGnafbMtK9+QJy/DckxmkPOE4UQ
         h+Yg==
X-Gm-Message-State: AOAM531pIeG/Yn7+JyYnqYiPB5XcJzj+I4Vi2XUd/khHuicgp6WoO3ub
        ewOdGkmRVklNKcgwAMmab4ZGnGjRfoPRHHxn
X-Google-Smtp-Source: ABdhPJwVtoNlwGtVWMSadXgwwXxS2o67SZR8HangbbD87rRH9KN5qPngrQJpmzAic4pHTiuGP2p7N8MS0/tYgX6p
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:58aa:: with SMTP id
 ea10mr3757654qvb.58.1600204597332; Tue, 15 Sep 2020 14:16:37 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:15:48 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <b154864a1b17319c865fddd01a4bca5aaa73aff5.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 06/37] kasan: only build init.c for software modes
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
index 754b641c83c7..20f5e1ab8d95 100644
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
2.28.0.618.gf4bc123cb7-goog


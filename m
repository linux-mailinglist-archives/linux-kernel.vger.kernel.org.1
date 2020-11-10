Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945412AE2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbgKJWLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732312AbgKJWL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:11:27 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6159C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:26 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id k128so1852220wme.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6f9VU8cnKdC26HiWZCbo7yiQNGjM3ZLFH75+rhjhEuo=;
        b=l7Hc/vzPC33aK0F2FIwgATKyemADk7tdOmZrpOP8l2NozmNU7dTMYzx+4npCt0feKi
         KSOilVDVHDm8DsTkYgDpTg3kYxyhwKNlGfWXXNQ6swfPw/DeVNxT9uawaPbUBhXG5GIe
         ipA5298LKMh3NZpmggt8K/fCNgHnqV5XmgvaK1KfYzpWYL4ay11vVxxhut2NLg6THaeP
         enxKse/CPfgSp7EVWaAXGZymqT77ntW7tWS5U2WPjdll03kJx6j+ZI3ZeZkB6hM+wgWQ
         3uesvOfapoVmF5T8WxbmKBg+rhoo0TcqjyqMS30GmS8JAGED4uLACabPMwPgeA9S5NwI
         9ChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6f9VU8cnKdC26HiWZCbo7yiQNGjM3ZLFH75+rhjhEuo=;
        b=FrhhHSZ5ChKBpFbAThKrsznxC09nHd57HEH6jQ7l54Yronu7BsHPJPk0XmD3Bo4Nk3
         hDHuV+vzIz2qewk8GPlGrQ3qQK6ZF3t9zlEiHu8mGe3oZ38u12dZ+Vr0czUd40GEBOu6
         gvVZrQGS2QS+4lb5oGxav5hGCcQMaGAtDagHyP8VqBtB+rgndW9ImYYlESm81uN+EZob
         8AVVxrN86A73qG8ZE1HGsJlk3wUssA5JKMu2wGgZwm0j52M0kRiS+v29PT53lxsw2X06
         twqrk4cEU7ftTlrRDer9iB+6dHxov3RfJGGkS7Dkn0zn7t6x1DniZtBw2Uc2rtTa4N7u
         Fz5g==
X-Gm-Message-State: AOAM530SUDWlDZC8zha0FJa3BjZqlW/uQG5d80ZxQy+AiJJDo3VymWBf
        4ZA6jFFF1rvJvvRQNA/oXri2c0mPXMBA1g0V
X-Google-Smtp-Source: ABdhPJzzHYnhIMVYTBo48dWfa01YIUeKy05HkzFxcXPTRtXwbOHLJwDIYk0OW4nPWTiw0rh1kN+BALAEOKuM2KHX
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:a5d8:: with SMTP id
 o207mr283775wme.0.1605046285365; Tue, 10 Nov 2020 14:11:25 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:05 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <8f1316319d050f2019e03dac28a37ce1dd5206db.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 08/44] kasan: only build init.c for software modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
2.29.2.222.g5d2a92d10f8-goog


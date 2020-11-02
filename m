Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984442A2F1C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgKBQFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgKBQFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:08 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C781BC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:05:07 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id m11so8466137qvt.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Sy6BvWdNS0zjXQiflbFd/HmI5xZS6ylM1lYk0zN7bgc=;
        b=HVGBfoVQuqawyYPyqkKhtPLjHY70+xmE4evLY9Wev/QYsd3YskSStGJaHrpAxkxpXW
         TdiudYldSt8CzICgNI20YY/qKjrbAYANuNINAXllncJKS3JwBokvGa9hZeSaMtZznhry
         X00+ueOe5kQS5bhF+C9mcCiKs3A20KcCmTjJn7Z7fIQ4Gj1QWSNuLjVwE03OxRkVvly3
         qqsUkbpqy8FLCmpiUyVLqG5iq3/13ZPgkYsGOoqNOikwl8Ot4sRvU3i2bLye2h5E1ynB
         tqnS63qKVsEWGOuoNvIsH8nqWTLq4BnEH7Zi/1y8ZcW2eEpetUt2IapXtllgv0MVeONn
         3hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sy6BvWdNS0zjXQiflbFd/HmI5xZS6ylM1lYk0zN7bgc=;
        b=EOSwcEbfKbdbLqOAY1s3/nOjSoQxW0mKWr0wgacwHG4HW9/mdCjyZNmyoJd/tGSgjx
         Sa+vIOIucuZT13xW/WbagCazDE5R+lMB9FY0tjUVgk5xhdzy1yJloiBVJCBJm9H/+ETU
         pi8yButkmCRQOfi1Kljr6dvLjExPnjHJ17dcc9DhQ6x8a2Fw5RR/mtjhNJNVAOu3/r5p
         Osp8ZFjdvUmSJxcW6GqXqNQjuzUcig2qynxpb17dOhJNK2BYS9hylj1MkarTH+1X2eK1
         eGWLeAjnFg+4R9WjsinBszDgosU6FIUCUkQ2/hJX+rJNZCO69XoNVDh6unv13rUA6irp
         /WYQ==
X-Gm-Message-State: AOAM533ZjRXUN6Xw3KQe4UwnWrc1SwK5UcOQ2ehYoFBlr4xFmjBIMDx0
        lnIxSIpuRRZuQz6s46IGu63MPGDykvD1ClwF
X-Google-Smtp-Source: ABdhPJyb67OnlC/QoQu0KF9Gdop+DlVTu6p8FT4oUvbt8p7oowAaHDwBN/mhcMngE2XNR8scYV9LA86mLJlVhjo7
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:e585:: with SMTP id
 t5mr22207546qvm.6.1604333106950; Mon, 02 Nov 2020 08:05:06 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:03:57 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <83f76fc92ca8c7f1a037356d11b6242ae0c4beef.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 17/41] kasan: only build init.c for software modes
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
2.29.1.341.ge80a0c044ae-goog


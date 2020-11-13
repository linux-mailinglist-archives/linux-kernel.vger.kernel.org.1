Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5162B2810
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgKMWQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgKMWQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:16:34 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B9DC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:33 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id dj19so5516506edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=XIXqMdSsmfBQs1yd8rWpQ1njkvR1OEP1mN24itzZ0z8=;
        b=MsQn79SoUJJeObtCQubP1XJM+/4uvn5lt22MBP3Wghdb06ywsc6YEeSNO+pYa3OIkh
         ssT4hBIw4jIkKZ2DFOTcVmfje5MA5QM1F+iJRPkRIeGP3mYJFg0uKDY6QuHIrXKWDU2R
         pzx/P0TPfJ7ttGDIaZI2mtP2nD5XnBF8ws2Otd/EjPQLE6h2BaCqXaZ9BI8T5YfOEL03
         Iv8AGAs342RuHWaVZwAD6ZxN8L7XLb977yu1ejzUbvmzOxHKkaQrPvJ6tjnwhGHdfOgc
         CZzrtaEbw1REc2DDSauDmL9ePBBjDqvJgvvO5a65iOYnT0wmSQq9DkfU513BeUV/9Mrp
         qspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XIXqMdSsmfBQs1yd8rWpQ1njkvR1OEP1mN24itzZ0z8=;
        b=MVbW+AxOAo/dmryCkWEwq4CbxTR/ZLm9ac0rIbBXss8/ScXM7r86uFURGgN0dlCIkM
         vNC/Qekldcc+bF9pJ5Ag7hUdtiBrO5lZrZnS8EuBbhW8zFGJqZOHp85+iNIyGHTthjgi
         nhQmsTDZhmsAOpCx5ktknJ2jetw2OqAsEiS5/TggZgKrcFf8VZwIKZ2h5xcsFX/shKnd
         GdGOp2X0BZxQV2KPtT0nCrWkhZL8WECQNrrIxvhSVoMLCvuCXJ5Jf5ehGEJGDyj0Tc+S
         uLnFwXjcDzm+ksnK7RvREHY798IXgmjr9nGt3J4Tj/SpdQigfqTuqlxvPHJqMRrh5FJi
         tNNw==
X-Gm-Message-State: AOAM530PLPb9pcGo6w/8N1ikZGx+mzbuO8M4gh6aoWyGvw7a4g740hmo
        tbgPykB+aZRbW29nNA2WCjMG7WIMy1QsTZ4M
X-Google-Smtp-Source: ABdhPJytYvAT7sfC6L6XRnid0q2PW2TI4VItscibi11n6UCT/CiKjrH55CPiPlLNCy0c2MaTEHl78/CLRBNkVgDR
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6402:783:: with SMTP id
 d3mr4903651edy.168.1605305791570; Fri, 13 Nov 2020 14:16:31 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:35 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <a1864343953031cddc2cca424d9b7f50ddf971d4.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 07/42] kasan: only build init.c for software modes
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
2.29.2.299.gdc1121823c-goog


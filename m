Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED59628C309
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbgJLUpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388242AbgJLUpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:45:34 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8577FC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:32 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id v5so9846939wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+lIiyQNbZ2iD7jyjbQzQvRa+OabJUbarW1CP8KW9GaM=;
        b=vBaZz+YU+ry3XJmEwNeO1dT8ozyCPZe4R8FjW0kRP9nT82E29kj5Y42lCWkmR1+36l
         0nomN48mPRH03DSICjNl+KQqHYjsSlTloqovuDgMBC4t2QyK6kFjLWq1PSf+WkMaLqCx
         ja/bh+BDUSPhg2tVTK34HEevGIA3Ax4gY6+qUJBoC8dJ26tyx/QLoQpO3LLhy9jxKlQp
         E9g9p4uv8TCR85eErEkpZ2LVkm0Qfy0M+SfmqiFkkD1VAwmYBMy8EFPcXjBJI9IU2as4
         1Ul2inLhPW3HKmZBhAoj/lnvkJ8ZqkEbep3xXuzYEsEAL1xB7u3f+MgIXG/XL2LgGUV7
         xzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+lIiyQNbZ2iD7jyjbQzQvRa+OabJUbarW1CP8KW9GaM=;
        b=V3F40Q6JdGUWizfrum1QILLFk/OxlmfBxsjzbMkW989ypPlWtrzw1otRkXP6/LSgy4
         4yzir0fp40sk6ubZw0A3uwGimZNh83q1xVocoFD97mwKkxV46uJs/whdBupl93XDMR9K
         kRJ/QJx4SLAkdQfqLhV4ucSpvjOVD1F7z+aTJ/GqHFb3Bz5TO0I+VspimCd/ox88FiUP
         kGAlRKzJv74QscbaVLJ75oold/+YyjSr/dFhTBz8emQdejR9J7DUZaGO+gKivGhe49yx
         OlANuxpJ+R5BToXnSMkUf8+maxlTjYe6yfgiuocMUJAlnVRK3Mn0KOFfG4fBj6MNYdb4
         Yvew==
X-Gm-Message-State: AOAM5330eYYiByK9Ru36jCrwUDWZcL2RusYP3w1WxFIkt4H6yMf9HrJZ
        Oz0LrC5YGsYWYO+gZf8DAtMCLKtYc118khz8
X-Google-Smtp-Source: ABdhPJyW4QbvFfCV2DzCKlpyUbAyqDnAwr25iZsR9Cokt/GEbqub39TPrYlM7wHE95VxxeQDe/V6RDGARxmr0rAi
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:9952:: with SMTP id
 b79mr2315293wme.144.1602535531176; Mon, 12 Oct 2020 13:45:31 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:22 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <1ad8692bc5cbe77ffa26052c2e827e1949f2ec84.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 16/40] kasan: only build init.c for software modes
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
2.28.0.1011.ga647a8990f-goog


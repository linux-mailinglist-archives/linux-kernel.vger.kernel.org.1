Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9F626B00A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgIOV56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgIOV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:29:24 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F5EC06121E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:13 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id p20so233171wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=esxSXj6mlAjehqEnyoU+Xpp5A2AelPI+Y2Gwz7MtjPo=;
        b=ujKP7f3676l72cWSInq5T3BbJ1ePrrsTWesoXaljrb3jzdEAOeQg9Ap8DBJKkPTnUA
         VB2vx3VHlei3rH+0RnjabUY/ixqcWjZw2y5lzkCfx6MzmDOroHPawZJt6uInPJMXU90j
         HS6aIT/g4L1kJ6E4mb0/xDt6scUTaOJLSlt6KsAcBNpmndBLe6TcTof0Ua5de0FMqqg6
         5diX4jZZDu07mSajtmyv2OaNR6lFEHkV2YtbhwvqUzaLDUjpVRbX1qGkErZiFgQUD5ZV
         S61AucVPy0W2K8hGiDP20CYQAC5uzNXI/s5l/IYVSWE8QZ4SEAbKQQmJl02QArsG9u2C
         oEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=esxSXj6mlAjehqEnyoU+Xpp5A2AelPI+Y2Gwz7MtjPo=;
        b=uKjpp5ERQ3kIiyUV/RMYTyIJ9cmqSuE2/ZoY1FeL5QUPQtbgyDCqbVy4OBXItaH92W
         DxLpo9Zi8X9KRGOq9n4IgEhQ0a295mxylWVBQAmt0N1i68LlxvXB2iOsNr2BWsNENWwW
         45fXF/XYNJzwrnKMwlMTqB7RtPV69FzYurLfUNuKO1OIY2BnbUm/s6elDgoUUrExIMwo
         xp3yBz2NcAdIVSK9zop8a5PLDZaPfn3xp/jbtc7WRlY6l0hC6nzfi/JlMswDwE/uXkw4
         vTtgOJjoKRn+EAukeLi+LGroO2JluiPwmzFARdcRmixvQEaYwL48hapNjmTgEZJkwhmz
         sI9w==
X-Gm-Message-State: AOAM533FPEYbuCm+Q0ACHCUGb70oZyJ0UDFrVAgEug4OdaZAvNsHUaza
        bRrLpYhw74/QwilKq/ygtmMlfx+2qQ6/AO84
X-Google-Smtp-Source: ABdhPJxcytv3DgzuyYcVFGJMlv8Oz2ucCD3HgDMSQ5j66wJnUEU9r4DqngEjJLt07XY6hdWbMt1ObH6FNDSH9bD8
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:e256:: with SMTP id
 z83mr1249442wmg.33.1600204631443; Tue, 15 Sep 2020 14:17:11 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:02 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <28d17537bbd029104cf7de4f7ca92246449efa50.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 20/37] kasan: rename tags.c to tags_sw.c
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

Hardware tag-based KASAN will also be using tag-based approach, so rename
tags.c to tags_sw.c and report_tags.c to report_tags_sw.c to avoid
confusion once the new mode is added

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: I922ab246c5903e8ce3dd3766b923aaf250599850
---
 mm/kasan/Makefile                            | 10 +++++-----
 mm/kasan/{report_tags.c => report_tags_sw.c} |  0
 mm/kasan/{tags.c => tags_sw.c}               |  0
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename mm/kasan/{report_tags.c => report_tags_sw.c} (100%)
 rename mm/kasan/{tags.c => tags_sw.c} (100%)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index b2596512421a..0789f9023884 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -10,9 +10,9 @@ CFLAGS_REMOVE_init.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_quarantine.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_report_generic.o = $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_report_tags.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_report_tags_sw.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_shadow.o = $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_tags.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_tags_sw.o = $(CC_FLAGS_FTRACE)
 
 # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
 # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
@@ -27,10 +27,10 @@ CFLAGS_init.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_quarantine.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_report.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_report_generic.o := $(CC_FLAGS_KASAN_RUNTIME)
-CFLAGS_report_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_report_tags_sw.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_shadow.o := $(CC_FLAGS_KASAN_RUNTIME)
-CFLAGS_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_tags_sw.o := $(CC_FLAGS_KASAN_RUNTIME)
 
 obj-$(CONFIG_KASAN) := common.o report.o
 obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
-obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_tags.o shadow.o tags.o
+obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_tags_sw.o shadow.o tags_sw.o
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags_sw.c
similarity index 100%
rename from mm/kasan/report_tags.c
rename to mm/kasan/report_tags_sw.c
diff --git a/mm/kasan/tags.c b/mm/kasan/tags_sw.c
similarity index 100%
rename from mm/kasan/tags.c
rename to mm/kasan/tags_sw.c
-- 
2.28.0.618.gf4bc123cb7-goog


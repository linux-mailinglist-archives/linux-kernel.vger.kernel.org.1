Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76152A2F3B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgKBQFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgKBQFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:50 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49659C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:05:50 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id 11so5508030wrc.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NNmCWg3uUJkm97N9bODpJVOfWoCAwpfkACCfjKkMoC0=;
        b=qPcFaq777hgcZTn8yo7P5F27kww5oGhyVSMjBwDWyTz9uft51/+YlmhHlTg9S7hGV9
         d8b0wvwV7HgGGYbBBF+UzG6xXIGdftNQsOe6rw6IrJtgsp9EVwCV/URLlBvOkk1AIaNy
         YChwpa3HVCcyS0b6aFarAJ/RSkc/zQa+sNebjqtfmGTTw0xy53wENFlCMAheQaaGdb9T
         cvjsSMFugF6SyvsfPEl42aBMAnt/JAiB9geaSTKxkef2XdTa+yJl/ZUmTGs4BDTO36E/
         1QlyL75W/QDPxiOkFTufsc1+SyAqNVAybEujDrd9vhWrHLfADL9mBLfJKI5VEttMLVrz
         BU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NNmCWg3uUJkm97N9bODpJVOfWoCAwpfkACCfjKkMoC0=;
        b=dqMCiIU38vgSLeHcsTS8v3e6sTxwAb4xYN9p7CTHmfPR5q9R7aqdP4v/URkHX2rYg0
         1SWAC0RwoBLlMynC4VvJZ4jTHqHv+POs6wCNrmkZxXfKHnrxt+DQEaxpMicXcoaYBhPz
         Mn7dSjzoFtBnpfYSZ1U9jpk8bi9w1FpbstCuaZC3SvkkgHPq2d9MzeL0HvahEoJpoFBk
         22yS3MVyZ1r1191iI1yAT2QL3Fc1Bb32UHJfoaf+4q+LdqpnWChJIPmBpC2d27WNby8M
         FXCUvtT13/uBVOR36JgP+snDydPUZq8KNnmRtDpiTLi1GhuhE45Hks+4b3VoJvWFsgIt
         2zuQ==
X-Gm-Message-State: AOAM532W03g/r2dUkNU4YzxHmoPEdxng6+XUBPufRvdsDLTKfpVXHHqr
        aMlXMfSAF3uPyKxPnB/IicQLZZ/fSa7TdRH8
X-Google-Smtp-Source: ABdhPJxTZtMrOlRAcivtl/DfxDa2NTxs0uKOGlHNXMtACmGBEzGdVF5pCUR1iRnUEa0kJT9CCPiHdU6rMhOzZWEt
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:b0ca:: with SMTP id
 z193mr18288765wme.82.1604333148905; Mon, 02 Nov 2020 08:05:48 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:04:14 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <bd64e051e8e36ac25751debc071887af3d7f663f.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 34/41] kasan, x86, s390: update undef CONFIG_KASAN
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

With the intoduction of hardware tag-based KASAN some kernel checks of
this kind:

  ifdef CONFIG_KASAN

will be updated to:

  if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)

x86 and s390 use a trick to #undef CONFIG_KASAN for some of the code
that isn't linked with KASAN runtime and shouldn't have any KASAN
annotations.

Also #undef CONFIG_KASAN_GENERIC with CONFIG_KASAN.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I2a622db0cb86a8feb60c30d8cb09190075be2a90
---
 arch/s390/boot/string.c         | 1 +
 arch/x86/boot/compressed/misc.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/boot/string.c b/arch/s390/boot/string.c
index b11e8108773a..faccb33b462c 100644
--- a/arch/s390/boot/string.c
+++ b/arch/s390/boot/string.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #undef CONFIG_KASAN
+#undef CONFIG_KASAN_GENERIC
 #include "../lib/string.c"
 
 int strncmp(const char *cs, const char *ct, size_t count)
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 6d31f1b4c4d1..652decd6c4fc 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -12,6 +12,7 @@
 #undef CONFIG_PARAVIRT_XXL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 #undef CONFIG_KASAN
+#undef CONFIG_KASAN_GENERIC
 
 /* cpu_feature_enabled() cannot be used this early */
 #define USE_EARLY_PGTABLE_L5
-- 
2.29.1.341.ge80a0c044ae-goog


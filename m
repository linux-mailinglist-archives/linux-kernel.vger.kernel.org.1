Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22262C15F7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgKWUKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbgKWUJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:09:51 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65A1C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:51 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id l2so6007339ejx.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rfxkb1rbWhlJP1u/zeppHvBMeszJmW3VoX+v06hDfPQ=;
        b=S901JV6OYv0DZw1mRU118ANFvXmzWoHSDPEmWrI6jzezugG3fwVLpz2mHCft2nxRtP
         EI2eUSJ3x1IU4k0OV3hutp956T65HeL8BBatSiHQMHfJQWjUDK8bvoOm1OrtNMO7uQxw
         XtvdlJ3+5yv+QYS7x7jaIAc1n0cqHMb1iFQktJ+VYW6aQNM3xpKnciG27mJ42MGeL8zL
         4oco0b6imy4Xv7aOQ72vo/UyvC31zc+f2u155Dzz88zZ+FNMlf0F2blDqd6nJa0EJ3KO
         vJgx0Vx7C/TH4I+y1+cOY1w4u6ZRPlwsibSqX0nqnAsCh6+9B4tgebFi/sjwVLwWRsOH
         3D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rfxkb1rbWhlJP1u/zeppHvBMeszJmW3VoX+v06hDfPQ=;
        b=n7SlKJUWXvo9idFUyaHt53tHs0S54eYtC5ifmITJVJC46EZprg5nCL/edCS48NFYe8
         +OVPtyZ/S1sFnJCh8oEMH9ELXpOAY7yncCaGF8WfOHmrSWb8EfAeTk8QrV3PjB7qZe3s
         8lKxb19/1EP/3Wfb5q4QWBuloykTJateb556P7u9MSgesDCaO91sKqKUmp3BhpIXziSs
         bGHu4l9Ce9xf4ud6fzLSdvgb62btd2NYQ1SSi8ou6tDSSDbzH/zXzEaStwm/ir0A6XzU
         Qv+Ja2S3EXRxj67hcsRAwhtFoWIWO8sCD9eYNth7lQVHmUSUxYN12NupDwdp6J2EjRCJ
         Uw/w==
X-Gm-Message-State: AOAM532f/Ji0jDjyf+t0zF0VaxOj+DnlKc+3GkN2VIAxyb0XYo+jDOAS
        1g1f3cZg8m/+KTF44rBWH/FMnh1PHEsMPZdj
X-Google-Smtp-Source: ABdhPJwCl3N4O1o+4xYsupCVtEdYknPpNvWd01pn7sNTrxrPEx3Sbcne4XR5ESpGoEVMUbTQU5mzs7X0t0Tx2Qg6
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:c0d1:: with SMTP id
 bn17mr1284452ejb.114.1606162189982; Mon, 23 Nov 2020 12:09:49 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:59 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <9d84bfaaf8fabe0fc89f913c9e420a30bd31a260.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 35/42] kasan, x86, s390: update undef CONFIG_KASAN
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
        Andrey Konovalov <andreyknvl@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>
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
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
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
index d9a631c5973c..901ea5ebec22 100644
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
2.29.2.454.gaff20da3a2-goog


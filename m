Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CAE2AE2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732983AbgKJWMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732971AbgKJWMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:12:36 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6F4C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:36 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id d8so5231954wrr.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7C8N6r4JJ4qY+cHK/gFnwxLkHzjgeTe7+92TE+0jPPs=;
        b=YvQ5Un7KpgwmcezPEXaAUP8hpYtZyNCnEnOccFbaSYcbx6SJHu8KzzNajc5YOyA3cz
         HfiKVQkunx2vL46SoYIwE2SFC2+mVM6jOz2rTvjh9yY1FLTPCaGng24kSWY3H270SEA9
         xHmYoS4XQl01JzqP20Emtv+NN3BxgG/NpTKeTR/PT9qcT3ZA6K2WCp6QEoXcS4L6eMoY
         TzTEjkcpUxQAOropERblscTf0Djg5pgNrCwoHKpnrOIOvQ0qTGGoFybOuu3vzwZob8Pk
         md8iuty1xuBKMfiIIAQvT6+QFQgIaU4dPEtcqdvIPTSXfkr+LKg693LdKhpKmom2HuWy
         clbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7C8N6r4JJ4qY+cHK/gFnwxLkHzjgeTe7+92TE+0jPPs=;
        b=VFEag68VgA1F3FSY2bNIxKY2jvhv4I44UCR8Kut3zuS4nf3A6AYGvSX2XbI564ZXU3
         o2vj+UoHu1OY3Hl+vzcs8pvVSzWO1wgukYrrZvPXMbe1/AAIZM7X/ld1YggZ3Tz7661k
         qwscYBEmYVt6Xdh/r9q9eoMfQYwEtxd2jTujOoak0VcBaern1UPLGBZQDrr4jTtgCguZ
         A2iBZUcN3TrFnT2Er00FChREbFXih5BbdMlU7AnRgsxxgmD3Cgc4gOqkq5R/wRjMUqvr
         DxEtCqjRYrTXRmQWN4CqqlPBXo8SkQGRi01BOkYuWqrhteHHyGcjb66yQdqftR3bRR53
         FLZg==
X-Gm-Message-State: AOAM532A8e3+TmHwOQa/JQxwDs5Ofq7bRm/BdU/lLuozICW/NwhaJTNp
        gwU2oygUIAAOb4uRPZKGPi/Syn75hihvmYuD
X-Google-Smtp-Source: ABdhPJzl5GsLF/tpsFk5OrVcRbgjl6qm9T5vyCu518DfRzeRWoShn0FhVtrtHn7ELb7tiDRniXsLP0B0mwAY+ryx
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:634c:: with SMTP id
 b12mr10670704wrw.130.1605046354872; Tue, 10 Nov 2020 14:12:34 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:34 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <096906ff06c532bbd0e9bda53bcba2ba0a1da873.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 37/44] kasan, x86, s390: update undef CONFIG_KASAN
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
2.29.2.222.g5d2a92d10f8-goog


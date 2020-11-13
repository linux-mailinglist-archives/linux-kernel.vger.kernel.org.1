Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4F82B284D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgKMWSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgKMWRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:53 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D167C061A47
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:40 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id 3so4704997wms.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oVadbN3NqpY7ZnHAx+kB6EDsExDJuzGfxhHAguhdwUM=;
        b=TaaWdO3Z9oElGMBNzh2f8+qtMVn40dx3CM2RnB9fmkRdKPAllpul9uP+B32dnclVVF
         8/Zpl1FFBQh6z6jDC/k81W7Xdlj6R5ZrfiqxiwoaM9xeTVsK1rT4uxOCTksOmNutwZsA
         ijDa3E8QiM/rulDyo8dTHKe5hm3rRPEvYK2x/W0N73k8uYOu8pQswUBQ0yaPS8w/vnbB
         N17YiOLHtltDhgW2D11PD98jyYMMcPIOB8DaqqU2uS0fp9CxHxhMATEZF0VlzhAOFpqA
         3tDLWDc5OqE1pLZwrlfbhlFSPhp9K8JduDafIEohgehd1y1wboXqhLj13OzmTdupGO8/
         mxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oVadbN3NqpY7ZnHAx+kB6EDsExDJuzGfxhHAguhdwUM=;
        b=eV7tLfIvMDMQ5wEFpoqBFR3++m9RZ+QYJ5RQEtSeKP9GAHNw7gmuDsuatElsxxlq5P
         4fe8m9hbnsIvtbYc5gGnwSiF+aMKJdo2a7c5njYmd8p+iLsLv9wAbRcffAHxRN5eaGju
         L3NKO0eH/d4AlCUuKQW4UaIzl48Ohs6ZIWQoXo7KOaCsPKR6EEz1ZZQ013rvDMzix8fx
         LJZScV52Rq9RejTrSWrUHOamhVWF0YKcuYWC7cInvjZZAkbrASFrhq/tttSLoKEE5AoE
         u/xydsPdzigHUwu6iXyS/fTrogQ5eXx+cIexGxbKqVVNd0gEYhzTVVnXaYyGs0AoY1Ct
         CE4w==
X-Gm-Message-State: AOAM532eOw7coEZNH5pYR/06AGrtuLHpYWY1X/ZlZAZtCKv1+dKDbjzx
        Od8sUqQL++lt/cNGexreDIpwXWvo581ek9jq
X-Google-Smtp-Source: ABdhPJwqa2plxzr+Xp6G01BlGars3fgz6BXNB4ELLA3Omf5LGJf2NJmzLu0GLN2zQNArzOvU2iCXktUucOZGgNs+
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:ebc6:: with SMTP id
 v6mr5701672wrn.427.1605305859268; Fri, 13 Nov 2020 14:17:39 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:16:03 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <cb21c3e3100b37b4250cb35e109b1513fc8aaf70.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 35/42] kasan, x86, s390: update undef CONFIG_KASAN
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
2.29.2.299.gdc1121823c-goog


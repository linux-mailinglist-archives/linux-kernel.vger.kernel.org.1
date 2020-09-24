Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444E3277BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgIXWvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgIXWvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:51:49 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164C7C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:49 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id j7so284856wro.14
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CfInn+EsKhB4L8Pe7ugZJV/aGs/bMMxN4WZ/9r1ElOU=;
        b=XMZR6S1ccGJpjLk2CioT8RXTdIOr7faQbPeBfVLl/ksbEzoalTJJpYU1V1Rb2mo71S
         k8Ad0ORPceksGDNXp3QBmNmYwzCcDbqR+CxaHEjIvrI7CUQMYUAdSQ60ziXM0rugQNiZ
         FI6F8QdBrBli4Np6b1pvAGVO5Ilvj0Vgc8XSk21WjhfmdHV+oyUP47v6hqcYuHPsn4QV
         Tuoq8mqzbmlt5+SgfRuk63a1mhP9SfPBcSGGSSyNVmVD5t8jx1NGEp0Hnbj7BY9V/ytg
         Fufb6BAm9GvsmvKJmcvCiwGIq++o4y3T1NOKx9GfCvsUzOHe2X6Mz9uaL9HEbim1iM+W
         +BHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CfInn+EsKhB4L8Pe7ugZJV/aGs/bMMxN4WZ/9r1ElOU=;
        b=oavwA0kpFUgP5vfenuCfwjrNzM9/tDZbU6yiLe6O6jLRAU5geaE+IA4m47CLwgxX3g
         h+R8+EME9pBmHe6dbvAGYBeKkSCmPtyazijEt8v7fImCqE5sNXL+EJvhJEieiOGIAsxR
         GffpUlKpigGVjmo20tdro0LfXR1/SRSDyNWJNJftQ9spLPg80N3bfvUOP+pMW05YOxzE
         P2xMw01B8KmSQ/iLQILS8mchov44K4rDp6QKZT/FXur7Q8LPLuizVBNh8LVLLUmtkrsf
         iBTtlokEikMU0SKgIqCeo3OGKErVzL+7h3+Lk8h6djHKOJjfUIHTJSOgHIRtFF6L7Eyi
         acuQ==
X-Gm-Message-State: AOAM532WxD4AyLMa62nq1XglZXVcqCKvWEHsBnyz/zQxxYMmzrBjCt0i
        c1yfpIfEh/yRj6znz2yeI8FFCaa5HJRcGBS9
X-Google-Smtp-Source: ABdhPJwKoF3YGVhEBJ5wDK0wOVSAq3MEoLUxaZtygFZ0faKi3sQoTN0k2mdS3T5ElyxDYi7GBHWLos1SCWh0e710
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:c5:: with SMTP id
 u5mr864994wmm.14.1600987907480; Thu, 24 Sep 2020 15:51:47 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:30 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <878fb755aed45104a44f2737d4244c14fdd1b9cd.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 23/39] arm64: Enable armv8.5-a asm-arch option
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Hardware tag-based KASAN relies on Memory Tagging Extension (MTE) which
is an armv8.5-a architecture extension.

Enable the correct asm option when the compiler supports it in order to
allow the usage of ALTERNATIVE()s with MTE instructions.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
Change-Id: I172e15e4c189f073e4c14a10276b276092e76536
---
 arch/arm64/Kconfig  | 4 ++++
 arch/arm64/Makefile | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e875db8e1c86..192544fcd1a5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1600,6 +1600,9 @@ endmenu
 
 menu "ARMv8.5 architectural features"
 
+config AS_HAS_ARMV8_5
+	def_bool $(cc-option,-Wa$(comma)-march=armv8.5-a)
+
 config ARM64_BTI
 	bool "Branch Target Identification support"
 	default y
@@ -1676,6 +1679,7 @@ config ARM64_MTE
 	bool "Memory Tagging Extension support"
 	default y
 	depends on ARM64_AS_HAS_MTE && ARM64_TAGGED_ADDR_ABI
+	depends on AS_HAS_ARMV8_5
 	select ARCH_USES_HIGH_VMA_FLAGS
 	help
 	  Memory Tagging (part of the ARMv8.5 Extensions) provides
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 130569f90c54..afcd61f7d2b0 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -94,6 +94,11 @@ ifeq ($(CONFIG_AS_HAS_ARMV8_4), y)
 asm-arch := armv8.4-a
 endif
 
+ifeq ($(CONFIG_AS_HAS_ARMV8_5), y)
+# make sure to pass the newest target architecture to -march.
+asm-arch := armv8.5-a
+endif
+
 ifdef asm-arch
 KBUILD_CFLAGS	+= -Wa,-march=$(asm-arch) \
 		   -DARM64_ASM_ARCH='"$(asm-arch)"'
-- 
2.28.0.681.g6f77f65b4e-goog


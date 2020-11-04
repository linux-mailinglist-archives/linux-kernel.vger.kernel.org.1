Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC302A713E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbgKDXUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732785AbgKDXUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:20:10 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E180C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:20:10 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id j13so48725wrn.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FlydYZzkHHsNkirizC6EMfUHVnYCnfRojTwu8q88f10=;
        b=p5M7LSLaT61WHDadMDBLNAMcGIKvjvrKRYa3SGUEl1sNihBTOSclx5u8f+Qo5EHr+6
         /K/M6rYVP0/6LMYQMjak6x8uJ/stlKgFYI8RmUlbytD/YieCCk0bq461xG5vteDbV87h
         q7zMidrBXX3nA11qkrcEGRENLa+V8q0iOHBSQJnNaRnd43G/QKdtQ33bM1rV8qrK6ASm
         Fbt5CY4IZb18ynf9AX0rAK7lfLbADrNjjvS5SMVsvNuLWlQgvjWvUaUI3vIwvH/W4zIh
         /mwKwhzfd2Zbe5xAqaAGbJLjtJmBU54bFSvDGvAv1iwM33/X233VK3eCNfoh3b/h6TXl
         fO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FlydYZzkHHsNkirizC6EMfUHVnYCnfRojTwu8q88f10=;
        b=XXqnJ60UEwU36bYp47nciND7iso/7Lq4Rf2O+70HnXX80PeiNIRiHxpkyNU9gYW11r
         mi8poR74r/qzYzRFEbMWS0SDd8EfiqmHn79r/JfjNxCClk07wiqBHSG8Fsj/QNrsOU7g
         hQua52SvN9YF3Qx3P2TNlzyf7RDgjgMyClVrmslugn2uIBmRte3nXR1iWPtF7CDV+iCE
         5OGe8RYZASDl3SHyetnCObvt5nA+y2y8OFvqVXoeAp40lLMl9SBJEPO47niadHNcF9p0
         +SVs/Dc+RGzHsixQttSY44C8tNDvuBaDfngGsTVQeacVU1Q22BTaLvuAU1aOnGlrq479
         G1+g==
X-Gm-Message-State: AOAM532NJOFVJP0XB1SFBgiYY+iiiTCUA0fdvPvl0ty/QuropX840iy2
        uKoA+1EiQS3TEZcWpMpGhP+2fJYI+mh7JX5k
X-Google-Smtp-Source: ABdhPJxKCyurj8TEcTufpfKCp557hhn8rTd9/YuYr5+pEIjMzpppMattzTBc3sQQ5DICUmayYjNCq6hKLBwj/U/V
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c937:: with SMTP id
 h23mr66523wml.19.1604532008922; Wed, 04 Nov 2020 15:20:08 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:41 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <c370778bd2f6b4810eaa2ba72cb3583fe05e1183.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 26/43] arm64: Enable armv8.5-a asm-arch option
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

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Hardware tag-based KASAN relies on Memory Tagging Extension (MTE) which
is an armv8.5-a architecture extension.

Enable the correct asm option when the compiler supports it in order to
allow the usage of ALTERNATIVE()s with MTE instructions.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: I172e15e4c189f073e4c14a10276b276092e76536
---
 arch/arm64/Kconfig  | 4 ++++
 arch/arm64/Makefile | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d58b4dcc6d44..cebbd07ba27c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1591,6 +1591,9 @@ endmenu
 
 menu "ARMv8.5 architectural features"
 
+config AS_HAS_ARMV8_5
+	def_bool $(cc-option,-Wa$(comma)-march=armv8.5-a)
+
 config ARM64_BTI
 	bool "Branch Target Identification support"
 	default y
@@ -1665,6 +1668,7 @@ config ARM64_MTE
 	bool "Memory Tagging Extension support"
 	default y
 	depends on ARM64_AS_HAS_MTE && ARM64_TAGGED_ADDR_ABI
+	depends on AS_HAS_ARMV8_5
 	select ARCH_USES_HIGH_VMA_FLAGS
 	help
 	  Memory Tagging (part of the ARMv8.5 Extensions) provides
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 5789c2d18d43..50ad9cbccb51 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -100,6 +100,11 @@ ifeq ($(CONFIG_AS_HAS_ARMV8_4), y)
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
2.29.1.341.ge80a0c044ae-goog


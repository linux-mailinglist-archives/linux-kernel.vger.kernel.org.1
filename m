Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24557280B25
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbgJAXMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387574AbgJAXLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:41 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06523C0613E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:41 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id r22so90857qtc.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/i/oGMXlxoli6h4O+lMoZppzKevwNPdee32h25HwaEc=;
        b=hxySTHTfozEyYeeT1nxdL5pmFLu0UMY+5MTLvM5zbDxfMbWJgsrQA3a5nS9YkFcxfG
         opGKS0A7W0VkUOZsKd9mwb4xd9z/ccQSG31zRv//t3q8Fmgvv512gA06yO1YNeyQaR5c
         IsIDBafKG8PICkWYE8ziJR3URpLID7CDUX/4y8TAcdTvROFKwbFD11IBltuFnCQwSgmq
         cP/6ojN/I8ME6SW/JNuxYVdPGMR3QZvNW57sc16rFAwcFpUtqzsa8lW4aI/mo3bhjTLE
         2Knl1qRhpQ+5Owm3h4Ssz81pT9e6sc8DZHb2uK3O8rsKOuaZnnuvMqjg2x0yDgCaSJjC
         zugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/i/oGMXlxoli6h4O+lMoZppzKevwNPdee32h25HwaEc=;
        b=tceAbnXUmuHHxAHv+c6UcachujVvxUAJ9P6ZTKxucZxPLIM88RhUe3dAwZDvAsQcBp
         jPAvneAJO0okC36pseeDPZcfgWhCDxLC9Lj+A76sKIVAuONEEioQSUMwMhHkagpfanHn
         6xJfJmxmhXw/qBSc4Xbm8ysX0KWeQfo18LPrTq+0bs3OGL9zqc9re+yG/Q+efRS8i5dk
         w+T/MQnhp1ajbCejBHmTHJcrxeG/dxtvYAp6Dfw0asWaS8pz1j12WIrqNkMgBnX4q3KB
         uwtPRLbtWZd/Jlawz1emYCLCXRHWLqru0PFoHADi9JVCY6VkosfNdGaI1VIdLCG6c+wh
         VWuA==
X-Gm-Message-State: AOAM5327/KFIOf9kZ+Fq2rbepdtXVPTCK02/L8SszPUSlC/0CwdbaeCx
        CUvHXEU9zm6ZyhK+YYW127PuFVcF0nAGE++z
X-Google-Smtp-Source: ABdhPJxW2fL4xOIXIEB1C823qRIrBhZ5OeVctGmwMtdSkVROm1+kM3fyfxJ6GF7dSVzQOo52oSI2LWoWr6ZWeUyM
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4d52:: with SMTP id
 m18mr10006770qvm.55.1601593900111; Thu, 01 Oct 2020 16:11:40 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:24 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <0215863872e20c790d7a17bf5f283512a06ab9ff.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 23/39] arm64: Enable armv8.5-a asm-arch option
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
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
2.28.0.709.gb0816b6eb0-goog


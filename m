Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439AD29F4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgJ2T0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgJ2T0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:26:10 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA13C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:10 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l16so1263117qvt.17
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=E3nLeu64H5OkoX6I7J0ZTAruHDRmKSNURPLcLoePP7U=;
        b=gGdqNoDG6h7UO7aVDFZq1OIBxCFkzzVN3HhhDLkrK6aSo7h9IF9ZCQMZOntfhy2WpN
         LNh1+gi0fWoUXnlUiM2JKjNWoaCfCMX1dDcgk1kAp24yveBC731I4mp/XCo4ZutXGYiT
         Td7s7U0SWEvrk3B5U0pfLnoWb5YvfKlMwPEh50sDKtOh6g/gY3sgOteCVmAcoUo7UYtn
         H3/ChNZA+jmEh0UpyswVVYx+Q0iX7CETcxoewRiSLz9LWVJvetqhoE8cdfCaWJrMs6Bw
         1lrVtPR5FiDD1c1oA7rFRfPEeDBXbWNF3WD0M5g6xwdnnFfw80HEfeEu7dX02Y6c8fZ/
         Ajzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E3nLeu64H5OkoX6I7J0ZTAruHDRmKSNURPLcLoePP7U=;
        b=ZoE9PG4bK9CEfN9o6lqo+h15WegrVPCgpwAp3sxjaFFkylLEZaT7Cz37JLqM/JDldx
         tiFFAYSLoM0BWTnBFlQulETc5s+6VKLaG2vQnj19sLX/Jg5CzTBWWSflAXFv6quo2e5e
         4iWFVAHcV4b6D6FyBiq6G5XraIin33mr6w2+Ysrg8l2U0zHR7g4HH0lrKzyjO4OpkLoL
         18wble1/joUNpHwPKCHbTuxjfwC3bSj77pjTxqgpchlePanyZuRt6uRaR9l4903RcSm0
         6oKgXZ2h6rEEp+gge5IDNijUJXw8eTOdo+N+Tl5npwCH2WURLN02EPSlWQRH4nOneAI8
         VNUg==
X-Gm-Message-State: AOAM533jXfKzRMlP3T1pEBSLA2gK+GqPvXLCeyGFT4YyLhEZi8BAcrOL
        cCG2vDcvjCN7zE25djPbJO0xvotLuFrzD7U6
X-Google-Smtp-Source: ABdhPJzQH6qHZ/5fDpF+4yvOJEC5I+E6RFhLzJ+BRCg6/Rb0dor0+bmy8demarneYgOOFfMGY94Ir+Jw9JtPIF0H
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:43c6:: with SMTP id
 o6mr5668120qvs.53.1603999569614; Thu, 29 Oct 2020 12:26:09 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:22 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <15c4e9480d957318797d39d0ac1aae08f9efcb18.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 01/40] arm64: Enable armv8.5-a asm-arch option
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
index f858c352f72a..9f13ab297b7a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1571,6 +1571,9 @@ endmenu
 
 menu "ARMv8.5 architectural features"
 
+config AS_HAS_ARMV8_5
+	def_bool $(cc-option,-Wa$(comma)-march=armv8.5-a)
+
 config ARM64_BTI
 	bool "Branch Target Identification support"
 	default y
@@ -1645,6 +1648,7 @@ config ARM64_MTE
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


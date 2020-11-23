Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1822C15E7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbgKWUJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbgKWUJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:09:26 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B923C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:24 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id g125so94868wme.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KVSJXJK3L8qTAj65/VfUWb47G8JUT1DB2NysMQkgqU4=;
        b=bzRUk7lH945+D4glkCJTKLJUwSPZmB7Rhy8GTksmj5BD4GyFtkilz7wrLtlk9Ei+MY
         2bSehq8DRjRDlXgHVIWbosolvD7F7NAi8y2Sln5aVLVGPp3qMblvzZByi7i85hUbLveg
         JcrtmiCCavd+vGYNqKM63InzkQ/nYT2ezWga/nUZmX3pq8a8Bcvis4S747GTAKSuWi35
         7WziuBIy2Im/xwj8823jjukD2LFYv55LMajt90HiyEzNUk1RUucBXEuRFOQHPzpn3oST
         gkJ7HsBzFRfEbATT6NuZK0moEs0gyz/vJnauuOMCrDARGRLGJOPJ9a/fU/L43Jfxl9eI
         sSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KVSJXJK3L8qTAj65/VfUWb47G8JUT1DB2NysMQkgqU4=;
        b=Hqrlm06iuoAjXEUTNaOxiKpa6xRUZ3Q3pfK8IrXUDMzvGB3sSPVwwn21oRs3KzBCgv
         fNyF1wx14ICPTDmOFSVr68YxN8LK9Hakk4AWxQ7Ku2cgx36YJnndtdVqQR3O7FvoZxYN
         dG4lRaa9/bR/dLQYQhsqyEYtk+i7GTydbHLC16/0EnHY8Y08c180oO8369kvWBzagGDq
         pIq2jcqn4DpfdJce4Uxb4A+quCipzUXGsrnemszdCswQEaZkOBq4juOjV0FnoejoYrRA
         YrCbEOJuwAKK+0Qie2MQGU9YLbvyapA5zMk+fkkESR4BQSq/LUC663M9gUorRSROyDLN
         cicQ==
X-Gm-Message-State: AOAM530cRnjrAgulGxF9m/smkgH5Q7yx67IPOd3myYa8m8c5I2uWqNSA
        NlzfWXrB4pRLPFM7V/dfgo10PUUkOd7k7mJu
X-Google-Smtp-Source: ABdhPJyACYW4zaMGjNwfxx49aU3DfZ/9cHrTN2moJdj3kkxbybIzLkr76NufI/imYXaFTYNN4fq5KUcM14rjZc9m
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:e3d4:: with SMTP id
 a203mr566406wmh.177.1606162163180; Mon, 23 Nov 2020 12:09:23 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:48 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <d03d1157124ea3532eaeb77507988733f5734986.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 24/42] arm64: Enable armv8.5-a asm-arch option
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
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: I172e15e4c189f073e4c14a10276b276092e76536
---
 arch/arm64/Kconfig  | 4 ++++
 arch/arm64/Makefile | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 026aaa64a7e0..b641bb6cbc73 100644
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
2.29.2.454.gaff20da3a2-goog


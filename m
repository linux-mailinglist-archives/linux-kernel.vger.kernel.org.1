Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8199129F520
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgJ2T1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgJ2T1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:27:44 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47CFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:43 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e19so2508514qtq.17
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=m61njPxPjXbU7KpGf2VpyrS3MAG/f/HeOixCOkKzSfs=;
        b=c9rgrTFUsvE/sv1GcywQgY/eSol+KDqntEwftlv6oWt1cbs8fqUyZPHMbjy4ImGnBg
         yvzL7HRhqYgS2NmliN7YFPbwm7Vcz16bhehb2K4OWdsi5JYle+OFO4Xv78BYzsManxVz
         kmGlvOb2aLPWWXtXjExbynZdhpOTgKJTzBpeXDMKssEWmEbmqBYhCOrt5O0YE+Uu161K
         7e7ffbR01RB0EEq1qqMiVx0atwA8j99jWe9TFp4gReTI1Vid/GJbBulBlEI61n6ScubY
         XIEGiaw9pXCpQtVvPuRZ2GzYHQrfYGDT4ZdXrWMNXkTpREe18LWY6Qlz83OrSp/ZQg7r
         AdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m61njPxPjXbU7KpGf2VpyrS3MAG/f/HeOixCOkKzSfs=;
        b=IXI9wckVaRU9o2Cn9DZQg7m8rOoQQ91xgflmYVmlBiCJLZ0DVoE8yOUStSeW8ICAvA
         Uojh/86py9h2FAJZIQtay9Bzv9Zu1kQ0oR6jsMZRAMnf+Dur+vP9HcsHd0fpZHsMkh1T
         eoePG5L9P+JPPf16IjS4Vg3DE6PpcXWTaQRgEtPjtzBrLSiL7ELabO9RNlF35ApZDibk
         0xtxhxrMTdX8eOa/Xk4/gwxLy49Z3tvHYvQ7txwMELDONrq1tdY7RUiity7NJvk91wom
         Dt7QSMNvAiy5kaFOrlR4kR1/95sa3KiFwGXMe1NAeS+ly+jtvcNbWwoeoxi60alJ7Fmf
         AW7Q==
X-Gm-Message-State: AOAM530TlMiVHR7q5WFwGmOcNLTCxvtOgG/aUJ1RQXjuEZCfJA3uWMC3
        Mi9fBFU+hmUCKHYJbJoz5Fe2/z11Ys8/wVhV
X-Google-Smtp-Source: ABdhPJyTw+5/AI1vddSkqxvYk6W27NYNSP1BubYpVP5epDu/+PWjGokJXSm1nm25NJnYChYG/skjvKLSGsho8wGI
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f14b:: with SMTP id
 y11mr6066348qvl.35.1603999663004; Thu, 29 Oct 2020 12:27:43 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:26:00 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <25b961778f590965c697f9310297d9a0cbe4c181.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 39/40] kasan: add documentation for hardware tag-based mode
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

Add documentation for hardware tag-based KASAN mode and also add some
clarifications for software tag-based mode.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: Ib46cb444cfdee44054628940a82f5139e10d0258
---
 Documentation/dev-tools/kasan.rst | 78 ++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 21 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index b6db715830f9..5bfafecfc033 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -5,12 +5,14 @@ Overview
 --------
 
 KernelAddressSANitizer (KASAN) is a dynamic memory error detector designed to
-find out-of-bound and use-after-free bugs. KASAN has two modes: generic KASAN
-(similar to userspace ASan) and software tag-based KASAN (similar to userspace
-HWASan).
+find out-of-bound and use-after-free bugs. KASAN has three modes:
+1. generic KASAN (similar to userspace ASan),
+2. software tag-based KASAN (similar to userspace HWASan),
+3. hardware tag-based KASAN (based on hardware memory tagging).
 
-KASAN uses compile-time instrumentation to insert validity checks before every
-memory access, and therefore requires a compiler version that supports that.
+Software KASAN modes (1 and 2) use compile-time instrumentation to insert
+validity checks before every memory access, and therefore require a compiler
+version that supports that.
 
 Generic KASAN is supported in both GCC and Clang. With GCC it requires version
 8.3.0 or later. Any supported Clang version is compatible, but detection of
@@ -19,7 +21,7 @@ out-of-bounds accesses for global variables is only supported since Clang 11.
 Tag-based KASAN is only supported in Clang.
 
 Currently generic KASAN is supported for the x86_64, arm64, xtensa, s390 and
-riscv architectures, and tag-based KASAN is supported only for arm64.
+riscv architectures, and tag-based KASAN modes are supported only for arm64.
 
 Usage
 -----
@@ -28,14 +30,16 @@ To enable KASAN configure kernel with::
 
 	  CONFIG_KASAN = y
 
-and choose between CONFIG_KASAN_GENERIC (to enable generic KASAN) and
-CONFIG_KASAN_SW_TAGS (to enable software tag-based KASAN).
+and choose between CONFIG_KASAN_GENERIC (to enable generic KASAN),
+CONFIG_KASAN_SW_TAGS (to enable software tag-based KASAN), and
+CONFIG_KASAN_HW_TAGS (to enable hardware tag-based KASAN).
 
-You also need to choose between CONFIG_KASAN_OUTLINE and CONFIG_KASAN_INLINE.
-Outline and inline are compiler instrumentation types. The former produces
-smaller binary while the latter is 1.1 - 2 times faster.
+For software modes, you also need to choose between CONFIG_KASAN_OUTLINE and
+CONFIG_KASAN_INLINE. Outline and inline are compiler instrumentation types.
+The former produces smaller binary while the latter is 1.1 - 2 times faster.
 
-Both KASAN modes work with both SLUB and SLAB memory allocators.
+Both software KASAN modes work with both SLUB and SLAB memory allocators,
+hardware tag-based KASAN currently only support SLUB.
 For better bug detection and nicer reporting, enable CONFIG_STACKTRACE.
 
 To augment reports with last allocation and freeing stack of the physical page,
@@ -196,17 +200,24 @@ and the second to last.
 Software tag-based KASAN
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-Tag-based KASAN uses the Top Byte Ignore (TBI) feature of modern arm64 CPUs to
-store a pointer tag in the top byte of kernel pointers. Like generic KASAN it
-uses shadow memory to store memory tags associated with each 16-byte memory
+Software tag-based KASAN requires software memory tagging support in the form
+of HWASan-like compiler instrumentation (see HWASan documentation for details).
+
+Software tag-based KASAN is currently only implemented for arm64 architecture.
+
+Software tag-based KASAN uses the Top Byte Ignore (TBI) feature of arm64 CPUs
+to store a pointer tag in the top byte of kernel pointers. Like generic KASAN
+it uses shadow memory to store memory tags associated with each 16-byte memory
 cell (therefore it dedicates 1/16th of the kernel memory for shadow memory).
 
-On each memory allocation tag-based KASAN generates a random tag, tags the
-allocated memory with this tag, and embeds this tag into the returned pointer.
+On each memory allocation software tag-based KASAN generates a random tag, tags
+the allocated memory with this tag, and embeds this tag into the returned
+pointer.
+
 Software tag-based KASAN uses compile-time instrumentation to insert checks
 before each memory access. These checks make sure that tag of the memory that
 is being accessed is equal to tag of the pointer that is used to access this
-memory. In case of a tag mismatch tag-based KASAN prints a bug report.
+memory. In case of a tag mismatch software tag-based KASAN prints a bug report.
 
 Software tag-based KASAN also has two instrumentation modes (outline, that
 emits callbacks to check memory accesses; and inline, that performs the shadow
@@ -215,9 +226,34 @@ simply printed from the function that performs the access check. With inline
 instrumentation a brk instruction is emitted by the compiler, and a dedicated
 brk handler is used to print bug reports.
 
-A potential expansion of this mode is a hardware tag-based mode, which would
-use hardware memory tagging support instead of compiler instrumentation and
-manual shadow memory manipulation.
+Software tag-based KASAN uses 0xFF as a match-all pointer tag (accesses through
+pointers with 0xFF pointer tag aren't checked). The value 0xFE is currently
+reserved to tag freed memory regions.
+
+Software tag-based KASAN currently only supports tagging of slab memory.
+
+Hardware tag-based KASAN
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Hardware tag-based KASAN is similar to the software mode in concept, but uses
+hardware memory tagging support instead of compiler instrumentation and
+shadow memory.
+
+Hardware tag-based KASAN is currently only implemented for arm64 architecture
+and based on both arm64 Memory Tagging Extension (MTE) introduced in ARMv8.5
+Instruction Set Architecture, and Top Byte Ignore (TBI).
+
+Special arm64 instructions are used to assign memory tags for each allocation.
+Same tags are assigned to pointers to those allocations. On every memory
+access, hardware makes sure that tag of the memory that is being accessed is
+equal to tag of the pointer that is used to access this memory. In case of a
+tag mismatch a fault is generated and a report is printed.
+
+Hardware tag-based KASAN uses 0xFF as a match-all pointer tag (accesses through
+pointers with 0xFF pointer tag aren't checked). The value 0xFE is currently
+reserved to tag freed memory regions.
+
+Hardware tag-based KASAN currently only supports tagging of slab memory.
 
 What memory accesses are sanitised by KASAN?
 --------------------------------------------
-- 
2.29.1.341.ge80a0c044ae-goog


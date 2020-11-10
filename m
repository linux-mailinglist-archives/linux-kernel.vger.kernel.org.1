Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DA42AE2D8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732773AbgKJWMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732722AbgKJWMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:12:10 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145C9C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:10 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id 202so194991qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=d0luRNisG3KRkUWIJpA+kozZ7VZYZZ7aV9TEVeCXzwc=;
        b=HzxJDWjpBYBTx2nnzeaKR40IhBDGNp8//Q5g3+Yp8d8qaNxWMXc3C+4pVR31Fqn3xG
         fCKVwStNYBwd5N5fYGv0zlaIwWPFu+TBlPtIWMsEP6uSKlc0RDdsgWMDzgaDnld5lYPC
         hNvbDCdbNwFY5UNDA9qOkIQHMLKr+eaDpVgknzFtlhGsHay1WkNrzs5ZypWi9lsuJWKh
         omZpvEkEYE9CoCPW0+jFNFzoLp+kNp5DPHpUt7hzn9l3BjrggNZFNATTGFBlUXC3imBa
         tZo2pRjwpXd7khtzo/kg6/TokptyVi5r4cwYn2oxhHbLbXjTGtQZRkf62np7og6rShje
         jMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d0luRNisG3KRkUWIJpA+kozZ7VZYZZ7aV9TEVeCXzwc=;
        b=tng955/4l44HU262rtrs39WTqKueV2bVmCEHzV46H5FN5cGspRLPHpgZjfRjZ4mvNn
         RYDi+mhWU4sKkKswg++FnqhyDvmVzmBvwf2FEPdRY58twfCqX47RwFKeWaq8rIUbjnNF
         Fjj5b6L26P7eAAdulCqhVvYGZT6U70gkXQ4E2Vh5m7ucvaBnguuE9gKO3d0C/Qxthcf/
         nT5zH75Hvyh5laRFuM79AucRB6wneSvsiV5QJVLhJYv0qzVwIcVEG3aXM5SXVuvtv/oX
         XAgniZI2/9XZ13R5scjHRt/zr9zX2R/nFzM3/p5qK5vBkwAnalfHf/6hR9u6Hm6hZt9H
         Z+aQ==
X-Gm-Message-State: AOAM530/ondjwruJqvpjuUHBQLzWrLkXZYIDacxVPL9vkBRSB7Y7HIsz
        4dPXHN3BUjK8y4htPnBWI/3mIsuna5VLYUQZ
X-Google-Smtp-Source: ABdhPJwpJeDUnREbb6gHaUPPYAcEUOobtengpR9kJKiWVhPyIavQao1BN6Cj2oA+Dzr1a/WdAfsYGMhCOnSInOLT
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:90e4:: with SMTP id
 p91mr20380986qvp.61.1605046329251; Tue, 10 Nov 2020 14:12:09 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:23 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <e7f69b87c86266c3671ec137f56e7740890155d3.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 26/44] arm64: Enable armv8.5-a asm-arch option
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
index 25ead11074bf..c84a0e6b4650 100644
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
2.29.2.222.g5d2a92d10f8-goog


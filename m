Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A02C2A2F10
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgKBQEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgKBQEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:04:32 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9BAC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:04:30 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id g11so8275358qto.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=m6E33oJg1cT4FLFX7kYbKRuylbP2hj1k0453+DytozM=;
        b=eTQoB5ZgIpjbQfIhUIQDO3ivN+FuBAfTi4VLVEnQZ3+5ddqMb4rqWULFHQZp1P92wW
         0f2iVrYZVY359/GwnrAKHyxMOmW1h1mOQ0Z6A1Zn7kC87YzHAy7yXIpx7SeccoDZ8lLB
         AcWIZXgIBFodzuh748+X7nw4pOv/1JD3JbDOqB0afcFKAjk/n7HBaukQqq4GS0zo2Jsp
         66xFjw7OFVez2Vp7CiLJ6ugK7qnsjZeUU3gH028W5plToaBoLhDYsR4EtnerKBmMbJb8
         u3CQx4tJLCjNZehtgxDLuU5kzznRlMjNmtKrzDUnQc0aRO4sRGid3HaSl94nXtP4QqTP
         Z8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m6E33oJg1cT4FLFX7kYbKRuylbP2hj1k0453+DytozM=;
        b=P57oy9uk3r7NI3m0HF3RxtcYkopF/nywdBOr7geRVKhLtAU8MtoTo/46wQIM3hRRC4
         gxoGUiDv9lHYy6swMTLrnl9GR0zbwjFsj6VuBVK+wVLwpC+UFeD/LvYlukWCLV+Js/Ne
         W9iws5eJVMSPiZxkYOgYMjxwTWNboAashRbOPc4GRZ09pprRZf+0YFGSHpCYFMoiaXlG
         M45IyEcOYanIUb3vaUrhb+rkV8Pp/JPujvlC5hkMUrMJieHS0GnEuHm9OswN1T9KqVMz
         8No/+t0QqZs6LZZJMRCMcC5xkq53GSr+2f9cOZX8/3pPK+VcH1vL6rfvBv2V2ughh2Fv
         aV8g==
X-Gm-Message-State: AOAM530qQyT+SuoIISUSS1C3T83Jc1fZIuyu6rR/+RRik1BAIwBd24tA
        wvSCqrlOEwesbiOPpLhNVekMEgC1ehG805kZ
X-Google-Smtp-Source: ABdhPJwc+wJGFLhB5OFAE8wGFb80S0xYuxobgJ7EO+r8UFcqX8a+pLUj5yaP4IAUEYBIDLCA+kBF4HWw4JLFwTiA
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:127:: with SMTP id
 w7mr7030495qvs.3.1604333069499; Mon, 02 Nov 2020 08:04:29 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:03:41 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <d9ec144c1150de0cb5d69e8f204cf559af0ae2d0.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 01/41] arm64: Enable armv8.5-a asm-arch option
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
index 1d466addb078..fddb48d35f0f 100644
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


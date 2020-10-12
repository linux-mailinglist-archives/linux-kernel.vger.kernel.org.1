Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA628C2E4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbgJLUo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387772AbgJLUo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:44:57 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1913CC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:44:57 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id 2so659188wrd.14
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DmclJkDR4Qm5lsb7ydlGYlEQZpzVsyh6HqffasVR3Wo=;
        b=VScTU+0p8eF/zz4mZQVMYdWWD2El/y9UVrnM21faQoYYGMWFZ2VUSWXIU0vkGt3PlD
         TvkWt//RfWPWv8xCXw2oZRawVUo60eqAx7JfH5k9aF2IUQ+E6pAcK7ip5SdfkUUa9x/z
         seWvaJPM588rFpLRJnEvw0/SeNL+kEmNvwsyA6hTP0vvnsGrXOF+Ohas26Wc47NS9aT1
         bTRCoZMNCMV/C5Kz/4QQX8UnEIha6lWveun9Dm74BwLONEIlKC1PC3WnipGQroJ5A6Wj
         cumAdmN4RHm/2sLnehMU5qVMP8/rxAAU6pXJa/YgRIWk609bVyaxCpv0QfUpwRsktlLY
         1mGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DmclJkDR4Qm5lsb7ydlGYlEQZpzVsyh6HqffasVR3Wo=;
        b=UC1K9bhbEquCxLJKyLhJsuUVulGx3HeskSZy2zldaTco36cdk2EasV80hyaS1dAKCE
         3xhio9mH/eX+6NUHYhzYvlgK/HpJQWN0+gmLTjkvAjcbRwxW2f+Q97PdDK/haEMe8IqO
         e0EGNmeASGvZhKnO1mECzHrpdScv1pPDF46Qz0TUYa2NUACIlBVMSFAXSmq0XIDAA0th
         8Q4lLLa3jepCs5+frUozqzrde4cSVO2f9G0UaAYiEeBEn9X1eZkEMsf57dtYI4fDQLQs
         YS3ecZb68ebqn7VjsSCcPbzUBrpA0rrJuynThbNi/dsFCX412K8kCk5wLGBVSkiknqrU
         59sg==
X-Gm-Message-State: AOAM532vs0TyfZxqPAzR73CBclNt5RIxjlQQe1wdnkbxFTRR5Blf66Un
        xKm6+VKdhGmkhLxIHE+k/LSvCWaIfj/s8SVr
X-Google-Smtp-Source: ABdhPJyZct8Pt2l8Kp955U1QPIzytEc6BVLp0niDriGROF+h982d73KRu4GChhMiIEs9RcvNcCgK5kUILF6ICAUS
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:5344:: with SMTP id
 t4mr12260918wrv.267.1602535495668; Mon, 12 Oct 2020 13:44:55 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:07 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <f861d02845a596328fa98faba825e06d712c88bf.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 01/40] arm64: Enable armv8.5-a asm-arch option
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
index e7450fbd0aa7..f27297ac70bf 100644
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
2.28.0.1011.ga647a8990f-goog


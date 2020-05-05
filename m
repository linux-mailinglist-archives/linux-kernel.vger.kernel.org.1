Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80221C5F23
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 19:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgEERod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 13:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbgEERod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:44:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AFEC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 10:44:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n205so3179041ybf.14
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Xw/XeQONehgAZgmp50DsvTIx8rMMLD3xww9tGSOkTsA=;
        b=lneA14fzuFIhvEyDZhEZTjVIaajfkM2Z7jKfKmPgQ32k4DXwTcL6jmrVG9lLKS/STZ
         i1h5X98Rgd/oyrVzCu4ccHiaoXOVE6pNfPXCDw1dC27kWhnuB24Pl6NHQejX1rAOoNob
         uxdOxtVcR57USHxeCw39W3UFF68ZmyFXSDnrkcblxXwOTZLZ1A7k1FPLtWM2C8QUxQRM
         tYj7uyH/RRNIV5aGL8nNs6qF8M0ghJZznLP795RJ0up2LeIE9E1JVbtTNqrD5gB7fVKk
         hDPTWVoBA5rqaknUJTuYGNajFguFjI3/Vrg/I4l5PVV3wBXe82Wjjvio1muWO7wBehvL
         heZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Xw/XeQONehgAZgmp50DsvTIx8rMMLD3xww9tGSOkTsA=;
        b=WP+c8l+hJVST9IXL3TEGwdI3a6o0EWtmJPu6mPfR8RSwIgZPVei75YisirhX1KSaBP
         Lu9GYqtjZ5RDWCbNfQ72dllq7+LicgBT4TlTj6GYRP3TNgVYtDmZrpqFmg0lvW63o/64
         HnLlYJP8p1ecY3X41THa/zlxleSIPJFJCSHq6MakP55Ur+llFTxSHpDDbLBEjJr7GXAU
         XyHXMxnaBDBW/gr625arpmZY/6Ipt4FCj6wjtRyS6j1esstspMlXscRCstvN3PAeol3u
         8Sncm7U0daDR+pw762Ygbw8Ku30QpO9znmOZQiplz2xw8Lv9iJEf3CIWZAsFuz7mZshN
         om7Q==
X-Gm-Message-State: AGi0PuYr/dCM5pxalXF4ITFXNHGfKfNdZfosYDsd+VXGe+38zqvDxfa+
        ycnWhlPR1TL2U7WXELWVhI5Q87tDNk06ALwOXGc=
X-Google-Smtp-Source: APiQypIX//cgIeEKcfL0yb8zr5R8ZbH/uRJM3Yv5sXuOog51eI5PRryDXtV3TYrJvL5SfnLEbSZi5o6qlXlDHTWTyWM=
X-Received: by 2002:a25:9a47:: with SMTP id r7mr6630305ybo.7.1588700672013;
 Tue, 05 May 2020 10:44:32 -0700 (PDT)
Date:   Tue,  5 May 2020 10:44:22 -0700
Message-Id: <20200505174423.199985-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH] x86: bitops: fix build regression
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>, stable@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Axtens <dja@axtens.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sedat Dilek <sedat.dilek@gmail.com>

It turns out that if your config tickles __builtin_constant_p via
differences in choices to inline or not, this now produces invalid
assembly:

$ cat foo.c
long a(long b, long c) {
  asm("orb\t%1, %0" : "+q"(c): "r"(b));
  return c;
}
$ gcc foo.c
foo.c: Assembler messages:
foo.c:2: Error: `%rax' not allowed with `orb'

The "q" constraint only has meanting on -m32 otherwise is treated as
"r".

This is easily reproducible via Clang+CONFIG_STAGING=y+CONFIG_VT6656=m,
or Clang+allyesconfig.

Keep the masking operation to appease sparse (`make C=1`), add back the
cast in order to properly select the proper 8b register alias.

 [Nick: reworded]

Cc: stable@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/961
Link: https://lore.kernel.org/lkml/20200504193524.GA221287@google.com/
Fixes: 1651e700664b4 ("x86: Fix bitops.h warning with a moved cast")
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Reported-by: kernelci.org bot <bot@kernelci.org>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Suggested-by: Ilie Halip <ilie.halip@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index b392571c1f1d..139122e5b25b 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
 	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "orb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" (CONST_MASK(nr) & 0xff)
+			: "iq" ((u8)(CONST_MASK(nr) & 0xff))
 			: "memory");
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
@@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
 	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "andb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" (CONST_MASK(nr) ^ 0xff));
+			: "iq" ((u8)(CONST_MASK(nr) ^ 0xff)));
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
-- 
2.26.2.526.g744177e7f7-goog


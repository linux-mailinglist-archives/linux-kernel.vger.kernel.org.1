Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528A124A6BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 21:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHSTRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 15:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgHSTRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:17:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9E8C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:17:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r1so27191704ybg.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=efiHHkgEE+CqxH/d5/JVGKFvb03OVNHvP+6tS83wQTA=;
        b=OPGqsRDr301KcIzCldz6WJJy9VBaYiXVyvRIguhEG0mHItwSbwmZ3OYYYnr3lSQw8z
         saZGrGV98qN5vUKsUZ6K+jx72/kiM7nPUPFzUiNs2zk/+IEd9Aqcepwu7b242kUUu2En
         T3bZL+t8wWTa5W9dTY+OfCYRh603Ox4p2mtxHTr6ZGaHVCf7P1ztBgCjy6rtaQxlT8dD
         DiE1NCywYnYaxxC91+VVqOXFdmlUzkXUGU0a/FSjXkvJbT4sjkwP0tU9mCM2ss++dNMg
         wVjnZOGXx0WpVNHVwWyA8RtQP+2QopXWlNUa5/SeQi9Z9c5DR2U4ThJd/2cfAtYdHAUa
         rF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=efiHHkgEE+CqxH/d5/JVGKFvb03OVNHvP+6tS83wQTA=;
        b=V23RCRNSltoTboFJRLxy+KBkBuWne5Zhmph0B23ipZgnQFQ3S6g+6k/YK7Q9OLjZOq
         Itwjh2eCsJLdi+pDGO8umIn/81POjRryZPjmG3jiiFt/y+LIEX9a8gi5wg7aXA6RpT2A
         UASG0Vv3uxB/xf4Ju4qNd4Kw2N8SX9X1W47F5IO6q0R7W7fcX6w/B6ZWtcsFvXda3NHg
         lpK74/seZoYg28VS/oe0v+zV0C+IdigagjjXJOCUWKgsvm4C6b3SDgf0BuuHTsahmATU
         CqRpClCXNGRIz/iKmpmuT1L+g56eeNe49u/3MR+Z9jyuhHSbsv5t809ou51tH7mdM0U2
         820w==
X-Gm-Message-State: AOAM532CaP1BiRpjnJjYUMv5yyqCoAZ+yXhUJcxqQoazgD8S108F5l5h
        RG2B4FHQJKM3Dpqr44CB0C50MevFEZGzR7y76BE=
X-Google-Smtp-Source: ABdhPJy/hRQI6MDpI3HydaZnOmr3CT858pQRkKElz+rZHlgLweGs650io4t9lHlAbTzpTPNopzfL6lZbGKAASJ4cZz8=
X-Received: by 2002:a25:25cc:: with SMTP id l195mr36922173ybl.383.1597864622679;
 Wed, 19 Aug 2020 12:17:02 -0700 (PDT)
Date:   Wed, 19 Aug 2020 12:16:49 -0700
Message-Id: <20200819191654.1130563-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v2 0/5] -ffreestanding/-fno-builtin-* patches
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Andi Kleen <ak@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "=?UTF-8?q?D=C3=A1vid=20Bolvansk=C3=BD?=" <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent "libcall optimization" addition to LLVM will emit libcalls to
stpcpy, which the kernel doesn't provide an implementation, breaking
almost all kernel builds with ToT Clang. Disable it for clang.

We discussed providing an implementation, but the interface is generally
unsafe as it provides no bounds checking.

-fno-builtin-foo doesn't prevent GCC from emitting calls to foo, and GCC
doesn't currently do the same libcall optimizations. If it ever does,
then we can resurrect these implementations, but right now, YAGNI. So we
only add these flags to CLANG_FLAGS to solve a Clang specific issue.

The first patch is critical, I'm hoping Masahiro will pick it for the
Kbuild tree and help us to get the fix in 5.9.

The rest are cleanups; sending them for feedback/review/testing.  Once
the first hits mainline, I plan to resend the rest to the x86
maintainers for inclusion in tip.

Nick Desaulniers (5):
  Makefile: add -fno-builtin-stpcpy
  Makefile: add -fno-builtin-bcmp
  Revert "lib/string.c: implement a basic bcmp"
  x86/boot: use -fno-builtin-bcmp
  x86: don't build CONFIG_X86_32 as -ffreestanding

 Makefile               |  2 ++
 arch/x86/Makefile      |  3 ---
 arch/x86/boot/Makefile |  1 +
 arch/x86/boot/string.c |  8 --------
 include/linux/string.h |  3 ---
 lib/string.c           | 20 --------------------
 6 files changed, 3 insertions(+), 34 deletions(-)

-- 
2.28.0.297.g1956fa8f8d-goog


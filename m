Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6242C947B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 02:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgLABNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 20:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbgLABNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 20:13:52 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2234C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 17:13:11 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id m13so71120pjh.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 17:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=pPz0VnlmKmXK2XSeYjB2NPBA8zjGQ8y5FO2YdKBkBls=;
        b=rji6Q7/DZbMRObU3wFMshrNGzgBqrlCYWcmnvBj1iOc5QmCLEvI1Xt+I+3WD0aTL9S
         PRMsBfTT7bBYiyE4sVIc/e0d4OnaOdLtPqJE0T8JgohKNcoeqHEFtwGzEnwcGU5Q2J+F
         qdrA0DoHt1+vixe3mk9AjDPtEvBzMUN8lSn928HwcmVaeKwuKg9vp7ovD9xCJ/End5R3
         FCgsUbeSo2GWg0h6bdGqA7p3q5V12BshIZ0xQBnlY4G4d9/blUj1LrweJ3Iko98Z+d1l
         Qp+eEDJDzPwzNpcOHtAFNLrsq11NbFkgVD/4OkFnKYTdP3iuREZP8vQtnJ8jzTx9cmf9
         3ZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=pPz0VnlmKmXK2XSeYjB2NPBA8zjGQ8y5FO2YdKBkBls=;
        b=M8Atag4rtDqe+apqx7a4fYKy5wUoBAL3mujoLkxs/XBI40+1p+SdI62c6nA4ytR+Mm
         TpKqS3b3S5TWL4cTrrArBnR7/1Pa1URM/yfy0Ga5J5WP0zOW9mkeBhIBq2qYKAiLfrty
         5VNW+KmykrifGB6AW7ZeIWAMkXAKQlPEj5kUvEavZw3H+7PXcs4Gg697eTpArJccHL2Z
         AHQN4JcJh68aHAl4joIPnl44KWrpmzKjFmczxDp3lY0tVAJJ/s1uaTEYK673G1m0+uU1
         uKay8oNL7MsCuEb+yu1HsaVe8Vftqa6wyH5bsMEpkOkSETBRXu4QfX4hmMErhwJGmoOE
         URdg==
X-Gm-Message-State: AOAM533N8fb2BeoH0Fd8/fJj923P8Gpzedr+Y+RmVPvvEc0z5y2KLe/Y
        QJieThULZJpTdWlyC/EiFEHmVvKPJBStH6H6Nxk=
X-Google-Smtp-Source: ABdhPJxXU/QA0VKUh8ii4JauOuAheq5Ds+eE8sviMZQU3un7GyLEbcs2FTUhvigMmY4spPtYEViEBHkaW4fTGBW4J20=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a63:5d05:: with SMTP id
 r5mr100120pgb.442.1606785191309; Mon, 30 Nov 2020 17:13:11 -0800 (PST)
Date:   Mon, 30 Nov 2020 17:13:06 -0800
Message-Id: <20201201011307.3676986-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] x86, build: remove -m16 workaround for unsupported versions
 of GCC
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A revert of the following two commits.
commit de3accdaec88 ("x86, build: Build 16-bit code with -m16 where
possible")
commit a9cfccee6604 ("x86, build: Change code16gcc.h from a C header to
an assembly header")

Since commit 0bddd227f3dc ("Documentation: update for gcc 4.9
requirement") the minimum supported version of GCC is gcc-4.9.  It's now
safe to remove this code.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/Makefile         |  9 +--------
 arch/x86/boot/code16gcc.h | 12 ------------
 2 files changed, 1 insertion(+), 20 deletions(-)
 delete mode 100644 arch/x86/boot/code16gcc.h

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1bf21746f4ce..7116da3980be 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -24,14 +24,7 @@ endif
 
 # How to compile the 16-bit code.  Note we always compile for -march=i386;
 # that way we can complain to the user if the CPU is insufficient.
-#
-# The -m16 option is supported by GCC >= 4.9 and clang >= 3.5. For
-# older versions of GCC, include an *assembly* header to make sure that
-# gcc doesn't play any games behind our back.
-CODE16GCC_CFLAGS := -m32 -Wa,$(srctree)/arch/x86/boot/code16gcc.h
-M16_CFLAGS	 := $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
-
-REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
+REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse
diff --git a/arch/x86/boot/code16gcc.h b/arch/x86/boot/code16gcc.h
deleted file mode 100644
index e19fd7536307..000000000000
--- a/arch/x86/boot/code16gcc.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#
-# code16gcc.h
-#
-# This file is added to the assembler via -Wa when compiling 16-bit C code.
-# This is done this way instead via asm() to make sure gcc does not reorder
-# things around us.
-#
-# gcc 4.9+ has a real -m16 option so we can drop this hack long term.
-#
-
-	.code16gcc
-- 
2.29.2.454.gaff20da3a2-goog


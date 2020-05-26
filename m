Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B251C49FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 01:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgEDXDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 19:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728182AbgEDXDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:03:35 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521C0C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 16:03:34 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w12so5566qto.19
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 16:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=riJtF6wnIn/7Sr6BY03T361JLi5EWFboyLscUDM7chc=;
        b=nSNYyMa0Ag3IGJnIHcETMoofQRjf/uWCB3a1UEuCsnmr2sovLYdjfRQZ+qj89nWrgg
         gpSRpqvvDAhNuzl+vZhHDzNm03hPwFuJTaEl5ewyOEHCnXrRCV4ca9h8GVKRwkc0AhUk
         6saCDJPR7AU2DxvR+RT0mXFsnVLSjh+k1tmdbdVqVHOEF9wpuw7QZJp5rwGQZJcBHaMH
         KHYof6HN0q2S/jbiquH6KNObdD3gNh/8bNPvjM6gQFIZT0lZgZ9cDouRVQ7TktyA95kd
         tgewVf0TPWAE/KtCrmbUZnVQF0OWf6KTZD5h8jbZwqHpfiOfAejwil16Qt3Kktuf7IFK
         f1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=riJtF6wnIn/7Sr6BY03T361JLi5EWFboyLscUDM7chc=;
        b=gDA3yEPrDlggGZ053aCCSuuQVkgyw+h7zNP6kVcWS6qWM1Pxfj6vwDN1Jse5nXKaTd
         MurJhVh/3fFfpo0/yDN4R4KOObsidXYgwYek6HsCMJ05Y0EkA03TPO60An3rEnvzYbu1
         e7A6/dz5DdfdCyay5AZOCsL+ptaxBLqAZKEAKs+2+5m+tsspt7my/UHyECk+eOgawJ/q
         S/dBAuqkGdmM5UfCf/SIGPF/6dXhLDQ9aE0Elsgs60POm8e3WrySmaC2gM4Su7sWBrKy
         kr4ZDLWuBeigmlHXbW0WcVrlj0DY3zWVld64EUYNTRWtVA6hBGe37LvVZ/ZV/SX7LTQQ
         Yk7g==
X-Gm-Message-State: AGi0PuY8zY5fdTfU5SHfROBWXk126w1JV8Yc4wo5tfY45HevM8/VYSv+
        eviYAweYRMneoGWDLrOkGeR8JJgIO4pF+dQyppg=
X-Google-Smtp-Source: APiQypKKbbGIodBbmoNg+Bd3UCuudEFWI3amAwwTE7q4jyHkz+LOcM90+Fwj4xlOvneGVL1IDm7bbqoA5ZWEY6G3X/w=
X-Received: by 2002:a05:6214:1242:: with SMTP id q2mr354063qvv.198.1588633412455;
 Mon, 04 May 2020 16:03:32 -0700 (PDT)
Date:   Mon,  4 May 2020 16:03:08 -0700
Message-Id: <20200504230309.237398-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH] x86: support i386 with Clang
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Golovin <dima@golovin.in>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC and Clang are architecturally different, which leads to subtle
issues for code that's invalid but clearly dead. This can happen with
code that emulates polymorphism with the preprocessor and sizeof.

GCC will perform semantic analysis after early inlining and dead code
elimination, so it will not warn on invalid code that's dead. Clang
strictly performs optimizations after semantic analysis, so it will warn
for dead code.

Neither Clang nor GCC like this very much with -m32:

long long ret;
asm ("movb $5, %0" : "=q" (ret));

However, GCC can tolerate this variant:

long long ret;
switch (sizeof(ret)) {
case 1:
        asm ("movb $5, %0" : "=q" (ret));
        break;
case 8:;
}

Clang, on the other hand, won't accept that because it validates the
inline asm for the '1' case *before* the optimisation phase where it
realises that it wouldn't have to emit it anyway.

If LLVM (Clang's "back end") fails such as during instruction selection
or register allocation, it cannot provide accurate diagnostics
(warnings/errors) that contain line information, as the AST has been
discarded from memory at that point.

While there have been early discussions about having C/C++ specific
language optimizations in Clang via the use of MLIR, which would enable
such earlier optimizations, such work is not scoped and likely a
multi-year endeavor.

We also don't want to swap the use of "=q" with "=r". For 64b, it
doesn't matter. For 32b, it's possible that a 32b register without a 8b
lower alias (i.e. ESI, EDI, EBP) is selected which the assembler will
then reject.

With this, Clang can finally build an i386 defconfig.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: David Woodhouse <dwmw2@infradead.org>
Reported-by: Dmitry Golovin <dima@golovin.in>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://bugs.llvm.org/show_bug.cgi?id=33587
Link: https://github.com/ClangBuiltLinux/linux/issues/3
Link: https://github.com/ClangBuiltLinux/linux/issues/194
Link: https://github.com/ClangBuiltLinux/linux/issues/781
Link: https://lore.kernel.org/lkml/20180209161833.4605-1-dwmw2@infradead.org/
Link: https://lore.kernel.org/lkml/CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Note: this is a resend of:
https://lore.kernel.org/lkml/20180209161833.4605-1-dwmw2@infradead.org/
rebased on today's Linux next, and with the additional change to
uaccess.h.

I'm happy to resend with authorship and reported by tags changed to
suggested by's or whatever, just let me know.

Part of the commit message is stolen from David, and part from Linus.
Shall I resend with David's authorship and
[Nick: reworded]
???

I don't really care, I just don't really want to carry this out of tree
for our CI, which is green for i386 otherwise.


 arch/x86/include/asm/percpu.h  | 12 ++++++++----
 arch/x86/include/asm/uaccess.h |  4 +++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 2278797c769d..826d086f71c9 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -99,7 +99,7 @@ do {							\
 	case 1:						\
 		asm qual (op "b %1,"__percpu_arg(0)	\
 		    : "+m" (var)			\
-		    : "qi" ((pto_T__)(val)));		\
+		    : "qi" ((unsigned char)(unsigned long)(val))); \
 		break;					\
 	case 2:						\
 		asm qual (op "w %1,"__percpu_arg(0)	\
@@ -144,7 +144,7 @@ do {									\
 		else							\
 			asm qual ("addb %1, "__percpu_arg(0)		\
 			    : "+m" (var)				\
-			    : "qi" ((pao_T__)(val)));			\
+			    : "qi" ((unsigned char)(unsigned long)(val))); \
 		break;							\
 	case 2:								\
 		if (pao_ID__ == 1)					\
@@ -182,12 +182,14 @@ do {									\
 
 #define percpu_from_op(qual, op, var)			\
 ({							\
+	unsigned char pfo_u8__;				\
 	typeof(var) pfo_ret__;				\
 	switch (sizeof(var)) {				\
 	case 1:						\
 		asm qual (op "b "__percpu_arg(1)",%0"	\
-		    : "=q" (pfo_ret__)			\
+		    : "=q" (pfo_u8__)			\
 		    : "m" (var));			\
+		pfo_ret__ = (typeof(var))(unsigned long)pfo_u8__;	\
 		break;					\
 	case 2:						\
 		asm qual (op "w "__percpu_arg(1)",%0"	\
@@ -211,12 +213,14 @@ do {									\
 
 #define percpu_stable_op(op, var)			\
 ({							\
+	unsigned char pfo_u8__;				\
 	typeof(var) pfo_ret__;				\
 	switch (sizeof(var)) {				\
 	case 1:						\
 		asm(op "b "__percpu_arg(P1)",%0"	\
-		    : "=q" (pfo_ret__)			\
+		    : "=q" (pfo_u8__)			\
 		    : "p" (&(var)));			\
+		pfo_ret__ = (typeof(var))(unsigned long)pfo_u8__;	\
 		break;					\
 	case 2:						\
 		asm(op "w "__percpu_arg(P1)",%0"	\
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index d8f283b9a569..cf8483cd80e1 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -314,11 +314,13 @@ do {									\
 
 #define __get_user_size(x, ptr, size, retval)				\
 do {									\
+	unsigned char x_u8__;						\
 	retval = 0;							\
 	__chk_user_ptr(ptr);						\
 	switch (size) {							\
 	case 1:								\
-		__get_user_asm(x, ptr, retval, "b", "=q");		\
+		__get_user_asm(x_u8__, ptr, retval, "b", "=q");		\
+		(x) = x_u8__;						\
 		break;							\
 	case 2:								\
 		__get_user_asm(x, ptr, retval, "w", "=r");		\
-- 
2.26.2.526.g744177e7f7-goog


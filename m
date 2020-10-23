Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13162297842
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 22:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756135AbgJWUcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 16:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756104AbgJWUcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:32:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64208C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 13:32:07 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p5so4133099ejj.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 13:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZU/qUeXMavkRC+pe9HBJQaSWzlqrekrq4O+umKE7KF4=;
        b=AEdztIF83UeO94QzF1WRP1AcHPVeQkjEu+cGQoTXOXxx3W3dPkNhvA+lsuPOlZyzO5
         AK3IO102rtpmY9nCBzEWcCWROwiZWMjYHok75o1dtp7ZJKXaE+0v1Jf/JQGWfLEvqHvq
         Cc99u369F9TUyMME84uAl6JBy/I9P/EX5yMck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZU/qUeXMavkRC+pe9HBJQaSWzlqrekrq4O+umKE7KF4=;
        b=sDlmkC56alCI3/56K56ZLvBpblGBzLwL4Mli9LcvTob1p7L7knfyapUHG99S9Sm+3t
         F1v+m6HPh5BkQ/WMEwRrEPBFqJht9fte84+WK9Iu9DKDVdHBTt7HxDU0B7KEJw+vMvwr
         Ot5POjbC4wl7OTvUZ6kpPZtYQ1ZQEyrwdrdhml4tXbFO7gJX2VunGHBsocO6ZOwgIprR
         cW0CUvWzqHm16ID1Un3Cfoi9X7uOJLWIZwG4fSGopmziV2hLn+N2au3wZMNNzIpkFZ/n
         Wxw3f/issaYWscZ6tEnRrtR9HNJCd9S6cxQgG5ogKVvLfmQdEGfBRPE1+EEMKi9AFmmy
         4uHg==
X-Gm-Message-State: AOAM532fu+Fh4oVAATir3OoTQNnZv1TkcjVrja1Mg0YxFSptx7dXScw8
        CnrTdVmyCcf6017C1y6SmaZg7g==
X-Google-Smtp-Source: ABdhPJzZQQaNS5WnnNGVVyY31Ql298tYp0bSqfA/12ntrYI2g6G9RR5NS2TNO+dT2BNIPu0jA7EDGQ==
X-Received: by 2002:a17:906:af87:: with SMTP id mj7mr772243ejb.178.1603485126012;
        Fri, 23 Oct 2020 13:32:06 -0700 (PDT)
Received: from prevas-ravi.aaad.autarch.net (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id oa19sm1338822ejb.95.2020.10.23.13.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 13:32:05 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/uaccess: fix code generation in put_user()
Date:   Fri, 23 Oct 2020 22:31:54 +0200
Message-Id: <20201023203154.27335-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting
https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html:

  You can define a local register variable and associate it with a
  specified register...

  The only supported use for this feature is to specify registers for
  input and output operands when calling Extended asm (see Extended
  Asm). This may be necessary if the constraints for a particular
  machine don't provide sufficient control to select the desired
  register.

On 32-bit x86, this is used to ensure that gcc will put an 8-byte
value into the %edx:%eax pair, while all other cases will just use the
single register %eax (%rax on x86-64). While the _ASM_AX actually just
expands to "%eax", note this comment next to get_user() which does
something very similar:

 * The use of _ASM_DX as the register specifier is a bit of a
 * simplification, as gcc only cares about it as the starting point
 * and not size: for a 64-bit value it will use %ecx:%edx on 32 bits
 * (%ecx being the next register in gcc's x86 register sequence), and
 * %rdx on 64 bits.

However, getting this to work requires that there is no code between
the assignment to the local register variable and its use as an input
to the asm() which can possibly clobber any of the registers involved
- including evaluation of the expressions making up other inputs.

In the current code, the ptr expression used directly as an input may
cause such code to be emitted. For example, Sean Christopherson
observed that with KASAN enabled and ptr being
current->set_child_tid (from chedule_tail()), the load of
current->set_child_tid causes a call to __asan_load8() to be emitted
immediately prior to the __put_user_4 call, and Naresh Kamboju reports
that various mmstress tests fail on KASAN-enabled builds. It's also
possible to synthesize a broken case without KASAN if one uses "foo()"
as the ptr argument, with foo being some "extern u64
__user *foo(void);" (though I don't know if that appears in real
code).

Fix it by making sure ptr gets evaluated before the assignment to
__val_pu, and add a comment that __val_pu must be the last thing
computed before the asm() is entered.

Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: d55564cfc222 ("x86: Make __put_user() generate an out-of-line call")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

I tried to put together a changelog to earn just a little
claim-to-fame, feel free to edit, especially if I got something
wrong. Did I miss any appropriate *-by tags?

I'm wondering if one would also need to make __ptr_pu and __ret_pu
explicitly "%"_ASM_CX".

 arch/x86/include/asm/uaccess.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index f13659523108..c9fa7be3df82 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -208,16 +208,24 @@ extern void __put_user_nocheck_2(void);
 extern void __put_user_nocheck_4(void);
 extern void __put_user_nocheck_8(void);
 
+/*
+ * ptr must be evaluated and assigned to the temporary __ptr_pu before
+ * the assignment of x to __val_pu, to avoid any function calls
+ * involved in the ptr expression (possibly implicitly generated due
+ * to KASAN) from clobbering %ax.
+ */
 #define do_put_user_call(fn,x,ptr)					\
 ({									\
 	int __ret_pu;							\
+	void __user *__ptr_pu;						\
 	register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX);		\
 	__chk_user_ptr(ptr);						\
+	__ptr_pu = (ptr);						\
 	__val_pu = (x);							\
 	asm volatile("call __" #fn "_%P[size]"				\
 		     : "=c" (__ret_pu),					\
 			ASM_CALL_CONSTRAINT				\
-		     : "0" (ptr),					\
+		     : "0" (__ptr_pu),					\
 		       "r" (__val_pu),					\
 		       [size] "i" (sizeof(*(ptr)))			\
 		     :"ebx");						\
-- 
2.23.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBC71E942B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 00:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgE3WME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 18:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbgE3WLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 18:11:50 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8804EC0A88B4
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:48 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id v11so5973849ilh.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d+eiMzeZbmcuIhhC0c40VxnM3edyG90lx+BihnOt8/E=;
        b=q8Xk7NaT5x/vweCOXdg3lZZX10qCE7U1xuPrdj/I0BAGsKyYghPKT4pT6jJr50mMXx
         64bpAzlA9ywDxKqjQmglL+ZwkwKAyg5XFMgXTJnFQwKxip2I8j8Kv/guR9lG2nK6Yv09
         y0ygSSQpKmNUqR8AiBXHWEeXxhqqn32Eu9aSS7QEP7AyYENXWdp7c3+XJD2/uWtjcvYw
         R2D2XXTfThvtxfos1Bm/khOTh89DAOsXkb936VEFYDTc6LVOmD7SyQZ/fc6/o4Chkjtg
         XFyw0q3d1mpVNWjtpaAH930/HZ4heV2CcLofYO0WHBP8YX7182LvyQeYCrViiU9vOH5q
         5f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+eiMzeZbmcuIhhC0c40VxnM3edyG90lx+BihnOt8/E=;
        b=W9Qk+jABq0TyPuZLXdwZX2wbPJtP+YKA7ORMEgUm+KMh8O8UrwGkFL3As6SQYt+Cr6
         VSIijYeZGLpy+TSPBHZ6LbFaRmNgq5qWuV/s0p1aJci8pD+plgWk+As7I/iz9QbBD6Qy
         DO7SRWp30VGsOPH+AzIY72FrBJCs9Zzya5MzZ6fKvpZP9YhGboVHCqKp4hOZx9jK7rVL
         wnayeTYkpdkNM6ci7wWTaCciLYH3dEiYLXGDtwxFsftxQhjZdKu+YN8wYfqWNLSBnuCq
         1K6iLn7hV6zboIyE8hZBvVaR7OZ3nvJXgbuXmiZ2Pg4xA0byiy/6vIknr3ag5b2v0yr7
         DZog==
X-Gm-Message-State: AOAM533SmKJ/76c17hoAIq+PXMlGjFayVTTO4dcxqQxw9gsGoSAOSzuK
        HCJvYn2PcHvpMx2e8m10ThAxQTS3mA==
X-Google-Smtp-Source: ABdhPJw7Ohx9SWK+DqLmNJz1KrqtjH8XBDMW/d+TL/QJCGJxMXsWNEYOZv/GzLitSA8X8n70izNhtA==
X-Received: by 2002:a92:b0d:: with SMTP id b13mr14212519ilf.225.1590876707680;
        Sat, 30 May 2020 15:11:47 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id w78sm2735698ilk.14.2020.05.30.15.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 15:11:47 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 08/10] x86/percpu: Clean up percpu_cmpxchg_op()
Date:   Sat, 30 May 2020 18:11:25 -0400
Message-Id: <20200530221127.459704-9-brgerst@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200530221127.459704-1-brgerst@gmail.com>
References: <20200530221127.459704-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core percpu macros already have a switch on the data size, so the switch
in the x86 code is redundant and produces more dead code.

Also use appropriate types for the width of the instructions.  This avoids
errors when compiling with Clang.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/percpu.h | 58 +++++++++++------------------------
 1 file changed, 18 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index ac6d7e76c0d4..7efc0b5c4ff0 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -236,39 +236,17 @@ do {									\
  * cmpxchg has no such implied lock semantics as a result it is much
  * more efficient for cpu local operations.
  */
-#define percpu_cmpxchg_op(qual, var, oval, nval)			\
+#define percpu_cmpxchg_op(size, qual, _var, _oval, _nval)		\
 ({									\
-	typeof(var) pco_ret__;						\
-	typeof(var) pco_old__ = (oval);					\
-	typeof(var) pco_new__ = (nval);					\
-	switch (sizeof(var)) {						\
-	case 1:								\
-		asm qual ("cmpxchgb %2, "__percpu_arg(1)		\
-			    : "=a" (pco_ret__), "+m" (var)		\
-			    : "q" (pco_new__), "0" (pco_old__)		\
-			    : "memory");				\
-		break;							\
-	case 2:								\
-		asm qual ("cmpxchgw %2, "__percpu_arg(1)		\
-			    : "=a" (pco_ret__), "+m" (var)		\
-			    : "r" (pco_new__), "0" (pco_old__)		\
-			    : "memory");				\
-		break;							\
-	case 4:								\
-		asm qual ("cmpxchgl %2, "__percpu_arg(1)		\
-			    : "=a" (pco_ret__), "+m" (var)		\
-			    : "r" (pco_new__), "0" (pco_old__)		\
-			    : "memory");				\
-		break;							\
-	case 8:								\
-		asm qual ("cmpxchgq %2, "__percpu_arg(1)		\
-			    : "=a" (pco_ret__), "+m" (var)		\
-			    : "r" (pco_new__), "0" (pco_old__)		\
-			    : "memory");				\
-		break;							\
-	default: __bad_percpu_size();					\
-	}								\
-	pco_ret__;							\
+	__pcpu_type_##size pco_old__ = __pcpu_cast_##size(_oval);	\
+	__pcpu_type_##size pco_new__ = __pcpu_cast_##size(_nval);	\
+	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
+				    __percpu_arg([var]))		\
+		  : [oval] "+a" (pco_old__),				\
+		    [var] "+m" (_var)					\
+		  : [nval] __pcpu_reg_##size(, pco_new__)		\
+		  : "memory");						\
+	(typeof(_var))(unsigned long) pco_old__;			\
 })
 
 /*
@@ -336,16 +314,16 @@ do {									\
 #define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, , pcp, val)
 #define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, , pcp, val)
 #define raw_cpu_add_return_4(pcp, val)		percpu_add_return_op(4, , pcp, val)
-#define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
-#define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
-#define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
+#define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, , pcp, oval, nval)
+#define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, , pcp, oval, nval)
+#define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, , pcp, oval, nval)
 
 #define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, volatile, pcp, val)
 #define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, volatile, pcp, val)
 #define this_cpu_add_return_4(pcp, val)		percpu_add_return_op(4, volatile, pcp, val)
-#define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
-#define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
-#define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, volatile, pcp, oval, nval)
 
 #ifdef CONFIG_X86_CMPXCHG64
 #define percpu_cmpxchg8b_double(pcp1, pcp2, o1, o2, n1, n2)		\
@@ -376,7 +354,7 @@ do {									\
 #define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
 #define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, , pcp, val)
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
-#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
+#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, , pcp, oval, nval)
 
 #define this_cpu_read_8(pcp)			percpu_from_op(8, volatile, "mov", pcp)
 #define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
@@ -385,7 +363,7 @@ do {									\
 #define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
 #define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(8, volatile, pcp, nval)
-#define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
 
 /*
  * Pretty complex macro to generate cmpxchg16 instruction.  The instruction
-- 
2.25.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FA02B7C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgKRLRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgKRLRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:17:08 -0500
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49063C061A4D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 03:17:08 -0800 (PST)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4Cbg5J4CYfz8sh3;
        Wed, 18 Nov 2020 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1605697668;
        bh=OaWvHg/EA6JyylB5bFXIMFDN1Jwf8aYCFNvhWBTYrvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eICoYrgJQAu73TYo9feKoHl5/z4keVo2O7m0HezKJZvx6NmUca6v8aGWJmzO6HxMR
         RYtoNRY1WitYrLAOo69nZi5dCQu3fDGPKodSINz+kI+zT0+YjRrjpzGXOrYJmKAr2Y
         u+4gGb7dsG4nVrZDJ6SdpaUuBH0DSXLL/7TKIMmw=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4Cbg5H68G0z8sgF;
        Wed, 18 Nov 2020 11:07:47 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     akpm@linux-foundation.org
Cc:     linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dja@axtens.net,
        keescook@chromium.org, Daniel Micay <danielmicay@gmail.com>
Subject: [PATCH v5 1/5] string.h: detect intra-object overflow in fortified string functions
Date:   Wed, 18 Nov 2020 12:07:27 +0100
Message-Id: <20201118110731.15833-2-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201118110731.15833-1-laniel_francis@privacyrequired.com>
References: <20201118110731.15833-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Axtens <dja@axtens.net>

When the fortify feature was first introduced in commit 6974f0c4555e
("include/linux/string.h: add the option of fortified string.h functions"),
Daniel Micay observed:

  * It should be possible to optionally use __builtin_object_size(x, 1) for
    some functions (C strings) to detect intra-object overflows (like
    glibc's _FORTIFY_SOURCE=2), but for now this takes the conservative
    approach to avoid likely compatibility issues.

This is a case that often cannot be caught by KASAN. Consider:

struct foo {
    char a[10];
    char b[10];
}

void test() {
    char *msg;
    struct foo foo;

    msg = kmalloc(16, GFP_KERNEL);
    strcpy(msg, "Hello world!!");
    // this copy overwrites foo.b
    strcpy(foo.a, msg);
}

The questionable copy overflows foo.a and writes to foo.b as well. It
cannot be detected by KASAN. Currently it is also not detected by fortify,
because strcpy considers __builtin_object_size(x, 0), which considers the
size of the surrounding object (here, struct foo). However, if we switch
the string functions over to use __builtin_object_size(x, 1), the compiler
will measure the size of the closest surrounding subobject (here, foo.a),
rather than the size of the surrounding object as a whole. See
https://gcc.gnu.org/onlinedocs/gcc/Object-Size-Checking.html for more info.

Only do this for string functions: we cannot use it on things like
memcpy, memmove, memcmp and memchr_inv due to code like this which
purposefully operates on multiple structure members:
(arch/x86/kernel/traps.c)

	/*
	 * regs->sp points to the failing IRET frame on the
	 * ESPFIX64 stack.  Copy it to the entry stack.  This fills
	 * in gpregs->ss through gpregs->ip.
	 *
	 */
	memmove(&gpregs->ip, (void *)regs->sp, 5*8);

This change passes an allyesconfig on powerpc and x86, and an x86 kernel
built with it survives running with syz-stress from syzkaller, so it seems
safe so far.

Cc: Daniel Micay <danielmicay@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 include/linux/string.h | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index b1f3894a0a3e..46e91d684c47 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -292,7 +292,7 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 
 __FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
 {
-	size_t p_size = __builtin_object_size(p, 0);
+	size_t p_size = __builtin_object_size(p, 1);
 	if (__builtin_constant_p(size) && p_size < size)
 		__write_overflow();
 	if (p_size < size)
@@ -302,7 +302,7 @@ __FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
 
 __FORTIFY_INLINE char *strcat(char *p, const char *q)
 {
-	size_t p_size = __builtin_object_size(p, 0);
+	size_t p_size = __builtin_object_size(p, 1);
 	if (p_size == (size_t)-1)
 		return __underlying_strcat(p, q);
 	if (strlcat(p, q, p_size) >= p_size)
@@ -313,7 +313,7 @@ __FORTIFY_INLINE char *strcat(char *p, const char *q)
 __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
 {
 	__kernel_size_t ret;
-	size_t p_size = __builtin_object_size(p, 0);
+	size_t p_size = __builtin_object_size(p, 1);
 
 	/* Work around gcc excess stack consumption issue */
 	if (p_size == (size_t)-1 ||
@@ -328,7 +328,7 @@ __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
 extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
 __FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
 {
-	size_t p_size = __builtin_object_size(p, 0);
+	size_t p_size = __builtin_object_size(p, 1);
 	__kernel_size_t ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
 	if (p_size <= ret && maxlen != ret)
 		fortify_panic(__func__);
@@ -340,8 +340,8 @@ extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
 __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
 {
 	size_t ret;
-	size_t p_size = __builtin_object_size(p, 0);
-	size_t q_size = __builtin_object_size(q, 0);
+	size_t p_size = __builtin_object_size(p, 1);
+	size_t q_size = __builtin_object_size(q, 1);
 	if (p_size == (size_t)-1 && q_size == (size_t)-1)
 		return __real_strlcpy(p, q, size);
 	ret = strlen(q);
@@ -361,8 +361,8 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
 __FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
 {
 	size_t p_len, copy_len;
-	size_t p_size = __builtin_object_size(p, 0);
-	size_t q_size = __builtin_object_size(q, 0);
+	size_t p_size = __builtin_object_size(p, 1);
+	size_t q_size = __builtin_object_size(q, 1);
 	if (p_size == (size_t)-1 && q_size == (size_t)-1)
 		return __underlying_strncat(p, q, count);
 	p_len = strlen(p);
@@ -475,11 +475,16 @@ __FORTIFY_INLINE void *kmemdup(const void *p, size_t size, gfp_t gfp)
 /* defined after fortified strlen and memcpy to reuse them */
 __FORTIFY_INLINE char *strcpy(char *p, const char *q)
 {
-	size_t p_size = __builtin_object_size(p, 0);
-	size_t q_size = __builtin_object_size(q, 0);
+	size_t p_size = __builtin_object_size(p, 1);
+	size_t q_size = __builtin_object_size(q, 1);
+	size_t size;
 	if (p_size == (size_t)-1 && q_size == (size_t)-1)
 		return __underlying_strcpy(p, q);
-	memcpy(p, q, strlen(q) + 1);
+	size = strlen(q) + 1;
+	/* test here to use the more stringent object size */
+	if (p_size < size)
+		fortify_panic(__func__);
+	memcpy(p, q, size);
 	return p;
 }
 
-- 
2.20.1


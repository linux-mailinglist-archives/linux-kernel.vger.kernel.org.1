Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7432ED32C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 16:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbhAGPCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 10:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbhAGPCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:02:44 -0500
Received: from confino.investici.org (confino.investici.org [IPv6:2a00:c38:11e:ffff::a020])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11988C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 07:02:03 -0800 (PST)
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4DBTj31xq6z12wb;
        Thu,  7 Jan 2021 14:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1610031127;
        bh=bvByBwH1oxdHOhwjl0+viow5EUmcv5Vyw1QaOkN6vdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwouQxaa0sOyGCurbzHGqa+pg0uKRHSyTUSAd6oL21MEWAyRxQM8RmLDXGYl2Z04l
         EnmQWCqHm7tGyEwqNeUFB6Bq7Xg0QBn695OaQPH5C1Irw5bo7nay19lQPjwFsDstWB
         RtptyACHuji/wBYFmhSS7G25U+MLAk6jWmlmQIHA=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4DBTj30cMxz12wB;
        Thu,  7 Jan 2021 14:52:07 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [RFC PATCH 1/1] string.h: Create header for fortified string functions.
Date:   Thu,  7 Jan 2021 15:51:43 +0100
Message-Id: <20210107145143.7438-2-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210107145143.7438-1-laniel_francis@privacyrequired.com>
References: <20210107145143.7438-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

This patch adds fortify-string.h to contain fortified functions definitions.
Thus, the code is more separated and compile time is slightly faster for people
who do not set CONFIG_FORTIFY_SOURCE.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 include/linux/fortify-string.h | 302 +++++++++++++++++++++++++++++++++
 include/linux/string.h         | 282 +-----------------------------
 2 files changed, 303 insertions(+), 281 deletions(-)
 create mode 100644 include/linux/fortify-string.h

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
new file mode 100644
index 000000000000..8a61b983318b
--- /dev/null
+++ b/include/linux/fortify-string.h
@@ -0,0 +1,302 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FORTIFY_STRING_H_
+#define _LINUX_FORTIFY_STRING_H_
+
+
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
+extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
+extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
+extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
+extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
+extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
+extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
+extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
+extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
+extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
+#else
+#define __underlying_memchr	__builtin_memchr
+#define __underlying_memcmp	__builtin_memcmp
+#define __underlying_memcpy	__builtin_memcpy
+#define __underlying_memmove	__builtin_memmove
+#define __underlying_memset	__builtin_memset
+#define __underlying_strcat	__builtin_strcat
+#define __underlying_strcpy	__builtin_strcpy
+#define __underlying_strlen	__builtin_strlen
+#define __underlying_strncat	__builtin_strncat
+#define __underlying_strncpy	__builtin_strncpy
+#endif
+
+__FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
+{
+	size_t p_size = __builtin_object_size(p, 1);
+
+	if (__builtin_constant_p(size) && p_size < size)
+		__write_overflow();
+	if (p_size < size)
+		fortify_panic(__func__);
+	return __underlying_strncpy(p, q, size);
+}
+
+__FORTIFY_INLINE char *strcat(char *p, const char *q)
+{
+	size_t p_size = __builtin_object_size(p, 1);
+
+	if (p_size == (size_t)-1)
+		return __underlying_strcat(p, q);
+	if (strlcat(p, q, p_size) >= p_size)
+		fortify_panic(__func__);
+	return p;
+}
+
+__FORTIFY_INLINE __kernel_size_t strlen(const char *p)
+{
+	__kernel_size_t ret;
+	size_t p_size = __builtin_object_size(p, 1);
+
+	/* Work around gcc excess stack consumption issue */
+	if (p_size == (size_t)-1 ||
+		(__builtin_constant_p(p[p_size - 1]) && p[p_size - 1] == '\0'))
+		return __underlying_strlen(p);
+	ret = strnlen(p, p_size);
+	if (p_size <= ret)
+		fortify_panic(__func__);
+	return ret;
+}
+
+extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
+__FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
+{
+	size_t p_size = __builtin_object_size(p, 1);
+	__kernel_size_t ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
+
+	if (p_size <= ret && maxlen != ret)
+		fortify_panic(__func__);
+	return ret;
+}
+
+/* defined after fortified strlen to reuse it */
+extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
+__FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
+{
+	size_t ret;
+	size_t p_size = __builtin_object_size(p, 1);
+	size_t q_size = __builtin_object_size(q, 1);
+
+	if (p_size == (size_t)-1 && q_size == (size_t)-1)
+		return __real_strlcpy(p, q, size);
+	ret = strlen(q);
+	if (size) {
+		size_t len = (ret >= size) ? size - 1 : ret;
+
+		if (__builtin_constant_p(len) && len >= p_size)
+			__write_overflow();
+		if (len >= p_size)
+			fortify_panic(__func__);
+			__underlying_memcpy(p, q, len);
+		p[len] = '\0';
+	}
+	return ret;
+}
+
+/* defined after fortified strnlen to reuse it */
+extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
+__FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t size)
+{
+	size_t len;
+	/* Use string size rather than possible enclosing struct size. */
+	size_t p_size = __builtin_object_size(p, 1);
+	size_t q_size = __builtin_object_size(q, 1);
+
+	/* If we cannot get size of p and q default to call strscpy. */
+	if (p_size == (size_t) -1 && q_size == (size_t) -1)
+		return __real_strscpy(p, q, size);
+
+	/*
+	 * If size can be known at compile time and is greater than
+	 * p_size, generate a compile time write overflow error.
+	 */
+	if (__builtin_constant_p(size) && size > p_size)
+		__write_overflow();
+
+	/*
+	 * This call protects from read overflow, because len will default to q
+	 * length if it smaller than size.
+	 */
+	len = strnlen(q, size);
+	/*
+	 * If len equals size, we will copy only size bytes which leads to
+	 * -E2BIG being returned.
+	 * Otherwise we will copy len + 1 because of the final '\O'.
+	 */
+	len = len == size ? size : len + 1;
+
+	/*
+	 * Generate a runtime write overflow error if len is greater than
+	 * p_size.
+	 */
+	if (len > p_size)
+		fortify_panic(__func__);
+
+	/*
+	 * We can now safely call vanilla strscpy because we are protected from:
+	 * 1. Read overflow thanks to call to strnlen().
+	 * 2. Write overflow thanks to above ifs.
+	 */
+	return __real_strscpy(p, q, len);
+}
+
+/* defined after fortified strlen and strnlen to reuse them */
+__FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
+{
+	size_t p_len, copy_len;
+	size_t p_size = __builtin_object_size(p, 1);
+	size_t q_size = __builtin_object_size(q, 1);
+
+	if (p_size == (size_t)-1 && q_size == (size_t)-1)
+		return __underlying_strncat(p, q, count);
+	p_len = strlen(p);
+	copy_len = strnlen(q, count);
+	if (p_size < p_len + copy_len + 1)
+		fortify_panic(__func__);
+		__underlying_memcpy(p + p_len, q, copy_len);
+	p[p_len + copy_len] = '\0';
+	return p;
+}
+
+__FORTIFY_INLINE void *memset(void *p, int c, __kernel_size_t size)
+{
+	size_t p_size = __builtin_object_size(p, 0);
+
+	if (__builtin_constant_p(size) && p_size < size)
+		__write_overflow();
+	if (p_size < size)
+		fortify_panic(__func__);
+	return __underlying_memset(p, c, size);
+}
+
+__FORTIFY_INLINE void *memcpy(void *p, const void *q, __kernel_size_t size)
+{
+	size_t p_size = __builtin_object_size(p, 0);
+	size_t q_size = __builtin_object_size(q, 0);
+
+	if (__builtin_constant_p(size)) {
+		if (p_size < size)
+			__write_overflow();
+		if (q_size < size)
+			__read_overflow2();
+	}
+	if (p_size < size || q_size < size)
+		fortify_panic(__func__);
+	return __underlying_memcpy(p, q, size);
+}
+
+__FORTIFY_INLINE void *memmove(void *p, const void *q, __kernel_size_t size)
+{
+	size_t p_size = __builtin_object_size(p, 0);
+	size_t q_size = __builtin_object_size(q, 0);
+
+	if (__builtin_constant_p(size)) {
+		if (p_size < size)
+			__write_overflow();
+		if (q_size < size)
+			__read_overflow2();
+	}
+	if (p_size < size || q_size < size)
+		fortify_panic(__func__);
+	return __underlying_memmove(p, q, size);
+}
+
+extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
+__FORTIFY_INLINE void *memscan(void *p, int c, __kernel_size_t size)
+{
+	size_t p_size = __builtin_object_size(p, 0);
+
+	if (__builtin_constant_p(size) && p_size < size)
+		__read_overflow();
+	if (p_size < size)
+		fortify_panic(__func__);
+	return __real_memscan(p, c, size);
+}
+
+__FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
+{
+	size_t p_size = __builtin_object_size(p, 0);
+	size_t q_size = __builtin_object_size(q, 0);
+
+	if (__builtin_constant_p(size)) {
+		if (p_size < size)
+			__read_overflow();
+		if (q_size < size)
+			__read_overflow2();
+	}
+	if (p_size < size || q_size < size)
+		fortify_panic(__func__);
+	return __underlying_memcmp(p, q, size);
+}
+
+__FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
+{
+	size_t p_size = __builtin_object_size(p, 0);
+
+	if (__builtin_constant_p(size) && p_size < size)
+		__read_overflow();
+	if (p_size < size)
+		fortify_panic(__func__);
+	return __underlying_memchr(p, c, size);
+}
+
+void *__real_memchr_inv(const void *s, int c, size_t n) __RENAME(memchr_inv);
+__FORTIFY_INLINE void *memchr_inv(const void *p, int c, size_t size)
+{
+	size_t p_size = __builtin_object_size(p, 0);
+
+	if (__builtin_constant_p(size) && p_size < size)
+		__read_overflow();
+	if (p_size < size)
+		fortify_panic(__func__);
+	return __real_memchr_inv(p, c, size);
+}
+
+extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup);
+__FORTIFY_INLINE void *kmemdup(const void *p, size_t size, gfp_t gfp)
+{
+	size_t p_size = __builtin_object_size(p, 0);
+
+	if (__builtin_constant_p(size) && p_size < size)
+		__read_overflow();
+	if (p_size < size)
+		fortify_panic(__func__);
+	return __real_kmemdup(p, size, gfp);
+}
+
+/* defined after fortified strlen and memcpy to reuse them */
+__FORTIFY_INLINE char *strcpy(char *p, const char *q)
+{
+	size_t p_size = __builtin_object_size(p, 1);
+	size_t q_size = __builtin_object_size(q, 1);
+	size_t size;
+
+	if (p_size == (size_t)-1 && q_size == (size_t)-1)
+		return __underlying_strcpy(p, q);
+	size = strlen(q) + 1;
+	/* test here to use the more stringent object size */
+	if (p_size < size)
+		fortify_panic(__func__);
+	memcpy(p, q, size);
+	return p;
+}
+
+/* Don't use these outside the FORITFY_SOURCE implementation */
+#undef __underlying_memchr
+#undef __underlying_memcmp
+#undef __underlying_memcpy
+#undef __underlying_memmove
+#undef __underlying_memset
+#undef __underlying_strcat
+#undef __underlying_strcpy
+#undef __underlying_strlen
+#undef __underlying_strncat
+#undef __underlying_strncpy
+
+#endif /* _LINUX_FORTIFY_STRING_H_ */
diff --git a/include/linux/string.h b/include/linux/string.h
index 4fcfb56abcf5..9521d8cab18e 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -266,287 +266,7 @@ void __read_overflow3(void) __compiletime_error("detected read beyond size of ob
 void __write_overflow(void) __compiletime_error("detected write beyond size of object passed as 1st parameter");
 
 #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
-
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
-extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
-extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
-extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
-extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
-extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
-extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
-extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
-extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
-extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
-extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
-#else
-#define __underlying_memchr	__builtin_memchr
-#define __underlying_memcmp	__builtin_memcmp
-#define __underlying_memcpy	__builtin_memcpy
-#define __underlying_memmove	__builtin_memmove
-#define __underlying_memset	__builtin_memset
-#define __underlying_strcat	__builtin_strcat
-#define __underlying_strcpy	__builtin_strcpy
-#define __underlying_strlen	__builtin_strlen
-#define __underlying_strncat	__builtin_strncat
-#define __underlying_strncpy	__builtin_strncpy
-#endif
-
-__FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
-{
-	size_t p_size = __builtin_object_size(p, 1);
-	if (__builtin_constant_p(size) && p_size < size)
-		__write_overflow();
-	if (p_size < size)
-		fortify_panic(__func__);
-	return __underlying_strncpy(p, q, size);
-}
-
-__FORTIFY_INLINE char *strcat(char *p, const char *q)
-{
-	size_t p_size = __builtin_object_size(p, 1);
-	if (p_size == (size_t)-1)
-		return __underlying_strcat(p, q);
-	if (strlcat(p, q, p_size) >= p_size)
-		fortify_panic(__func__);
-	return p;
-}
-
-__FORTIFY_INLINE __kernel_size_t strlen(const char *p)
-{
-	__kernel_size_t ret;
-	size_t p_size = __builtin_object_size(p, 1);
-
-	/* Work around gcc excess stack consumption issue */
-	if (p_size == (size_t)-1 ||
-	    (__builtin_constant_p(p[p_size - 1]) && p[p_size - 1] == '\0'))
-		return __underlying_strlen(p);
-	ret = strnlen(p, p_size);
-	if (p_size <= ret)
-		fortify_panic(__func__);
-	return ret;
-}
-
-extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
-__FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
-{
-	size_t p_size = __builtin_object_size(p, 1);
-	__kernel_size_t ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
-	if (p_size <= ret && maxlen != ret)
-		fortify_panic(__func__);
-	return ret;
-}
-
-/* defined after fortified strlen to reuse it */
-extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
-__FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
-{
-	size_t ret;
-	size_t p_size = __builtin_object_size(p, 1);
-	size_t q_size = __builtin_object_size(q, 1);
-	if (p_size == (size_t)-1 && q_size == (size_t)-1)
-		return __real_strlcpy(p, q, size);
-	ret = strlen(q);
-	if (size) {
-		size_t len = (ret >= size) ? size - 1 : ret;
-		if (__builtin_constant_p(len) && len >= p_size)
-			__write_overflow();
-		if (len >= p_size)
-			fortify_panic(__func__);
-		__underlying_memcpy(p, q, len);
-		p[len] = '\0';
-	}
-	return ret;
-}
-
-/* defined after fortified strnlen to reuse it */
-extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
-__FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t size)
-{
-	size_t len;
-	/* Use string size rather than possible enclosing struct size. */
-	size_t p_size = __builtin_object_size(p, 1);
-	size_t q_size = __builtin_object_size(q, 1);
-
-	/* If we cannot get size of p and q default to call strscpy. */
-	if (p_size == (size_t) -1 && q_size == (size_t) -1)
-		return __real_strscpy(p, q, size);
-
-	/*
-	 * If size can be known at compile time and is greater than
-	 * p_size, generate a compile time write overflow error.
-	 */
-	if (__builtin_constant_p(size) && size > p_size)
-		__write_overflow();
-
-	/*
-	 * This call protects from read overflow, because len will default to q
-	 * length if it smaller than size.
-	 */
-	len = strnlen(q, size);
-	/*
-	 * If len equals size, we will copy only size bytes which leads to
-	 * -E2BIG being returned.
-	 * Otherwise we will copy len + 1 because of the final '\O'.
-	 */
-	len = len == size ? size : len + 1;
-
-	/*
-	 * Generate a runtime write overflow error if len is greater than
-	 * p_size.
-	 */
-	if (len > p_size)
-		fortify_panic(__func__);
-
-	/*
-	 * We can now safely call vanilla strscpy because we are protected from:
-	 * 1. Read overflow thanks to call to strnlen().
-	 * 2. Write overflow thanks to above ifs.
-	 */
-	return __real_strscpy(p, q, len);
-}
-
-/* defined after fortified strlen and strnlen to reuse them */
-__FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
-{
-	size_t p_len, copy_len;
-	size_t p_size = __builtin_object_size(p, 1);
-	size_t q_size = __builtin_object_size(q, 1);
-	if (p_size == (size_t)-1 && q_size == (size_t)-1)
-		return __underlying_strncat(p, q, count);
-	p_len = strlen(p);
-	copy_len = strnlen(q, count);
-	if (p_size < p_len + copy_len + 1)
-		fortify_panic(__func__);
-	__underlying_memcpy(p + p_len, q, copy_len);
-	p[p_len + copy_len] = '\0';
-	return p;
-}
-
-__FORTIFY_INLINE void *memset(void *p, int c, __kernel_size_t size)
-{
-	size_t p_size = __builtin_object_size(p, 0);
-	if (__builtin_constant_p(size) && p_size < size)
-		__write_overflow();
-	if (p_size < size)
-		fortify_panic(__func__);
-	return __underlying_memset(p, c, size);
-}
-
-__FORTIFY_INLINE void *memcpy(void *p, const void *q, __kernel_size_t size)
-{
-	size_t p_size = __builtin_object_size(p, 0);
-	size_t q_size = __builtin_object_size(q, 0);
-	if (__builtin_constant_p(size)) {
-		if (p_size < size)
-			__write_overflow();
-		if (q_size < size)
-			__read_overflow2();
-	}
-	if (p_size < size || q_size < size)
-		fortify_panic(__func__);
-	return __underlying_memcpy(p, q, size);
-}
-
-__FORTIFY_INLINE void *memmove(void *p, const void *q, __kernel_size_t size)
-{
-	size_t p_size = __builtin_object_size(p, 0);
-	size_t q_size = __builtin_object_size(q, 0);
-	if (__builtin_constant_p(size)) {
-		if (p_size < size)
-			__write_overflow();
-		if (q_size < size)
-			__read_overflow2();
-	}
-	if (p_size < size || q_size < size)
-		fortify_panic(__func__);
-	return __underlying_memmove(p, q, size);
-}
-
-extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
-__FORTIFY_INLINE void *memscan(void *p, int c, __kernel_size_t size)
-{
-	size_t p_size = __builtin_object_size(p, 0);
-	if (__builtin_constant_p(size) && p_size < size)
-		__read_overflow();
-	if (p_size < size)
-		fortify_panic(__func__);
-	return __real_memscan(p, c, size);
-}
-
-__FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
-{
-	size_t p_size = __builtin_object_size(p, 0);
-	size_t q_size = __builtin_object_size(q, 0);
-	if (__builtin_constant_p(size)) {
-		if (p_size < size)
-			__read_overflow();
-		if (q_size < size)
-			__read_overflow2();
-	}
-	if (p_size < size || q_size < size)
-		fortify_panic(__func__);
-	return __underlying_memcmp(p, q, size);
-}
-
-__FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
-{
-	size_t p_size = __builtin_object_size(p, 0);
-	if (__builtin_constant_p(size) && p_size < size)
-		__read_overflow();
-	if (p_size < size)
-		fortify_panic(__func__);
-	return __underlying_memchr(p, c, size);
-}
-
-void *__real_memchr_inv(const void *s, int c, size_t n) __RENAME(memchr_inv);
-__FORTIFY_INLINE void *memchr_inv(const void *p, int c, size_t size)
-{
-	size_t p_size = __builtin_object_size(p, 0);
-	if (__builtin_constant_p(size) && p_size < size)
-		__read_overflow();
-	if (p_size < size)
-		fortify_panic(__func__);
-	return __real_memchr_inv(p, c, size);
-}
-
-extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup);
-__FORTIFY_INLINE void *kmemdup(const void *p, size_t size, gfp_t gfp)
-{
-	size_t p_size = __builtin_object_size(p, 0);
-	if (__builtin_constant_p(size) && p_size < size)
-		__read_overflow();
-	if (p_size < size)
-		fortify_panic(__func__);
-	return __real_kmemdup(p, size, gfp);
-}
-
-/* defined after fortified strlen and memcpy to reuse them */
-__FORTIFY_INLINE char *strcpy(char *p, const char *q)
-{
-	size_t p_size = __builtin_object_size(p, 1);
-	size_t q_size = __builtin_object_size(q, 1);
-	size_t size;
-	if (p_size == (size_t)-1 && q_size == (size_t)-1)
-		return __underlying_strcpy(p, q);
-	size = strlen(q) + 1;
-	/* test here to use the more stringent object size */
-	if (p_size < size)
-		fortify_panic(__func__);
-	memcpy(p, q, size);
-	return p;
-}
-
-/* Don't use these outside the FORITFY_SOURCE implementation */
-#undef __underlying_memchr
-#undef __underlying_memcmp
-#undef __underlying_memcpy
-#undef __underlying_memmove
-#undef __underlying_memset
-#undef __underlying_strcat
-#undef __underlying_strcpy
-#undef __underlying_strlen
-#undef __underlying_strncat
-#undef __underlying_strncpy
+#include <linux/fortify-string.h>
 #endif
 
 /**
-- 
2.20.1


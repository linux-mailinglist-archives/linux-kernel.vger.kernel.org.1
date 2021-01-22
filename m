Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9CF3009EA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbhAVRa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:30:27 -0500
Received: from mail.thundersoft.com ([114.242.213.35]:40314 "EHLO
        mail1.thundersoft.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbhAVP5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:57:15 -0500
Received: from localhost.localdomain (unknown [192.168.8.82])
        by mail1.thundersoft.com (Postfix) with ESMTPSA id 58E0017A3BFF;
        Fri, 22 Jan 2021 23:56:24 +0800 (CST)
From:   Wesley Zhao <zhaowei1102@thundersoft.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, keescook@chromium.org,
        tglx@linutronix.de, kerneldev@karsmulder.nl, nivedita@alum.mit.edu,
        joe@perches.com, gpiccoli@canonical.com, aquini@redhat.com,
        gustavoars@kernel.org, zhaowei1102@thundersoft.com,
        ojeda@kernel.org, ndesaulniers@gooogle.com,
        linux-kernel@vger.kernel.org, david@redhat.com,
        dan.j.williams@intel.com, guohanjun@huawei.com,
        mchehab+huawei@kernel.org
Subject: [PATCH v3 1/2] lib/cmdline: add new function get_option_ull()
Date:   Fri, 22 Jan 2021 07:55:36 -0800
Message-Id: <1611330937-22654-2-git-send-email-zhaowei1102@thundersoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611330937-22654-1-git-send-email-zhaowei1102@thundersoft.com>
References: <1611330937-22654-1-git-send-email-zhaowei1102@thundersoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the future we would pass the unsigned long long parameter
like(0x123456781234) in cmdline on the 64bit platform, so add a new
option parse function get_option_ull()

Signed-off-by: Wesley Zhao <zhaowei1102@thundersoft.com>
---
 include/linux/kernel.h |  2 ++
 lib/cmdline.c          | 94 ++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 82 insertions(+), 14 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f7902d8c1048..eb1f0b14a0c5 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -348,6 +348,8 @@ extern __scanf(2, 0)
 int vsscanf(const char *, const char *, va_list);
 
 extern int get_option(char **str, int *pint);
+extern int get_option_ll(char **str, long long *pll);
+extern int get_option_ull(char **str, unsigned long long *pull);
 extern char *get_options(const char *str, int nints, int *ints);
 extern unsigned long long memparse(const char *ptr, char **retptr);
 extern bool parse_option_str(const char *str, const char *option);
diff --git a/lib/cmdline.c b/lib/cmdline.c
index b390dd03363b..6030fc70e0f5 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -31,6 +31,81 @@ static int get_range(char **str, int *pint, int n)
 		*pint++ = x;
 	return inc_counter;
 }
+/**
+ *	get_option_ull - Parse unsigned long long from an option string
+ *	@str: option string
+ *	@pull: (output) unsigned long long value parsed from @str
+ *
+ *	Read an unsigned long long from an option string; if available accept a subsequent
+ *	comma as well.
+ *
+ *	Return values:
+ *	0 - no ull in string
+ *	1 - ull found, no subsequent comma
+ *	2 - ull found including a subsequent comma
+ *	3 - hyphen found to denote a range
+ */
+
+int get_option_ull(char **str, unsigned long long *pull)
+{
+	char *cur = *str;
+	unsigned long long value;
+
+	if (!cur || !(*cur))
+		return 0;
+	value = simple_strtoull(cur, str, 0);
+	if (pull)
+		*pull = value;
+	if (cur == *str)
+		return 0;
+	if (**str == ',') {
+		(*str)++;
+		return 2;
+	}
+	if (**str == '-')
+		return 3;
+
+	return 1;
+}
+EXPORT_SYMBOL(get_option_ull);
+
+/**
+ *	get_option_ll - Parse long long from an option string
+ *	@str: option string
+ *	@pll: (output) long long value parsed from @str
+ *
+ *	Read an long long from an option string; if available accept a subsequent
+ *	comma as well.
+ *
+ *	Return values:
+ *	0 - no ll in string
+ *	1 - ll found, no subsequent comma
+ *	2 - ll found including a subsequent comma
+ *	3 - hyphen found to denote a range
+ */
+
+int get_option_ll(char **str, long long *pll)
+{
+	char *cur = *str;
+	unsigned long long value;
+	int ret;
+
+	if (!cur || !(*cur))
+		return 0;
+	if (*cur == '-') {
+		(*str) = cur + 1;
+		ret = get_option_ull(str, &value);
+		if (pll)
+			*pll = -value;
+	} else {
+		ret = get_option_ull(str, &value);
+		if (pll)
+			*pll = value;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(get_option_ll);
 
 /**
  *	get_option - Parse integer from an option string
@@ -56,26 +131,17 @@ static int get_range(char **str, int *pint, int n)
 int get_option(char **str, int *pint)
 {
 	char *cur = *str;
-	int value;
+	long long value;
+	int ret;
 
 	if (!cur || !(*cur))
 		return 0;
-	if (*cur == '-')
-		value = -simple_strtoull(++cur, str, 0);
-	else
-		value = simple_strtoull(cur, str, 0);
+	ret = get_option_ll(str, &value);
+
 	if (pint)
 		*pint = value;
-	if (cur == *str)
-		return 0;
-	if (**str == ',') {
-		(*str)++;
-		return 2;
-	}
-	if (**str == '-')
-		return 3;
 
-	return 1;
+	return ret;
 }
 EXPORT_SYMBOL(get_option);
 
-- 
2.7.4


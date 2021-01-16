Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11762F8CDC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 11:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbhAPKny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 05:43:54 -0500
Received: from mail.thundersoft.com ([114.242.213.61]:43216 "EHLO
        mail2.thundersoft.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbhAPKnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 05:43:53 -0500
Received: from localhost.localdomain (unknown [192.168.8.81])
        by mail2.thundersoft.com (Postfix) with ESMTPSA id 03DD0E60BA5;
        Sat, 16 Jan 2021 18:43:36 +0800 (CST)
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
Subject: [PATCH v2 1/2] lib/cmdline: add new function get_option_ull()
Date:   Sat, 16 Jan 2021 02:41:12 -0800
Message-Id: <1610793673-64008-2-git-send-email-zhaowei1102@thundersoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610793673-64008-1-git-send-email-zhaowei1102@thundersoft.com>
References: <1610793673-64008-1-git-send-email-zhaowei1102@thundersoft.com>
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
index b390dd03363b..d32b585d287d 100644
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
+		cur = cur + 1;
+		ret = get_option_ull((char **)&cur, &value);
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


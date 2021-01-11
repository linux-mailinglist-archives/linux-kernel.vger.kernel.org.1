Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF31F2F1B42
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389020AbhAKQmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:42:36 -0500
Received: from mail.thundersoft.com ([114.242.213.61]:36453 "EHLO
        mail2.thundersoft.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbhAKQmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:42:36 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jan 2021 11:42:34 EST
Received: from localhost.localdomain (unknown [192.168.8.82])
        by mail2.thundersoft.com (Postfix) with ESMTPSA id 7659AE608B9;
        Tue, 12 Jan 2021 00:34:47 +0800 (CST)
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
Subject: [PATCH 1/2] lib/cmdline: add new function get_option_ull()
Date:   Mon, 11 Jan 2021 08:33:17 -0800
Message-Id: <1610382798-4528-1-git-send-email-zhaowei1102@thundersoft.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Wesley.Zhao" <zhaowei1102@thundersoft.com>

In the future we would pass the unsigned long long parameter
like(0x123456781234) in cmdline on the 64bit platform, so add a new
option parse function get_option_ull()

Signed-off-by: Wesley.Zhao <zhaowei1102@thundersoft.com>
---
 include/linux/kernel.h |  1 +
 lib/cmdline.c          | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f7902d8..5568133 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -348,6 +348,7 @@ extern __scanf(2, 0)
 int vsscanf(const char *, const char *, va_list);
 
 extern int get_option(char **str, int *pint);
+extern int get_option_ull(char **str, unsigned long long *pull);
 extern char *get_options(const char *str, int nints, int *ints);
 extern unsigned long long memparse(const char *ptr, char **retptr);
 extern bool parse_option_str(const char *str, const char *option);
diff --git a/lib/cmdline.c b/lib/cmdline.c
index b390dd0..2d089a2 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -80,6 +80,41 @@ int get_option(char **str, int *pint)
 EXPORT_SYMBOL(get_option);
 
 /**
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
+
+	if (!cur || !(*cur))
+		return 0;
+	*pull = simple_strtoull(cur, str, 0);
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
  *	get_options - Parse a string into a list of integers
  *	@str: String to be parsed
  *	@nints: size of integer array
-- 
2.7.4


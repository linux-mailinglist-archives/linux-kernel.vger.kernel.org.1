Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAE32B45EB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgKPOd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:33:28 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:63190 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729825AbgKPOd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:33:27 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AGEWuan004686;
        Mon, 16 Nov 2020 08:32:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=i6mceA35rm7CRErJrGX/DRU5ePDbCNi8nK11G87J2BA=;
 b=Ka5IJ9IQVs5EPrhw3RB3z92arSlKCbjOwss3C7vC/FcbeZg7glfYjnZSuG+zLGFf83V7
 5gd5vZQ35KH/vyeZK08T3XzLQyof85Ed7nUd6dh/+voFdmDSmnuPmSRc3InyWuoevIAk
 mMfmHAU3WYy3fj7tDonwABVsqe7JcbLwblckrEHYtIwXgYlMSm7byHGbBUP5aa3fFeGX
 k/jsBTS5BDLluaGyv1+hqFQwYcd0bj0fXJiSHPCyAjLJQic77eYbO4+mX4xxf/uxeOSb
 V2Mf3hhv0ZAM42mGX6GNQ94rz5qwEsUIbAVhLLLPfs94FltuoB/EGspXCT1FsC26Q96V 1w== 
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 34tdh7agvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 Nov 2020 08:32:56 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 16 Nov
 2020 14:32:54 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 16 Nov 2020 14:32:54 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.65.1])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 40BC145;
        Mon, 16 Nov 2020 14:32:54 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] lib: vsprintf: Fix handling of number field widths in vsscanf
Date:   Mon, 16 Nov 2020 14:32:52 +0000
Message-ID: <20201116143252.19983-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011160088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing code attempted to handle numbers by doing a strto[u]l(),
ignoring the field width, and then bitshifting the field out of the
converted value. If the string contains a run of valid digits longer
than will fit in a long or long long, this would overflow and no amount
of bitshifting can recover the correct value.

This patch fixes vsscanf to obey number field widths.

A new _parse_integer_limit() is added that takes a limit for the number
of characters to parse. A length of INT_MAX is effectively unlimited, as
we are not likely to need parsing of digit strings >INT_MAX length.

The number field conversion in vsscanf is changed to use this new
_parse_integer_limit() function so that field widths are obeyed when
parsing the number. Note also that the conversion is always done as a
long long - as there's currently no overflow checking there is no point
implementing separate long and long long conversions.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kstrtox.c  | 14 ++++++++---
 lib/kstrtox.h  |  2 ++
 lib/vsprintf.c | 65 +++++++++++++++++++++++++++-----------------------
 3 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index a14ccf905055..9867501a4ab0 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -39,20 +39,23 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
 
 /*
  * Convert non-negative integer string representation in explicitly given radix
- * to an integer.
+ * to an integer. The maximum number of characters to convert can be given.
+ * A character limit of INT_MAX is effectively unlimited since a string that
+ * long is unreasonable.
  * Return number of characters consumed maybe or-ed with overflow bit.
  * If overflow occurs, result integer (incorrect) is still returned.
  *
  * Don't you dare use this function.
  */
-unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
+unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
+				  int max_chars)
 {
 	unsigned long long res;
 	unsigned int rv;
 
 	res = 0;
 	rv = 0;
-	while (1) {
+	for (; max_chars > 0; max_chars--) {
 		unsigned int c = *s;
 		unsigned int lc = c | 0x20; /* don't tolower() this line */
 		unsigned int val;
@@ -82,6 +85,11 @@ unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long
 	return rv;
 }
 
+unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
+{
+	return _parse_integer_limit(s, base, p, INT_MAX);
+}
+
 static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
 {
 	unsigned long long _res;
diff --git a/lib/kstrtox.h b/lib/kstrtox.h
index 3b4637bcd254..4e5dfa3437dc 100644
--- a/lib/kstrtox.h
+++ b/lib/kstrtox.h
@@ -4,6 +4,8 @@
 
 #define KSTRTOX_OVERFLOW	(1U << 31)
 const char *_parse_integer_fixup_radix(const char *s, unsigned int *base);
+unsigned int _parse_integer_limit(const char *s, unsigned int base,
+				  unsigned long long *res, int max_chars);
 unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *res);
 
 #endif
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 14c9a6af1b23..8ec47b5da2cb 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -53,6 +53,25 @@
 #include <linux/string_helpers.h>
 #include "kstrtox.h"
 
+static unsigned long long simple_strntoull(const char *startp, int max_chars,
+					   char **endp, unsigned int base)
+{
+	const char *cp;
+	unsigned long long result;
+	unsigned int rv;
+
+	cp = _parse_integer_fixup_radix(startp, &base);
+	max_chars -= (cp - startp);
+	rv = _parse_integer_limit(cp, base, &result, max_chars);
+	/* FIXME */
+	cp += (rv & ~KSTRTOX_OVERFLOW);
+
+	if (endp)
+		*endp = (char *)cp;
+
+	return result;
+}
+
 /**
  * simple_strtoull - convert a string to an unsigned long long
  * @cp: The start of the string
@@ -63,18 +82,7 @@
  */
 unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base)
 {
-	unsigned long long result;
-	unsigned int rv;
-
-	cp = _parse_integer_fixup_radix(cp, &base);
-	rv = _parse_integer(cp, base, &result);
-	/* FIXME */
-	cp += (rv & ~KSTRTOX_OVERFLOW);
-
-	if (endp)
-		*endp = (char *)cp;
-
-	return result;
+	return simple_strntoull(cp, INT_MAX, endp, base);
 }
 EXPORT_SYMBOL(simple_strtoull);
 
@@ -126,6 +134,15 @@ long long simple_strtoll(const char *cp, char **endp, unsigned int base)
 }
 EXPORT_SYMBOL(simple_strtoll);
 
+static long long simple_strntoll(const char *cp, int max_chars, char **endp,
+				 unsigned int base)
+{
+	if (*cp == '-')
+		return -simple_strntoull(cp + 1, max_chars - 1, endp, base);
+
+	return simple_strntoull(cp, max_chars, endp, base);
+}
+
 static noinline_for_stack
 int skip_atoi(const char **s)
 {
@@ -3444,25 +3461,13 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			break;
 
 		if (is_sign)
-			val.s = qualifier != 'L' ?
-				simple_strtol(str, &next, base) :
-				simple_strtoll(str, &next, base);
+			val.s = simple_strntoll(str,
+						field_width > 0 ? field_width : INT_MAX,
+						&next, base);
 		else
-			val.u = qualifier != 'L' ?
-				simple_strtoul(str, &next, base) :
-				simple_strtoull(str, &next, base);
-
-		if (field_width > 0 && next - str > field_width) {
-			if (base == 0)
-				_parse_integer_fixup_radix(str, &base);
-			while (next - str > field_width) {
-				if (is_sign)
-					val.s = div_s64(val.s, base);
-				else
-					val.u = div_u64(val.u, base);
-				--next;
-			}
-		}
+			val.u = simple_strntoull(str,
+						 field_width > 0 ? field_width : INT_MAX,
+						 &next, base);
 
 		switch (qualifier) {
 		case 'H':	/* that's 'hh' in format */
-- 
2.20.1


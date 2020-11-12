Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DB92B03B1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgKLLSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:18:37 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:3464 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727147AbgKLLSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:18:36 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ACB6r11012339;
        Thu, 12 Nov 2020 05:18:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=0JXW40qNmOIXAMSKQ/j6loVZ/s0nO8nx+m2h3QbPDUw=;
 b=aODBeVhfvqpSrCBbB8JiVzT3eaXCn8nLOM5KC6fIRIN6FtwQ4cnZLAyIj9+ME4S5yrBl
 YnDYC+4C4NQJ2BEDQXJg1tDLil4gC12PTvQly0utrtqZL9ISTHoa32M9zNlz7ICuU+bD
 o9ijTQONQGGMb99wzAi9wJQRJbZV2ZKIvX6JjThEEa4SuV+QfnSh6l4UQ9AhANbJCMy5
 6MiwUj52pRiW2/vjgTlRmsj37S02mtXKvT3iGdJ14S1azXf8RhP+T0SGcZFUVY9h/r2i
 lV2YKuD2oVFnbjkE0BnTZaVvt4phar4bKcUCkNr4y+G1ubGVY0FofgEKjCzD7kzSgRwM zQ== 
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 34rn2yh4u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 05:18:04 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 12 Nov
 2020 11:18:02 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 12 Nov 2020 11:18:02 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.64.168])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EAA9845;
        Thu, 12 Nov 2020 11:18:01 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] lib: vsprintf: Avoid 32-bit truncation in vsscanf number parsing
Date:   Thu, 12 Nov 2020 11:17:59 +0000
Message-ID: <20201112111759.16377-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 malwarescore=0 clxscore=1011 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Number conversion in vsscanf converts a whole string of digits and then
extracts the field width part from the converted value. The maximum run
of digits is limited by overflow. Conversion was using either
simple_strto[u]l or simple_strto[u]ll based on the 'L' qualifier. This
created a difference in truncation between builds where long is 32-bit
and builds where it is 64-bit. This especially affects parsing a run of
contiguous digits into separate fields - the maximum length of the run
is 16 digits if long is 64-bit but only 8 digits if long is 32-bits.
For example a conversion "%6x%6x" would convert both fields correctly if
long is 64-bit but not if long is 32-bit.

It is undesirable for vsscanf to parse numbers differently depending on
the size of long on the target build.

As simple_strto[u]l just calls simple_strto[u]ll anyway the conversion
is always 64-bit, and the result is manipulated as a u64, so this is an
avoidable behaviour difference between 32-bit and 64-bit builds. The
conversion can call simple_strto[u]ll directly and preserve the full
64-bits that were parsed out of the string.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/vsprintf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 14c9a6af1b23..63b6cddfa7f7 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3444,13 +3444,9 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			break;
 
 		if (is_sign)
-			val.s = qualifier != 'L' ?
-				simple_strtol(str, &next, base) :
-				simple_strtoll(str, &next, base);
+			val.s = simple_strtoll(str, &next, base);
 		else
-			val.u = qualifier != 'L' ?
-				simple_strtoul(str, &next, base) :
-				simple_strtoull(str, &next, base);
+			val.u = simple_strtoull(str, &next, base);
 
 		if (field_width > 0 && next - str > field_width) {
 			if (base == 0)
-- 
2.20.1


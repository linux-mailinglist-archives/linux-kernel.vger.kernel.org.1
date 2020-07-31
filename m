Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8E2345DD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 14:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733272AbgGaMbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 08:31:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:39232 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733191AbgGaMbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:31:48 -0400
IronPort-SDR: rny3sesX7x4RlY6JqDiQhjTxhZ6pCuPctK9SJn5EZOgiA0MiQstair0TnNA31rMq1HnuncX8bS
 GM75qSoJ78Hg==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="149232209"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="149232209"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 05:31:48 -0700
IronPort-SDR: ilotydtmrA2FcfLQtAIzb1+hTTKJCnvEFrJsJsC114Irw6V+ifcCUa2bpMBN4lbUgNteGwqaGZ
 OEcOqFlO5Juw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="329233931"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2020 05:31:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3B1DA21D; Fri, 31 Jul 2020 15:31:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] lib/vsprintf: Replace hidden BUILD_BUG_ON() with static_assert()
Date:   Fri, 31 Jul 2020 15:31:43 +0300
Message-Id: <20200731123145.22357-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, there is no compile time check for the SMALL
to be ' ' (0x20, i.e. space). Second, for ZEROPAD the check
is hidden in the code.

For better maintenance replace BUILD_BUG_ON() with static_assert()
for ZEROPAD and move it closer to the definition. While at it,
introduce check for SMALL.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 31a674dd2674..8a8ac7ce0289 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -381,6 +381,9 @@ int num_to_str(char *buf, int size, unsigned long long num, unsigned int width)
 #define SMALL	32		/* use lowercase in hex (must be 32 == 0x20) */
 #define SPECIAL	64		/* prefix hex with "0x", octal with "0" */
 
+static_assert(ZEROPAD + ' ' == '0');
+static_assert(SMALL == ' ');
+
 enum format_type {
 	FORMAT_TYPE_NONE, /* Just a string part */
 	FORMAT_TYPE_WIDTH,
@@ -507,7 +510,7 @@ char *number(char *buf, char *end, unsigned long long num,
 	/* zero or space padding */
 	if (!(spec.flags & LEFT)) {
 		char c = ' ' + (spec.flags & ZEROPAD);
-		BUILD_BUG_ON(' ' + ZEROPAD != '0');
+
 		while (--field_width >= 0) {
 			if (buf < end)
 				*buf = c;
-- 
2.27.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272102B4170
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgKPKmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:42:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:7715 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbgKPKms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:42:48 -0500
IronPort-SDR: lfTJUy8Cgb8DEytzWQV6uKZkHNwZP798FK5AhmdPJtKTWIV8cu3iSO+3UxjjX9FGc4wyY33p6i
 dlVBTD8n6ghw==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="157752799"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="157752799"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 02:42:47 -0800
IronPort-SDR: qaPrulC7Oyk8B/aaG3BqK+WvIHFR0kE1iuJnHycSmhWSYelD8qBmNjNQ43h0sYXQjhpCK2xLM+
 5app8GMJMb8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="329644638"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 16 Nov 2020 02:42:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 47B2111C; Mon, 16 Nov 2020 12:42:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] lib/cmdline_kunit: Type of expected returned values should be int
Date:   Mon, 16 Nov 2020 12:42:44 +0200
Message-Id: <20201116104244.15472-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Type of expected returned values should be int.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/cmdline_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cmdline_kunit.c b/lib/cmdline_kunit.c
index 208b485abfd7..3eb022d4c723 100644
--- a/lib/cmdline_kunit.c
+++ b/lib/cmdline_kunit.c
@@ -13,7 +13,7 @@ static const char *cmdline_test_strings[] = {
 	"+,"  , "--", ",,", "''" , "\"\",", "\",\"", "-\"\"", "\"",
 };
 
-static const char cmdline_test_values[] = {
+static const int cmdline_test_values[] = {
 	1, 1, 1, 1, 2, 3, 2, 3,
 	1, 3, 2, 1, 1, 1, 3, 1,
 };
-- 
2.28.0


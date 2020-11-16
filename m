Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02882B417F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgKPKnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:43:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:31808 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbgKPKnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:43:00 -0500
IronPort-SDR: Ct8FjMKYcXdHQ/X8g6TEoxIa5t0WL2bX8/EY6IZFhKD9KwK0TWjO5PV34XiKWd40+2wxkSVIvv
 0fSpFHMOX/Ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="170897989"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="170897989"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 02:43:00 -0800
IronPort-SDR: a3QrPQkue8bX6YpM5ZN7ZAnEmDvWxfP4Fto3pCrJJ0ACrd+NG/87H/0qtnW3NIe5XE9iNaLK04
 6pYz8GwtuKSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="400412448"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 16 Nov 2020 02:42:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0ADFC11C; Mon, 16 Nov 2020 12:42:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v1] lib/cmdline_kunit: Provide meaningful MODULE_LICENSE()
Date:   Mon, 16 Nov 2020 12:42:57 +0200
Message-Id: <20201116104257.15527-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modpost complains that module has no licence provided.
Provide it via meaningful MODULE_LICENSE().

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/cmdline_kunit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/cmdline_kunit.c b/lib/cmdline_kunit.c
index 3eb022d4c723..550e7a47fd24 100644
--- a/lib/cmdline_kunit.c
+++ b/lib/cmdline_kunit.c
@@ -96,3 +96,5 @@ static struct kunit_suite cmdline_test_suite = {
 	.test_cases = cmdline_test_cases,
 };
 kunit_test_suite(cmdline_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B6C2B906F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 11:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgKSKxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 05:53:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:14504 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgKSKxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:53:30 -0500
IronPort-SDR: XSWAPS4XN8znrNNR0/v3ZT7kWI+U1sU+6M5o+eEa8ulLtyKG6dlp9/KsH5AqYzOlLeNQ/rOvYh
 2JJRkwJyE+qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="170487750"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="170487750"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 02:53:29 -0800
IronPort-SDR: jp2Bt8v7dXaiZnblBV6H9F8iHvLiblvplxM0NH1ome6tnh6lAvcjKIaOm/OOJdmbUjx+08m1F+
 2o8l1H+x1NiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="311026114"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 19 Nov 2020 02:53:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CDEC611E; Thu, 19 Nov 2020 12:53:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v1] resource: provide meaningful MODULE_LICENSE() in test suite
Date:   Thu, 19 Nov 2020 12:53:27 +0200
Message-Id: <20201119105327.89917-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
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
 kernel/resource_kunit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/resource_kunit.c b/kernel/resource_kunit.c
index 9fdbca8426f1..58ab9f914602 100644
--- a/kernel/resource_kunit.c
+++ b/kernel/resource_kunit.c
@@ -148,3 +148,5 @@ static struct kunit_suite resource_test_suite = {
 	.test_cases = resource_test_cases,
 };
 kunit_test_suite(resource_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.29.2


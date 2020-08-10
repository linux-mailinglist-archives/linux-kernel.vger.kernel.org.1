Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255772413F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 01:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHJXxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 19:53:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:1236 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbgHJXxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:53:21 -0400
IronPort-SDR: WK2668p5xheWOSL8Wytnb4l9f/jU+s3n0jobp7Mfo6BTLeW4DNdb8jxVQGJ9ZV1PUFcZug0WWy
 5Dc7NzU59zPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="151317486"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="151317486"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 16:53:21 -0700
IronPort-SDR: MrAtgg6/Tp9kq/6WFClZ5dVMtaAdGvG6mrQbzRwmTNwY85Vg7FRwZY3+lWkAxSlnrMzpfkmEcG
 v6oJk6gdbnLQ==
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="334395937"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 16:53:20 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memremap: Convert devmap static branch to {inc,dec}
Date:   Mon, 10 Aug 2020 16:53:19 -0700
Message-Id: <20200810235319.2796597-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

While reviewing Protection Key Supervisor support it was pointed out
that using a counter to track static branch enable was an anti-pattern
which was better solved using the provided static_branch_{inc,dec}
functions.[1]

Fix up devmap_managed_key to work the same way.  Also this should be
safer because there is a very small (very unlikely) race when multiple
callers try to enable at the same time.

[1] https://lore.kernel.org/lkml/20200714194031.GI5523@worktop.programming.kicks-ass.net/

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 mm/memremap.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 03e38b7a38f1..9fb9ad500e78 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -40,12 +40,10 @@ EXPORT_SYMBOL_GPL(memremap_compat_align);
 #ifdef CONFIG_DEV_PAGEMAP_OPS
 DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
 EXPORT_SYMBOL(devmap_managed_key);
-static atomic_t devmap_managed_enable;
 
 static void devmap_managed_enable_put(void)
 {
-	if (atomic_dec_and_test(&devmap_managed_enable))
-		static_branch_disable(&devmap_managed_key);
+	static_branch_dec(&devmap_managed_key);
 }
 
 static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
@@ -56,8 +54,7 @@ static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
 		return -EINVAL;
 	}
 
-	if (atomic_inc_return(&devmap_managed_enable) == 1)
-		static_branch_enable(&devmap_managed_key);
+	static_branch_inc(&devmap_managed_key);
 	return 0;
 }
 #else
-- 
2.28.0.rc0.12.gb6a658bd00c9


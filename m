Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C57927921B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgIYUdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:33:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:18973 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729020AbgIYUda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:33:30 -0400
IronPort-SDR: 6bfgG7+RP92sWxdeNXnOn29sbxyAT97ukyRQOr6xma3+xPfo1UDdR1bXa6rqhc7I5YVzxW1ipo
 k01KKy6IpzYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="149272226"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="149272226"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:31:31 -0700
IronPort-SDR: +RoebDDnCqGqo9e7gIxH7H/7a3OBdUmnEcz0O0yLSM7kWluyc3urPS/pmU3LLmx4OteSxYGHP1
 lsh1A/4uY3Gg==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="348515710"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:31:30 -0700
Subject: [PATCH v5 16/17] dax/hmem: introduce dax_hmem.region_idle parameter
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Joao Martins <joao.m.martins@oracle.com>, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Sep 2020 12:13:10 -0700
Message-ID: <160106119033.30709.11249962152222193448.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

Introduce a new module parameter for dax_hmem which initializes all region
devices as free, rather than allocating a pagemap for the region by
default.

All hmem devices created with dax_hmem.region_idle=1 will have full
available size for creating dynamic dax devices.

Link: https://lkml.kernel.org/r/159643106460.4062302.5868522341307530091.stgit@dwillia2-desk3.amr.corp.intel.com
Link: https://lore.kernel.org/r/20200716172913.19658-4-joao.m.martins@oracle.com
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/hmem/hmem.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 1a3347bb6143..1bf040dbc834 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -5,6 +5,9 @@
 #include <linux/pfn_t.h>
 #include "../bus.h"
 
+static bool region_idle;
+module_param_named(region_idle, region_idle, bool, 0644);
+
 static int dax_hmem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -30,7 +33,7 @@ static int dax_hmem_probe(struct platform_device *pdev)
 	data = (struct dev_dax_data) {
 		.dax_region = dax_region,
 		.id = -1,
-		.size = resource_size(res),
+		.size = region_idle ? 0 : resource_size(res),
 	};
 	dev_dax = devm_create_dev_dax(&data);
 	if (IS_ERR(dev_dax))


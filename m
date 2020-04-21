Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94731B2E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 19:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgDURdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 13:33:03 -0400
Received: from foss.arm.com ([217.140.110.172]:38940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDURdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:33:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52CA61FB;
        Tue, 21 Apr 2020 10:33:02 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B5D2D3F73D;
        Tue, 21 Apr 2020 10:33:01 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Richard Gong <richard.gong@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] firmware: stratix10-svc: Drop unnecessary checking for and populating /firmware/ node
Date:   Tue, 21 Apr 2020 18:32:56 +0100
Message-Id: <20200421173256.34897-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3aa0582fdb82 ("of: platform: populate /firmware/ node from
of_platform_default_populate_init()") changed the core-code to generate
the platform devices, meaning there is no need for the driver to check
the firmware node and populate it again here.

Let us just drop the unnecessary extra check done here as the core takes
care of it.

Cc: Richard Gong <richard.gong@linux.intel.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/stratix10-svc.c | 17 -----------------
 1 file changed, 17 deletions(-)

Hi Richard,

I assume the subsys_initcall is essential here. If not we can remove the
whole initcalls and replace it with module_platform_driver(). Let me know.
Just found this by accident when grepping for something else.

Regards,
Sudeep

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index d5f0769f3761..791d70fe82c1 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1094,23 +1094,6 @@ static struct platform_driver stratix10_svc_driver = {
 
 static int __init stratix10_svc_init(void)
 {
-	struct device_node *fw_np;
-	struct device_node *np;
-	int ret;
-
-	fw_np = of_find_node_by_name(NULL, "firmware");
-	if (!fw_np)
-		return -ENODEV;
-
-	np = of_find_matching_node(fw_np, stratix10_svc_drv_match);
-	if (!np)
-		return -ENODEV;
-
-	of_node_put(np);
-	ret = of_platform_populate(fw_np, stratix10_svc_drv_match, NULL, NULL);
-	if (ret)
-		return ret;
-
 	return platform_driver_register(&stratix10_svc_driver);
 }
 
-- 
2.17.1


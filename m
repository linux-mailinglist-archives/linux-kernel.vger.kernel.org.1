Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCA62F85E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbhAOUBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:01:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:25630 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388154AbhAOUBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:01:19 -0500
IronPort-SDR: NDPhvXA3wzqSymDo3OFVVRw+b9UCJ5e8ZD3uGlNItpKSffg/llSpqmzieiudsWqYyTc69wWqYb
 MFlBapS1LrVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="175096289"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="175096289"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 11:59:33 -0800
IronPort-SDR: vsvNVOdOZYTlj8X6CqWZNTt69anN75v7z38Fpu1cQT1RyO5sveYN+1DPh4GS8bZFMGVmSPLFUp
 0yfHIVEwKDGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="465686863"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2021 11:59:30 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Wang Hui <john.wanghui@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 1/2] stm class: Fix module init return on allocation failure
Date:   Fri, 15 Jan 2021 22:59:16 +0300
Message-Id: <20210115195917.3184-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115195917.3184-1-alexander.shishkin@linux.intel.com>
References: <20210115195917.3184-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hui <john.wanghui@huawei.com>

In stm_heartbeat_init(): return value gets reset after the first
iteration by stm_source_register_device(), so allocation failures
after that will, after a clean up, return success. Fix that.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 119291853038 ("stm class: Add heartbeat stm source device")
Signed-off-by: Wang Hui <john.wanghui@huawei.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/heartbeat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/stm/heartbeat.c b/drivers/hwtracing/stm/heartbeat.c
index 3e7df1c0477f..81d7b21d31ec 100644
--- a/drivers/hwtracing/stm/heartbeat.c
+++ b/drivers/hwtracing/stm/heartbeat.c
@@ -64,7 +64,7 @@ static void stm_heartbeat_unlink(struct stm_source_data *data)
 
 static int stm_heartbeat_init(void)
 {
-	int i, ret = -ENOMEM;
+	int i, ret;
 
 	if (nr_devs < 0 || nr_devs > STM_HEARTBEAT_MAX)
 		return -EINVAL;
@@ -72,8 +72,10 @@ static int stm_heartbeat_init(void)
 	for (i = 0; i < nr_devs; i++) {
 		stm_heartbeat[i].data.name =
 			kasprintf(GFP_KERNEL, "heartbeat.%d", i);
-		if (!stm_heartbeat[i].data.name)
+		if (!stm_heartbeat[i].data.name) {
+			ret = -ENOMEM;
 			goto fail_unregister;
+		}
 
 		stm_heartbeat[i].data.nr_chans	= 1;
 		stm_heartbeat[i].data.link	= stm_heartbeat_link;
-- 
2.29.2


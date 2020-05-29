Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010351E7EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 15:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgE2NcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 09:32:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:60457 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgE2NcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:32:14 -0400
IronPort-SDR: kIHyoXdqIhIzyt01030mK+6UB2IiwIfg+koGQK8RCIp3NGwEQvtbfOPo6B3I62hBSFk5EQKI4t
 5gZ1opVyRBpw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 06:32:14 -0700
IronPort-SDR: HgsECfhY7gYrS4aqDkxN0tPFmJVmnJko8sZPj0nMZeR0A/SPpjxZFwMpMq3+nwvpKSyxk+7nFh
 7M5OaWECpLNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="292375216"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 29 May 2020 06:32:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6BBFC101; Fri, 29 May 2020 16:32:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] coresight: Drop double check for ACPI companion device
Date:   Fri, 29 May 2020 16:32:10 +0300
Message-Id: <20200529133210.20566-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_dev_get_resources() does perform the NULL pointer check against
ACPI companion device which is given as function parameter. Thus,
there is no need to duplicate this check in the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index b908ca104645..673d2f56ed1e 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -727,8 +727,6 @@ static int acpi_stm_get_stimulus_area(struct device *dev, struct resource *res)
 
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 
-	if (!adev)
-		return -ENODEV;
 	rc = acpi_dev_get_resources(adev, &res_list, NULL, NULL);
 	if (rc < 0)
 		return rc;
-- 
2.26.2


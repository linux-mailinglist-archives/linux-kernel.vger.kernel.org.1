Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997931DB294
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 14:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgETMB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 08:01:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:14584 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbgETMB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:01:28 -0400
IronPort-SDR: Wl3syB6EnAeDvJLUW/0tan0arQuvQtlv6DKuwyuh1X/aKceWfBH3YhyxoecCXtzVr9feGT/9of
 t8+R8NtmVlPw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 05:01:27 -0700
IronPort-SDR: uzxLOKHXe9SE2HdBBCrz11GHuT8VoiLselYaXhYRPPoKgG0XNl1xSRf9jj3alBUfTxG+gRHZka
 wGeN+UdTN/Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,413,1583222400"; 
   d="scan'208";a="411996535"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 20 May 2020 05:01:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D5E6914E; Wed, 20 May 2020 15:01:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mircea Caprioru <mircea.caprioru@analog.com>,
        linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v1] mux: adgs1408: Add mod_devicetable.h and remove of_match_ptr
Date:   Wed, 20 May 2020 15:01:22 +0300
Message-Id: <20200520120122.67528-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables probing via the ACPI PRP0001 route but more is mostly about
removing examples of this that might get copied into new drivers.

Also fixes
  drivers/mux/adgs1408.c:112:34: warning: unused variable 'adgs1408_of_match
as has been reported recently.

Fixes: e9e40543ad5b ("spi: Add generic SPI multiplexer")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mux/adgs1408.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c
index 89096f10f4c4..12466b06692c 100644
--- a/drivers/mux/adgs1408.c
+++ b/drivers/mux/adgs1408.c
@@ -6,9 +6,9 @@
  */
 
 #include <linux/err.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mux/driver.h>
-#include <linux/of_platform.h>
 #include <linux/property.h>
 #include <linux/spi/spi.h>
 
@@ -59,7 +59,7 @@ static int adgs1408_probe(struct spi_device *spi)
 	s32 idle_state;
 	int ret;
 
-	chip_id = (enum adgs1408_chip_id)of_device_get_match_data(dev);
+	chip_id = (enum adgs1408_chip_id)device_get_match_data(dev);
 	if (!chip_id)
 		chip_id = spi_get_device_id(spi)->driver_data;
 
@@ -119,7 +119,7 @@ MODULE_DEVICE_TABLE(of, adgs1408_of_match);
 static struct spi_driver adgs1408_driver = {
 	.driver = {
 		.name = "adgs1408",
-		.of_match_table = of_match_ptr(adgs1408_of_match),
+		.of_match_table = adgs1408_of_match,
 	},
 	.probe = adgs1408_probe,
 	.id_table = adgs1408_spi_id,
-- 
2.26.2


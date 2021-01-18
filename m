Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179832FA19E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392254AbhARNaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392207AbhARN27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:28:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E77FF221ED;
        Mon, 18 Jan 2021 13:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610976499;
        bh=P5famsmNqxFy3kRdQiJ3S9R1bIcL68pOBNQEbAmhHFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9KjLklicGwZwiU6YsirGSc3BfcPHAYL2bhyhfOAp5zm0Rx236uFXRqFaI1pwbmyH
         WYjqcy5ygVrgpjt79N3eIQhtkHrh1BP/iRFwrO4xs2rTlFEajH2qvvJ5reGX19fh0t
         0s1xYEjy/iDf19+Tiv4ccULtUV7HxhHJWVspI+99eqehxD5AA5nacmDHatbtkx3Wr2
         oUJfBChCyG2C1MmeEIgt5K+hevgqmFTHXGNyX2YHtmtIKLoJVbf4gTyJYJAmvtp/uD
         J/Fa0DwuRR1QKOhJrwYl2uQRaC6PAuig22jxcpvhtTNtKT4/HD3riShd54bjrkTKr2
         +UXVB2QvQhPwQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1UZs-000Vki-Dv; Mon, 18 Jan 2021 14:28:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/13] staging: hikey9xx: hi6421v600-regulator: do some cleanups
Date:   Mon, 18 Jan 2021 14:28:04 +0100
Message-Id: <f6fb24c6a7f3a2820868aef6d085df93e7224295.1610975633.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610975633.git.mchehab+huawei@kernel.org>
References: <cover.1610975633.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use C99 comments at the beginning of the file and remove
uneeded includes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/hi6421v600-regulator.c   | 43 +++++++------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index 614b03c9ddfb..4ee0444b2b4e 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -1,41 +1,30 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Device driver for regulators in Hisi IC
- *
- * Copyright (c) 2013 Linaro Ltd.
- * Copyright (c) 2011 Hisilicon.
- *
- * Guodong Xu <guodong.xu@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+//
+// Device driver for regulators in Hisi IC
+//
+// Copyright (c) 2013 Linaro Ltd.
+// Copyright (c) 2011 Hisilicon.
+//
+// Guodong Xu <guodong.xu@linaro.org>
+//
+// This program is free software; you can redistribute it and/or modify
+// it under the terms of the GNU General Public License version 2 as
+// published by the Free Software Foundation.
+//
+// This program is distributed in the hope that it will be useful,
+// but WITHOUT ANY WARRANTY; without even the implied warranty of
+// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+// GNU General Public License for more details.
 
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/io.h>
 #include <linux/mfd/hi6421-spmi-pmic.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
 #include <linux/spmi.h>
-#include <linux/time.h>
-#include <linux/uaccess.h>
 
 #define rdev_dbg(rdev, fmt, arg...)	\
 		 pr_debug("%s: %s: " fmt, (rdev)->desc->name, __func__, ##arg)
-- 
2.29.2


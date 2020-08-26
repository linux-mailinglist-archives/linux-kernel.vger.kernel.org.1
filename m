Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0873C253389
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 17:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgHZPYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 11:24:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:33106 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbgHZPX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:23:59 -0400
IronPort-SDR: tO/hLou7WVK37JKV/8S9kO90s6vJFPZ1c7xCQfzx3cnBlaM8sARmSFoxUE0fzty9BmV/v1rZKg
 kuqkRhHZsY9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="241125959"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="241125959"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 08:23:44 -0700
IronPort-SDR: H0rijT/dpmI4L0i0byIEo0BNHcitpXMTRVQ0zS7qErMT7hXFX9PYJ8+aXo0fssRY/Mz7v7Bjdy
 wzVJuyi6dqiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="403094607"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2020 08:23:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 98250166; Wed, 26 Aug 2020 18:23:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] extcon: ptn5150: Deduplicate parts of dev_err_probe()
Date:   Wed, 26 Aug 2020 18:23:41 +0300
Message-Id: <20200826152341.56741-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() is designed to be used like

	return dev_err_probe(dev, ret, "Error message\n");

Hence no need to have a separate return statement. Besides that
dev_err_probe() prints already returned error code, no need to repeat
that either.

Cc: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
v2: dropped Fixed tag (Krzysztof)
 drivers/extcon/extcon-ptn5150.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 8ba706fad887..051bf374b43f 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -242,8 +242,7 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 			dev_info(dev, "No VBUS GPIO, ignoring VBUS control\n");
 			info->vbus_gpiod = NULL;
 		} else {
-			dev_err_probe(dev, ret, "failed to get VBUS GPIO\n");
-			return ret;
+			return dev_err_probe(dev, ret, "failed to get VBUS GPIO\n");
 		}
 	}
 
@@ -253,10 +252,8 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 
 	info->regmap = devm_regmap_init_i2c(i2c, &ptn5150_regmap_config);
 	if (IS_ERR(info->regmap)) {
-		ret = PTR_ERR(info->regmap);
-		dev_err_probe(info->dev, ret, "failed to allocate register map: %d\n",
-			      ret);
-		return ret;
+		return dev_err_probe(info->dev, PTR_ERR(info->regmap),
+				     "failed to allocate register map\n");
 	}
 
 	if (i2c->irq > 0) {
@@ -264,9 +261,8 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 	} else {
 		info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
 		if (IS_ERR(info->int_gpiod)) {
-			ret = PTR_ERR(info->int_gpiod);
-			dev_err_probe(dev, ret, "failed to get INT GPIO\n");
-			return ret;
+			return dev_err_probe(dev, PTR_ERR(info->int_gpiod),
+					     "failed to get INT GPIO\n");
 		}
 
 		info->irq = gpiod_to_irq(info->int_gpiod);
-- 
2.28.0


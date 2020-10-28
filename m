Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3321829D80C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387507AbgJ1W3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387529AbgJ1W3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:29:12 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6461D2070E;
        Wed, 28 Oct 2020 22:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603924152;
        bh=2kWIOEH/KcIuHZlj3LQjGfE/KRmEsQxNgUBxZTqQXR0=;
        h=From:To:Cc:Subject:Date:From;
        b=xAfMd+hX3L/aRRKqFpkAUWCsG/m9w8cTpR9m9a1o/TF2RBimn294+yDG9kUJb7G/S
         VPQ/gvTiOU+OG8nT8jlREUW7t+qQpCCk7yDgQUsjxUgu1si7v3PF5V3VwHjo0mcthz
         UoJvCtnhsG85n1LI9y6VaK6ZQ1/Z/CuSMGDWkxBg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [RESEND PATCH] mfd: sec: initialize driver via module_platform_driver
Date:   Wed, 28 Oct 2020 23:28:49 +0100
Message-Id: <20201028222849.365998-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was using subsys_initcall() because in old times deferred
probe was not supported everywhere and specific ordering was needed.
Since probe deferral works fine and specific ordering is discouraged
(hides dependencies between drivers and couples their boot order), the
driver can be converted to regular module_platform_driver.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mfd/sec-core.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index 7bfab43b455e..804f32d0ae22 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -549,19 +549,7 @@ static struct i2c_driver sec_pmic_driver = {
 	.shutdown = sec_pmic_shutdown,
 	.id_table = sec_pmic_id,
 };
-
-static int __init sec_pmic_init(void)
-{
-	return i2c_add_driver(&sec_pmic_driver);
-}
-
-subsys_initcall(sec_pmic_init);
-
-static void __exit sec_pmic_exit(void)
-{
-	i2c_del_driver(&sec_pmic_driver);
-}
-module_exit(sec_pmic_exit);
+module_i2c_driver(sec_pmic_driver);
 
 MODULE_AUTHOR("Sangbeom Kim <sbkim73@samsung.com>");
 MODULE_DESCRIPTION("Core support for the S5M MFD");
-- 
2.25.1


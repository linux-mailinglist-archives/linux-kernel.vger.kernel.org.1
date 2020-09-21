Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A4A27339B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 22:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgIUUfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 16:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgIUUfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 16:35:43 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C802C218AC;
        Mon, 21 Sep 2020 20:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600720543;
        bh=/wtETaXOWAeot366BdSSRX4NUfzVkmU//hz/ecaJgr4=;
        h=From:To:Subject:Date:From;
        b=mwLAQuWvlu4WJk8B43mBWwOIhB/muusT6C8FH599begb+hnQpBUTCCuF+obyhu2DR
         6uj3FZDo+2LIW1Fh3KcWaofCuvYYgBl2uvSjKdV/TIcn4r8qBYhNPVP20hhhjnsiM4
         bd8n5F9DNf3gOck5W6G6RuTeNgIZ/EsTJNOZ97xg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] mfd: sec: initialize driver via module_platform_driver
Date:   Mon, 21 Sep 2020 22:34:21 +0200
Message-Id: <20200921203421.19456-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was using subsys_initcall() because in old times deferred
probe was not supported everywhere and specific ordering was needed.
Since probe deferral works fine and specific ordering is discouraged
(hides dependencies between drivers and couples their boot order), the
driver can be converted to regular module_platform_driver.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/sec-core.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index 95473ff9bb4b..8d55992da19e 100644
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
2.17.1


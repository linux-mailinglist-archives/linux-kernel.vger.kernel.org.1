Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C936722BB22
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 02:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgGXAuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 20:50:19 -0400
Received: from mleia.com ([178.79.152.223]:35378 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgGXAuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 20:50:19 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 527DA3F9092;
        Fri, 24 Jul 2020 00:50:17 +0000 (UTC)
From:   Vladimir Zapolskiy <vz@mleia.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wen Yang <wenyang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: fix memory leak on error path of regulator_register()
Date:   Fri, 24 Jul 2020 03:50:13 +0300
Message-Id: <20200724005013.23278-1-vz@mleia.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20200724_005017_358293_61AE4293 
X-CRM114-Status: GOOD (  13.97  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change corrects registration and deregistration on error path
of a regulator, the problem was manifested by a reported memory
leak on deferred probe:

    as3722-regulator as3722-regulator: regulator 13 register failed -517

    # cat /sys/kernel/debug/kmemleak
    unreferenced object 0xecc43740 (size 64):
      comm "swapper/0", pid 1, jiffies 4294937640 (age 712.880s)
      hex dump (first 32 bytes):
        72 65 67 75 6c 61 74 6f 72 2e 32 34 00 5a 5a 5a  regulator.24.ZZZ
        5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
      backtrace:
        [<0c4c3d1c>] __kmalloc_track_caller+0x15c/0x2c0
        [<40c0ad48>] kvasprintf+0x64/0xd4
        [<109abd29>] kvasprintf_const+0x70/0x84
        [<c4215946>] kobject_set_name_vargs+0x34/0xa8
        [<62282ea2>] dev_set_name+0x40/0x64
        [<a39b6757>] regulator_register+0x3a4/0x1344
        [<16a9543f>] devm_regulator_register+0x4c/0x84
        [<51a4c6a1>] as3722_regulator_probe+0x294/0x754
        ...

The memory leak problem was introduced as a side ef another fix in
regulator_register() error path, I believe that the proper fix is
to decouple device_register() function into its two compounds and
initialize a struct device before assigning any values to its fields
and then using it before actual registration of a device happens.

This lets to call put_device() safely after initialization, and, since
now a release callback is called, kfree(rdev->constraints) shall be
removed to exclude a double free condition.

Fixes: a3cde9534ebd ("regulator: core: fix regulator_register() error paths to properly release rdev")
Cc: Wen Yang <wenyang@linux.alibaba.com>
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/regulator/core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 03154f5b939f..720f28844795 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5023,7 +5023,6 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	struct regulator_dev *rdev;
 	bool dangling_cfg_gpiod = false;
 	bool dangling_of_gpiod = false;
-	bool reg_device_fail = false;
 	struct device *dev;
 	int ret, i;
 
@@ -5152,10 +5151,12 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	}
 
 	/* register with sysfs */
+	device_initialize(&rdev->dev);
 	rdev->dev.class = &regulator_class;
 	rdev->dev.parent = dev;
 	dev_set_name(&rdev->dev, "regulator.%lu",
 		    (unsigned long) atomic_inc_return(&regulator_no));
+	dev_set_drvdata(&rdev->dev, rdev);
 
 	/* set regulator constraints */
 	if (init_data)
@@ -5206,12 +5207,9 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	    !rdev->desc->fixed_uV)
 		rdev->is_switch = true;
 
-	dev_set_drvdata(&rdev->dev, rdev);
-	ret = device_register(&rdev->dev);
-	if (ret != 0) {
-		reg_device_fail = true;
+	ret = device_add(&rdev->dev);
+	if (ret != 0)
 		goto unset_supplies;
-	}
 
 	rdev_init_debugfs(rdev);
 
@@ -5233,17 +5231,15 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	mutex_unlock(&regulator_list_mutex);
 wash:
 	kfree(rdev->coupling_desc.coupled_rdevs);
-	kfree(rdev->constraints);
 	mutex_lock(&regulator_list_mutex);
 	regulator_ena_gpio_free(rdev);
 	mutex_unlock(&regulator_list_mutex);
+	put_device(&rdev->dev);
+	rdev = NULL;
 clean:
 	if (dangling_of_gpiod)
 		gpiod_put(config->ena_gpiod);
-	if (reg_device_fail)
-		put_device(&rdev->dev);
-	else
-		kfree(rdev);
+	kfree(rdev);
 	kfree(config);
 rinse:
 	if (dangling_cfg_gpiod)
-- 
2.24.0


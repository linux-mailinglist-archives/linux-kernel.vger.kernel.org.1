Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670D32A75C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 03:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbgKECwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 21:52:41 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:14289 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgKECwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 21:52:40 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CRSjx6Kltz8p;
        Thu,  5 Nov 2020 03:52:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1604544758; bh=zWJe/U1Epyy7S+Cs2A5ju86zEkutJ8zcTgNOaF6A/oU=;
        h=Date:From:Subject:To:Cc:From;
        b=SlcXh3ie+RLph1tRZabd/RNnRS+Aj7j1X5unc34ffB133GuuN9ma5/lf5RiFeTaQ4
         n515wgWoRo9V+Mmmz6YTFf/xEytrMsPtbaYHS/x57zkfARfq4ECjqxrNzCtCjWyvfo
         bmd6Aa106nQhlG8QQqCJaP59rmwE1mHkfaSThLoR30p9bhfK7CjoxBOpnbYNoU58on
         9dyAW6fSVoHrGbqJudllYCbDyQCFyRwdurGYb5vk32c1Y/M+zpw4seAlzmV3mRGc5M
         truPjSdn3C8Xxj3vhAi1h1vgjS2pLHREiiKYI/iSr3jJ9wHPsLEiL8Z3QTENcvij6o
         mEsHQ9ruGYzOw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Thu, 05 Nov 2020 03:52:35 +0100
Message-Id: <a199f158291a47de1d2d87482855802e3ff29494.1604544068.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] regulator: fix memory leak with repeated
 set_machine_constraints()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed commit introduced a possible second call to
set_machine_constraints() and that allocates memory for
rdev->constraints. Move the allocation to the caller so
it's easier to manage and done once.

Fixes: aea6cb99703e ("regulator: resolve supply after creating regulator")
Cc: stable@vger.kernel.org
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 8521f74ee75c..402a72a70eb1 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1290,7 +1290,6 @@ static int _regulator_do_enable(struct regulator_dev *rdev);
 /**
  * set_machine_constraints - sets regulator constraints
  * @rdev: regulator source
- * @constraints: constraints to apply
  *
  * Allows platform initialisation code to define and constrain
  * regulator circuits e.g. valid voltage/current ranges, etc.  NOTE:
@@ -1298,21 +1297,11 @@ static int _regulator_do_enable(struct regulator_dev *rdev);
  * regulator operations to proceed i.e. set_voltage, set_current_limit,
  * set_mode.
  */
-static int set_machine_constraints(struct regulator_dev *rdev,
-	const struct regulation_constraints *constraints)
+static int set_machine_constraints(struct regulator_dev *rdev)
 {
 	int ret = 0;
 	const struct regulator_ops *ops = rdev->desc->ops;
 
-	if (constraints)
-		rdev->constraints = kmemdup(constraints, sizeof(*constraints),
-					    GFP_KERNEL);
-	else
-		rdev->constraints = kzalloc(sizeof(*constraints),
-					    GFP_KERNEL);
-	if (!rdev->constraints)
-		return -ENOMEM;
-
 	ret = machine_constraints_voltage(rdev, rdev->constraints);
 	if (ret != 0)
 		return ret;
@@ -5121,7 +5110,6 @@ struct regulator_dev *
 regulator_register(const struct regulator_desc *regulator_desc,
 		   const struct regulator_config *cfg)
 {
-	const struct regulation_constraints *constraints = NULL;
 	const struct regulator_init_data *init_data;
 	struct regulator_config *config = NULL;
 	static atomic_t regulator_no = ATOMIC_INIT(-1);
@@ -5260,14 +5248,23 @@ regulator_register(const struct regulator_desc *regulator_desc,
 
 	/* set regulator constraints */
 	if (init_data)
-		constraints = &init_data->constraints;
+		rdev->constraints = kmemdup(&init_data->constraints,
+					    sizeof(*rdev->constraints),
+					    GFP_KERNEL);
+	else
+		rdev->constraints = kzalloc(sizeof(*rdev->constraints),
+					    GFP_KERNEL);
+	if (!rdev->constraints) {
+		ret = -ENOMEM;
+		goto wash;
+	}
 
 	if (init_data && init_data->supply_regulator)
 		rdev->supply_name = init_data->supply_regulator;
 	else if (regulator_desc->supply_name)
 		rdev->supply_name = regulator_desc->supply_name;
 
-	ret = set_machine_constraints(rdev, constraints);
+	ret = set_machine_constraints(rdev);
 	if (ret == -EPROBE_DEFER) {
 		/* Regulator might be in bypass mode and so needs its supply
 		 * to set the constraints */
@@ -5276,7 +5273,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		 * that is just being created */
 		ret = regulator_resolve_supply(rdev);
 		if (!ret)
-			ret = set_machine_constraints(rdev, constraints);
+			ret = set_machine_constraints(rdev);
 		else
 			rdev_dbg(rdev, "unable to resolve supply early: %pe\n",
 				 ERR_PTR(ret));
-- 
2.20.1


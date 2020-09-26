Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E063279CAB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 23:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgIZVcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 17:32:52 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:64271 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIZVco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 17:32:44 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BzMSm6TLPz2KM;
        Sat, 26 Sep 2020 23:32:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1601155960; bh=/irEh+hidb7pQ6LBoBGLiJkcqr56sMmIS5Kqs5CaziY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=WO2l3J+LYqks9am0345GbQ95WJ2Yt4sC0BQNYiMU9FjfsONL/LEJ8rv7JJY10cDnR
         xwkNEGC/QyMGfRmiVh4SMOG128Q5pf6HtdQAzgws0VQRW1LwwTLVgi8WkS951IA9w8
         IjNVvHgXQHTcySOocoFF5wELSDsmbDqKTkbTR9N8EFl51Stv+RLAsT5+3ZexckxWNZ
         5ftrtnLbyJa75iXiikUGBWdubyPMwlp/X4+NuPph+HUzFyqT6NBkeXAJ9sBGxszDvy
         dpGjQo4aqTr9alQm5N2o+cAnir/OoaoNOFLsXWynjOguNL76z3jmLJt8lnECblLuFH
         TsxUzUXjEuNsQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sat, 26 Sep 2020 23:32:40 +0200
Message-Id: <1dcf25f39188882eb56918a9aa281ab17b792aa5.1601155770.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1601155770.git.mirq-linux@rere.qmqm.pl>
References: <cover.1601155770.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/3] regulator: print symbolic errors in kernel messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change all error-printing messages to include error name via %pe instead
of numeric error or nothing.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 94 +++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index bf88d74f5401..6b56a22fd37f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -967,7 +967,8 @@ static int drms_uA_update(struct regulator_dev *rdev)
 		/* set the optimum mode for our new total regulator load */
 		err = rdev->desc->ops->set_load(rdev, current_uA);
 		if (err < 0)
-			rdev_err(rdev, "failed to set load %d\n", current_uA);
+			rdev_err(rdev, "failed to set load %d: %pe\n",
+				 current_uA, ERR_PTR(err));
 	} else {
 		/* get output voltage */
 		output_uV = regulator_get_voltage_rdev(rdev);
@@ -994,14 +995,15 @@ static int drms_uA_update(struct regulator_dev *rdev)
 		/* check the new mode is allowed */
 		err = regulator_mode_constrain(rdev, &mode);
 		if (err < 0) {
-			rdev_err(rdev, "failed to get optimum mode @ %d uA %d -> %d uV\n",
-				 current_uA, input_uV, output_uV);
+			rdev_err(rdev, "failed to get optimum mode @ %d uA %d -> %d uV: %pe\n",
+				 current_uA, input_uV, output_uV, ERR_PTR(err));
 			return err;
 		}
 
 		err = rdev->desc->ops->set_mode(rdev, mode);
 		if (err < 0)
-			rdev_err(rdev, "failed to set optimum mode %x\n", mode);
+			rdev_err(rdev, "failed to set optimum mode %x: %pe\n",
+				 mode, ERR_PTR(err));
 	}
 
 	return err;
@@ -1022,14 +1024,14 @@ static int __suspend_set_state(struct regulator_dev *rdev,
 		ret = 0;
 
 	if (ret < 0) {
-		rdev_err(rdev, "failed to enabled/disable\n");
+		rdev_err(rdev, "failed to enabled/disable: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	if (rdev->desc->ops->set_suspend_voltage && rstate->uV > 0) {
 		ret = rdev->desc->ops->set_suspend_voltage(rdev, rstate->uV);
 		if (ret < 0) {
-			rdev_err(rdev, "failed to set voltage\n");
+			rdev_err(rdev, "failed to set voltage: %pe\n", ERR_PTR(ret));
 			return ret;
 		}
 	}
@@ -1037,7 +1039,7 @@ static int __suspend_set_state(struct regulator_dev *rdev,
 	if (rdev->desc->ops->set_suspend_mode && rstate->mode > 0) {
 		ret = rdev->desc->ops->set_suspend_mode(rdev, rstate->mode);
 		if (ret < 0) {
-			rdev_err(rdev, "failed to set mode\n");
+			rdev_err(rdev, "failed to set mode: %pe\n", ERR_PTR(ret));
 			return ret;
 		}
 	}
@@ -1157,8 +1159,8 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 
 		if (current_uV < 0) {
 			rdev_err(rdev,
-				 "failed to get the current voltage(%d)\n",
-				 current_uV);
+				 "failed to get the current voltage: %pe\n",
+				 ERR_PTR(current_uV));
 			return current_uV;
 		}
 
@@ -1187,8 +1189,8 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 				rdev, target_min, target_max);
 			if (ret < 0) {
 				rdev_err(rdev,
-					"failed to apply %d-%duV constraint(%d)\n",
-					target_min, target_max, ret);
+					"failed to apply %d-%duV constraint: %pe\n",
+					target_min, target_max, ERR_PTR(ret));
 				return ret;
 			}
 		}
@@ -1337,7 +1339,7 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		ret = ops->set_input_current_limit(rdev,
 						   rdev->constraints->ilim_uA);
 		if (ret < 0) {
-			rdev_err(rdev, "failed to set input limit\n");
+			rdev_err(rdev, "failed to set input limit: %pe\n", ERR_PTR(ret));
 			return ret;
 		}
 	}
@@ -1346,7 +1348,7 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 	if (rdev->constraints->initial_state) {
 		ret = suspend_set_initial_state(rdev);
 		if (ret < 0) {
-			rdev_err(rdev, "failed to set suspend state\n");
+			rdev_err(rdev, "failed to set suspend state: %pe\n", ERR_PTR(ret));
 			return ret;
 		}
 	}
@@ -1359,7 +1361,7 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 
 		ret = ops->set_mode(rdev, rdev->constraints->initial_mode);
 		if (ret < 0) {
-			rdev_err(rdev, "failed to set initial mode: %d\n", ret);
+			rdev_err(rdev, "failed to set initial mode: %pe\n", ERR_PTR(ret));
 			return ret;
 		}
 	} else if (rdev->constraints->system_load) {
@@ -1374,7 +1376,7 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		&& ops->set_ramp_delay) {
 		ret = ops->set_ramp_delay(rdev, rdev->constraints->ramp_delay);
 		if (ret < 0) {
-			rdev_err(rdev, "failed to set ramp_delay\n");
+			rdev_err(rdev, "failed to set ramp_delay: %pe\n", ERR_PTR(ret));
 			return ret;
 		}
 	}
@@ -1382,7 +1384,7 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 	if (rdev->constraints->pull_down && ops->set_pull_down) {
 		ret = ops->set_pull_down(rdev);
 		if (ret < 0) {
-			rdev_err(rdev, "failed to set pull down\n");
+			rdev_err(rdev, "failed to set pull down: %pe\n", ERR_PTR(ret));
 			return ret;
 		}
 	}
@@ -1390,7 +1392,7 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 	if (rdev->constraints->soft_start && ops->set_soft_start) {
 		ret = ops->set_soft_start(rdev);
 		if (ret < 0) {
-			rdev_err(rdev, "failed to set soft start\n");
+			rdev_err(rdev, "failed to set soft start: %pe\n", ERR_PTR(ret));
 			return ret;
 		}
 	}
@@ -1399,7 +1401,8 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		&& ops->set_over_current_protection) {
 		ret = ops->set_over_current_protection(rdev);
 		if (ret < 0) {
-			rdev_err(rdev, "failed to set over current protection\n");
+			rdev_err(rdev, "failed to set over current protection: %pe\n",
+				 ERR_PTR(ret));
 			return ret;
 		}
 	}
@@ -1410,7 +1413,7 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 
 		ret = ops->set_active_discharge(rdev, ad_state);
 		if (ret < 0) {
-			rdev_err(rdev, "failed to set active discharge\n");
+			rdev_err(rdev, "failed to set active discharge: %pe\n", ERR_PTR(ret));
 			return ret;
 		}
 	}
@@ -1430,7 +1433,7 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 
 		ret = _regulator_do_enable(rdev);
 		if (ret < 0 && ret != -EINVAL) {
-			rdev_err(rdev, "failed to enable\n");
+			rdev_err(rdev, "failed to enable: %pe\n", ERR_PTR(ret));
 			return ret;
 		}
 
@@ -1654,8 +1657,8 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 		err = sysfs_create_link_nowarn(&rdev->dev.kobj, &dev->kobj,
 					       supply_name);
 		if (err) {
-			rdev_dbg(rdev, "could not add device link %s err %d\n",
-				  dev->kobj.name, err);
+			rdev_dbg(rdev, "could not add device link %s: %pe\n",
+				  dev->kobj.name, ERR_PTR(err));
 			/* non-fatal */
 		}
 	}
@@ -2443,7 +2446,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 	if (ret >= 0) {
 		delay = ret;
 	} else {
-		rdev_warn(rdev, "enable_time() failed: %d\n", ret);
+		rdev_warn(rdev, "enable_time() failed: %pe\n", ERR_PTR(ret));
 		delay = 0;
 	}
 
@@ -2632,7 +2635,7 @@ static int _regulator_enable(struct regulator *regulator)
 			_notifier_call_chain(rdev, REGULATOR_EVENT_ENABLE,
 					     NULL);
 		} else if (ret < 0) {
-			rdev_err(rdev, "is_enabled() failed: %d\n", ret);
+			rdev_err(rdev, "is_enabled() failed: %pe\n", ERR_PTR(ret));
 			goto err_consumer_disable;
 		}
 		/* Fallthrough on positive return values - already enabled */
@@ -2734,7 +2737,7 @@ static int _regulator_disable(struct regulator *regulator)
 
 			ret = _regulator_do_disable(rdev);
 			if (ret < 0) {
-				rdev_err(rdev, "failed to disable\n");
+				rdev_err(rdev, "failed to disable: %pe\n", ERR_PTR(ret));
 				_notifier_call_chain(rdev,
 						REGULATOR_EVENT_ABORT_DISABLE,
 						NULL);
@@ -2801,7 +2804,7 @@ static int _regulator_force_disable(struct regulator_dev *rdev)
 
 	ret = _regulator_do_disable(rdev);
 	if (ret < 0) {
-		rdev_err(rdev, "failed to force disable\n");
+		rdev_err(rdev, "failed to force disable: %pe\n", ERR_PTR(ret));
 		_notifier_call_chain(rdev, REGULATOR_EVENT_FORCE_DISABLE |
 				REGULATOR_EVENT_ABORT_DISABLE, NULL);
 		return ret;
@@ -2880,7 +2883,8 @@ static void regulator_disable_work(struct work_struct *work)
 		for (i = 0; i < count; i++) {
 			ret = _regulator_disable(regulator);
 			if (ret != 0)
-				rdev_err(rdev, "Deferred disable failed: %d\n", ret);
+				rdev_err(rdev, "Deferred disable failed: %pe\n",
+					 ERR_PTR(ret));
 		}
 	}
 	WARN_ON(!total_count);
@@ -3405,7 +3409,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 	}
 
 	if (delay < 0) {
-		rdev_warn(rdev, "failed to get delay: %d\n", delay);
+		rdev_warn(rdev, "failed to get delay: %pe\n", ERR_PTR(delay));
 		delay = 0;
 	}
 
@@ -3557,8 +3561,8 @@ int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 		ret = regulator_set_voltage_unlocked(rdev->supply,
 				best_supply_uV, INT_MAX, state);
 		if (ret) {
-			dev_err(&rdev->dev, "Failed to increase supply voltage: %d\n",
-					ret);
+			dev_err(&rdev->dev, "Failed to increase supply voltage: %pe\n",
+				ERR_PTR(ret));
 			goto out;
 		}
 	}
@@ -3575,8 +3579,8 @@ int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 		ret = regulator_set_voltage_unlocked(rdev->supply,
 				best_supply_uV, INT_MAX, state);
 		if (ret)
-			dev_warn(&rdev->dev, "Failed to decrease supply voltage: %d\n",
-					ret);
+			dev_warn(&rdev->dev, "Failed to decrease supply voltage: %pe\n",
+				 ERR_PTR(ret));
 		/* No need to fail here */
 		ret = 0;
 	}
@@ -4562,8 +4566,8 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
 
 err:
 	if (ret != -EPROBE_DEFER)
-		dev_err(dev, "Failed to get supply '%s': %d\n",
-			consumers[i].supply, ret);
+		dev_err(dev, "Failed to get supply '%s': %pe\n",
+			consumers[i].supply, ERR_PTR(ret));
 	else
 		dev_dbg(dev, "Failed to get supply '%s', deferring\n",
 			consumers[i].supply);
@@ -4621,8 +4625,8 @@ int regulator_bulk_enable(int num_consumers,
 err:
 	for (i = 0; i < num_consumers; i++) {
 		if (consumers[i].ret < 0)
-			pr_err("Failed to enable %s: %d\n", consumers[i].supply,
-			       consumers[i].ret);
+			pr_err("Failed to enable %s: %pe\n", consumers[i].supply,
+			       ERR_PTR(consumers[i].ret));
 		else
 			regulator_disable(consumers[i].consumer);
 	}
@@ -4658,12 +4662,12 @@ int regulator_bulk_disable(int num_consumers,
 	return 0;
 
 err:
-	pr_err("Failed to disable %s: %d\n", consumers[i].supply, ret);
+	pr_err("Failed to disable %s: %pe\n", consumers[i].supply, ERR_PTR(ret));
 	for (++i; i < num_consumers; ++i) {
 		r = regulator_enable(consumers[i].consumer);
 		if (r != 0)
-			pr_err("Failed to re-enable %s: %d\n",
-			       consumers[i].supply, r);
+			pr_err("Failed to re-enable %s: %pe\n",
+			       consumers[i].supply, ERR_PTR(r));
 	}
 
 	return ret;
@@ -5042,8 +5046,8 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
 	if (coupler && coupler->detach_regulator) {
 		err = coupler->detach_regulator(coupler, rdev);
 		if (err)
-			rdev_err(rdev, "failed to detach from coupler: %d\n",
-				 err);
+			rdev_err(rdev, "failed to detach from coupler: %pe\n",
+				 ERR_PTR(err));
 	}
 
 	kfree(rdev->coupling_desc.coupled_rdevs);
@@ -5087,7 +5091,7 @@ static int regulator_init_coupling(struct regulator_dev *rdev)
 
 	if (IS_ERR(rdev->coupling_desc.coupler)) {
 		err = PTR_ERR(rdev->coupling_desc.coupler);
-		rdev_err(rdev, "failed to get coupler: %d\n", err);
+		rdev_err(rdev, "failed to get coupler: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
@@ -5250,8 +5254,8 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	if (config->ena_gpiod) {
 		ret = regulator_ena_gpio_request(rdev, config);
 		if (ret != 0) {
-			rdev_err(rdev, "Failed to request enable GPIO: %d\n",
-				 ret);
+			rdev_err(rdev, "Failed to request enable GPIO: %pe\n",
+				 ERR_PTR(ret));
 			goto clean;
 		}
 		/* The regulator core took over the GPIO descriptor */
@@ -5836,7 +5840,7 @@ static int regulator_late_cleanup(struct device *dev, void *data)
 		rdev_info(rdev, "disabling\n");
 		ret = _regulator_do_disable(rdev);
 		if (ret != 0)
-			rdev_err(rdev, "couldn't disable: %d\n", ret);
+			rdev_err(rdev, "couldn't disable: %pe\n", ERR_PTR(ret));
 	} else {
 		/* The intention is that in future we will
 		 * assume that full constraints are provided
-- 
2.20.1


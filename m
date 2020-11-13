Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E4C2B132D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKMAUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:20:31 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:13192 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgKMAU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:20:29 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CXJyg2XHyzKj;
        Fri, 13 Nov 2020 01:20:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1605226827; bh=V7HSPNSozpIXr1ujMh8djMuILzn4otXrS7tNpH0CxW8=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=X7fewpZiLRISra8a+7M37SslDkjSNvkIQwAyr001ioILw7vku+3wcym9IFFyz6JL0
         LaNKuodVX//mrqARlbvvAAuQrnvdl4S7azcJgDy6GvW8ikcyAFdREIpscdRicLahCG
         JLZo/VUcXrzJuxNdNpDngzfVYRxtqupzN7+rpZlhMp6kXnnfhvZ0pRnLjZffTcmpYz
         gjdd0CpaIjQdhoP16NVl2nfBd4QERSlhGl7xubWOliVcJy1alS9ntqn+4WBAlLAPZd
         QW9ozJZWRpDPZK7AsebSjZiWzL3RcmfFYcBEj/tx/KHUwP+ObNlJQBuC1rBK2nahe+
         BwHSRjRrfFgWQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Fri, 13 Nov 2020 01:20:27 +0100
Message-Id: <78c3d4016cebc08d441aad18cb924b4e4d9cf9df.1605226675.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1605226675.git.mirq-linux@rere.qmqm.pl>
References: <cover.1605226675.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH RESEND 1/4] regulator: fix memory leak with repeated
 set_machine_constraints()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
index 2e1ea18221ef..bcd64ba21fb9 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1315,7 +1315,6 @@ static int _regulator_do_enable(struct regulator_dev *rdev);
 /**
  * set_machine_constraints - sets regulator constraints
  * @rdev: regulator source
- * @constraints: constraints to apply
  *
  * Allows platform initialisation code to define and constrain
  * regulator circuits e.g. valid voltage/current ranges, etc.  NOTE:
@@ -1323,21 +1322,11 @@ static int _regulator_do_enable(struct regulator_dev *rdev);
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
@@ -5146,7 +5135,6 @@ struct regulator_dev *
 regulator_register(const struct regulator_desc *regulator_desc,
 		   const struct regulator_config *cfg)
 {
-	const struct regulation_constraints *constraints = NULL;
 	const struct regulator_init_data *init_data;
 	struct regulator_config *config = NULL;
 	static atomic_t regulator_no = ATOMIC_INIT(-1);
@@ -5285,14 +5273,23 @@ regulator_register(const struct regulator_desc *regulator_desc,
 
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
@@ -5301,7 +5298,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
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


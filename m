Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F34279CAA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 23:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgIZVcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 17:32:47 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:44381 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgIZVcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 17:32:45 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BzMSn3zLwz2KQ;
        Sat, 26 Sep 2020 23:32:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1601155961; bh=yjW/YkTtfoxUSEufTrCdNzGAG3DmVwt9dXwIVmLLdBk=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=OS9/Urme9gevsQ3P1Bbeo/BFJPV0/sVuic+L/qGf9QkaZwsv90eTAclTMTcVrQW8Q
         oP+ZimuCwPx0b9DrQSVlZhWos2l27IkudrOW/8psDBlaae+s2J8CwYThKAt9vEsVxE
         PYiUXSyDL1vgvEr/ZKfluo7UO9T9U+BBESCnmkYKIU/Wf66XtwVSnlUTkmkJaA+MLS
         705D8pB87UhKRw08dynOdhBNRwUo2HBM3Uw0zncqfgok6N8vOmgBxv14g8Cf02PVMc
         IhuvRdwomy3axPdAkVqPSo7JYDAUS7Okpkloao5iW6V+bGom9KutqQDrkLoAd5rI39
         JrwcwyIGDB2Uw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sat, 26 Sep 2020 23:32:41 +0200
Message-Id: <ba09e0a8617ffeeb25cb4affffe6f3149319cef8.1601155770.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1601155770.git.mirq-linux@rere.qmqm.pl>
References: <cover.1601155770.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/3] regulator: resolve supply after creating regulator
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating a new regulator its supply cannot create the sysfs link
because the device is not yet published. Remove early supply resolving
since it will be done later anyway. This makes the following error
disappear and the symlinks get created instead.

  DCDC_REG1: supplied by VSYS
  VSYS: could not add device link regulator.3 err -2

Note: It doesn't fix the problem for bypassed regulators, though.

Fixes: 45389c47526d ("regulator: core: Add early supply resolution for regulators")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6b56a22fd37f..607c2a76bb60 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5279,15 +5279,20 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	else if (regulator_desc->supply_name)
 		rdev->supply_name = regulator_desc->supply_name;
 
-	/*
-	 * Attempt to resolve the regulator supply, if specified,
-	 * but don't return an error if we fail because we will try
-	 * to resolve it again later as more regulators are added.
-	 */
-	if (regulator_resolve_supply(rdev))
-		rdev_dbg(rdev, "unable to resolve supply\n");
-
 	ret = set_machine_constraints(rdev, constraints);
+	if (ret == -EPROBE_DEFER) {
+		/* Regulator might be in bypass mode and so needs its supply
+		 * to set the constraints */
+		/* FIXME: this currently triggers a chicken-and-egg problem
+		 * when creating -SUPPLY symlink in sysfs to a regulator
+		 * that is just being created */
+		ret = regulator_resolve_supply(rdev);
+		if (!ret)
+			ret = set_machine_constraints(rdev, constraints);
+		else
+			rdev_dbg(rdev, "unable to resolve supply early: %pe\n",
+				 ERR_PTR(ret));
+	}
 	if (ret < 0)
 		goto wash;
 
-- 
2.20.1


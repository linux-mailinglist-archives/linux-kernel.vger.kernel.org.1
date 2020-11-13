Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD4B2B1323
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKMARY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:17:24 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:16396 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgKMAQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:16:52 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CXJtW0dPfzkL;
        Fri, 13 Nov 2020 01:16:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1605226611; bh=GU5qJ1nTeXHIDvDBgFSSbRsT2IkPhz3ghAkGAasa5UQ=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=IzlFN8fmmsWs4LZtqIXKKD9EGAyCm/uCe6GPTww7rSjai4h114WlMOv1t5xoUToGl
         Cz1NcitRrhxfb+gjm2fdVpOe9GpurNzX2StKz8mCNfCVVgMXCBNVaOSX1Mz3riB2gr
         yQqjqN29ngXChyKguYtsya3xJP/WxDcj12zpw/sGXnH3XgybXFp1gy+8L0polXCD7Q
         ICWHUBlmcRXWTl4N3RkvS0M0sBmv//107KXxafWyDUKWlN1ARrGkAdETNtMnKSFgYm
         jOp/D67yGHfxfOQeudnDpCpcNkwI+o5wu7T+ojuepFHMClMtdJ8qKhbJiUVkvhwL8W
         /mVnI0LOeUbjw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Fri, 13 Nov 2020 01:16:50 +0100
Message-Id: <6e250bd5d444db3afd010b1ce66db9843a9114d1.1605225991.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1605225991.git.mirq-linux@rere.qmqm.pl>
References: <cover.1605225991.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 4/4] regulator: workaround self-referent regulators
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Workaround regulators whose supply name happens to be the same as its
own name. This fixes boards that used to work before the early supply
resolving was removed. The error message is left in place so that
offending drivers can be detected.

Fixes: aea6cb99703e ("regulator: resolve supply after creating regulator")
Cc: stable@vger.kernel.org
Reported-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ab922ed273f3..38ba579efe2b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1844,7 +1844,10 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	if (r == rdev) {
 		dev_err(dev, "Supply for %s (%s) resolved to itself\n",
 			rdev->desc->name, rdev->supply_name);
-		return -EINVAL;
+		if (!have_full_constraints())
+			return -EINVAL;
+		r = dummy_regulator_rdev;
+		get_device(&r->dev);
 	}
 
 	/*
-- 
2.20.1


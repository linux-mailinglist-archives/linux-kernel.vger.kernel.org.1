Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6402B131B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgKMAQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:16:55 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:58777 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgKMAQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:16:52 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CXJtV3P4WzZx;
        Fri, 13 Nov 2020 01:16:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1605226610; bh=v/N+ke/pAmzjcPwPxtjEP2gk5NrcB9U2EpCsm2ZUup4=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=E2VXw3pHSyNHddidLaJ6ET8ftTfWSuB/JiQU8MG+So+i6bwXxTJfzlPdhoaC+VJPR
         nfYng5wBIWDvDHFJrEBNtVbpOe73+mpweR2WHCo5tIrzmK8f5P682BzTNrKN+24kFv
         KorNApxtuWx42fkHHDqDcM3K0TNdWEwypeBX8G2/9Fe4dQm2aU3gIRYYsfbFyGBiBE
         aAr/6i/Wk3nMXhvDcBFSYhrW0yILHkl6pFqRU1KD/2KXNoYDPHl5tJgWZu87W4HtM5
         /iUunAvCZv9V3TZMV/msjnCxlsr03VirHwU9W7N/g2t7AQ/y7T5lmqn37QWUVQEr2x
         Az4vNGbgvL/tA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Fri, 13 Nov 2020 01:16:49 +0100
Message-Id: <c6171057cfc0896f950c4d8cb82df0f9f1b89ad9.1605225991.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1605225991.git.mirq-linux@rere.qmqm.pl>
References: <cover.1605225991.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/4] regulator: avoid resolve_supply() infinite recursion
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a regulator's name equals its supply's name the
regulator_resolve_supply() recurses indefinitely. Add a check
so that debugging the problem is easier. The "fixed" commit
just exposed the problem.

Fixes: aea6cb99703e ("regulator: resolve supply after creating regulator")
Cc: stable@vger.kernel.org
Reported-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ad36f03d7ee6..ab922ed273f3 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1841,6 +1841,12 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		}
 	}
 
+	if (r == rdev) {
+		dev_err(dev, "Supply for %s (%s) resolved to itself\n",
+			rdev->desc->name, rdev->supply_name);
+		return -EINVAL;
+	}
+
 	/*
 	 * If the supply's parent device is not the same as the
 	 * regulator's parent device, then ensure the parent device
-- 
2.20.1


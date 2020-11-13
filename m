Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017B62B131C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKMAQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:16:57 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:9500 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgKMAQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:16:52 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CXJtT6DgnzKw;
        Fri, 13 Nov 2020 01:16:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1605226609; bh=DQRcuEJmpEK6o+KN0OiQBuiYhpkks7VZqxdk2Ek0AWU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=YYxtC1kmdWVZ3xr5cD1zRoELvC7rZkROyLKFuOfxAbs0W91qdjIHpo00Ai1zf+BmQ
         xZoa534YZk/Tz7r6P6f+aMw0z+/9M4f1RCiLq+1LWjtWHVcVhkJTS271XgJApGsEnJ
         AgfHbkoUgNcvpdv2o3aLupeQOIYhzFx0eREhngkGHon8Ezv4UVmbT9JIIjx2Bd0qSk
         JB2LY82js6XmXIfhtQvQwCwNyvAYDreM/+h+WTOntUpOIl1BPdf+1m4yixrUapd4hD
         JOyo1W2zStLi+Ytq+vsTLr5ICcsPkZtjiEh5ufnLLpI3ljF6VCgrDvbkode5fHytJ9
         qK1lSFIiaLw5A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Fri, 13 Nov 2020 01:16:49 +0100
Message-Id: <f9cba575580369e46661a9278ee6c6a8d8564c2a.1605225991.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1605225991.git.mirq-linux@rere.qmqm.pl>
References: <cover.1605225991.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/4] regulator: debug early supply resolving
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

Help debugging the case when set_machine_constraints() needs to be
repeated.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index bcd64ba21fb9..ad36f03d7ee6 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5296,6 +5296,8 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		/* FIXME: this currently triggers a chicken-and-egg problem
 		 * when creating -SUPPLY symlink in sysfs to a regulator
 		 * that is just being created */
+		rdev_dbg(rdev, "will resolve supply early: %s\n",
+			 rdev->supply_name);
 		ret = regulator_resolve_supply(rdev);
 		if (!ret)
 			ret = set_machine_constraints(rdev);
-- 
2.20.1


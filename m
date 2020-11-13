Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101022B132E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgKMAUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:20:32 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:43287 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgKMAU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:20:29 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CXJyh0FNGzKw;
        Fri, 13 Nov 2020 01:20:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1605226828; bh=DQRcuEJmpEK6o+KN0OiQBuiYhpkks7VZqxdk2Ek0AWU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=p9UzMwxtzT4ZcN6g65oZQDvCBwJ3whwWsDb+81YPMHLMOsyFvw9cGeBZdZnMLfk8Q
         bbqTWjN14DnCiSHjazEBXRTiJyXJD4SS/3loJRrXRnUEM3jrGjNnaAeW1RqPZlL9AI
         LqlNumry4QbfrsDlrjCHy7YT3q1G2+9ytF140OCkO3QCWbK4GCkB4F0IHah51Xh+x9
         fh+MtiDaCUjyIyghZlpF18BOaYgGzs+dYT9xw1nXxeiu5yEzw7SkIMClGCnb4ZGn0j
         KlpCkDVJdhPZzyV1848xUpxF37DM40c7UqavvpNWx/VdFhuk2eiI19K4sX3b1ugQbE
         ox72bn/FfmmuA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Fri, 13 Nov 2020 01:20:27 +0100
Message-Id: <f9cba575580369e46661a9278ee6c6a8d8564c2a.1605226675.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1605226675.git.mirq-linux@rere.qmqm.pl>
References: <cover.1605226675.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH RESEND 2/4] regulator: debug early supply resolving
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


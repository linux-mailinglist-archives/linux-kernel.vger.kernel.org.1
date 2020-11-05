Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8CC2A75C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 03:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733055AbgKECyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 21:54:12 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:21902 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgKECyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 21:54:12 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CRSlg554vz8p;
        Thu,  5 Nov 2020 03:54:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1604544850; bh=Iju+iBATdmDfQ4OsSyAkY4bpLERQ5SJXyrehln6ZXhQ=;
        h=Date:From:Subject:To:Cc:From;
        b=fCjP2YRyVLi9HR9jvBZEGU69UoTDXSiAgzwssbTSnUbw4r7VdErU1NjD9MR9zGbOQ
         0U44JjSICzkhByj3UHy1c3s52Rawdel+4+oHQDZ5TRiMwSxyCRCDa+/MPlGk9Go+m+
         n+jmvPL8C7tJsxDamyo0IL3CasVR5PxRxNnvrnM6PGpYES5obL1sl6QcNOuPfA33Bm
         dGdvLNheiRNpNpzw69E6WeDGWs0DiRJ0kxzo8lXYQttbFZw4reVS7zh1pt1WMeRTOi
         1DQsZJUnWsHokOFj6FHz1Nb6JBqhHM7j2ZObLm7yN6C43lqU3uds4mXVnUBDJ2VdUR
         6vYdt7KuJakBQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Thu, 05 Nov 2020 03:54:07 +0100
Message-Id: <7ede83e8d78414d8618e1044fd8fd11e8ed7a09f.1604544767.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] regulator: debug early supply resolving
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>, lgirdwood@gmail.com,
        mripard@kernel.org, linux-kernel@vger.kernel.org, wens@csie.org,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
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
index 402a72a70eb1..c84e3b0b63de 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5271,6 +5271,8 @@ regulator_register(const struct regulator_desc *regulator_desc,
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


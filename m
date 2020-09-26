Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF4279CA8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 23:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgIZVcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 17:32:42 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:10287 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgIZVcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 17:32:41 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BzMSm4MNsz2KH;
        Sat, 26 Sep 2020 23:32:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1601155960; bh=QJ7FZ09SHYhjsXh8zlUuxlRrtk0GOw387uUyUheheac=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Pd83FPjqNQO68JLmPWLMguU9zabsmh0pkmyk/zqvrWrOdb4ssCRt2eU0//mLeE7Kf
         ogcgSpIEJ7qTetvGLJm4sMOdu+8kjYBr8JdYh0kfpAgom2pL4TqTKVmpGGe/pCjRca
         4BficF2zvXA3w8gabj2v4r/islPvyzXR48NkOilYLSffNR/a0Zt1hiFt7ixhib2lug
         mxxDTtUx2JOW9lgmaXw97R4hSxJCbkt+akauQLWSvhYoC5fQVVTNeqp7lNALypLxHp
         MM+RfBIeK5Lpac+itBU8CFK3tPg3hEtKgzVrXoBI4m3oIwwVZn63rTh5VrFAdS+gJM
         HhvuFk1DEQQxA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sat, 26 Sep 2020 23:32:40 +0200
Message-Id: <53c4f3d394d68f0989174f89e3b0882cebbbd787.1601155770.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1601155770.git.mirq-linux@rere.qmqm.pl>
References: <cover.1601155770.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/3] regulator: print state at boot
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

Make the initial state of the regulator shown when debugging.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9238613a8c26..bf88d74f5401 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1114,10 +1114,15 @@ static void print_constraints(struct regulator_dev *rdev)
 	if (constraints->valid_modes_mask & REGULATOR_MODE_IDLE)
 		count += scnprintf(buf + count, len - count, "idle ");
 	if (constraints->valid_modes_mask & REGULATOR_MODE_STANDBY)
-		count += scnprintf(buf + count, len - count, "standby");
+		count += scnprintf(buf + count, len - count, "standby ");
 
 	if (!count)
-		scnprintf(buf, len, "no parameters");
+		count = scnprintf(buf, len, "no parameters");
+	else
+		--count;
+
+	count += scnprintf(buf + count, len - count, ", %s",
+		_regulator_is_enabled(rdev) ? "enabled" : "disabled");
 
 	rdev_dbg(rdev, "%s\n", buf);
 
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222E9300415
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbhAVNYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:24:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbhAVNXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:23:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2250B23437;
        Fri, 22 Jan 2021 13:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611321788;
        bh=O0kXBh406ZqWp6u3rL1NVk2dxAuNH47Sw0WDHc0KUFQ=;
        h=From:To:Cc:Subject:Date:From;
        b=JYST3S5mhCIGE7b2UZ27X46rkQjaf1Cpy7aP80iN9cGxKchBZcc1VfkekFKjIfmxV
         J6wR67CDasF4axPvmqoWqG6AYt0YhLPKvI2UXRFgvUFHzWU55gqiaIc7LBD/elHpAE
         +CC/MrzHxzAl2NlYTxOAI2aSC8uh71ZdfvOwnjI3VYlN338vVTt4hYHoPEo+Gvnscb
         uVDzqXhckZme6G9sdglEV4vqfWG2p4ojTtE1DmEz4zScC1tGttTpE+Et2XdfFmdPSS
         bbv2Gku8hjo7p3dvTzMD4N+p9rWXikd/I8DV/KjF6AaSdgj4Z9kH0vItaxS/RhouhP
         XJgOnxQosvmCA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] regulator: Fix lockdep warning resolving supplies
Date:   Fri, 22 Jan 2021 13:20:42 +0000
Message-Id: <20210122132042.10306-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit eaa7995c529b54 (regulator: core: avoid
regulator_resolve_supply() race condition) we started holding the rdev
lock while resolving supplies, an operation that requires holding the
regulator_list_mutex. This results in lockdep warnings since in other
places we take the list mutex then the mutex on an individual rdev.

Since the goal is to make sure that we don't call set_supply() twice
rather than a concern about the cost of resolution pull the rdev lock
and check for duplicate resolution down to immediately before we do the
set_supply() and drop it again once the allocation is done.

Fixes: eaa7995c529b54 (regulator: core: avoid regulator_resolve_supply() race condition)
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3ae5ccd9277d..3b73634d50ff 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1823,17 +1823,6 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	if (rdev->supply)
 		return 0;
 
-	/*
-	 * Recheck rdev->supply with rdev->mutex lock held to avoid a race
-	 * between rdev->supply null check and setting rdev->supply in
-	 * set_supply() from concurrent tasks.
-	 */
-	regulator_lock(rdev);
-
-	/* Supply just resolved by a concurrent task? */
-	if (rdev->supply)
-		goto out;
-
 	r = regulator_dev_lookup(dev, rdev->supply_name);
 	if (IS_ERR(r)) {
 		ret = PTR_ERR(r);
@@ -1885,12 +1874,29 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		goto out;
 	}
 
+	/*
+	 * Recheck rdev->supply with rdev->mutex lock held to avoid a race
+	 * between rdev->supply null check and setting rdev->supply in
+	 * set_supply() from concurrent tasks.
+	 */
+	regulator_lock(rdev);
+
+	/* Supply just resolved by a concurrent task? */
+	if (rdev->supply) {
+		regulator_unlock(rdev);
+		put_device(&r->dev);
+		goto out;
+	}
+
 	ret = set_supply(rdev, r);
 	if (ret < 0) {
+		regulator_unlock(rdev);
 		put_device(&r->dev);
 		goto out;
 	}
 
+	regulator_unlock(rdev);
+
 	/*
 	 * In set_machine_constraints() we may have turned this regulator on
 	 * but we couldn't propagate to the supply if it hadn't been resolved
@@ -1906,7 +1912,6 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	}
 
 out:
-	regulator_unlock(rdev);
 	return ret;
 }
 
-- 
2.20.1


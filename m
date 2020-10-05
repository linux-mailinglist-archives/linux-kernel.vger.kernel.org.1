Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35561283663
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJENPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgJENPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:15:50 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3046C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 06:15:49 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id cDFn2300X4C55Sk06DFnQQ; Mon, 05 Oct 2020 15:15:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kPQLD-0007Fu-B9; Mon, 05 Oct 2020 15:15:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kPQLD-0005qn-8R; Mon, 05 Oct 2020 15:15:47 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] regulator: Make constraint debug processing conditional on DEBUG
Date:   Mon,  5 Oct 2020 15:15:46 +0200
Message-Id: <20201005131546.22448-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If debugging is disabled, print_constraints() does not print the actual
constraints, but still performs some processing and string formatting,
only to throw away the result later.

Fix this by moving all constraint debug processing to a separate
function, and replacing it by a dummy when debugging is disabled.
This reduces kernel size by almost 800 bytes (on arm/arm64).

Fixes: 194dbaefa0da24bb ("regulator: Lower priority of constraint logging")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/regulator/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 607c2a76bb604f96..98beccef3fcd0905 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1059,7 +1059,8 @@ static int suspend_set_initial_state(struct regulator_dev *rdev)
 	return __suspend_set_state(rdev, rstate);
 }
 
-static void print_constraints(struct regulator_dev *rdev)
+#if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
+static void print_constraints_debug(struct regulator_dev *rdev)
 {
 	struct regulation_constraints *constraints = rdev->constraints;
 	char buf[160] = "";
@@ -1127,6 +1128,16 @@ static void print_constraints(struct regulator_dev *rdev)
 		_regulator_is_enabled(rdev) ? "enabled" : "disabled");
 
 	rdev_dbg(rdev, "%s\n", buf);
+}
+#else /* !DEBUG && !CONFIG_DYNAMIC_DEBUG */
+static inline void print_constraints_debug(struct regulator_dev *rdev) {}
+#endif /* !DEBUG && !CONFIG_DYNAMIC_DEBUG */
+
+static void print_constraints(struct regulator_dev *rdev)
+{
+	struct regulation_constraints *constraints = rdev->constraints;
+
+	print_constraints_debug(rdev);
 
 	if ((constraints->min_uV != constraints->max_uV) &&
 	    !regulator_ops_is_valid(rdev, REGULATOR_CHANGE_VOLTAGE))
-- 
2.17.1


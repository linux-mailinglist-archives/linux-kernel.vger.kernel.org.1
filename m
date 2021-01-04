Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289A42E923D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbhADI6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 03:58:33 -0500
Received: from ptr.189.cn ([183.61.185.101]:10945 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbhADI6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:58:33 -0500
HMM_SOURCE_IP: 10.64.10.46:56478.1954273017
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.10.46])
        by 189.cn (HERMES) with SMTP id 84ED710063D;
        Mon,  4 Jan 2021 16:55:37 +0800 (CST)
Received: from  ([10.64.8.34])
        by gateway-151646-dep-54888d799-2jgfg with ESMTP id 1b302b44d5f7474ba839454b81875be3 for greg@kroah.com;
        Mon Jan  4 16:55:38 2021
X-Transaction-ID: 1b302b44d5f7474ba839454b81875be3
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 10.64.8.34
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     greg@kroah.com, linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        sfr@canb.auug.org.au
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        Song Chen <chensong_2000@189.cn>
Subject: [PATCH v2] staging: board: Remove macro board_staging
Date:   Mon,  4 Jan 2021 16:55:46 +0800
Message-Id: <1609750546-17118-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro is not supposed to have flow control in it's
statement, remove.

Signed-off-by: Song Chen <chensong_2000@189.cn>

---
Changes in v2:
1, kzm9d_init and armadillo800eva_init are not compatible
with the definition of device_initcall, fixed.
---
 drivers/staging/board/armadillo800eva.c | 15 ++++++++++-----
 drivers/staging/board/board.h           | 11 -----------
 drivers/staging/board/kzm9d.c           | 23 ++++++++++++++---------
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/board/armadillo800eva.c b/drivers/staging/board/armadillo800eva.c
index 0225234..9896c7ba 100644
--- a/drivers/staging/board/armadillo800eva.c
+++ b/drivers/staging/board/armadillo800eva.c
@@ -78,11 +78,16 @@ static const struct board_staging_dev armadillo800eva_devices[] __initconst = {
 	},
 };
 
-static void __init armadillo800eva_init(void)
+static int __init armadillo800eva_init(void)
 {
-	board_staging_gic_setup_xlate("arm,pl390", 32);
-	board_staging_register_devices(armadillo800eva_devices,
-				       ARRAY_SIZE(armadillo800eva_devices));
+	if (of_machine_is_compatible("renesas,armadillo800eva")) {
+		board_staging_gic_setup_xlate("arm,pl390", 32);
+		board_staging_register_devices(armadillo800eva_devices,
+					       ARRAY_SIZE(armadillo800eva_devices));
+		return 0;
+	}
+
+	return -ENODEV;
 }
 
-board_staging("renesas,armadillo800eva", armadillo800eva_init);
+device_initcall(armadillo800eva_init);
diff --git a/drivers/staging/board/board.h b/drivers/staging/board/board.h
index 5609daf..f1c233e 100644
--- a/drivers/staging/board/board.h
+++ b/drivers/staging/board/board.h
@@ -32,15 +32,4 @@ int board_staging_register_device(const struct board_staging_dev *dev);
 void board_staging_register_devices(const struct board_staging_dev *devs,
 				    unsigned int ndevs);
 
-#define board_staging(str, fn)			\
-static int __init runtime_board_check(void)	\
-{						\
-	if (of_machine_is_compatible(str))	\
-		fn();				\
-						\
-	return 0;				\
-}						\
-						\
-device_initcall(runtime_board_check)
-
 #endif /* __BOARD_H__ */
diff --git a/drivers/staging/board/kzm9d.c b/drivers/staging/board/kzm9d.c
index d449a83..d48c3ef 100644
--- a/drivers/staging/board/kzm9d.c
+++ b/drivers/staging/board/kzm9d.c
@@ -10,17 +10,22 @@ static struct resource usbs1_res[] __initdata = {
 	DEFINE_RES_IRQ(159),
 };
 
-static void __init kzm9d_init(void)
+static int __init kzm9d_init(void)
 {
-	board_staging_gic_setup_xlate("arm,pl390", 32);
+	if (of_machine_is_compatible("renesas,kzm9d")) {
+		board_staging_gic_setup_xlate("arm,pl390", 32);
 
-	if (!board_staging_dt_node_available(usbs1_res,
-					     ARRAY_SIZE(usbs1_res))) {
-		board_staging_gic_fixup_resources(usbs1_res,
-						  ARRAY_SIZE(usbs1_res));
-		platform_device_register_simple("emxx_udc", -1, usbs1_res,
-						ARRAY_SIZE(usbs1_res));
+		if (!board_staging_dt_node_available(usbs1_res,
+						     ARRAY_SIZE(usbs1_res))) {
+			board_staging_gic_fixup_resources(usbs1_res,
+							  ARRAY_SIZE(usbs1_res));
+			platform_device_register_simple("emxx_udc", -1, usbs1_res,
+							ARRAY_SIZE(usbs1_res));
+			return 0;
+		}
 	}
+
+	return -ENODEV;
 }
 
-board_staging("renesas,kzm9d", kzm9d_init);
+device_initcall(kzm9d_init);
-- 
2.7.4


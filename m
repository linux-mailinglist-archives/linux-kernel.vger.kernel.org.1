Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D132F7C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbhAONLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:11:31 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:42573 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731502AbhAONLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:11:30 -0500
Received: by mail-lf1-f45.google.com with SMTP id b26so13038699lff.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=K06j7lsj180LPmR/P3f+pZJJCQ2sHRn9srXjW3rlnps=;
        b=SSkj/W8XCJFSSGyfje7XRCBI6p9FbPGe6hdjV9C9b3xPBNqQomfz1oAi3CBFjg3CUx
         iTZ+y5EdCfdpyysM+yRWP0DlcHgdlRIhj/DkWaUDJF9d1so16A4v4ZjQ26RBnm3/8K6U
         HCaEBMP4dEb7BcdqUBmATO1FL/F2BlZQ4bH3iQ9pGfCS9jAVOX6Qm5Bbt31i90El0daJ
         Lz/fl2jhXMnfpveDndMAsZ5RgZukQeurcg5nNpAw5QHbn+bbJaXcYIlNarKpJ9lBZbXJ
         IU89R0Z2S8UWUTiIVJc6cB5lRE4kIBY+4jWwR7jnwaD0RjyGHUanctB5U7rJyf5MxNon
         qwLA==
X-Gm-Message-State: AOAM5300jt2frM1xjJvTvoLt0Dl+loU6xfL+SmkzBjvE1NR4wkonRwSp
        8Frx/N03Ls4EnCYJxAfhDtjZzL0mUspG2g==
X-Google-Smtp-Source: ABdhPJzWVNCtfOyAzGTaMUuONv9dNtRWUt5xpEDkG1WBz2NtegZ8ssftkifSw8SFFts72u8tJRF0Ng==
X-Received: by 2002:ac2:429a:: with SMTP id m26mr4765793lfh.368.1610716247661;
        Fri, 15 Jan 2021 05:10:47 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id a24sm892502lfg.256.2021.01.15.05.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 05:10:46 -0800 (PST)
Date:   Fri, 15 Jan 2021 15:10:40 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd718x7, bd71828, Fix dvs voltage levels
Message-ID: <20210115131040.GA633776@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ROHM BD718x7 and BD71828 drivers support setting HW state
specific voltages from device-tree. This is used also by various
in-tree DTS files.

These drivers do incorrectly try to compose bit-map using enum
values. By a chance this works for first two valid levels having
values 1 and 2 - but setting values for the rest of the levels
do indicate capbility of setting values for first levels as
well. Luckily the regulators which support settin values for
SUSPEND/LPSR do usually also support setting values for RUN
and IDLE too - thus this has not been such a fatal issue.

Fix this by defining the old enum values as bits and using
new enum in parsing code. This allows keeping existing IC
specific drivers intact and only adding the defines and
slightly changing the rohm-regulator.c

Fixes: 21b72156ede8b ("regulator: bd718x7: Split driver to common and bd718x7 specific parts")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/rohm-regulator.c |  8 ++++----
 include/linux/mfd/rohm-generic.h   | 22 ++++++++++++++++------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/rohm-regulator.c b/drivers/regulator/rohm-regulator.c
index 399002383b28..96caae7dbef4 100644
--- a/drivers/regulator/rohm-regulator.c
+++ b/drivers/regulator/rohm-regulator.c
@@ -55,25 +55,25 @@ int rohm_regulator_set_dvs_levels(const struct rohm_dvs_config *dvs,
 	for (i = 0; i < ROHM_DVS_LEVEL_MAX && !ret; i++) {
 		if (dvs->level_map & (1 << i)) {
 			switch (i + 1) {
-			case ROHM_DVS_LEVEL_RUN:
+			case _ROHM_DVS_LEVEL_RUN:
 				prop = "rohm,dvs-run-voltage";
 				reg = dvs->run_reg;
 				mask = dvs->run_mask;
 				omask = dvs->run_on_mask;
 				break;
-			case ROHM_DVS_LEVEL_IDLE:
+			case _ROHM_DVS_LEVEL_IDLE:
 				prop = "rohm,dvs-idle-voltage";
 				reg = dvs->idle_reg;
 				mask = dvs->idle_mask;
 				omask = dvs->idle_on_mask;
 				break;
-			case ROHM_DVS_LEVEL_SUSPEND:
+			case _ROHM_DVS_LEVEL_SUSPEND:
 				prop = "rohm,dvs-suspend-voltage";
 				reg = dvs->suspend_reg;
 				mask = dvs->suspend_mask;
 				omask = dvs->suspend_on_mask;
 				break;
-			case ROHM_DVS_LEVEL_LPSR:
+			case _ROHM_DVS_LEVEL_LPSR:
 				prop = "rohm,dvs-lpsr-voltage";
 				reg = dvs->lpsr_reg;
 				mask = dvs->lpsr_mask;
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-generic.h
index 4283b5b33e04..a557988831d7 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -20,15 +20,25 @@ struct rohm_regmap_dev {
 	struct regmap *regmap;
 };
 
+/*
+ * Do not use these in IC specific driver - the bit map should be created using
+ * defines without the underscore. These should be used only in rohm-regulator.c
+ */
 enum {
-	ROHM_DVS_LEVEL_UNKNOWN,
-	ROHM_DVS_LEVEL_RUN,
-	ROHM_DVS_LEVEL_IDLE,
-	ROHM_DVS_LEVEL_SUSPEND,
-	ROHM_DVS_LEVEL_LPSR,
-	ROHM_DVS_LEVEL_MAX = ROHM_DVS_LEVEL_LPSR,
+	_ROHM_DVS_LEVEL_UNKNOWN,
+	_ROHM_DVS_LEVEL_RUN,
+	_ROHM_DVS_LEVEL_IDLE,
+	_ROHM_DVS_LEVEL_SUSPEND,
+	_ROHM_DVS_LEVEL_LPSR,
+	ROHM_DVS_LEVEL_MAX = _ROHM_DVS_LEVEL_LPSR,
 };
 
+#define ROHM_DVS_LEVEL_UNKNOWN	(1 << _ROHM_DVS_LEVEL_UNKNOWN)
+#define ROHM_DVS_LEVEL_RUN	(1 << _ROHM_DVS_LEVEL_RUN)
+#define ROHM_DVS_LEVEL_IDLE	(1 << _ROHM_DVS_LEVEL_IDLE)
+#define ROHM_DVS_LEVEL_SUSPEND	(1 << _ROHM_DVS_LEVEL_SUSPEND)
+#define ROHM_DVS_LEVEL_LPSR	(1 << _ROHM_DVS_LEVEL_LPSR)
+
 /**
  * struct rohm_dvs_config - dynamic voltage scaling register descriptions
  *

base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 

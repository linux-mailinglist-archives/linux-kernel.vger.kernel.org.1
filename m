Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166E92F9AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733295AbhARH7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:59:48 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:46492 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733243AbhARH7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:59:44 -0500
Received: by mail-lj1-f169.google.com with SMTP id u11so17176499ljo.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 23:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MKOHJ0aLXDSerE5Z+jLbJV+4tHZob15EnyShW6J4TTs=;
        b=K22vdCD8+XrkBUaRrrtXAjj+bPiqjH4O2rtihh2t0pLyft41WQ3ZmpOVHTRjoL4YJ5
         sifzf4UQ0nTaHG/WWOx1WfEHEywwb2LQDkSIan5Xqrx+Reujs0KSWaUGTCyLJb8OpcHE
         2omyLgTslKv+5VfuusR7DwNGo+evchyLMlSxC7AxBKrnybzwlMxQD09j3yufsvgaVWF5
         Ft2LF+d3XgdRxIuqEMo6332DrA/JiphXyUzCQliytN7sd+To0ji/P7Fqv2sutoPFPY39
         FmXsCwm+EHO0bZQ+KeTQbAe9m7Y17wII1pPZFQHv4aATOgdSleWhwMr7JPWjB9W+a3Ww
         6E9Q==
X-Gm-Message-State: AOAM5300DgDrtgqJnDYgio9A+eOQNUThSkBVN/RSHlW2jK8puutAX/iJ
        DfOtCF1AlH6YCe1CTVT4m0I=
X-Google-Smtp-Source: ABdhPJwF6echMsZk8YPjE1xc74Iqgx59a/UB3HpsTUH/F60vNGgu0Y5/O0vGvgr39df+vHI3ymbTYw==
X-Received: by 2002:a2e:7a07:: with SMTP id v7mr9713744ljc.119.1610956740791;
        Sun, 17 Jan 2021 23:59:00 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id 29sm1815411lfr.304.2021.01.17.23.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 23:59:00 -0800 (PST)
Date:   Mon, 18 Jan 2021 09:58:51 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] regulator: bd718x7, bd71828, Fix dvs voltage levels
Message-ID: <20210118075851.GA1016281@localhost.localdomain>
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

Resending after testing the logic with additional prints on
BD71815 (driver under development) and BD71847.

 drivers/regulator/rohm-regulator.c |  9 ++++++---
 include/linux/mfd/rohm-generic.h   | 14 ++++++--------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/rohm-regulator.c b/drivers/regulator/rohm-regulator.c
index 399002383b28..5c558b153d55 100644
--- a/drivers/regulator/rohm-regulator.c
+++ b/drivers/regulator/rohm-regulator.c
@@ -52,9 +52,12 @@ int rohm_regulator_set_dvs_levels(const struct rohm_dvs_config *dvs,
 	char *prop;
 	unsigned int reg, mask, omask, oreg = desc->enable_reg;
 
-	for (i = 0; i < ROHM_DVS_LEVEL_MAX && !ret; i++) {
-		if (dvs->level_map & (1 << i)) {
-			switch (i + 1) {
+	for (i = 0; i < ROHM_DVS_LEVEL_VALID_AMOUNT && !ret; i++) {
+		int bit;
+
+		bit = BIT(i);
+		if (dvs->level_map & bit) {
+			switch (bit) {
 			case ROHM_DVS_LEVEL_RUN:
 				prop = "rohm,dvs-run-voltage";
 				reg = dvs->run_reg;
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-generic.h
index 4283b5b33e04..2b85b9deb03a 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -20,14 +20,12 @@ struct rohm_regmap_dev {
 	struct regmap *regmap;
 };
 
-enum {
-	ROHM_DVS_LEVEL_UNKNOWN,
-	ROHM_DVS_LEVEL_RUN,
-	ROHM_DVS_LEVEL_IDLE,
-	ROHM_DVS_LEVEL_SUSPEND,
-	ROHM_DVS_LEVEL_LPSR,
-	ROHM_DVS_LEVEL_MAX = ROHM_DVS_LEVEL_LPSR,
-};
+#define ROHM_DVS_LEVEL_RUN		BIT(0)
+#define ROHM_DVS_LEVEL_IDLE		BIT(1)
+#define ROHM_DVS_LEVEL_SUSPEND		BIT(2)
+#define ROHM_DVS_LEVEL_LPSR		BIT(3)
+#define ROHM_DVS_LEVEL_VALID_AMOUNT	4
+#define ROHM_DVS_LEVEL_UNKNOWN		0
 
 /**
  * struct rohm_dvs_config - dynamic voltage scaling register descriptions

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

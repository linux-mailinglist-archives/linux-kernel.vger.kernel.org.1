Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E302F7E57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbhAOOeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:34:22 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:41972 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbhAOOeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:34:21 -0500
Received: by mail-lf1-f51.google.com with SMTP id s26so13390750lfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 06:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EYynAAe01v0az5oN2AITmKdZxLEimEvKPrB2V3ro+Hs=;
        b=K6Rz9/uPTW1x4ySLcdxoKas0X7DkBFosGcP8wsrFfKW07xsgGZ2e9VTR3z6axkgsc+
         c+euxOWR6+mqD63e8TxdXFtY5Wg1U7TgmS/wCt/ttC9hVzy8w2rTrdRdF0c0ex9PAOaV
         2qfpf38+bTXGy+i3BQKpyOKtLT23yHo3EgA08rp71U0t5oYZjgIfr7mtsN+P8UMNvUW5
         vaMQYTNijoZrLX5SuRWliU6qkdzmJdn1FTESdlCSFbyms9HaANvOuxQuE8Cw6R0sNEX0
         ZfZ6NgresJJzIo1NTk7c+9x1G4yPlffn3H1E21Wsob4fzjIFaspk5Ccmg8TAOJxc1tA2
         REzw==
X-Gm-Message-State: AOAM5306BdqEG2HsbGHTbt+N2v1JVI5m9vZhoLNp5hBdSePtzGjanvwG
        xhoAOg/knhKKTlj06x8zvzs=
X-Google-Smtp-Source: ABdhPJxYYwRXawHojiTYdTNzmA9TiK+cKjV7BVmhwMBT/jy0Qt49eeyRHJInLsJC2yRAu+8EHPQzLA==
X-Received: by 2002:a19:88c3:: with SMTP id k186mr5471877lfd.276.1610721219340;
        Fri, 15 Jan 2021 06:33:39 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id f23sm917092lfh.196.2021.01.15.06.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 06:33:38 -0800 (PST)
Date:   Fri, 15 Jan 2021 16:33:32 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd718x7, bd71828, Fix dvs voltage levels
Message-ID: <20210115143332.GA721433@localhost.localdomain>
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

One more attempt today. I did test the driver is not causing a crash
when load but no further tests concluded as I don't have BD71837/47/50
at home. This looks now trivial though so I decided to give it a go.
Sorry for all the trouble this far - and also for the mistakes to come.

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

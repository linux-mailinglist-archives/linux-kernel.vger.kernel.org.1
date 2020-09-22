Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CEE27490F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIVT1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgIVT1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:27:10 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D392EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:27:09 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x69so19309725lff.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PayRoMmiYdsIP5LqP0+POV5Nj2TYp2unTk9mqYApYLc=;
        b=rZ+8dnN+mtAg8NPpayPfyuXOU+7g/eMLzhnn+JlpIbGAwNpo1DB9g773+C3yX5wVAI
         plrd34WOwdw0l4ZRGKTerdb3xUVind/iGqTgKUY1/mpFWa1H0MRe4iISMVN3IxBzfDRV
         2jxNGVJD3wu/pOXwoizzanu/WQcFgCaB/hOr9CrR0L9QfABrdQHMa74btwq2r17wvyD1
         tmteD0YosflgIVNvPzKgK0TqRGck9BTpBKUS5bD04f0tJhP0m5F+FO1xisx5h764x76u
         amEWa2GaJ5xsF9cBTT9wXZGTZgTQT7mGWBSNFW5FqNdpZxv63DAeSGM51iPVidBpf9s0
         DjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PayRoMmiYdsIP5LqP0+POV5Nj2TYp2unTk9mqYApYLc=;
        b=NDMvR7a1URzUquFa6jVP4E6fw0cac/nZj5hkHWCP5KCnNdYNwQp8ePmaScarezpJFv
         hOeoiQIvEuMSnYVmNGkv/KFff0gJVla8LdAe89tOSH9p7b5bxoq8S787qDzGUQZrJggj
         DCxAha9kks9R76mKFD0u6F66OPE4hbywf9BZIYWA0BscWCC6uCLDgiI9Mi3OyF1sLIN5
         ptihsdXAvB359I3RKvgLNK2uUSGA7wirBXqbrmAhPUzZppK/zVepV1KyYF62EthUHT42
         cUvqKYBK6rpYq0CuO9Lpk7ZKbIrHZPK9hX13k43hI+DnKibapqnPmM5FNu+tESCUy6t+
         h8uw==
X-Gm-Message-State: AOAM53208xL6JL0aOZ2X15DM+G4UFLeiEgSmK9jefK7qJuaLeEv7lGZK
        gBfcNxIjXUv4U2pSd0go/Xw=
X-Google-Smtp-Source: ABdhPJzbXTryfAd2CuckvNbXpVoh6HeUFHfydNcAlcvcbERrFC5eUmUd1V48ijXyWGDM/7aMJ3b5HQ==
X-Received: by 2002:a19:7ece:: with SMTP id z197mr1981862lfc.545.1600802828160;
        Tue, 22 Sep 2020 12:27:08 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r132sm3770013lff.167.2020.09.22.12.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:27:07 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        support.opensource@diasemi.com
Subject: [PATCH 1/8] mfd: da: Constify static struct resource
Date:   Tue, 22 Sep 2020 21:26:52 +0200
Message-Id: <20200922192659.14535-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a number of static struct resource. The only usage of the
structs are to assign their address to the resources field in the
mfd_cell struct. This allows the compiler to put them in read-only
memory. Done with the help of Coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/mfd/da9055-core.c |  8 ++++----
 drivers/mfd/da9062-core.c | 24 ++++++++++++------------
 drivers/mfd/da9063-core.c |  8 ++++----
 drivers/mfd/da9150-core.c |  6 +++---
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index 6d0af8486269..d074d213e661 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -254,14 +254,14 @@ const struct regmap_config da9055_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(da9055_regmap_config);
 
-static struct resource da9055_onkey_resource = {
+static const struct resource da9055_onkey_resource = {
 	.name = "ONKEY",
 	.start = DA9055_IRQ_NONKEY,
 	.end   = DA9055_IRQ_NONKEY,
 	.flags = IORESOURCE_IRQ,
 };
 
-static struct resource da9055_rtc_resource[] = {
+static const struct resource da9055_rtc_resource[] = {
 	{
 		.name = "ALM",
 		.start = DA9055_IRQ_ALARM,
@@ -276,14 +276,14 @@ static struct resource da9055_rtc_resource[] = {
 	},
 };
 
-static struct resource da9055_hwmon_resource = {
+static const struct resource da9055_hwmon_resource = {
 	.name = "HWMON",
 	.start = DA9055_IRQ_HWMON,
 	.end   = DA9055_IRQ_HWMON,
 	.flags = IORESOURCE_IRQ,
 };
 
-static struct resource da9055_ld05_6_resource = {
+static const struct resource da9055_ld05_6_resource = {
 	.name = "REGULATOR",
 	.start = DA9055_IRQ_REGULATOR,
 	.end   = DA9055_IRQ_REGULATOR,
diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index fc30726e2e27..9583a98d3aae 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -160,23 +160,23 @@ static struct regmap_irq_chip da9062_irq_chip = {
 	.ack_base = DA9062AA_EVENT_A,
 };
 
-static struct resource da9061_core_resources[] = {
+static const struct resource da9061_core_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_VDD_WARN, "VDD_WARN"),
 };
 
-static struct resource da9061_regulators_resources[] = {
+static const struct resource da9061_regulators_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_LDO_LIM, "LDO_LIM"),
 };
 
-static struct resource da9061_thermal_resources[] = {
+static const struct resource da9061_thermal_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_TEMP, "THERMAL"),
 };
 
-static struct resource da9061_wdt_resources[] = {
+static const struct resource da9061_wdt_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_WDG_WARN, "WD_WARN"),
 };
 
-static struct resource da9061_onkey_resources[] = {
+static const struct resource da9061_onkey_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_ONKEY, "ONKEY"),
 };
 
@@ -211,32 +211,32 @@ static const struct mfd_cell da9061_devs[] = {
 	},
 };
 
-static struct resource da9062_core_resources[] = {
+static const struct resource da9062_core_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_VDD_WARN, 1, "VDD_WARN", IORESOURCE_IRQ),
 };
 
-static struct resource da9062_regulators_resources[] = {
+static const struct resource da9062_regulators_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_LDO_LIM, 1, "LDO_LIM", IORESOURCE_IRQ),
 };
 
-static struct resource da9062_thermal_resources[] = {
+static const struct resource da9062_thermal_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_TEMP, 1, "THERMAL", IORESOURCE_IRQ),
 };
 
-static struct resource da9062_wdt_resources[] = {
+static const struct resource da9062_wdt_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_WDG_WARN, 1, "WD_WARN", IORESOURCE_IRQ),
 };
 
-static struct resource da9062_rtc_resources[] = {
+static const struct resource da9062_rtc_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_ALARM, 1, "ALARM", IORESOURCE_IRQ),
 	DEFINE_RES_NAMED(DA9062_IRQ_TICK, 1, "TICK", IORESOURCE_IRQ),
 };
 
-static struct resource da9062_onkey_resources[] = {
+static const struct resource da9062_onkey_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_ONKEY, 1, "ONKEY", IORESOURCE_IRQ),
 };
 
-static struct resource da9062_gpio_resources[] = {
+static const struct resource da9062_gpio_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_GPI0, 1, "GPI0", IORESOURCE_IRQ),
 	DEFINE_RES_NAMED(DA9062_IRQ_GPI1, 1, "GPI1", IORESOURCE_IRQ),
 	DEFINE_RES_NAMED(DA9062_IRQ_GPI2, 1, "GPI2", IORESOURCE_IRQ),
diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index a353d52210a9..df407c3afce3 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -29,7 +29,7 @@
 #include <linux/uaccess.h>
 
 
-static struct resource da9063_regulators_resources[] = {
+static const struct resource da9063_regulators_resources[] = {
 	{
 		.name	= "LDO_LIM",
 		.start	= DA9063_IRQ_LDO_LIM,
@@ -38,7 +38,7 @@ static struct resource da9063_regulators_resources[] = {
 	},
 };
 
-static struct resource da9063_rtc_resources[] = {
+static const struct resource da9063_rtc_resources[] = {
 	{
 		.name	= "ALARM",
 		.start	= DA9063_IRQ_ALARM,
@@ -53,7 +53,7 @@ static struct resource da9063_rtc_resources[] = {
 	}
 };
 
-static struct resource da9063_onkey_resources[] = {
+static const struct resource da9063_onkey_resources[] = {
 	{
 		.name	= "ONKEY",
 		.start	= DA9063_IRQ_ONKEY,
@@ -62,7 +62,7 @@ static struct resource da9063_onkey_resources[] = {
 	},
 };
 
-static struct resource da9063_hwmon_resources[] = {
+static const struct resource da9063_hwmon_resources[] = {
 	{
 		.start	= DA9063_IRQ_ADC_RDY,
 		.end	= DA9063_IRQ_ADC_RDY,
diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.c
index 7f0aa1e8db96..d8b0cde48589 100644
--- a/drivers/mfd/da9150-core.c
+++ b/drivers/mfd/da9150-core.c
@@ -350,18 +350,18 @@ static const struct regmap_irq_chip da9150_regmap_irq_chip = {
 	.num_irqs = ARRAY_SIZE(da9150_irqs),
 };
 
-static struct resource da9150_gpadc_resources[] = {
+static const struct resource da9150_gpadc_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_GPADC, "GPADC"),
 };
 
-static struct resource da9150_charger_resources[] = {
+static const struct resource da9150_charger_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_CHG, "CHG_STATUS"),
 	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_TJUNC, "CHG_TJUNC"),
 	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_VFAULT, "CHG_VFAULT"),
 	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_VBUS, "CHG_VBUS"),
 };
 
-static struct resource da9150_fg_resources[] = {
+static const struct resource da9150_fg_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_FG, "FG"),
 };
 
-- 
2.28.0


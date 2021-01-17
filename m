Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A982F93BB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 16:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbhAQPuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 10:50:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728368AbhAQPs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 10:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610898449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IOaqbIKSRS9ckIeSaq3IkbuULYGxEaXINEMbw0LKySc=;
        b=DREQm/ZywI6ePf77Rny/fCZBvjvrEPar1N7C2rQC+xTzLVbzlvW+Y8y0wutJjvLJRH87qQ
        8pUjXRca1twKPps16x0nh4552SWN2I+f9tiiniM7mpQxKhkvTScX2LFhAwdbR5fwntGnUn
        qKNRYyMPdhHlzA8eq1wfpxvqShVZZ28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-ydWa8s5_OK6LJLOTwF41Sw-1; Sun, 17 Jan 2021 10:47:27 -0500
X-MC-Unique: ydWa8s5_OK6LJLOTwF41Sw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F66D180A086;
        Sun, 17 Jan 2021 15:47:26 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-7.ams2.redhat.com [10.36.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D478C19C44;
        Sun, 17 Jan 2021 15:47:23 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v2 2/5] mfd: arizona: Replace arizona_of_get_type() with device_get_match_data()
Date:   Sun, 17 Jan 2021 16:47:14 +0100
Message-Id: <20210117154717.77969-3-hdegoede@redhat.com>
In-Reply-To: <20210117154717.77969-1-hdegoede@redhat.com>
References: <20210117154717.77969-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the custom arizona_of_get_type() function with the generic
device_get_match_data() helper. Besides being a nice cleanup this
also makes it easier to add support for binding to ACPI enumerated
devices.

While at it also fix a possible NULL pointer deref of the id
argument to the probe functions (this could happen on e.g. manual
driver binding through sysfs).

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- New patch in v2 of this patchset
---
 drivers/mfd/arizona-core.c | 11 -----------
 drivers/mfd/arizona-i2c.c  | 10 ++++++----
 drivers/mfd/arizona-spi.c  | 10 ++++++----
 drivers/mfd/arizona.h      |  9 ---------
 4 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 000cb82023e3..75f1bc671d59 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -797,17 +797,6 @@ const struct dev_pm_ops arizona_pm_ops = {
 EXPORT_SYMBOL_GPL(arizona_pm_ops);
 
 #ifdef CONFIG_OF
-unsigned long arizona_of_get_type(struct device *dev)
-{
-	const struct of_device_id *id = of_match_device(arizona_of_match, dev);
-
-	if (id)
-		return (unsigned long)id->data;
-	else
-		return 0;
-}
-EXPORT_SYMBOL_GPL(arizona_of_get_type);
-
 static int arizona_of_get_core_pdata(struct arizona *arizona)
 {
 	struct arizona_pdata *pdata = &arizona->pdata;
diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index 2a4a3a164d0a..5e83b730c4ce 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -23,14 +23,16 @@
 static int arizona_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
+	const void *match_data;
 	struct arizona *arizona;
 	const struct regmap_config *regmap_config = NULL;
-	unsigned long type;
+	unsigned long type = 0;
 	int ret;
 
-	if (i2c->dev.of_node)
-		type = arizona_of_get_type(&i2c->dev);
-	else
+	match_data = device_get_match_data(&i2c->dev);
+	if (match_data)
+		type = (unsigned long)match_data;
+	else if (id)
 		type = id->driver_data;
 
 	switch (type) {
diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 704f214d2614..798b88295c77 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -23,14 +23,16 @@
 static int arizona_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
+	const void *match_data;
 	struct arizona *arizona;
 	const struct regmap_config *regmap_config = NULL;
-	unsigned long type;
+	unsigned long type = 0;
 	int ret;
 
-	if (spi->dev.of_node)
-		type = arizona_of_get_type(&spi->dev);
-	else
+	match_data = device_get_match_data(&spi->dev);
+	if (match_data)
+		type = (unsigned long)match_data;
+	else if (id)
 		type = id->driver_data;
 
 	switch (type) {
diff --git a/drivers/mfd/arizona.h b/drivers/mfd/arizona.h
index 995efc6d7f32..801cbbcd71cb 100644
--- a/drivers/mfd/arizona.h
+++ b/drivers/mfd/arizona.h
@@ -50,13 +50,4 @@ int arizona_dev_exit(struct arizona *arizona);
 int arizona_irq_init(struct arizona *arizona);
 int arizona_irq_exit(struct arizona *arizona);
 
-#ifdef CONFIG_OF
-unsigned long arizona_of_get_type(struct device *dev);
-#else
-static inline unsigned long arizona_of_get_type(struct device *dev)
-{
-	return 0;
-}
-#endif
-
 #endif
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012452FDC4F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 23:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391351AbhATWUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 17:20:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731377AbhATVwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611179414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LESTpO7CsLPM5kxrQDfHWvEK5RuCWs7J22g2n+Iz+Qw=;
        b=gUBgU9cZzabZdZs5EyYgtMvv8nPLOAn0Tl+bSnAec28j1BrAPcFjoC1/oj48ajn3iBUt43
        WKmIqxIIQv28YW3jLczrur96RGZe9D3ueEcq9BuVwGRMroHyuZuDSwo9KEu3uXH6906OWU
        2COG0zSCzsy03Bq9EPpY09H6siLAzsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-Em_ckMstN0Ki-KJrw3w-kQ-1; Wed, 20 Jan 2021 16:50:08 -0500
X-MC-Unique: Em_ckMstN0Ki-KJrw3w-kQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CB3F1842140;
        Wed, 20 Jan 2021 21:50:06 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-1.ams2.redhat.com [10.36.114.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65ABC61F38;
        Wed, 20 Jan 2021 21:50:04 +0000 (UTC)
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
Subject: [PATCH v4 2/5] mfd: arizona: Replace arizona_of_get_type() with device_get_match_data()
Date:   Wed, 20 Jan 2021 22:49:54 +0100
Message-Id: <20210120214957.140232-3-hdegoede@redhat.com>
In-Reply-To: <20210120214957.140232-1-hdegoede@redhat.com>
References: <20210120214957.140232-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
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


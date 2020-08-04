Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4707023B17B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 01:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgHCX7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 19:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbgHCX6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:58:25 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF8C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:58:24 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j9so29279146ilc.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2ctQerw1ZPbA2zuLIi6/rRsyLUTQ+gWJWVkQvyMgWY=;
        b=nJyTQLv+zLnyN/sgUDu1vGkZfpIZyEG+0giWMo3GXr58KTfEnInnWT+Jm1O4bVCeXx
         xRXevYa7KqxQRD2n69EgiW2IKfeXlizLx2kriE6DRfuobDnMjzBqLAZ7FsSXzWDwZIj1
         XCy6MwGA9wLi4shT2nTr5Q3Ub2Q5arG0Fmdk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2ctQerw1ZPbA2zuLIi6/rRsyLUTQ+gWJWVkQvyMgWY=;
        b=FDY6J8Z++C3aTn5LMOFf4BFZyaytnVT8S6wFpEANLp0lcN9d8XwKUAEhd8fsLxsQcR
         5KbMsGOBAiyzMmCd1XcWUZFD153Wvy5NyPcZ+YEGSA9xDKWJ5Q99eevxTT608hxzzzvE
         pLdkDZsRfppRwReXsXdzv567MTd2eM8CE/LOsTNOCggLr6RrPZyjXkNUS92Bc5YSCdlY
         Np75EFyb8A03v5N3bleiAokI2eBLMKB11+DH4AeODXo1fSOXJHMEqsnxvdnyRmrw2Ztb
         AiyVdqORhmI8aY+Q99NNiIuLYqlcEDjssOnFz637kbwgAbRnbuQ93pJUL0abc+fKhRzr
         z/qA==
X-Gm-Message-State: AOAM53213LraSUOZjWonrZcKp7UdbyOyMTdUwg2XDA2XtdH5l5PwHN/i
        O8wnQeFp5aN4vd/CKPa9hFwCxg==
X-Google-Smtp-Source: ABdhPJxFAphk+KFRD7qjdSBT20KaIKYyOBi1u10LiuUjabStMlRVk/lAVrWN5Z8QvENBdDFmmOmnLA==
X-Received: by 2002:a92:4802:: with SMTP id v2mr1941457ila.32.1596499104315;
        Mon, 03 Aug 2020 16:58:24 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id x185sm11075992iof.41.2020.08.03.16.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:58:23 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 05/15] iio: sx9310: Change from .probe to .probe_new
Date:   Mon,  3 Aug 2020 17:58:05 -0600
Message-Id: <20200803175559.v5.5.Ieb5fdf7381764835dad0b3099c7b19ba754e4c47@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803235815.778997-1-campello@chromium.org>
References: <20200803235815.778997-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses .probe_new in place of .probe. Also uses device_get_match_data()
for whoami matching.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
 - Added '\n' to dev_err()

 drivers/iio/proximity/sx9310.c | 39 ++++++++++++----------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 9daf2b8591a0a0..66ecdd309e0ddc 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -139,7 +139,7 @@ struct sx9310_data {
 	struct completion completion;
 	unsigned int chan_read, chan_event;
 	int channel_users[SX9310_NUM_CHANNELS];
-	int whoami;
+	unsigned int whoami;
 };
 
 static const struct iio_event_spec sx9310_events[] = {
@@ -858,24 +858,15 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
 
 static int sx9310_set_indio_dev_name(struct device *dev,
 				     struct iio_dev *indio_dev,
-				     const struct i2c_device_id *id, int whoami)
+				     unsigned int whoami)
 {
-	const struct acpi_device_id *acpi_id;
-
-	/* id will be NULL when enumerated via ACPI */
-	if (id) {
-		if (id->driver_data != whoami)
-			dev_err(dev, "WHOAMI does not match i2c_device_id: %s",
-				id->name);
-	} else if (ACPI_HANDLE(dev)) {
-		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
-		if (!acpi_id)
-			return -ENODEV;
-		if (acpi_id->driver_data != whoami)
-			dev_err(dev, "WHOAMI does not match acpi_device_id: %s",
-				acpi_id->id);
-	} else
+	unsigned int long ddata;
+
+	ddata = (uintptr_t)device_get_match_data(dev);
+	if (ddata != whoami) {
+		dev_err(dev, "WHOAMI does not match device data: %u\n", whoami);
 		return -ENODEV;
+	}
 
 	switch (whoami) {
 	case SX9310_WHOAMI_VALUE:
@@ -885,15 +876,14 @@ static int sx9310_set_indio_dev_name(struct device *dev,
 		indio_dev->name = "sx9311";
 		break;
 	default:
-		dev_err(dev, "unexpected WHOAMI response: %u", whoami);
+		dev_err(dev, "unexpected WHOAMI response: %u\n", whoami);
 		return -ENODEV;
 	}
 
 	return 0;
 }
 
-static int sx9310_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int sx9310_probe(struct i2c_client *client)
 {
 	int ret;
 	struct iio_dev *indio_dev;
@@ -919,8 +909,7 @@ static int sx9310_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, id,
-					data->whoami);
+	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, data->whoami);
 	if (ret < 0)
 		return ret;
 
@@ -1033,8 +1022,8 @@ static const struct acpi_device_id sx9310_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);
 
 static const struct of_device_id sx9310_of_match[] = {
-	{ .compatible = "semtech,sx9310" },
-	{ .compatible = "semtech,sx9311" },
+	{ .compatible = "semtech,sx9310", (void *)SX9310_WHOAMI_VALUE },
+	{ .compatible = "semtech,sx9311", (void *)SX9311_WHOAMI_VALUE },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sx9310_of_match);
@@ -1053,7 +1042,7 @@ static struct i2c_driver sx9310_driver = {
 		.of_match_table = sx9310_of_match,
 		.pm = &sx9310_pm_ops,
 	},
-	.probe		= sx9310_probe,
+	.probe_new	= sx9310_probe,
 	.id_table	= sx9310_id,
 };
 module_i2c_driver(sx9310_driver);
-- 
2.28.0.163.g6104cc2f0b6-goog


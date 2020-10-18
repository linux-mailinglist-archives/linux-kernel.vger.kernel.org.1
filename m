Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D2C291561
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 05:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgJRDZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 23:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgJRDZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 23:25:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21E3C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 20:25:50 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hk7so3661428pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 20:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=kmtW1KHQUcgwd9+ADcDQxKs+FBGL12TyOP2a0AHn8c4=;
        b=Ze5Kr6j2vM6n25tsfW616nYmhWHQrVmSGCpAIW62xtRFJYbEIapeaEiotMh40IZiee
         cZyFMcvjIqOCMYUoaZ10EJ/dwcnbcMt81QqPyGtnzM9eOBfZ32YOkXu5V23m6JkOinHA
         zWPcLRXhRKgYoo/CaAS4FswwPl/sx8HEjBwnrS1eyeMk4CjCOAB3D8CWpnGmvIxan5RR
         NBoWPM7lwQzFiB5pdctD4om8jfqTii1z+oKA2SULRcSIhuUA7dKaYy4mgmPfAwOM5zSv
         hMYlXpLOH+HQX0O3EMS7OsNrNYzBGnAEYtqDPYhmgSCr1LQP7kvVLJ7OjOL0JrtBin0O
         iw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kmtW1KHQUcgwd9+ADcDQxKs+FBGL12TyOP2a0AHn8c4=;
        b=BdZvUOLYHAYOujBikKD72IKOTS7odCrGCvTpI805aG0Qq1zKZRemj9z65vtEOdLYDU
         Mps04uQXmMAoiKBI7epSqNi09HT5EDkZjWONAt4Gwy/RefMSDQ4smw2XuElnvu3zcBBH
         m17lNsMbjzAfvrMFViLzTTgex8xcpypHeRND36++qd7K+niezSaCuMsuz2rz5RIPOSX6
         hiuhnQccSLrdBiESbbOEUFn87MNcvDIRuFGQXG02vq21gQQcdIjWRte7HNnd2GP8PeGu
         bGRUHjcC3L+8HL8QmioZVLvtn/iiYZdjFePCvKQk0HxzJbjCIEerdEeECEvL+AfAvdLc
         hB4Q==
X-Gm-Message-State: AOAM533jXR4aQQugUstPSW2BsxeRqunqsN50B0KsIohy3qw8915WiqkK
        bD7xpF1xA35LXYk+zj4lhJdw
X-Google-Smtp-Source: ABdhPJxopzSCnUzIfpdbFWqTe+6dDeWBbgiVV9/GoPjb4IYtcZWdST8vQilaXnMiIcS4ZzVGByTPGw==
X-Received: by 2002:a17:90a:cb05:: with SMTP id z5mr11544583pjt.92.1602991550387;
        Sat, 17 Oct 2020 20:25:50 -0700 (PDT)
Received: from ubuntu ([116.68.78.80])
        by smtp.gmail.com with ESMTPSA id z10sm2783144pjz.49.2020.10.17.20.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 20:25:49 -0700 (PDT)
Date:   Sun, 18 Oct 2020 08:55:43 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        alexandru.ardelean@analog.com, nish.malpani25@gmail.com,
        matt.ranostay@konsulko.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        vaishnav@beagleboard.org
Subject: [PATCH v2] iio: light: tsl2563 change of_property_read to
 device_property_read
Message-ID: <20201018032543.GA27580@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace the of_property_read_u32 for reading the amstaos,cover-comp-gain
property with device_property_read_u32,allows the driver to
get the properties information using the more generic device_property_*
helpers and opens the possibility of passing the properties during
platform instantiation of the device by a suitably populated
struct property_entry.

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 v2:
	- fix commit message
 drivers/iio/light/tsl2563.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index abc8d7db8dc1..1f1b8b7cefa4 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -703,7 +703,6 @@ static int tsl2563_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	struct tsl2563_chip *chip;
 	struct tsl2563_platform_data *pdata = client->dev.platform_data;
-	struct device_node *np = client->dev.of_node;
 	int err = 0;
 	u8 id = 0;
 
@@ -738,13 +737,14 @@ static int tsl2563_probe(struct i2c_client *client,
 	chip->calib0 = tsl2563_calib_from_sysfs(CALIB_BASE_SYSFS);
 	chip->calib1 = tsl2563_calib_from_sysfs(CALIB_BASE_SYSFS);
 
-	if (pdata)
+	if (pdata) {
 		chip->cover_comp_gain = pdata->cover_comp_gain;
-	else if (np)
-		of_property_read_u32(np, "amstaos,cover-comp-gain",
-				     &chip->cover_comp_gain);
-	else
-		chip->cover_comp_gain = 1;
+	} else {
+		err = device_property_read_u32(&client->dev, "amstaos,cover-comp-gain",
+					       &chip->cover_comp_gain);
+		if (err)
+			chip->cover_comp_gain = 1;
+	}
 
 	dev_info(&client->dev, "model %d, rev. %d\n", id >> 4, id & 0x0f);
 	indio_dev->name = client->name;
-- 
2.25.1


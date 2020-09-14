Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AA5269102
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgINQCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgINPq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:46:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F7AC06121E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:46:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so199222wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2NiDdLKfaF45Hmo8b72rTpZ47d6NVsfNNivwKidUBtY=;
        b=R3EXKcUJOlRaMpzLSR4tcuRS4mPAhzgADhqB7JocX7xSzM2Qhes7SeI9L3pvcapwfK
         7ge4xAjKl3lAIGJP4QmvDEn573f4iqiLrTFkjnDy18hA4zoioxgiy6RvUQ++Q+wt7g0s
         UPS1tm2GibuMpKirb4tl1O+5T/whMFJiSJUwRaODp14CBIhbLQpVP00cDcAL0LbSnace
         BpNul7cR3rfoxtsKCDi5f6U0d9EFaMPlKfHgeWSHQOPag0+u5XCXPsr7rS9I4OmoA7hz
         wvtMmOyDtdSi2onZLvRRRt14B1X9mFTEYHWoCSN7Z3sdR/O3CBIu31yA3lCWkALCikVO
         gGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2NiDdLKfaF45Hmo8b72rTpZ47d6NVsfNNivwKidUBtY=;
        b=a+qxH8X9Ef1jY4WeplzW2JjdT31aEcsOepBsVlBa2TrxUWX4paoR9hOYcOYFEznAcw
         1yYBfSDOzDcZzvaHjpjpSB/S47bV7qtxhHUlOkFcRCnksb4MMfFbvFmNNfMYYCBg3Vw1
         n8l4Am/SzThQNqDLv66QrsZn+O1gVIs/qLOzMYpOSg3hJYeNFOHEK5XlDEzRM31H/uDQ
         Fmu+UmGpi0gUv+HKGj1mrelkXjQ0WeMFhE8vmH6iy1mykDzZC87xEJXHtivzegYutuv/
         9wtL+Kq9refBIIR8Q+gYT6fJ/0zj+Arb+JIJbz7fFanfhAxLiE5xlmXWhvBLVNSuUmxw
         yfLA==
X-Gm-Message-State: AOAM530Qx43nP2ylaX0JKBWAz3LMVUJqQlessXy1ppchtYiIWudR4w2+
        9robV7BOCkvWAmn8XxpUt03BIA==
X-Google-Smtp-Source: ABdhPJybqLeVfhiCAnRX6k8T2rF0xEq3Cis/6p7YWj8k8PlJC/W6rXNqTA03F2S5SqrmntM7Cpu0Gw==
X-Received: by 2002:a5d:40c4:: with SMTP id b4mr13464346wrq.151.1600098370074;
        Mon, 14 Sep 2020 08:46:10 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id l19sm19510448wmi.8.2020.09.14.08.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:46:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 06/14] rtc: rx8010: rename ret to err in rx8010_set_time()
Date:   Mon, 14 Sep 2020 17:45:53 +0200
Message-Id: <20200914154601.32245-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200914154601.32245-1-brgl@bgdev.pl>
References: <20200914154601.32245-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All other functions in this driver use 'err' for integer return values.
Do the same in rx8010_set_time() for consistency.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 51ac4fac8f19..300314ab7b6d 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -140,7 +140,7 @@ static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
 {
 	struct rx8010_data *rx8010 = dev_get_drvdata(dev);
 	u8 date[7];
-	int ctrl, flagreg, ret;
+	int ctrl, flagreg, err;
 
 	if ((dt->tm_year < 100) || (dt->tm_year > 199))
 		return -EINVAL;
@@ -150,10 +150,10 @@ static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
 	if (ctrl < 0)
 		return ctrl;
 	rx8010->ctrlreg = ctrl | RX8010_CTRL_STOP;
-	ret = i2c_smbus_write_byte_data(rx8010->client, RX8010_CTRL,
+	err = i2c_smbus_write_byte_data(rx8010->client, RX8010_CTRL,
 					rx8010->ctrlreg);
-	if (ret < 0)
-		return ret;
+	if (err < 0)
+		return err;
 
 	date[RX8010_SEC - RX8010_SEC] = bin2bcd(dt->tm_sec);
 	date[RX8010_MIN - RX8010_SEC] = bin2bcd(dt->tm_min);
@@ -163,27 +163,27 @@ static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
 	date[RX8010_YEAR - RX8010_SEC] = bin2bcd(dt->tm_year - 100);
 	date[RX8010_WDAY - RX8010_SEC] = bin2bcd(1 << dt->tm_wday);
 
-	ret = i2c_smbus_write_i2c_block_data(rx8010->client,
+	err = i2c_smbus_write_i2c_block_data(rx8010->client,
 					     RX8010_SEC, 7, date);
-	if (ret < 0)
-		return ret;
+	if (err < 0)
+		return err;
 
 	/* clear STOP bit after changing clock/calendar */
 	ctrl = i2c_smbus_read_byte_data(rx8010->client, RX8010_CTRL);
 	if (ctrl < 0)
 		return ctrl;
 	rx8010->ctrlreg = ctrl & ~RX8010_CTRL_STOP;
-	ret = i2c_smbus_write_byte_data(rx8010->client, RX8010_CTRL,
+	err = i2c_smbus_write_byte_data(rx8010->client, RX8010_CTRL,
 					rx8010->ctrlreg);
-	if (ret < 0)
-		return ret;
+	if (err < 0)
+		return err;
 
 	flagreg = i2c_smbus_read_byte_data(rx8010->client, RX8010_FLAG);
 	if (flagreg < 0)
 		return flagreg;
 
 	if (flagreg & RX8010_FLAG_VLF)
-		ret = i2c_smbus_write_byte_data(rx8010->client, RX8010_FLAG,
+		err = i2c_smbus_write_byte_data(rx8010->client, RX8010_FLAG,
 						flagreg & ~RX8010_FLAG_VLF);
 
 	return 0;
-- 
2.26.1


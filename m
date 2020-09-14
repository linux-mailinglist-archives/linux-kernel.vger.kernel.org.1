Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866AD269097
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgINPsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgINPqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:46:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC24C06178B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:46:06 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so554474wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plilCXA5A5q09idBzIpTg+BIsAJANgsHzo+a6wZVjlA=;
        b=S7ctMuLP+H6ZENeDO2FsY0msTCT202b26BjCdFuawnWwkLH2CKc8jwl0bbUXNbCeg6
         63B+pHIzJLSDKmztuJU29lKzRs5XVgbvoktw5AMA/G/E89qjGV66ZJGEA9OoTuirhU6F
         0To6lxnCn8AvOI5jrUjzC7IjVXOTh4Qlli1ZBKXdgLXv8LpIGj0lBGSHm0JwPNhg+HZf
         w1xBEfETzJrdkNYmCT15XKmqXcdAurqGk5GSJXSs3QMGIKvhHrTrfRG2NTyYJ2vlgks6
         keCX4c7V4PAYBPenv2P46IJmOVGuVJhbCKkLDt8/72Vjsw8PeZDadfFwxIN2u+RJx0K4
         ptUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plilCXA5A5q09idBzIpTg+BIsAJANgsHzo+a6wZVjlA=;
        b=qknCeUCGMJqepv7n8xwELgaLXsR4j1fLt3SRhxyHW0k2A4qKIvEBlVQ6VEZ7KoXmMz
         JarbKgqQ3wwJFu8KRPmL0j1bbeW80buimXQ5j8Rp83CtqqpFomLRbTMt+9zthrHPkMXY
         sam7BRLZ4BzbHiyVvAYDWrZFz29gicl7AHZ6uiV07Ggx4A+qvkqu2847FskUgwI6gKPW
         loT7Kk9nhdBpU8Db1Fn3usTjvVzCQG6/WPEMCuo9UP9+u4oOWAErO9xXX5GQgRADoAEC
         /becXBTC+0hSevavyM2e7R4tBQg9fKAuzOs0KiqPwA/9UnVinfWWv+E7xnJNvCQLK6Gt
         BR6w==
X-Gm-Message-State: AOAM532Zk+H9RCQ3lnfsV3AtEdaSK0fndCr0KF/HQn4A2rql6U67dKRt
        wnZx/oue/g9JW5eT9mk/ldnk4A==
X-Google-Smtp-Source: ABdhPJyQwSx+HXVYm5DHmvbn4LTEV128NOS4N1474J7+Jszy/ozfkmXbRUZuDvtDHuuKGVCWyrxs6w==
X-Received: by 2002:a7b:c5c6:: with SMTP id n6mr31296wmk.120.1600098364820;
        Mon, 14 Sep 2020 08:46:04 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id l19sm19510448wmi.8.2020.09.14.08.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:46:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 01/14] rtc: rx8010: don't modify the global rtc ops
Date:   Mon, 14 Sep 2020 17:45:48 +0200
Message-Id: <20200914154601.32245-2-brgl@bgdev.pl>
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

The way the driver is implemented is buggy for the (admittedly unlikely)
use case where there are two RTCs with one having an interrupt configured
and the second not. This is caused by the fact that we use a global
rtc_class_ops struct which we modify depending on whether the irq number
is present or not.

Fix it by using two const ops structs with and without alarm operations.
While at it: not being able to request a configured interrupt is an error
so don't ignore it and bail out of probe().

Fixes: ed13d89b08e3 ("rtc: Add Epson RX8010SJ RTC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index fe010151ec8f..08c93d492494 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -407,16 +407,26 @@ static int rx8010_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 	}
 }
 
-static struct rtc_class_ops rx8010_rtc_ops = {
+static const struct rtc_class_ops rx8010_rtc_ops_default = {
 	.read_time = rx8010_get_time,
 	.set_time = rx8010_set_time,
 	.ioctl = rx8010_ioctl,
 };
 
+static const struct rtc_class_ops rx8010_rtc_ops_alarm = {
+	.read_time = rx8010_get_time,
+	.set_time = rx8010_set_time,
+	.ioctl = rx8010_ioctl,
+	.read_alarm = rx8010_read_alarm,
+	.set_alarm = rx8010_set_alarm,
+	.alarm_irq_enable = rx8010_alarm_irq_enable,
+};
+
 static int rx8010_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = client->adapter;
+	const struct rtc_class_ops *rtc_ops;
 	struct rx8010_data *rx8010;
 	int err = 0;
 
@@ -447,16 +457,16 @@ static int rx8010_probe(struct i2c_client *client,
 
 		if (err) {
 			dev_err(&client->dev, "unable to request IRQ\n");
-			client->irq = 0;
-		} else {
-			rx8010_rtc_ops.read_alarm = rx8010_read_alarm;
-			rx8010_rtc_ops.set_alarm = rx8010_set_alarm;
-			rx8010_rtc_ops.alarm_irq_enable = rx8010_alarm_irq_enable;
+			return err;
 		}
+
+		rtc_ops = &rx8010_rtc_ops_alarm;
+	} else {
+		rtc_ops = &rx8010_rtc_ops_default;
 	}
 
 	rx8010->rtc = devm_rtc_device_register(&client->dev, client->name,
-		&rx8010_rtc_ops, THIS_MODULE);
+					       rtc_ops, THIS_MODULE);
 
 	if (IS_ERR(rx8010->rtc)) {
 		dev_err(&client->dev, "unable to register the class device\n");
-- 
2.26.1


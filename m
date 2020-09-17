Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479C526E57E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgIQTmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbgIQQPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:15:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0133C0611C1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:15:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so2719310wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=275Kff5bHk1Ql5YO6/JaQK06TKyHT815Kx3MTAHc/Pc=;
        b=fODSaQgZLrr21eV0w+GBt0dO3x4xiprG2fqgMHnqiHHKONha29s5e0HqdUS3qkGGsQ
         JHF57zQ0w40IjfKKbdBoEPF2XmHOWM327glWkIdmJqRPzUcKvn9N5SoO91Mpkzvgx+Rg
         hXXxJA896kg+vdLkxoqKTcnG1oXFpZHXPouNhNpDka9OvnVl+kBfshNDbqnrjmlsQ+ws
         yVZlej+1H4QYrKSMPibaqONZcS9vy3BaTnLO2E4HeU3F8URMQNdeZ/ZBHA/7fVG4EIq9
         xT95EciGcg+K94U3/J02IBggo0qZ/dVa4ch0H9mqwNFHJrn8qLqXF0OCXIb2j6l7qPmV
         eusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=275Kff5bHk1Ql5YO6/JaQK06TKyHT815Kx3MTAHc/Pc=;
        b=JgGm7ZL/LIcma8cFtksoz2gIaaqGe7X7aJ1Hl1wyO534UzkRGTwmagRHXMH+z7TAJy
         Yu/RQ6p7D+PzPwIBF9T6Em4NDo79b+oIq0P46NBWisqZ6dlGaw7AwE67mHHTLLLC+DR3
         ZlwihqQ8c0CX0r3mbhWS0plmNnxmfBZM/bIfx8Je81x/oE52UcaU4m3FhqXbDg/BkjmI
         nqCAD8ekHjHpjgz6jsBame0oKbED2rLwrVYUkWlI3rZ2tLaFVd9noBKcYO2XHmQQAZlL
         ljBia3KKp+S0/M8kc42LrH2KZnN2ws35C5nvl+eWUuj6xe44DCK1dOBT4NIxKEdw6iIZ
         XUfg==
X-Gm-Message-State: AOAM5321gz+Ud5Q5q7pI+8Jfm92JlBEKHeS5O64te9edriCPIig567cg
        gq2cvnus1+GZ1S4VZJV5S57hAA==
X-Google-Smtp-Source: ABdhPJzTCx8JkQaPwINA5jVa2slX7fHpeL6wBTFTwGXtkFGZTm/zNeb7EiAGX56bZdO3lpf7dDVjHw==
X-Received: by 2002:adf:d845:: with SMTP id k5mr30825072wrl.285.1600359313106;
        Thu, 17 Sep 2020 09:15:13 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id u126sm47649wmu.9.2020.09.17.09.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 09:15:12 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4.19 v4.14 v4.9] rtc: rx8010: don't modify the global rtc ops
Date:   Thu, 17 Sep 2020 18:15:05 +0200
Message-Id: <20200917161505.8958-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200914154601.32245-2-brgl@bgdev.pl
---
Hi!

This is a backport that applies to the following stable branches:

    v4.19, v4.14, v4.9

 drivers/rtc/rtc-rx8010.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index d08da371912c..93b1d8d9d2e9 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -423,16 +423,26 @@ static int rx8010_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
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
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	const struct rtc_class_ops *rtc_ops;
 	struct rx8010_data *rx8010;
 	int err = 0;
 
@@ -463,16 +473,16 @@ static int rx8010_probe(struct i2c_client *client,
 
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


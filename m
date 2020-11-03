Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF252A4CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgKCR3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgKCR3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:29:40 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34C8C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 09:29:39 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id k18so92883wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 09:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xtvki4McB9jLla/dsGGCtBrgMZkhHSdMqdGrQg++B7s=;
        b=benXQO3sK0iEbfXbr95M6CNtTsHLNB77tt15bbBfaM7TnqifSmnCVkGysAIyN+52gW
         0Y+mHsPaZo0qboioe5ohkdUM1/E2WZq8jaqsOFCtMZS7p7ghs8E/pY0KrtoZqMqKINjd
         gPnvbvARMcuoHpNXQchLSuoMTAqHMghmXcYmnwqwlEDGpXDlDGi1S8NPWdGjA/8ndMpv
         R5j1yEW+Mwc/2dh3aNPUCQb5yve/9adq2eJrL9htvy75PrVVfdKc7UyvzzZFJcuam2EM
         IDGjcS6Q03UZy4UEXiCNFvm3xlEhQewof4idbCxjr1k6UzjDdKSWqRJHvq5K4lTBQkeK
         dejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xtvki4McB9jLla/dsGGCtBrgMZkhHSdMqdGrQg++B7s=;
        b=Wgl9xRx4jq2Q6RbcXzW895xeur7YS4sZ0qi8Ow6JcohGQuvLPkM8bbaJZEpitf3NBz
         5Rzs0rB+sQjFMeTMGk+gCfeMjZbReqh4v3vdJGDJQXThmRZ9aqhXS6bkAPo8/0hZQBYN
         ILlDlPH1Jy5ZhhEN4e+tLliMzPW5RVvu6UEX1GdJThgcnARWVdxII9baVmnDUxwdq0kE
         WAvnTjpA2ye4B3m7vwFJjCk1yyLBFe3gIBKde9/yPXVgI3JK7qJo2b4es2/YvvmxxYFq
         W+Ich/XcsLnMLBOLs7OK/aE9jjaljwxlejTJ02gylxrOHkwNt2ZqHCz8J6H4UtcFjhCi
         T+/A==
X-Gm-Message-State: AOAM530iQ01ss4jQDMCl1JZ5xNgtXdCs5n8CToaBwMlnbp5KxUtbJ/IM
        BhRkDH2tpTSuttOSfqlPdT11IA==
X-Google-Smtp-Source: ABdhPJy3/9ThSlWZqJU/rcjOCjU5D3nGY5d9eqWADAB6zPbqUKcs+gT+NotvoRGQjR7icLcX3cQkfQ==
X-Received: by 2002:a1c:9a0e:: with SMTP id c14mr216144wme.35.1604424578462;
        Tue, 03 Nov 2020 09:29:38 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id b4sm18798318wro.57.2020.11.03.09.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 09:29:37 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        stable@vger.kernel.org
Subject: [PATCH v4.9..v4.19] rtc: rx8010: don't modify the global rtc ops
Date:   Tue,  3 Nov 2020 18:29:01 +0100
Message-Id: <20201103172901.18231-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
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
 drivers/rtc/rtc-rx8010.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 7ddc22eb5b0f..f4db80f9c1b1 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -428,16 +428,26 @@ static int rx8010_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
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
 
@@ -468,16 +478,16 @@ static int rx8010_probe(struct i2c_client *client,
 
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
2.29.1


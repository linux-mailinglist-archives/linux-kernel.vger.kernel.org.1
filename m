Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8367E2B9155
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgKSLmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKSLmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:42 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764BDC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:42 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so6111077wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=at6RnRS2binr6/2DoZInS71m49aG42bZbjqPJx56QTI=;
        b=0LBtnzcjXnRGSdCTdytvwtVLfskXVbMAqdcH53p5UWq4+CK2rBI8eirA5qDjXCD419
         9+wFzkaSmkG2PyY0FEsJiPDuqj0Tr+g03E7X2t3jPlah9VzPOo50QYwMZKxOeholeKAE
         ZGvcjUgv3L0PXToKgPZB2f7wh1HnzQvONHWIbckm6vLY8lUfdZ36JBIskFGFVxsZWqqQ
         9ArpmUPmvEfuTr+f8N/ITJRK9vUEzA1Z8jsV6C7O/9uyh0fBZrCfkCX4x4mJzF4TB5vy
         b9TIVTOL6qlkP3dqgBCU0pWgLvnInrVF3DR6rN5+k77d29XMxmWCgNkBuT+zW5XjyMbL
         cuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=at6RnRS2binr6/2DoZInS71m49aG42bZbjqPJx56QTI=;
        b=EF9eKQjxiFEq14Jm2n1P97kMERGk5z9q0TfNJOBTXWWSoBkqnVf9t21hsAxMLF7GHT
         wt3gg59PX0DjLIF/6U9vlAstVv+uHHgk8U5ZUNQHN670KoMdP7n/ggqGP+XixIWEP2s6
         gxKy4gP4b5tUnuyUtyJ9U1wgC01sKFclxQ32ZedGqC5WU4ONQHA1o84n7yy3o9RxoMKK
         TTT4h2MgkMLWpErx7gjYMn5Dd2b86xzcEa7oFHE4rFQm2JqokfC6lP2aBnRp3UcZfIYv
         HwZrjsKqQzGQCMvFuWGvnR+2PdBP646QaqI0rNQ6TnTs+RVZ5cgn8jJzN10G/ninmkIO
         BrKQ==
X-Gm-Message-State: AOAM530UPKXjnVmfU1Hw7pRLIs7FfHY6IIhSiSZStSAUXO88kyfyOl6n
        Z6MNHBFCp/L0KNHsL99Zr3rcqg==
X-Google-Smtp-Source: ABdhPJztj8RdV8cAzQVm5qxyk8qTvD3pVn25y+QaZS7WF8vCP/yJAjNcq8tKhcJu0Atp9DQv0CCIXw==
X-Received: by 2002:adf:b78b:: with SMTP id s11mr9646394wre.42.1605786161290;
        Thu, 19 Nov 2020 03:42:41 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:40 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 35/59] rtc: rx8025: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:25 +0100
Message-Id: <20201119114149.4117-36-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201119114149.4117-1-brgl@bgdev.pl>
References: <20201119114149.4117-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

devm_rtc_device_register() is deprecated. Use devm_rtc_allocate_device()
and devm_rtc_register_device() pair instead.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8025.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index a24f85893f90..3c08cfa779d7 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -524,12 +524,9 @@ static int rx8025_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	rx8025->rtc = devm_rtc_device_register(&client->dev, client->name,
-					  &rx8025_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rx8025->rtc)) {
-		dev_err(&client->dev, "unable to register the class device\n");
+	rx8025->rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(rx8025->rtc))
 		return PTR_ERR(rx8025->rtc);
-	}
 
 	if (client->irq > 0) {
 		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
@@ -543,13 +540,15 @@ static int rx8025_probe(struct i2c_client *client,
 		}
 	}
 
+	rx8025->rtc->ops = &rx8025_rtc_ops;
 	rx8025->rtc->max_user_freq = 1;
 
 	/* the rx8025 alarm only supports a minute accuracy */
 	rx8025->rtc->uie_unsupported = 1;
 
 	err = rx8025_sysfs_register(&client->dev);
-	return err;
+
+	return devm_rtc_register_device(rx8025->rtc);
 }
 
 static int rx8025_remove(struct i2c_client *client)
-- 
2.29.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EB22B91D7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgKSLsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgKSLmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:11 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F6DC061A4C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:10 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so6109443wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pn7SdVHUMPmppMXB3BTCGf30PM6HBIJ5rW++xm0ywuI=;
        b=DWAN9vlwqCNbN8LsiH6OAQXlepKRv1Z2LiClItkZalohozwQ2BELJcLbVnXZoJUbuX
         2iJ8ywpd7yKO9xIXPg1BwGbn+Wd5RLHvTObYMrWv3JXmHe07ekkT5BicNXDUNdPjOwwx
         ydpktevWWeVpgmE5Zie4WpV8PkZwbd3w/OYNQ1jPKE7oMk8NQWlvNfzpYxlDNUsiIxwq
         Yt82UUrcJim7pL8B+X89tXqHx0RWG2ZXZ7bTRdKRAKjIEHvsW5m9WyyJMThSpiPdkmBz
         c/0TFgvV5WbkTN53kpTEXuaqwEKYLqTCx+eTCChdhY6E6/+FAuAWxYNKIlEZr6nAxA8T
         TuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pn7SdVHUMPmppMXB3BTCGf30PM6HBIJ5rW++xm0ywuI=;
        b=AFy/ydOnDGgI7v4gElL2KXU3AvjwXYuWUjxnjiiCdcZ9ijc0nokM2V/EdseJPcwBRk
         a3tY9qec8Is3e/Af+lpwUlA1Oy/5/035U9KDR3xwfFii/VzFirDe0VFaE8VoAk4LaLoo
         7DOMruF/HjK6BCKz3UOvAB09eBAGg8bWguJGRIrWpdYtKYoWyRNqj4S5bce7OhGIqSDV
         o2Y0kWI4j1D8yk6talmXTlxM9FdHVo59b1D82dzjl5Rbn6bxyTNNcfNxary1YiSim7Ja
         rbSyVGqPnQYt0EpSey6KGtKvrSAfS6pfs5njxHSH05aQXb2FWu7SxTIYQTJhnFSLNcH9
         DpuQ==
X-Gm-Message-State: AOAM533624AVW1QjVBvDEiWbmcV1qw+flaV9/EFzpAAJkoGiyufjpMU9
        Z2Cy0f8BPVOFac1BD4F63irDYw==
X-Google-Smtp-Source: ABdhPJxUi9NM3YQ7WTQLtXjkY/MdlPDnFvh3YfqmGcobbpSjJj8eNLBP+RAbuP0v8DRWWuCfrjKXng==
X-Received: by 2002:adf:f246:: with SMTP id b6mr9308686wrp.238.1605786129614;
        Thu, 19 Nov 2020 03:42:09 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:09 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 05/59] rtc: rx6110: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:40:55 +0100
Message-Id: <20201119114149.4117-6-brgl@bgdev.pl>
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
 drivers/rtc/rtc-rx6110.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-rx6110.c b/drivers/rtc/rtc-rx6110.c
index a7b671a21022..cdb05b67912e 100644
--- a/drivers/rtc/rtc-rx6110.c
+++ b/drivers/rtc/rtc-rx6110.c
@@ -315,20 +315,18 @@ static int rx6110_probe(struct rx6110_data *rx6110, struct device *dev)
 {
 	int err;
 
-	rx6110->rtc = devm_rtc_device_register(dev,
-					       RX6110_DRIVER_NAME,
-					       &rx6110_rtc_ops, THIS_MODULE);
-
+	rx6110->rtc = devm_rtc_allocate_device(dev);
 	if (IS_ERR(rx6110->rtc))
 		return PTR_ERR(rx6110->rtc);
 
+	rx6110->rtc->ops = &rx6110_rtc_ops;
+	rx6110->rtc->max_user_freq = 1;
+
 	err = rx6110_init(rx6110);
 	if (err)
 		return err;
 
-	rx6110->rtc->max_user_freq = 1;
-
-	return 0;
+	return devm_rtc_register_device(rx6110->rtc);
 }
 
 #ifdef CONFIG_SPI_MASTER
-- 
2.29.1


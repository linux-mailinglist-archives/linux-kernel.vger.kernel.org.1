Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6E22B91C0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgKSLrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbgKSLm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:27 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93687C08E85E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:24 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 10so6884116wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D+F/vslCkoMlgK6AevmyT7Am1/w2NuFk/P8bU7WWRdY=;
        b=QigWrsxbi5uTIexkJUp/ZLckqd3mzs89FP3S9j/0dlF1dVsFZ9sbO9SBb3DdLKO2nC
         +ei29M1XTdfAvcWi16jPOcWxupihz+dtO4CCO1wq2kNVNkG75dkJomOWeXbHD3vG5EBZ
         IL1EdLu2y5/e1mkLJUa9EbR/Cjxbe7QcGMaOsjsH7OHtRJCyrNVUGeWLvVUWb0L8k+lw
         hWrR51k7AOwMyzQo8MC5T7afWzr67uyecbCu0OTIDqq6Jwc1YWPn5NSq7r6JD0zFuzS6
         whPZQng5KGahpatBPYOVwp/l4Fq1ND6mvi+F+9lYHmrk9QKHGWW/gxOMOuqfTHZCtNU8
         IaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D+F/vslCkoMlgK6AevmyT7Am1/w2NuFk/P8bU7WWRdY=;
        b=o8LDOE8e3vtTaH0ZtGcLmkYq2ajfQ9g+/X5AEiide+nLHEemscSeEIAbqn4cuHHVSx
         zinO26Y8aI1PgxLWAab9QZMo3H2iGjWkZGg7WzIqa/8VL3aRqTI0XqnQ63KH92adjX5D
         mmGg9EOa7Y3MluTmn8Sx5cXhaOqHlmbxaCan4eHJs6JG7stqA+TAosEyTVFlmgBzlmqx
         NCSu/BGKW9Tl/pQibx4E8sj3ANhubHCgCcksKxQvsXclXgDS9qGw5/XUtf/7VVi5HsiJ
         6dsNy1DVN3eNatcQnCkUVOKrX5XBXaSMKF91cb3BZG4kaSrNiWHbuao99UVIC5JwT1b5
         VcRA==
X-Gm-Message-State: AOAM5309sZ8/UDY35AORjFSej5y9HB2JFdyWYgUXtOrqCthGX5DiiS3G
        CFXbEx4jCW+r23+88R2bdgclqw==
X-Google-Smtp-Source: ABdhPJxgDPdi22CdXYkILY9RZGnNeE/BFeJIABZ+aJjeayxO26J5PhoaMbq6kDCxwDEnMaaQI5FBwA==
X-Received: by 2002:a1c:5f08:: with SMTP id t8mr4033215wmb.84.1605786143306;
        Thu, 19 Nov 2020 03:42:23 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:22 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 18/59] rtc: max6916: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:08 +0100
Message-Id: <20201119114149.4117-19-brgl@bgdev.pl>
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
 drivers/rtc/rtc-max6916.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-max6916.c b/drivers/rtc/rtc-max6916.c
index e72e768ab8ff..06e98d6351ee 100644
--- a/drivers/rtc/rtc-max6916.c
+++ b/drivers/rtc/rtc-max6916.c
@@ -137,14 +137,14 @@ static int max6916_probe(struct spi_device *spi)
 	max6916_read_reg(&spi->dev, MAX6916_STATUS_REG, &data);
 	dev_info(&spi->dev, "MAX6916 RTC Status Reg = 0x%02x\n", data);
 
-	rtc = devm_rtc_device_register(&spi->dev, "max6916",
-				       &max6916_rtc_ops, THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&spi->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
+	rtc->ops = &max6916_rtc_ops;
 	spi_set_drvdata(spi, rtc);
 
-	return 0;
+	return devm_rtc_register_device(rtc);
 }
 
 static struct spi_driver max6916_driver = {
-- 
2.29.1


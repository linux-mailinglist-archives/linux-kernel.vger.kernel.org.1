Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70D12B9166
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgKSLnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbgKSLnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:43:03 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00824C061A52
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:43:03 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so6077233wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fh0/ML4VFEC9H+vJV6RWtrAyOJTOn4EWW2FuW2aJX+M=;
        b=nq65fEuUWFAN2kxughIowzyAZ/KF07TGDU25+nWq5Ozvi3zX/4NET3JTnu5AY2jinR
         sO8BV3xKwShEab9KXxfgzdqgH2yDwwnAxZDC6lxPnwkgVNLO0PdaUxdifqrE/VdgBfYL
         YV6RMEDfUIO7DIHIKUMXzStk8zE4O77ONRqv820PEe1TdcVg4ws7a5xe3k3E0O86q9fl
         N87P2pVpYmnb96oy8tdIo90aQ4jToQkVyPD3vCa2AxvaeExsgC1W3+QSRWsDvMUoz981
         KriMbNJa3OTiqcFM8u4nozwrAcd1xQUl0Rk4V64FLZLIJKEZqteE3TxtMvDeiDDjfTMi
         UHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fh0/ML4VFEC9H+vJV6RWtrAyOJTOn4EWW2FuW2aJX+M=;
        b=Mjt2dtBfygVRARcQIFPmQ1al4UcfhXTKp70qqYWgooP6C1dItm8XSGdk92bFwTEXx2
         AtZLCUejAezpl/UHKWWAmscf0xqcm5ZOD0bbK93XiiY5w6VFUsmrw/dX6wbWNfO2sDjq
         icgE1vNqaAeW11v/nR/iriMZBzqdT5u5wqUCiamxSNt5RRrUMlyITkxTSLbarhcLmzC8
         5HK4jIxjLVvIkBSCugx1sRZ4IP5ALGnPa4QBi+/mLu4GefFlAutZARzx28qX5QixOHg9
         uaDA4l2BOPl8N8zIFkUwaruDGBro8OgYQEeAMgmWbjZb4mBWD2nY97Efv1y1GUfz4ZmN
         Mj0w==
X-Gm-Message-State: AOAM532GTxSEFh7YukR9WwjOqV4yvLalABXYPJIZHpnqORZgcH4cGm4l
        3XN0/uda8vYJJJF+A3imoV/p9w==
X-Google-Smtp-Source: ABdhPJw5aOIENoQLUC/qJB8iVUJ1V/qfxtDoSsIzTGV/yXFjyqiqquHGS1w4nkL0SnTdS4d0nct+BA==
X-Received: by 2002:adf:bb92:: with SMTP id q18mr9500032wrg.315.1605786181762;
        Thu, 19 Nov 2020 03:43:01 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:43:00 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 53/59] rtc: m41t93: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:43 +0100
Message-Id: <20201119114149.4117-54-brgl@bgdev.pl>
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
 drivers/rtc/rtc-m41t93.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-m41t93.c b/drivers/rtc/rtc-m41t93.c
index 9444cb5f5190..7faa8a4f0032 100644
--- a/drivers/rtc/rtc-m41t93.c
+++ b/drivers/rtc/rtc-m41t93.c
@@ -181,14 +181,14 @@ static int m41t93_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	rtc = devm_rtc_device_register(&spi->dev, m41t93_driver.driver.name,
-					&m41t93_rtc_ops, THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&spi->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
+	rtc->ops = &m41t93_rtc_ops;
 	spi_set_drvdata(spi, rtc);
 
-	return 0;
+	return devm_rtc_register_device(rtc);
 }
 
 static struct spi_driver m41t93_driver = {
-- 
2.29.1


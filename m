Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7902B919B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgKSLpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgKSLmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:43 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9287DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:43 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so6879039wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUDDxJ6QrhE79EdxKg7lI4ODKwN3GG0oY8e3KZqF1cI=;
        b=W9yL3wLhV/G+OiJXPV54u2ifo0jFlG0/aH5HY/bHsqrcFr0oj+akPzjgVMqg1/NMm1
         2bZ3eGH5wzWEbECWF/opI5i3kDqLjGrCljDlSwRiYzxOI6wD2dvQH0SFNgsECJZ+nug8
         ZBlW352oj1aFkQBP0kUQyUxbuPlJ2agNrPACq+jDFY/y3bUgp7b5U8TxA23Xdy6ev1ij
         O8Zc+27/yg5ciD44WNAsQJnGBWwfsNdUmwFchkcsol3KJGs2M48Llg31lqMsVtnTst7/
         TCRqL8T1PXPLBJqnA+iOZw7g9j/IYLiOzOFxO7++77t68b+0ibSHluv7Pw/H8CBjo0qD
         qd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUDDxJ6QrhE79EdxKg7lI4ODKwN3GG0oY8e3KZqF1cI=;
        b=VLAqLNin5DDyr7XyoUWwX34RDq5riRQPzAbL17Fl8TiUuzXnd5QlGEg0hItXrh+47C
         GCVUq7DNni1KGGATK6x0pzW7ObrJYIrCDkB06TGG56ZRwz1TlbrLIAEooH1a0KD3pMfA
         aPFN5OaFVJ5MKWu9cRXxulo3gAFqeAsCsDK6d102+ejknmTN7clR/n2uARFUQagLa/DA
         iWi6opuffxx4uXXhT+iym/zsG1BTWOIJmc5sv8QQXlWGLtp1sJy34dB2ZcKa5MbnSTku
         CxqsBREoVfsh0MbbBXBTvH24F87rJEzMW5SMkozG92zITlM5FjHEqeo99K1JHMzWW1yf
         hndA==
X-Gm-Message-State: AOAM530uoouZfJWcfuHZa109lr4aWEOZFoAAliX13NkSrCr1ny7aodAn
        lpiSfcJmPfeMwqgOCSLao9+Esg==
X-Google-Smtp-Source: ABdhPJzdY3UgL7H9MVWSejzo3MvTbl+US/npXEvRSau4/Li6cWEG4X103a3Jj2cFdOao12InjVI3Wg==
X-Received: by 2002:a05:600c:2886:: with SMTP id g6mr4164141wmd.110.1605786162343;
        Thu, 19 Nov 2020 03:42:42 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:41 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 36/59] rtc: asm9260: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:26 +0100
Message-Id: <20201119114149.4117-37-brgl@bgdev.pl>
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
 drivers/rtc/rtc-asm9260.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-asm9260.c b/drivers/rtc/rtc-asm9260.c
index 3ab81cdec00b..c74455bce8b4 100644
--- a/drivers/rtc/rtc-asm9260.c
+++ b/drivers/rtc/rtc-asm9260.c
@@ -284,14 +284,14 @@ static int asm9260_rtc_probe(struct platform_device *pdev)
 	iowrite32(0, priv->iobase + HW_CIIR);
 	iowrite32(BM_AMR_OFF, priv->iobase + HW_AMR);
 
-	priv->rtc = devm_rtc_device_register(dev, dev_name(dev),
-					     &asm9260_rtc_ops, THIS_MODULE);
+	priv->rtc = devm_rtc_allocate_device(dev);
 	if (IS_ERR(priv->rtc)) {
 		ret = PTR_ERR(priv->rtc);
-		dev_err(dev, "Failed to register RTC device: %d\n", ret);
 		goto err_return;
 	}
 
+	priv->rtc->ops = &asm9260_rtc_ops;
+
 	ret = devm_request_threaded_irq(dev, irq_alarm, NULL,
 					asm9260_rtc_irq, IRQF_ONESHOT,
 					dev_name(dev), priv);
@@ -301,6 +301,10 @@ static int asm9260_rtc_probe(struct platform_device *pdev)
 		goto err_return;
 	}
 
+	ret = devm_rtc_register_device(priv->rtc);
+	if (ret)
+		goto err_return;
+
 	return 0;
 
 err_return:
-- 
2.29.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8119D2B91BC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgKSLqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbgKSLm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:29 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D28C061A48
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:28 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id j7so6127536wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hgVYTg0nBVKyzCt7mHcc2oQTRzr5HJj2f6v1HlorgCg=;
        b=svi+Oy3TZjzKeJL5CbOW6+70dGvk8nqim+BCGmR+utqOjN/f/GCqEcJ87yjWABwWCK
         T9box9RmE9PUD8F7CU2lhiDssVu+3IUFeve2t29EtIgKZTMJJNPCWUeIY9ANTI2gTHP6
         ZcOBPqbMlrIpdYqOPCucGcXOKuILkY7lp/h7ZVb4DUgVWCCXfFAhDb7t41m//SVBGDna
         mOz4Ve7o2yGuybEvSceWsPNAY73anioMTsqtAV1Qy/eANE55F0s2TRoQ7tt9WykxWQOa
         +oiqYI5eJaJOECtiUEV4Ae4olurx4//lT3cklbHfoqJjPm4ntsjMLVrq4PSQ9SjuPNGh
         3XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hgVYTg0nBVKyzCt7mHcc2oQTRzr5HJj2f6v1HlorgCg=;
        b=TH/tfGWdS55w6YNAhhQ74kJW8BGRfOPzVZME/sTck668uR2VilpMKlKqadSv2TXEOV
         UTdH/iudJnUMaQpZ94NlTzxVuSf6NDWaUEf9ASHItIHFZB7rw0980iMGo5X05Zn5MtcW
         EmqqwFkg9dG63DXDmKoz00KO1YAkTknSP68o3sDT9ccvKqNz8vdYK7uR3bR1Jpba9tXZ
         p7bhBpzf6rTQdrKJskTqOwX38mO33BKogg4tHSsYsW/iG1U8kcudzpNkL9/Stz+1JiLy
         JTXBo29CDLLEbfYivI9Q5LzNLaSsumIcRJKXyXta3AqP6N+WtQN0kmEEcJkV2U2elrsY
         Crew==
X-Gm-Message-State: AOAM533XqThbrlzD1WbGRINgjwkspyYw6kDFeNDzU6E2YtYA+yRo6P9J
        XLwf9gtYBAYKbKYf5PaokaGlAg==
X-Google-Smtp-Source: ABdhPJznB7SGU8Z5LOEiB7AqDuaRW73Ki7JDIIyTo2ZXqXmbWzTFKPT4vB61pCpLqo2P0ihs3Ff8Hg==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr9555698wrp.209.1605786147652;
        Thu, 19 Nov 2020 03:42:27 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:27 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 22/59] rtc: moxart: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:12 +0100
Message-Id: <20201119114149.4117-23-brgl@bgdev.pl>
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
 drivers/rtc/rtc-moxart.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-moxart.c b/drivers/rtc/rtc-moxart.c
index 6b24ac9e1cfa..f354bc8abecf 100644
--- a/drivers/rtc/rtc-moxart.c
+++ b/drivers/rtc/rtc-moxart.c
@@ -294,15 +294,13 @@ static int moxart_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	moxart_rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-						   &moxart_rtc_ops,
-						   THIS_MODULE);
-	if (IS_ERR(moxart_rtc->rtc)) {
-		dev_err(&pdev->dev, "devm_rtc_device_register failed\n");
+	moxart_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(moxart_rtc->rtc))
 		return PTR_ERR(moxart_rtc->rtc);
-	}
 
-	return 0;
+	moxart_rtc->rtc->ops = &moxart_rtc_ops;
+
+	return devm_rtc_register_device(moxart_rtc->rtc);
 }
 
 static const struct of_device_id moxart_rtc_match[] = {
-- 
2.29.1


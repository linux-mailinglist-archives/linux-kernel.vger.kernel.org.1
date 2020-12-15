Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476772DB222
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 18:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgLORDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 12:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbgLORDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 12:03:00 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF87C0617B0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 09:02:20 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id p126so24062784oif.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 09:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xxFeUjonFw77THjceoCtcx/rMZ97apnNhN3IhCP1UQI=;
        b=aue75vfYUzY/GfGESi3vMLtB76kOfdkcAR4gi8MefVNWtK2XuHIhcA7QGhMSo7HOVQ
         ozgUxbh8LnJONkVBu25itSz8lO7J6r6UVRi4CXL1BmrgG4rNv2C0kX3eu9wBqc58/5gD
         MvlXH1cVJYPxYNeX4QImasF/53U1iXEnCnLFfPz6UF2ZjmE527Un+/Osa/X5MciaBSz1
         3rUCgkIwIVrm6Ug2YtAvqSTZyUnMJJEwj6IVGaDqur/hRgcBrOASovJzHFOZxnHXKKMC
         yX1PIZ3IJOxIkTMv3nHxkxAzlBpIHYYSN1OIVG7akvXKpsTUhDGOQxFqBFIIpMqghThC
         IBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xxFeUjonFw77THjceoCtcx/rMZ97apnNhN3IhCP1UQI=;
        b=J502tjR57eL1SlQvpoJkl6K7PHeOtpn0WLySEtpg/ZoGwL12ne8BnKfhkXUx6cEUUE
         W1q0PgGOWzOh0B6cKlpBuUNSDANOSPKhPHZfTqRp4m2L08Skf+ymDec8u//bG6zvAbHg
         N6Q/prtWKkX/OVW7KUNW/+XQXwO4Z1C1VDEMv8+YvizF0mXYrvyThpAcoZDLUfJlf5SW
         Kc/8Y8NgCIX+V3/ha+qZUHy8he/Pkrgs0U31/+K8GZOlMST2xZye8Wu0pmMtqixOIi+L
         4QH51ujRSUtywct7TrRTPfTBa6LGYajoufanx/9dxthQXzrYJQPmXlHZDG6MKLSkTenZ
         u97A==
X-Gm-Message-State: AOAM530zL9pDbopYP6Zn2615Mcew8M3izBjFC24ZlJ9Y6I1Rq5f371RJ
        1/LFTK1fMOkXufyTuGMN5sAxUg==
X-Google-Smtp-Source: ABdhPJzIoeziRWYSinQSimU0cSGVxm1mRIUH9ZoqSvLiLUAOedJx9Yh2rnnfP37j0rzfRSMTZHjGeA==
X-Received: by 2002:aca:4c4f:: with SMTP id z76mr22331736oia.1.1608051739520;
        Tue, 15 Dec 2020 09:02:19 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s139sm5152887oih.10.2020.12.15.09.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 09:02:18 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] gpiolib: Allow name duplicates of "" and "NC"
Date:   Tue, 15 Dec 2020 09:03:08 -0800
Message-Id: <20201215170308.2037624-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all GPIO pins are exposed to the world and this is typically
described by not giving these lines particular names, commonly "" or
"NC".

With the recent introduction of '2cd64ae98f35 ("gpiolib: Disallow
identical line names in the same chip")' any gpiochip with multiple such
pins will refuse to probe.

Fix this by treating "" and "NC" as "no name specified" in
gpio_name_to_desc()

Fixes: 2cd64ae98f35 ("gpiolib: Disallow identical line names in the same chip")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

The introduction of 2cd64ae98f35 breaks pretty much all Qualcomm boards and
grepping the DT tree indicates that other vendors will have the same problem.

In addition to this the am335x-* boards will also needs "[NC]", "[ethernet]",
"[emmc"], "[i2c0]", "[SYSBOOT]" and "[JTAG]" added to this list to allow
booting v5.11 with the past and present dtb/dts files.

 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b3340ba68471..407ba79ae571 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -302,7 +302,7 @@ static struct gpio_desc *gpio_name_to_desc(const char * const name)
 	struct gpio_device *gdev;
 	unsigned long flags;
 
-	if (!name)
+	if (!name || !strcmp(name, "") || !strcmp(name, "NC"))
 		return NULL;
 
 	spin_lock_irqsave(&gpio_lock, flags);
-- 
2.29.2


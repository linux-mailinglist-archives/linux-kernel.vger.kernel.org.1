Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C635B2A6DE8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbgKDTbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbgKDTbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:31:01 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D625EC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:31:00 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so3946467wrc.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t/9DP21Y/K7Z/VraeZB1byIXgPmUm3+JNNTaYKuJoag=;
        b=X6wXiCxJ19YmJynRpQiIR1GKNEXqk6HCc8AB2RqHuJ3t9U5HvHt3IO/Ijl6tIrxY32
         MBMEj5rHE0elD5LzJFd6z4hQbRERvqvNUTg1Pzdpyl3fVSq5Et/8Mw1c/vhPri3zvUu2
         zIcQ+n4FtDzljU7tO460QRQIP0AgrECI6b2s+3OJ9AoNxxw5q39ABQ2VnRuIe6t/D7rd
         akPjX/jGan+YoJJm9JLjgiY0ib8LPecB81+yis/DuYEaKCosBj2fXq0YwGklgeF7Zeqp
         Igtu2AZoAGZBSgP38c8eMmE+cvhPDsmJa5OkdTkoLba9FQ57Q9NVD7BTJH6gJSqTeI5R
         1VFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t/9DP21Y/K7Z/VraeZB1byIXgPmUm3+JNNTaYKuJoag=;
        b=M3tRSPCDdUdwucrqiuFhXoXq4yUtGtBwaCXWlCnqA95EEx72fVykWMVAv0y0NXwLI1
         IDh9yZwvG6uU8y+d5Z+4t7Y8h+F1cHfLOj4s7eRAYYd771j9SCLeXzT7uK9+NhsWhEgp
         BUU0MX3ktb/+yLk8xbM6SranSAYnTrnvxdli79fPa0GPPnYItPVqRjlwRqnAgKh/BCr2
         Y8BjS4y1gs2NYtphlHNmOUXy2YkYKXBmyYq7LH8+Enr89I/La8ek1u5d5G7zylEdx3J3
         dbf7J625Ae69/aItWGsRjKIdegDM/4YEn9LWep5rw3v8gzSYgH7ypIfjDfijYZjYDaXQ
         LA+g==
X-Gm-Message-State: AOAM530Ush/mEoMzd2t0TfOLPhbA5rftKvLioOf6pIzH8c2ApAz22rxT
        0fSF1ygDbyQgwTMyMqB34+RRMw==
X-Google-Smtp-Source: ABdhPJwujp3SZEsGu7VhbaTGsgUxvo/eHznG69HLbFinR/fN8zCFPyza/HK/9iP1IkbiMaR8TO5KPA==
X-Received: by 2002:adf:f101:: with SMTP id r1mr36574226wro.392.1604518259652;
        Wed, 04 Nov 2020 11:30:59 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id m12sm4051671wrs.92.2020.11.04.11.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:30:59 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/8] gpio: exar: include idr.h
Date:   Wed,  4 Nov 2020 20:30:46 +0100
Message-Id: <20201104193051.32236-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104193051.32236-1-brgl@bgdev.pl>
References: <20201104193051.32236-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This driver uses IDA APIs but doesn't include the relevant header. This
fixes it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-exar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 4202dd363a11..1941ae533418 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -8,6 +8,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
+#include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.29.1


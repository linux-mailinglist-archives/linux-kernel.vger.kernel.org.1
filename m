Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F41F2B417C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgKPKm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbgKPKmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:42:51 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64567C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:42:49 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m6so957503wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4apnqJWN8UXAvTecYMu5JfVMbmh6VFU9aGBXnlA8P/0=;
        b=Ktg0VFJbNhT6Gyv5HvkEfFyTXEnt/sagcga2AKCTnRaxI3Vo7W5Jo2DIeexQEy/IL2
         WuHGOefd+zsGbutiHhWiQPpPi7VZY7ZBOyeS7XNY/0s0CUv3pSujfZmbzMOLSrUTJuz9
         tD9koaCivuaHB7vg1V9QnrsisX1tdlR1dF/uEsZEF/jZHhzeOSGuLq6wuUcEc1TVwCx+
         cJ6jXaM6F4J1KG20hkW5LTZxraj8mqCW3pxzpx4GmnQF2LxXt48c8BRXT7P4DgX0sc9L
         F1q7TUFIRtId2L6jCxx9k66btiRvUTcT3/ZnTJ6EJ0/lc7k/qP1JRlyQmLBRYSUByM+e
         3ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4apnqJWN8UXAvTecYMu5JfVMbmh6VFU9aGBXnlA8P/0=;
        b=WcfTHFDMDmMCvwLVucKWJAGBjFk8hMTF8zkcsXDhU6Y52NfZ2RX5ycGokgwxr4Qn1v
         T8SkBPs7yMPIWsU6Ltf+vm79gV95YUYAwW/9oGV1RFwAntvwcDZ/tbYhjXpe+bZAtAz6
         8cegKDh68w6uG1Ipsz1ek03BTBb+03k1UY2A5KUdEt/00e+J/uOEv/ds6QASg4W6lZSN
         Q3jqqm4vos0EBdzusUNONOYr9yRbf5JTgqkd1vMa3kNt4oIBZusQb4fP8gXRBZQsvXMo
         zL6iMCEruZSXVAk6YCV3I7OnnwYZ1SsPcLLC063xrAWT+yyJAJQt6Zgn96iVYrURDPwK
         nogw==
X-Gm-Message-State: AOAM530P+2elVjH+7ktFaqBfRWNiFrkW8w+HLuHOmhv2QOEWFK1JFKjZ
        zvy3PPAOPni+LFcwZA+nLEMXtw==
X-Google-Smtp-Source: ABdhPJwGmrcx6gHYvHJn300niK5264/YoVmJ2V0DOTP/flf2uNNb7eKaaKjY0lkh8vIe1LA3NtBzuQ==
X-Received: by 2002:a5d:514f:: with SMTP id u15mr17805606wrt.385.1605523368152;
        Mon, 16 Nov 2020 02:42:48 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id v16sm20583283wml.33.2020.11.16.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:42:47 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 2/7] gpio: exar: include idr.h
Date:   Mon, 16 Nov 2020 11:42:37 +0100
Message-Id: <20201116104242.19907-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201116104242.19907-1-brgl@bgdev.pl>
References: <20201116104242.19907-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This driver uses IDA APIs but doesn't include the relevant header. This
fixes it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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


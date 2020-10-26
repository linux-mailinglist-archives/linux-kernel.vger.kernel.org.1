Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FFC298EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781109AbgJZOSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:18:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53154 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781099AbgJZOSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:18:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id c194so11832034wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7Q6GcsOlUvCk0TynHXF9lujyUa3NnBo8eWmuL6l7+w=;
        b=dbERnr6pULh92RZDnWcvydfH2yw6FxlD2miJ7YCqpB4IphjIU4ejhTXlyktOIKn3Jb
         rZctRLFnMwOnfeFdVf30d8C2MkbbteOjzJD9mjltuxl+IykpgfRDZO6sV9l8K24hAHp7
         I0MDI54E/6dfGtOWk6xwCPZzYKUz6dL93plJnxKWVWfNnOArUgxyRcYanFTebe/PaYUZ
         nX/Tj/fZQH4jubG0MbIqB/0S2+fjGQE++3Vyu1hxWFDrjNT6RAgRu2S9NBYfCUq21GEH
         X0qoiqOMY4mV3JG6RyAwngQ0zI9g3SOFUk+zaFuQsM0A5gGqslSVI1S9DXDURbtsc1qb
         b5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7Q6GcsOlUvCk0TynHXF9lujyUa3NnBo8eWmuL6l7+w=;
        b=d55WvUZbRTy2u1BQ4Jk66uOHlECvwW7pNcF9ADqgmhzmQ7l6tR5DxGfshbE1oGFGl0
         ijUM7iwrLynleGXTuBUPWmswOxUUZCwd4m7JF4YTLl+l8/dIQfci6S27CHhPCCphp9Yo
         7SJBCZScyxqGFTaEy9e+77b057vwZwMlX7CWXwD9cP7BJ/lZ7ISdvHkWMZUUvM5KHLZ+
         kHChSWJvjn+OfFOqUfN1c8uTIBaxcmRBnvcqtQBdS9S/irC2tn6pk48wozirNYcSU7Nt
         bqnOsWZqHucPLSAfUOsctGKOqNLdV7VTvQN+oZmHgi+QgjioR+WpDkaLojuwIGcRRgY6
         eIWw==
X-Gm-Message-State: AOAM530o8lF4vp76w1L5WGD4BknnAui9PqHjPjOHVdk1E1L1nhtFmaIH
        MqpGv0UFu5q23ZTTzo0By/OuDg==
X-Google-Smtp-Source: ABdhPJw+ShFg7cEncyf7KSXkD3885HgMK01cPnCNxlaN5WvaFyxG7asKNOI9e2P3ixYeUv6A8J1HqA==
X-Received: by 2002:a1c:3882:: with SMTP id f124mr15715926wma.184.1603721930478;
        Mon, 26 Oct 2020 07:18:50 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id e15sm21920841wro.13.2020.10.26.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:18:49 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/7] gpio: exar: add a newline after the copyright notice
Date:   Mon, 26 Oct 2020 15:18:33 +0100
Message-Id: <20201026141839.28536-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201026141839.28536-1-brgl@bgdev.pl>
References: <20201026141839.28536-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

It's customary to have a newline between the copyright header and the
includes. Add one to gpio-exar.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-exar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index b1accfba017d..4202dd363a11 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2015 Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
  */
+
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
-- 
2.29.1


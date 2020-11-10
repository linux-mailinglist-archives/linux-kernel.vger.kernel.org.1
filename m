Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840AD2AD986
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbgKJO5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731164AbgKJO4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:56:06 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:56:05 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so12156374wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7Q6GcsOlUvCk0TynHXF9lujyUa3NnBo8eWmuL6l7+w=;
        b=w+ZcawHwB0e3nB10uWI5DX6CesgFsMuEwayRrb8XkjoRWUp0F/fCC7j5OVqQ1ZPWGj
         tA3151tQRB2+KJHEb8MJkzDqtN0Phvg7QYOrINaW1/t21gObq8PaefxB3iOo07bLp6yr
         E3xmoNacZfG6A/RDC+1A6gH1QB7CizNMfRH99ZAOdBMJT4B9ApoA8ppYNSyA9jsAolxF
         +3ZmzwdrQVL8BGfjkRg+eYYHtMKxklpKZDQUtUae5SROj/DPYAmpI2o5rVNLFozbXHIX
         GiCajga5UXzrpUP7/w7fPR+DcfeYuD8CvF51qkIi2A7kQW3DyQchWcv3us+i+q4GBySD
         SPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7Q6GcsOlUvCk0TynHXF9lujyUa3NnBo8eWmuL6l7+w=;
        b=Wkm1YXsA/hV8I8Fohe3oO7BR91mUOawOZZCeQoOw0/gxUtsLAFe18e7DGK47OiChSd
         nrRntEmXZAMYghFF5EzYB/uy7cN2wNJ6Kkaa0tRF40KzmmE1fvb8w889/HWuZGoqMlTH
         3+QpNt3jhIRcB63Xsh+FiOWOa4w57c6VZsuGbx3g0wdmZd9gHHHcV75SrOnw1GlbmX2G
         RVs592HMmQd/Q0hLeJIErWoxUUICVT1ZOy7E67/NESMtPWR9YszgeGmmoLx0drTD4Y+l
         nAnG+LRsRDiCcWsYAC8mAIwY4qz2FQR6Pd2lU8Nm6wDCiVwWzB7q9j9vEraI3nNhRHiU
         gbhA==
X-Gm-Message-State: AOAM532rTnzY05zYYaaAlvyZLZh9XBTELy+LiYJgp+FgP9bGhRl6W99b
        Azzo+Luoft7B4RGpdB1msA5bhQ==
X-Google-Smtp-Source: ABdhPJxOU/dttXRMN7VN6gM9Zf9mVLj8tSVjQRRNqbDf/ak/UG0PszbRWOZvfgV4zELM3w7aMe8OSA==
X-Received: by 2002:adf:8304:: with SMTP id 4mr23920371wrd.215.1605020164113;
        Tue, 10 Nov 2020 06:56:04 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id f17sm3261827wmf.41.2020.11.10.06.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 06:56:03 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 1/7] gpio: exar: add a newline after the copyright notice
Date:   Tue, 10 Nov 2020 15:55:46 +0100
Message-Id: <20201110145552.23024-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201110145552.23024-1-brgl@bgdev.pl>
References: <20201110145552.23024-1-brgl@bgdev.pl>
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


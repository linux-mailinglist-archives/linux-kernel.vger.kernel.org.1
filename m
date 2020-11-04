Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35D82A6DE6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbgKDTbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbgKDTbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:31:00 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0FDC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:30:59 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c18so3497577wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7Q6GcsOlUvCk0TynHXF9lujyUa3NnBo8eWmuL6l7+w=;
        b=Xc/0YLTZPI+UQWykB4lIw3iXmFif+BleKjICzPVQtQMaG33CpdikHlBIYxI88uBhTx
         VzVOCxpteEdhPXq8CADPFBzLyRqFstOzccip1HzUyAW8nNRx/ZFgN/LGRMolVNd3Luyp
         08AEebtbS+gSG+hrJuF3cHhYKyNnLytT5ZH2XlJrSVwq8WpcKuZk42Wnnz/qlLSrIffH
         19LBzz+ORA47JecLcYmI3mNJhrABpkA+B0QLfz5luZr3mhtSdAuhawQiLEcsVm3KuuEc
         5x5Bzo3WS6TSaUFzFJ5DKYFbHITmsureLqdX3Yr6uzRtZYDoFkJFBjSepfu5PCFhOaZo
         kDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7Q6GcsOlUvCk0TynHXF9lujyUa3NnBo8eWmuL6l7+w=;
        b=pKLqDcEJTHIL1lVXBFZZ36yMIIAnr24OWKCWiyNVmBFkFgAHl7mjC0yS6gOB5hArQI
         5tU5NIvWagylpu5IGabzn/gXKyzlOIqRWhr80HP+U3n37KG37eMb+4oUEfJy9HbzVden
         NCHp+r6W0EVFJOLNr+WFidO1bw9Fz5NyrSgBQ/6cQ62hW9kq75gA7clV5mGvaZy80yDs
         +mp2NTFP+TrwgOtw2MVYC0Oxfsq+IhXpbWDGrL5Y4sBIbviOtyPR04Xyb2LEOpO/IkRM
         t6KFZ9ssR4/YpnnFBcqNrTJDA8o21oPlOZkd4ZTzwtF7n/kHUk+aiOVbUTJ6ajzgNOPa
         pSrQ==
X-Gm-Message-State: AOAM531tlgy8id7MmBuxnjcJd5L1ee6nraek1LPkCnr73r/tDCCzeDVi
        LXJQdTjr1tKBcVUXVqIOnhgT4g==
X-Google-Smtp-Source: ABdhPJxbC0ey4Rg99lhY3yGZtCR9r7zZ57Li9DI4bUljuHc+JAs4CwW4XOl2xv8dyBpp5/NAwqsqLQ==
X-Received: by 2002:a1c:35c7:: with SMTP id c190mr6063566wma.7.1604518258408;
        Wed, 04 Nov 2020 11:30:58 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id m12sm4051671wrs.92.2020.11.04.11.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:30:57 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/8] gpio: exar: add a newline after the copyright notice
Date:   Wed,  4 Nov 2020 20:30:45 +0100
Message-Id: <20201104193051.32236-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104193051.32236-1-brgl@bgdev.pl>
References: <20201104193051.32236-1-brgl@bgdev.pl>
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


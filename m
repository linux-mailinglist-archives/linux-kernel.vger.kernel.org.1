Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2162FAA96
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437686AbhARTuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437666AbhARTuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:50:12 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7F9C061757;
        Mon, 18 Jan 2021 11:49:31 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id j26so12105505qtq.8;
        Mon, 18 Jan 2021 11:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o5HksdyTUdQQjk2zOw6fwIggM+3xcWHdyUNjxB+lolM=;
        b=f+Bf+sEP2mTEJI5cn94UIcqIquN01905oEdZfQ+gSimLgDzNIFqoowjvNQBbo6gi2X
         Lhc4l+vdPhhlJXBCk5SFppD2FBDq01vO5IkKTkEV2G+IuI0v7IuS8oKp5Rs5trUix3zg
         rrU6xYgDfC5jrCF+c/RUwI1VGVHZo3Ous7G3b/lkkYk1uRJl+/yTzy8JJ2c4priZt7Hd
         XeJjAiA/TtwmUZ+y3nbCMiWRHYrWa9Vas/fINYeQidZx/rgsr4SBeSfH4khDMmT98RFQ
         qOKjvYOJPMzZGEfKS3y/FH+FZ0s6D/soMVzBWsSC1fizsxDaqk1IYsXxpEOXp43LcAzc
         HDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o5HksdyTUdQQjk2zOw6fwIggM+3xcWHdyUNjxB+lolM=;
        b=jOuYFbEwF5UziWQFH8z2hdSxZuogFNBPMx+ZuME5edwpk1v9POsVwLtN8Zm5+alOlB
         +6JBXfhOyyXqaQnTybSoF9HSVirAOvLFSlKn8qQ+cxmd1I3Et8X1Qm4gfmE6d0tsd4On
         WtSlLYzbKd8pTbtpmaeb5SjLXLSgOzvwW/HGI0VsU9WTE8AtEtVI0400QZSuGIeC2vlk
         qltJq4ILSX/ONcDWCU9LBBEybaPHdyL2sRF7mnMmR3VTjsaQhKvqKvAhpm201R8kFdsk
         btuEaCWEsQnmSCkSwZ5Sa6aTf4xgMf6UNeKbWLVJk6d7p+d3Dl8d4iu2lmzVVKhmDMP/
         /oiQ==
X-Gm-Message-State: AOAM5307ckOD04f2SLk2JFS75x1EAZu4jSIConwibjVQppD662LKbKn8
        Lf2g5KS/kp2gmNu13hgtfdU=
X-Google-Smtp-Source: ABdhPJzzx5A9KgkbSufAunbooPXWFCoXUKi3te0JOtzs/8S4XM8V00ZL6LQlyMEAO24xQKU3isVjgw==
X-Received: by 2002:aed:31a6:: with SMTP id 35mr1200470qth.370.1610999371146;
        Mon, 18 Jan 2021 11:49:31 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id 184sm11438085qkg.92.2021.01.18.11.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 11:49:30 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] gpio: tegra: Add missing dependencies
Date:   Mon, 18 Jan 2021 20:49:25 +0100
Message-Id: <20210118194925.819610-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Commit efcdca286eef ("gpio: tegra: Convert to gpio_irq_chip") moved the
Tegra GPIO driver to the generic GPIO IRQ chip infrastructure and made
the IRQ domain hierarchical, so the driver needs to pull in the support
infrastructure via the GPIOLIB_IRQCHIP and IRQ_DOMAIN_HIERARCHY Kconfig
options.

Fixes: efcdca286eef ("gpio: tegra: Convert to gpio_irq_chip")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 75f6c37620ea..013a1055939d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -597,6 +597,8 @@ config GPIO_TEGRA
 	default ARCH_TEGRA
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on OF_GPIO
+	select GPIOLIB_IRQCHIP
+	select IRQ_DOMAIN_HIERARCHY
 	help
 	  Say yes here to support GPIO pins on NVIDIA Tegra SoCs.
 
-- 
2.30.0

